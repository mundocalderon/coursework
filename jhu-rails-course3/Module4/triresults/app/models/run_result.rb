class RunResult < LegResult
	field :mmile, as: :minute_mile, type:Float
	def calc_ave
		if event && secs
			time = secs/60
			self.mmile = time.nil? ? nil : time/event.miles
		end
	end
end