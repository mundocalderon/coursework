require_relative "module3_1_assignment"

puts Recipe.for("chocolate")
ex = Recipe.for("chocolate")
puts "*************************"
puts ex.request.last_uri