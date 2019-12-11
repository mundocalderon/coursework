class Point
attr_accessor :longitude, :latitude

	def to_hash
    	#{:type=>'Point', :coordinates=>[@longitude, @latitude]}
    	{"type":"Point", "coordinates":[ @longitude, @latitude]}
	end

	def initialize(hash)
		@latitude=hash[:lat] ||=  hash[:coordinates][1]
		@longitude=hash[:lng] ||= hash[:coordinates][0]

	end

end
