class Point
	attr_accessor :longitude, :latitude

	def initialize(lon, lat)
		@longitude=lon
		@latitude=lat
	end

	def mongoize
		{:type=>"Point", :coordinates=>[@longitude, @latitude]}
	end

	def self.mongoize(object)
		case object
		when nil then nil
		when Point then object.mongoize
		when Hash then Point.new(object[:coordinates][0],object[:coordinates][1]).mongoize
		end

	end

	def self.demongoize(object)
		if object.nil? || object[:coordinates][0].nil? || object[:coordinates][1].nil?
			return nil
		else
			Point.new(object[:coordinates][0],object[:coordinates][1])
		end
	end

	def self.evolve(object)
		case object
			when nil then nil
			when Point then object.mongoize
			when Hash then Point.new(object[:coordinates][0],object[:coordinates][1]).mongoize
		end

	end
end