class User < ActiveRecord::Base
	has_secure_password
	has_one :profile, :dependent => :destroy
	has_many :todo_lists, :dependent => :destroy
	has_many :todo_items, :through => :todo_lists, :source => :todo_items

	validates :username, :password_digest, presence: true

	def get_completed_count
		todo_items.where(completed: true).count
	end
end
