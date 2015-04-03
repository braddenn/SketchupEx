#####################################################
#  ex_clockwise.rb
#  by Brad Denniston   Copyright (c) 2014
#
#  Demonstrate normal for clockwise and CCW faces
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module ClockWise
#
  def self.reset
    $inst1 = nil
    $ent_array = Array.new # array of cube elements
	$model = Sketchup.active_model
  end

  # cubecomp
  #
  def self.cubecomp
    # create a Clockwise face definition
    points = Array.new
    points[0] = [0,0,0]
    points[1] = [10,0,0]
    points[2] = [10,10,0]
    points[3] = [0,10,0]
    # create a component definition for the cube
    new_comp_def = Sketchup.active_model.definitions.add("Cube size 10")
    num = $model.entities.count
    p "Initial number of entites in model for a cube is #{num}"

    # create a Counterclockwise face instance
    cwNewface = new_comp_def.entities.add_face(points)
    revpoints = Array.new
    revpoints[0] = [0,0,0]
    revpoints[1] = [0,10,0]
    revpoints[2] = [10,10,0]
    revpoints[3] = [10,0,0]
    ccwNewface = new_comp_def.entities.add_face(revpoints)
    num = $model.entities.count
    p "Added two faces. Number of entites in model is #{num}"
    puts "new CW face normal is #{cwNewface.normal.to_a}"
    puts "new CCW face normal is #{ccwNewface.normal.to_a}"

    # extend the face in the component definition into a cube
    # If the z face is pointing up, reverse it.  
    cwNewface.reverse! if cwNewface.normal.z < 0
    puts "Reversed CW face normal is #{cwNewface.normal.to_a}"
    cwNewface.pushpull 10   # now this is the cube
    num = $model.entities.count
    p "After face.pushpull number of entites in model is #{num}"

    # an instance must be placed at some location, transform it
    trans0 = Geom::Transformation.new # an empty, default transformation. 
    puts "the origin of the transformation is #{trans0.origin.to_a}"

    # Create an instance of the Cube component. 
    act_ents = Sketchup.active_model.active_entities
    new_inst_index = act_ents.size - 1
    act_ents.add_instance(new_comp_def, trans0)
    $inst1 = act_ents[new_inst_index]
    num = $model.entities.count
    p "After cube instance added, number of entites in model is #{num}"
  end

  # printEntities
  #
  def self.printEntities
    $ent_array.each { |e|
    if e.typename == "Vertex"
      p "Entity type is #{e.typename} with position #{e.position}"
    elsif e.typename == "EdgeUse"
      p "Entity type is EdgeUse with loop #{e.loop}"      
    else
      p "Entity type is #{e.typename} with vertices"
      if e.typename == "Face"
      p "face normal is: #{e.normal.to_a}"
      end
      for vert in e.vertices
      puts( "vert #{vert.position}")
      end
    end
    }
  end

  # ex_explode - explode - returns array of all entities in instance
  #
  def self.ex_explode
    $ent_array = $inst1.explode
    p "The cube component instance has now been destroyed."
    num = $model.entities.count
    p "number of entites in model is now #{num}, 6 faces, 12 edges"
    p "Cube exploded to #{$ent_array.size} entities."
    printEntities
    ### group = $ent_array.add_group .. is not legal, array not an 'entities'
    print("\n")
  end

  self.reset
  self.cubecomp
  self.ex_explode

end #module


