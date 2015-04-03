#####################################################
#  ex_rotate.rb
#  by Brad Denniston   Copyright (c) 2015
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module Rotate

  #
  def self.reset
    $boxDef
    $model = Sketchup.active_model
  end
  #
  # UTILITIES ----------------------------------------------

  # makeBoxDef - add a 6-sided component definition called box
  #
  def self.makeBoxDef( length, width, height )
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
    $boxDef = definition
  end
  #
  # OPERATIONS
  #

  # make one instance at x,y,z of a ComponentDefinition
  #
  def self.makeInstanceOfDefAt(compDef, x, y, z)
    trans = Geom::Transformation.translation([x,y,z])
    $model.entities.add_instance(compDef, trans )
  end

  # rotate - add to rotation
  # inst - the instance to be rotated
  # point - start of vector of rotation
  # vector - line through point that inst rotates around
  # angle - radians of rotation
  #
  def self.rotate( inst, point, vector, angle )
    puts "rotation is around point #{point.to_a}, vector #{vector.to_a}"
    puts "before rotation inst transformation is:"
    puts "#{inst.transformation.to_a}"
    puts "origin is #{inst.transformation.origin.to_a}"
    transformation = Geom::Transformation.rotation point, vector, angle
    inst.transform! transformation
    puts "after rotation inst transformation is:"
    puts "#{inst.transformation.to_a}"
    puts "and origin is #{inst.transformation.origin.to_a}"
  end #rotate

  self.reset
  
  self.makeBoxDef( 60, 30, 15 )

  #make an instance of a box at 0,0,0
  self.makeInstanceOfDefAt($boxDef, 0,0,0)
  puts "created new box instance at 0,0,0"
  inst = $boxDef.instances[0]
  UI.messagebox "made an instance of a box at 0,0,0"

  # set the rotation angle to 22.5 degrees
  angle = Math::PI/4
  puts "Rotation angle set to +/-45 degrees"

  puts "rotate box at point 0,0,0 around the x axis"
  UI.messagebox "will rotate at point 0,0,0 around the x axis"
  vector = Geom::Vector3d.new 1,0,0 # the x axis
  pt = Geom::Point3d.new 0,0,0
  self.rotate( inst, pt, vector, angle)
  UI.messagebox "rotated box around x by 22 degrees"

  UI.messagebox "will rotate box at end point around z"
  vector = Geom::Vector3d.new 0,0,1 # the z axis
  pt = Geom::Point3d.new 60,0,0 # around end of box length
  self.rotate( inst, pt, vector, angle)
  UI.messagebox "rotated box at end point around z"

  UI.messagebox "made an instance of a box at 50,50,50"
  self.makeInstanceOfDefAt($boxDef, 50,50,50)
  inst = $boxDef.instances[1]
  puts "created new box at 50,50,50"
  UI.messagebox "created new box at 50,50,50"

  UI.messagebox "will rotate new box from its origin by 30 degrees around y axis"
  pt = inst.transformation.origin
  vector = Geom::Vector3d.new 0,1,0 # the y axis
  self.rotate( inst, pt, vector, angle)
  UI.messagebox "rotated box around its origin, y axis"

  UI.messagebox "will rotate back"
  vector = Geom::Vector3d.new 0,1,0 # the y axis
  self.rotate( inst, pt, vector, -angle)
  UI.messagebox "rotated box around its origin, y axis"

  UI.messagebox "will rotate new box by 30 degrees around point 0, y axis"
  pt = [0,0,0]
  vector = Geom::Vector3d.new 0,1,0 # the y axis
  self.rotate( inst, pt, vector, angle)
  UI.messagebox "rotated box around point 0, y axis"

end # module



