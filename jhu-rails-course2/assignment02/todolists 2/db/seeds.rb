# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

User.create! [
  { username: "Fiorina", password_digest: "1234" },
  { username: "Trump", password_digest: "1234" },
  { username: "Carson", password_digest: "1234" },
  { username: "Clinton", password_digest: "1234" },
]

User.find_by!(username: "Fiorina").create_profile(gender: "female", birth_year: "1954", first_name: "Carly", last_name: "Fiorina")
User.find_by!(username: "Trump").create_profile(gender: "male", birth_year: "1946", first_name: "Donald", last_name: "Trump")
User.find_by!(username: "Carson").create_profile(gender: "male", birth_year: "1951", first_name: "Ben", last_name: "Carson")
User.find_by!(username: "Clinton").create_profile(gender: "female", birth_year: "1947", first_name: "Hillary", last_name: "Clinton")


User.all.each do |user| 
	list = user.todo_lists.create!(list_name: "My First List", list_due_date: Date.today + 1.year); 
	5.times do |x|
		list.todo_items.create!(due_date: Date.today + 1.year, title: "Item #{x}", description: "This is the text of item #{x}")
	end
end 
