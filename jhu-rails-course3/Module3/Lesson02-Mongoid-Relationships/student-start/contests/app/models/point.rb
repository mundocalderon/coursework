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
			when Point then object.mongoize
			when Hash then Point.new(object[:coordinates][0],object[:coordinates][1]).mongoize
		end

	end

	def self.demongoize(object)
		# lon=object[:coordinates][0]
		# lat=object[:coordinates][1]
		Point.new(object[:coordinates][0],object[:coordinates][1])
	end

	def self.evolve(object)
		case object
			when Point then object.mongoize
			when Hash then Point.new(object[:coordinates][0],object[:coordinates][1]).mongoize
		end

	end
end