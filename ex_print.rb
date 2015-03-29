#####################################################
#	ex_print.rb
#	by Brad Denniston   Copyright 2014
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

require 'sketchup.rb'

point1 = Geom::Point3d.new 10,20,30
point2 = Geom::Point3d.new 2,2,2
p "p - print this"
puts "puts - print this" # works
s = "print this with p"
p s # works
s = "print this with puts"
puts s # works
s = "print - print this with printf"
# printf ("%s", s ) # fails - gets error message about the comma??
UI.messagebox( "#{point1}" ) # works
p point1 # nice - but it adds a label Point3d
p "next is p point1.inspect"
p point1.inspect  # like p point1 but puts quotes around output??
p "p of #[point1.inspect} and quote - does not exppand #[...]"
print "print of #[point1.inspect} and quote\n" # does not expand
p( "using p - #{point1}" ) # works - but, follows number with \" meaning inches




