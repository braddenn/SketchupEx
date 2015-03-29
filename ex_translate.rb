#####################################################
#	ex_translate.rb
#	by Brad Denniston   Copyright (c) 2015
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################
# First pull in the standard API hooks.
require 'sketchup.rb'
SKETCHUP_CONSOLE.show
#
# GLOBAL VARS ---------------------------------------
#
$boxDef
$model = Sketchup.active_model
#
# UTILITIES ----------------------------------------------
#
# makeBoxDef - add a 6-sided component definition called box
#
def makeBoxDef( length, width, height )
	pts = Array.new
	pts[0] = [0,0,0]
	pts[1] = [length,0,0] # x
	pts[2] = [length, width,0] # xy
	pts[3] = [0,width,0]
	pts[4] = [0, 0, height]
	pts[5] = [0,width,height]
	pts[6] = [length, width,height]
	pts[7] = [length,0,height]
	# add the points to the active model defining a face
	definition = $model.definitions.add( "box"	)
	definition.entities.add_face( pts[0],pts[1], pts[2], pts[3]) #base
	definition.entities.add_face( pts[4],pts[5], pts[6], pts[7]) #top
	definition.entities.add_face( pts[0],pts[4], pts[7], pts[1]) #x
	definition.entities.add_face( pts[1],pts[7], pts[6], pts[2]) #xy
	definition.entities.add_face( pts[2],pts[6], pts[5], pts[3]) #yx
	definition.entities.add_face( pts[0],pts[3], pts[5], pts[4]) #y	
	return definition
end
#
# OPERATIONS
#
# make one instance at x,y,z of a ComponentDefinition
#
def makeInstanceOfDefAt(compDef, x, y, z)
	puts "createing instance at origin #{x}, #{y}, #{z}"
	trans = Geom::Transformation.translation([x,y,z])
	$model.entities.add_instance(compDef, trans )
end
#
# translate an instance by x, y, and z
# Params:
# inst - the instance to be translated
# vector x, y, and z
#
def translate( inst, x, y, z )
	puts "before translation of #{x}, #{y}, #{z} inst transformation is:"
	puts "#{inst.transformation.to_a}"
	puts "and origin is #{inst.transformation.origin.to_a}"
	v = Geom::Vector3d.new x,y,z
	t = Geom::Transformation.translation v
	inst.transform! t
	puts "after translation inst transformation is:"
	puts "#{inst.transformation.to_a}"
	puts "and origin is #{inst.transformation.origin.to_a}"
end # translate
#
##########################################
#
puts "make a box definition sized 60,30,15"
$boxDef = makeBoxDef( 60, 30, 15 )

# Make an instance of a box at 5,10,15
makeInstanceOfDefAt($boxDef, 5,10,15)
inst = $boxDef.instances[0] # could have been returned

puts "using box at origin (5,10,15)."
UI.messagebox "will translate box by 10,15,20"
translate( inst, 10, 15, 20)
UI.messagebox "translated box by 10,15,20"

UI.messagebox "will translate box by 0,0,-20"
translate( inst, 0, 0, -20)
UI.messagebox "translated box by 0,0,-20"

UI.messagebox "will translate box by -10,-15,0"
translate( inst, -10, -15, 0)
UI.messagebox "translated box by 0,0,-20 : back to start point."
