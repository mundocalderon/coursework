class Placing
	attr_accessor :name, :place

	def initialize(name, place)
		@name = name
		@place = place
	end

	def mongoize
		{:name=>@name, :place=>@place}
	end

	def self.mongoize(object)
		case object
		when nil then nil
		when Placing then object.mongoize
		when Hash then object
		end

	end

	def self.demongoize(object)
		if object.nil?
			return nil
		else
			Placing.new(object[:name], object[:place])
		end
	end

	def self.evolve(object)
		case object
		when nil then nil
		when Placing then object.mongoize
		when Hash then object
		end
	end
end