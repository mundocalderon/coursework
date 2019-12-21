class BikeResult < LegResult
	field :mph, type: Float
	def calc_ave
		if event && secs
			miles = event.miles*3600 
			self.mph = miles.nil? ? nil : miles/secs
		end
	end
end
