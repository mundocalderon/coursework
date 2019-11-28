class TodoItem < ActiveRecord::Base

	def self.completed_item_count
		where(completed: true).count
	end
end
