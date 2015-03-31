#####################################################
#	ex_block.rb
#	by Brad Denniston   Copyright (c) 2015
#
# demonstrate the scoping of variables in a block
# Ruby 1.9 (not 1.8)
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
# First block
#
 x = 1337 
 puts "Before the loop, x = #{x}"
 3.times{|x| 
	puts "Looping #{x}"
 }
 puts "After the loop, x = #{x}"
 puts '-' * 20
 puts
 # output
 # Before the loop, x = 1337
 # Looping 0
 # Looping 1
 # Looping 2
 # After the loop, x = 1337
 # x is local to the block, the outside x is not affected
 # this is the same as in C: for( int x=0; x<3; x++ )
 # ------------------------------
 #
 # Second block
 #
 x = 1337 
 puts "Before the loop, x = #{x}"
 3.times do|y|
	puts "Looping #{y}"
	x = y
 end 
 puts "After the loop, x = #{x}"
 puts '-' * 20
 puts
 # Before the loop, x = 1337
 # Looping 0
 # Looping 1 
 # Looping 2
 # After the loop, x = 2
 # this looks just like C
 #
 # Third block
 #
 x = 1337
 puts "Before the loop, x = #{x}"
 3.times do|y;x|
	puts "Looping #{y}"
	x = y
 end
 puts "After the loop, x = #{x}"
 puts ""
 # Before the loop, x = 1337
 # Looping 0
 # Looping 1
 # Looping 2
 # After the loop, x = 1337
 # in C this is creating a local variable with int x
 #
name = "Bob"
('Ted'..'Zed').each do |n|
	name = n
end
print name # Zed
puts
#
# block local variable
#
current = "2012"
1.upto(10) do |current|
	print current * current
end
puts
print current # 2012
puts "------------------"
puts
 #  The variable declared in the block is not the same as 
 # the variable defined outside the block
 #
 # but if you don't make it a local
 current = "2012"
 1.upto(10) do |i|
	current = i
	succ = current + 1
	print "#{current}, #{succ}"
 end
print current # 10
puts
#
# now to get a little more complex
#
puts "now to get a little more complex"
pt1 = [5, 10, 15]
pt2 = [10, 15, 5]
pt3 = [15, 5, 10]
points = [pt1, pt2, pt3]

pointMin = points[1[2]]
puts "initial pointMin is #{pointMin}"
points.each do |pt|
	puts "pointMin[2] is #{pointMin[2]} and next point[2] is #{pt[2]}"
	if ( pointMin[2] > pt[2] )
		pointMin = pt
		p "changed, now pointMin is #{pointMin}"
	end
end
p "final pointMin is #{pointMin}"

end #module