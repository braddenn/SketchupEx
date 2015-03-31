#####################################################
#  ex_transforms4.rb
#  by Brad Denniston   Copyright (c) 2015
#
# ex_create3CubeDefs - add 3 cube definitions
# ex_generateInstances - add and show 1 cube instance for each definition
# ex_moveCubeInstances  "move the instances
# ex_rotateInstances "rotate the instances
# ex_translate - translate cube #3 5 times in the same direction
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
# GLOBAL VARS ---------------------------------------
#
$all_instances = Array.new   # normalized and sorted array of instances
$exp_ents = Array.new    # all entities of one exploded instance
$quadDef
$pyramidDef
$cubeDef
$model = Sketchup.active_model
#
# UTILITIES ----------------------------------------------
#
# makeCubeDef - add a 6-sided component definition called box
#
def SketchUpEx.makeBoxDef( length, width, height )
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
  definition = $model.definitions.add( "box"  )
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
# makeDef - create a definition for a box
#
def SketchUpEx.makeDefs
  puts "make a box def of 60,30,15"
  $cubeDef = SketchUpEx.makeBoxDef( 60, 30, 15 )
end
#
# make one instance at x,y,z of a ComponentDefinition
#
def SketchUpEx.makeInstanceDefAt(compDef, x, y, z)
  trans = Geom::Transformation.translation([x,y,z])
  $model.entities.add_instance(compDef, trans )
end
#
# move - move an instance to x, y, and z
# inst - the instance to be moved
# params: destination x,y,z
#
def SketchUpEx.move( inst, x, y, z )
  puts "before move of #{x}, #{y}, #{z} inst transformation is:"
  puts "#{inst.transformation.to_a}"
  puts "and origin is #{inst.transformation.origin.to_a}"
  t = Geom::Transformation.new([x,y,z])
  inst.transform! t
  puts "after move by transform! inst transformation is:"
  puts "#{inst.transformation.to_a}"
  puts "and origin is #{inst.transformation.origin.to_a}"
end # move
#
# translate an instance by x, y, and z
# inst - the instance to be translated
# params: vector x, y, and z
#
def SketchUpEx.translate( inst, x, y, z )
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
# rotate - add to rotation
# inst - the instance to be rotated
# point - start of vector of rotation
# vector - line through point that inst rotates around
# angle - radians of rotation
#
def SketchUpEx.rotate( inst, point, vector, angle )
  puts "before rotation inst transformation is:"
  puts "#{inst.transformation.to_a}"
  puts "origin is #{inst.transformation.origin.to_a}"
  transformation = Geom::Transformation.rotation pt, vector, angle
  inst.transform! transformation
  puts "after rotation inst transformation is:"
  puts "#{inst.transformation.to_a}"
  puts "and origin is #{inst.transformation.origin.to_a}"
end #rotate

SketchUpEx.makeDefs
SketchUpEx.makeInstanceDefAt($cubeDef, 5,10,15)

angle = Math::PI/8

inst = $cubeDef.instances[0]
puts "using rectangle at origin (5,10,15)."
UI.messagebox "will translate rectangle by 10,15,20"
SketchUpEx.translate( inst, 10, 15, 20)
UI.messagebox "translated rectangle by 10,15,20"

inst = $cubeDef.instances[0]
puts "using rectangle at origin (5,10,15)"
UI.messagebox "will translate rectangle by 10,15,20"
SketchUpEx.translate( inst, 10, 15, 20)
UI.messagebox "translated rectangle by 10,15,20"

inst = $cubeDef.instances[0]

#UI.messagebox "will move rectangle by 15,15,15"
#SketchUpEx.move( inst, 15,15,15 )
#UI.messagebox "moved rectangle by 15,15,15"

UI.messagebox "will translate same rectangle by 10,15,20"
SketchUpEx.translate( inst, 10, 15, 20)

UI.messagebox "will rotate rectangle 22.5 degrees around z"
SketchUpEx.rotate( inst, 0,0,1, angle )
UI.messagebox "rotated rectangle 22.5 degrees around z"

end #module
