class Photo
	require 'exifr/jpeg'

	attr_accessor :id, :location, :place
	attr_writer :contents

	def self.mongo_client
		Mongoid::Clients.default
	end

	def initialize(params={})
		@id= params[:_id].nil? ? params[:id] : params[:_id].to_s
		if !params[:metadata].nil?
			@location= params[:metadata][:location].nil? ? nil : Point.new(params[:metadata][:location])
			@place= params[:metadata][:place].nil? ? nil : params[:metadata][:place]
		end
	end

	def persisted?
		!@id.nil?
	end

	def contents
	    f=self.class.mongo_client.database.fs.find_one(:_id=>BSON::ObjectId.from_string(@id))
	    if f 
	      buffer = ""
	      f.chunks.reduce([]) do |x,chunk| 
	          buffer << chunk.data.data 
	      end
	      return buffer
	    end 
	end

	def place
		@place.nil? ? nil : Place.find(@place)
	end

	def place=(new_place)
		case 
		when new_place.is_a?(Place)
			@place= BSON::ObjectId.from_string(new_place.id)
		when new_place.is_a?(String)
			@place= BSON::ObjectId.from_string(new_place)
		when new_place.is_a?(BSON::ObjectId)
			@place = new_place
		when new_place.nil?
			@place = nil
		end
	end

	def save  	
		if !self.persisted?  
			description = {}  		 		
			gps = EXIFR::JPEG.new(@contents).gps	
			@location = Point.new(:lng => gps.longitude, :lat => gps.latitude) 

			description[:content_type] = "image/jpeg"  		
			description[:metadata] = {}  		
			description[:metadata][:location] = @location.to_hash
			description[:metadata][:place] = @place  		
			if @contents  			
				@contents.rewind  			
				grid_file = Mongo::Grid::File.new(@contents.read, description)  			
				id = self.class.mongo_client.database.fs.insert_one(grid_file)  			
				@id = id.to_s  			
				return @id  		
			end  	
		else
			self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).
												update_one(:$set=>{:'metadata.place'=>@place, :'metadata.location' =>@location.to_hash})
		end

	end

	def destroy
		id_criteria = BSON::ObjectId.from_string(@id)
	    self.class.mongo_client.database.fs.find(:_id=>id_criteria).delete_one
	end

	def self.all(offset=0,limit=nil)
		result=[]
		photos= self.mongo_client.database.fs.find
		photos=photos.skip(offset) if offset
		photos=photos.limit(limit) if limit
		photos.map{|doc| result << Photo.new(doc)}
		result
	end

	def self.find(id)
    	bson_id = BSON::ObjectId.from_string(id)
    	doc = self.mongo_client.database.fs.find(:_id=>bson_id).first
    	photo = doc.nil? ? nil : Photo.new(doc)

	end

	def self.find_photos_for_place(place_id)
		place_id = BSON::ObjectId.from_string(place_id.to_s) #This will make sure that we are working with a BSON ObjectID
		photos = self.mongo_client.database.fs.find(:'metadata.place'=>place_id)  
	end

	def find_nearest_place_id(max_meters)
		place = Place.near(@location, max_meters).limit(1).projection(:_id=>1).first
		place.nil? ? 0 : place[:_id]
	end

end