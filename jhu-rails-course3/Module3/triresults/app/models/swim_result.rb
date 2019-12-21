class SwimResult < LegResult
  field :pace_100, type: Float
	def calc_ave
		if event && secs
			hundred_meters = event.meters/100 # convert the length from event object
			self.pace_100 = hundred_meters.nil? ? nil : secs/hundred_meters # to get the average pace per meter
		end
	end
end