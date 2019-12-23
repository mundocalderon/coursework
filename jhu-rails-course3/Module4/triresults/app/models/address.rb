class Address
	attr_accessor :city, :state, :location 

	def initialize(city, state, location)
		@city=city
		@state=state
		@location= location.nil? ? nil : Point.new(location[:coordinates][0],location[:coordinates][1])
	end

	def mongoize
		if @location.nil?
			{:city=>@city, :state=>@state, :loc=>nil}
		else
			{:city=>@city, :state=>@state, :loc=>{:type=>"Point", :coordinates=>[@location.longitude, @location.latitude]}}
		end
	end

	def self.mongoize(object)
		case object
		when nil then nil
		when Address then object.mongoize
		when Hash then Address.new(object[:city], object[:state], object[:loc]).mongoize
		end

	end

	def self.demongoize(object)
		if object.nil? 
			return nil
		else
			Address.new(object[:city], object[:state], object[:loc])
		end

	end

	def self.evolve(object)
		case object
		when nil then nil
		when Address then object.mongoize
		when Hash then Address.new(object[:city], object[:state], object[:loc]).mongoize
		end
	end

end
