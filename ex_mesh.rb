#####################################################
#	ex_mesh.rb
#	by Brad Denniston   Copyright (c) 2014
#
#	Demonstrate PolygonMesh methods
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
# cubecomp - build 3 cubes
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

$face
$mesh
$mesh2
$pts = Array.new
#
# ex_makeAmesh
#
def ex_makeAface
	$mesh1 = Geom::PolygonMesh.new
	$mesh2 = Geom::PolygonMesh.new
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
# ex_all_connected
#
def ex_all_connected
	connected = $face.all_connected
	p "connected is #{connected}" # shows all edges
	# to_a same as just connected.
	print "\n"
end
#
# ex_makePolyMesh
#
def ex_makePolyMesh
index = $mesh1.add_polygon( $pts )
	p "mesh1 index is #{index}"
	# p "Mesh1 is #{$mesh1[index]}" so what does the index mean?
	print "\n"
end
#
# ex_count
#
def ex_count_points
	index = $mesh2.add_polygon( $pts )
	$pts[4] = [15,15,0]
	$mesh2.add_point($pts[4]) # 5 sided
	num = $mesh2.count_points
	p "mesh2 point count is #{num}"
	print "\n"
end
#
# ex_faceToMesh
#
def faceToMesh
	$mesh1 = $face.mesh(7)
	p "mesh1 is now #{$mesh1}"
	print "\n"
end
#
# ex_point_at
#
def ex_point_at
	p "$mesh1 point at index 1 is #{$mesh1.point_at(1)}"
	p "$mesh1 point at index 2 is #{$mesh1.point_at(2)}"
	p "$mesh1 point at index 3 is #{$mesh1.point_at(3)}"
	p "$mesh1 index of point at [0,10,0] is #{$mesh1.point_index($pts[3])}"
	p "and $mesh1 points are #{$mesh1.points}"
	print "\n"
end

ex_makeAface
ex_all_connected
ex_makePolyMesh
ex_count_points
ex_point_at


