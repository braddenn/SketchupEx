#####################################################
#  ex_explode.rb
#  by Brad Denniston   Copyright (c) 2014
#
#  Demonstrate entity count when adding items and exploding itesm
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
$pts = Array.new
$inst1
$ent_array # array of cube elements
#
def SketchUpEx.cubecomp
  points = Array.new
  points[0] = ORIGIN
  points[1] = [10,0,0]
  points[2] = [10,10,0]
  points[3] = [0,10,0]
  # create a component definition for the cube
  new_comp_def = Sketchup.active_model.definitions.add("Cube size 10")
  num = Sketchup.active_model.entities.count
  p "Initial number of entites in model is #{num}"
  # create a face instance
  newface = new_comp_def.entities.add_face(points)
  num = Sketchup.active_model.entities.count
  p "Added face. Number of entites in model is #{num}"
  # extend the face in the component definition into a cube
  # If the z face is pointing up, reverse it.  
  newface.reverse! if newface.normal.z < 0
  newface.pushpull 10   # now this is the cube is defined
  num = Sketchup.active_model.entities.count
  p "After face.pushpull number of entites in model is #{num}"
  # an instance must be placed at some location, transform it
  trans0 = Geom::Transformation.new # an empty, default transformation. 
  # Create an instance of the Cube component. 
  act_ents = Sketchup.active_model.active_entities
  new_inst_index = act_ents.size - 1
  act_ents.add_instance(new_comp_def, trans0)
  $inst1 = act_ents[new_inst_index]
  num = Sketchup.active_model.entities.count
  p "After cube instance added, number of entites in model is #{num}"
end
#
# printEntities
def SketchUpEx.printEntities
  $ent_array.each { |e|
    if e.typename == "Vertex"
      p "Entity type is #{e.typename} with position #{e.position}"
    elsif e.typename == "EdgeUse"
      p "Entity type is EdgeUse with loop #{e.loop}"
    else
      p "Entity type is #{e.typename} with vertices"
      for vert in e.vertices
        puts( "vert #{vert.position}")
      end
    end
  }
end
#
# ex_explode - explode - returns array of all entities in instance
#
def SketchUpEx.ex_explode
 $ent_array = $inst1.explode
 p "The cube component instance has now been destroyed."
 num = Sketchup.active_model.entities.count
 p "number of entites in model is now #{num}, 6 faces, 12 edges"
 p "Cube exploded to #{$ent_array.size} entities."
 SketchUpEx.printEntities
 ### group = $ent_array.add_group .. is not legal, array not an 'entities'
 print("\n")
end

SketchUpEx.cubecomp
SketchUpEx.ex_explode

end #module



