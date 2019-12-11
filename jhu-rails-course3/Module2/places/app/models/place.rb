
class Place
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
    @location = Point.new(hash[:geometry][:location]) 
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

end

#Racer.reset
#Racer.reset ./student-start/race2_results.json"
