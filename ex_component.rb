#####################################################
#  ex_component.rb
#  by Brad Denniston   Copyright (c) 2015
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
#  Start with the base layout showing the man
#   This script is an example of:
#    delete a component (delete the man)
#    add a component to the model - a cube at the origin
#     print out the component entities
#    move a component 10 to the right
#####################################################

module Component

  def self.printComponents
    componentdefinitions = Sketchup.active_model.definitions
    index = 1
    for cd in componentdefinitions
      printf "\nComponent #{index} definition\n"
	  if index > 1 then
	    entities = cd.entities
        num = entities.size
        printf "Number of entities is #{num}\n"
        for ent in entities
          p "Entity type is #{ent.typename} with vertices"
          for vert in ent.vertices
            puts( "vert #{vert.position}")
          end
        end
	  end
      index = index + 1
    end
  end

  # add a cube component
  #
  points = Array.new
  points[0] = ORIGIN
  points[1] = [10,0,0]
  points[2] = [10,10,0]
  points[3] = [0,10,0]

  new_comp_def = Sketchup.active_model.definitions.add("Cube size 10")

  # add the points to the active model defining a face
  newface = new_comp_def.entities.add_face(points)

  # extend the face in the component definition into a cube
  # If the z face is pointing up, reverse it.  
  newface.reverse! if newface.normal.z < 0
  newface.pushpull 10   # now this is the cube is defined

  # an instance must be placed at some location
  trans = Geom::Transformation.new # an empty, default transformation. 

  # Create an instance of the Cube component. 
  Sketchup.active_model.active_entities.add_instance(new_comp_def, trans)
  #
  print "\nBuilt the cube component, now print it out"
  self.printComponents

  # move_cube 10 to the right
  #
  xdelta = 10 # size of move
  entities = Sketchup.active_model.entities
  transform = Geom::Transformation.new([xdelta,0,0])
  entities.transform_entities(transform, entities[0])

  # show the new entity values
  printf "\nmoved the cube 10 to the right\n"
  self.printComponents

end #module
