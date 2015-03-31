#####################################################
#  ex_align.rb
#  by Brad Denniston   Copyright (c) 2015
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx

#
# GLOBAL VARS ---------------------------------------
#
$boxDef1
$boxDef2
$model = Sketchup.active_model

#
# makeBoxDef - add a 6-sided component definition called box
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
# make one instance at x,y,z of a ComponentDefinition
#
def SketchUpEx.makeInstanceOfDefAt(compDef, x, y, z)
  trans = Geom::Transformation.translation([x,y,z])
  $model.entities.add_instance(compDef, trans )
end
#
# align - put the x,y,z axis of instRotate in alignment with instRef
#
def SketchUpEx.align( instRef, instRotate )
  # move the rotate inst to the ref inst
  rotInitialOrigin = instRotate.transformation.origin
  refOrigin = instRef.transformation.origin
  moveAmount = refOrigin - rotInitialOrigin # make it negative
  returnAmount = rotInitialOrigin - refOrigin
  tempMoveTrans = Geom::Transformation.new moveAmount
  instRotate.transform! tempMoveTrans
  
  # rotate zRot axis around cross
  # get the angle
  angle = get_angle( instRotate.transformation.zaxis, instRef.transformation.zaxis)
  puts "angle Rot z to Ref z is #{angle *180/Math::PI}"
  UI.messagebox "rotate Z by #{angle *180/Math::PI}"
  # rotate
  vector = instRef.transformation.zaxis.cross instRotate.transformation.zaxis
  rotOrigin = instRotate.transformation.origin
  tRot = Geom::Transformation.rotation rotOrigin, vector, angle
  instRotate.transform! tRot
  
  UI.messagebox "first rotation - Z"
  
  # rotate xRot axis around cross
  # get the angle
  angle = SketchUpEx.get_angle( instRotate.transformation.xaxis, instRef.transformation.xaxis)
  puts "angle x to x is #{angle *180/Math::PI}"
  UI.messagebox "rotate X by #{angle *180/Math::PI}"
  
  # rotate
  vector = instRef.transformation.xaxis.cross instRotate.transformation.xaxis
  rotOrigin = instRotate.transformation.origin
  tRot = Geom::Transformation.rotation rotOrigin, vector, angle
  instRotate.transform! tRot

  UI.messagebox "second rotation - X"

  #restore instRotate to original location
  tempMoveTrans = Geom::Transformation.new returnAmount
  instRotate.transform! tempMoveTrans
end
#
# get angle between 2 vectors with proper sign
#
def SketchUpEx.get_angle( vA, vB )
  angle = vA.angle_between vB
  # set the sign of the angle
  diff = vA.normalize - vB.normalize
  signAngle = diff.x  + diff.y + diff.z
  if signAngle < 0 then angle = -angle end
  return angle
end

$boxDef1 = SketchUpEx.makeBoxDef( 2, 30, 15 )
$boxDef2 = SketchUpEx.makeBoxDef( 10, 20, 30 )
#make an instance of a box at 10,10,10
makeInstanceOfDefAt($boxDef1, 10,10,10)
inst0 = $boxDef1.instances[0]

SketchUpEx.makeInstanceOfDefAt($boxDef2, -40,40,40)
inst1 = $boxDef2.instances[0]
SketchUpEx.makeInstanceOfDefAt($boxDef2, -40,40,40)
inst2 = $boxDef2.instances[1]

# set the rotation angle to 45 degrees
angle = Math::PI/4
puts "Rotation angle set to 45 degrees"

origin = inst1.transformation.origin
UI.messagebox "rotate second box z axis from its origin by 45 degrees around x axis"
vector = Geom::Vector3d.new 1,0,0 # the x axis
# rotate
tRot = Geom::Transformation.rotation origin, vector, angle
inst1.transform! tRot

UI.messagebox "rotate second box z axis from its origin by 45 degrees around y axis"
origin = inst1.transformation.origin
vector = Geom::Vector3d.new 0,1,0 # the y axis
#rotate
tRot = Geom::Transformation.rotation origin, vector, angle
inst1.transform! tRot

UI.messagebox "align them"
align( inst0, inst1 )

end #module

