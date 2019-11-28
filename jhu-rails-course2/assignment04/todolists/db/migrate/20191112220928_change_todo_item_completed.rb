class ChangeTodoItemCompleted < ActiveRecord::Migration
	def up
	  change_column :todo_items, :completed, :boolean, default: false
	end

	def down
	  change_column :todo_items, :completed, :boolean, default: nil
	end
end
