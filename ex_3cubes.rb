#####################################################
#	ex_loop.rb
#	by Brad Denniston   Copyright (c) 2014
#
#	Demonstrate making cube instances
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################
#
# add a cube component
#
$inst1
$inst2
$inst3
#
# cubecomp - create a cube definition and 3 instances
#
def cubecomp
	points = Array.new
	points[0] = ORIGIN
	points[1] = [10,0,0]
	points[2] = [10,10,0]
	points[3] = [0,10,0]
	# create a component definition for the cube
	new_comp_def = Sketchup.active_model.definitions.add("Cube size 10")
	# create a face instance
	newface = new_comp_def.entities.add_face(points)
	# extend the face in the component definition into a cube
	# If the z face is pointing up, reverse it.  
	newface.reverse! if newface.normal.z < 0
	newface.pushpull 10   # now this is the cube is defined
	# an instance must be placed at some location, transform it
	trans0 = Geom::Transformation.new # an empty, default transformation. 
	# Create an instance of the Cube component. 
	act_ents = Sketchup.active_model.active_entities
	new_inst_index = act_ents.size - 1
	act_ents.add_instance(new_comp_def, trans0)
	$inst1 = act_ents[new_inst_index]
	trans1 = Geom::Transformation.new([4,4,4])
	$inst2 = act_ents.add_instance(new_comp_def, trans1)
	$inst3 = act_ents.add_instance(new_comp_def, trans1)
end

cubecomp



