some_var = "false"
another_var = "nil"

if some_var == "pink elephant"
  puts "Don't think about the pink elephant!"

elsif another_var.nil?
  puts "Question mark in the method name?"

elsif some_var == false
  puts "Looks like this one should execute"

else
  puts "I guess nothing matched... But why?"
end

puts "moving onto the case block"
puts "***"

case 

when some_var == "pink elephant"
  puts "Don't think about the pink elephant!"
when another_var.nil?
  puts "Question mark in the method name?"
when some_var == false
  puts "looks like this one should execute"
when true
  puts "I guess nothing matched... But why?"
 
end