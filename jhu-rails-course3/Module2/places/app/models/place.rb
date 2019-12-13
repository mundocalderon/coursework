
class Place
  include ActiveModel::Model
  attr_accessor :id, :formatted_address, :location, :address_components

  def initialize(hash)
    @id = hash[:_id].is_a?(BSON::ObjectId) ? hash[:_id].to_s : hash[:_id]
    @address_components = []
    if !hash[:address_components].nil?
      hash[:address_components].each do |addr| 
        addr = AddressComponent.new(addr) 
        @address_components << addr
      end
    end
   
    @formatted_address = hash[:formatted_address]

    if hash[:geometry][:location]
      @location = Point.new(hash[:geometry][:location]) 
    elsif hash[:geometry][:geolocation]
      @location = Point.new(hash[:geometry][:geolocation])
    end
      
  end

  def persisted?
    !@id.nil?
  end

  def destroy
    self.class.collection.find({_id: BSON::ObjectId.from_string(@id)}).delete_one
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:places]
  end
  
  # helper method that will load a file and return a parsed JSON document as a hash
  def self.load_all(file_path) 
    file=File.read(file_path)
    self.collection.insert_many(JSON.parse(file))
  end

  def self.find_by_short_name(name)
    self.collection.find('address_components.short_name'=> name)
  end

  def self.find id
    bson_id = BSON::ObjectId.from_string(id)
    doc = self.collection.find(_id: bson_id).first
    doc.nil? ? nil : Place.new(doc)
  end

  def self.all(offset=0, limit=nil)
    coll=[]
    result=self.collection.find.skip(offset)
    result=result.limit(limit) if !limit.nil?
    if !result.nil?
      result.each do |doc|
        coll << Place.new(doc)
      end
    end
    coll
  end

  def self.to_places(input)
    coll=[]
    if !input.nil?
      input.each do |doc|
        coll << Place.new(doc)
      end
    end
    coll
  end

  def self.get_address_components(sort=nil,offset=0,limit=nil)
    aggregation = self.collection.aggregate([ {:$unwind=>"$address_components"}, {:$project=>{ address_components:1, formatted_address:1, 'geometry.geolocation'=>1}} ])
    aggregation.pipeline << {:$sort=> sort} if !sort.nil?
    aggregation.pipeline << {:$skip=>offset} if offset
    aggregation.pipeline << {:$limit=>limit} if !limit.nil?
    aggregation
  end

  def self.get_country_names
    countries = self.collection.aggregate([ {:$unwind => "$address_components"},
                                                {:$match=>{'address_components.types'=>'country'}},
                                                {:$project=>{_id:0, 'address_components.long_name'=>1, 'address_components.types'=>1}},
                                                {:$group=>{_id:'$address_components.long_name'}}
                                              ]).to_a.map{|h| h[:_id]}
  end

  def self.find_ids_by_country_code(country_code)
    ids= self.collection.aggregate([ {:$unwind => "$address_components"},
                                        {:$match=>{'address_components.types'=>'country', 'address_components.short_name'=>country_code}},
                                        {:$project=>{_id:1}}
                                    ]).map {|doc| doc[:_id].to_s}
  end

  def self.create_indexes
    Place.collection.indexes.create_one({'geometry.geolocation'=>Mongo::Index::GEO2DSPHERE})
  end

  def self.remove_indexes
    Place.collection.indexes.drop_one('geometry.geolocation_2dsphere')
  end

  def self.near(coordinate, max_meters=nil)
    near_query= {:$geometry=>coordinate.to_hash}
    near_query[:$maxDistance]=max_meters if max_meters
    collection.find(:"geometry.geolocation"=>{:$near=>near_query})
    #AKA self.collection.find(:"geometry.geolocation"=>{ :$near=>{:$geometry=>coordinate.to_hash}, :$maxDistance=>max_meters })
  end

  def near(max_meters=nil)
    self.class.to_places(self.class.near(@location,max_meters))
  end

  def photos(offset=0, limit=nil)
    result=[]
    photos = Photo.find_photos_for_place(self.id).skip(offset)
    photos = photos.limit(limit) if !limit.nil?
    photos.map{ |p| result << Photo.new(p)}
    result
  end

end

#Racer.reset
#Racer.reset ./student-start/race2_results.json"
