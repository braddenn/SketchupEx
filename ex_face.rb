#####################################################
#  ex_loop.rb
#  by Brad Denniston   Copyright (c) 2014
#
#  Demonstrate the elements of a face
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
$face
$pts = Array.new
#
# ex_makeAface
#
def SketchUpEx.makeAface
  $pts[0] = ORIGIN
  $pts[1] = [10,0,0]
  $pts[2] = [10,10,0]
  $pts[3] = [0,10,0]
  # Add the face to the entities in the model
  entities = Sketchup.active_model.active_entities
  $face = entities.add_face($pts)
  p "The face is #{$face}" # shows all 4 edges
  # to_s is no different
  # to_a is not defined
  print "\n"
end
#
# ex_face_describe
#
def SketchUpEx.face_describe
  ar = $face.edges
  ar.each { |e| 
    p "edge #{e}" 
    p "edge vertex (start) is #{e.start}"
    p "edge line is #{e.line.to_a}"
    p "vertex position is #{e.start.position}"
  }
  print "\n"
  
  p "face area is #{$face.area}"
  print "\n"

  p "face glued instances are #{$face.get_glued_instances}"
  print "\n"
  
  p "face loops are #{$face.loops}"
  print "\n"
  
  p "face normal is #{$face.normal}"
  print "\n"
  
  p "face outer loop is #{$face.outer_loop}"
  print "\n"
  
  p "face plane is #{$face.plane}"
  print "\n"
  
  p "face vertices are #{$face.vertices}"
  print "\n"
  #
end

SketchUpEx.makeAface
SketchUpEx.face_describe

end #module


