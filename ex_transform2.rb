#####################################################
#	ex_transforms2.rb
#	by Brad Denniston   Copyright (c) 2015
#
# ex_create3CubeDefs - add 3 cube definitions
# ex_generateInstances - add and show 1 cube instance for each definition
# ex_moveCubeInstances  "move the instances
# ex_rotateInstances "rotate the instances
# ex_translate - translate cube #3 5 times in the same direction
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

require 'sketchup.rb'
#
# add a cube component at the origin, pass in the size
#
def ex_addCubeDef (size)
	points = Array.new
	points[0] = ORIGIN
	points[1] = [size,0,0]
	points[2] = [size,size,0]
	points[3] = [0,size,0]

	new_comp_def = Sketchup.active_model.definitions.add("Cube size #{size}")

	# add the points to the active model by defining a face
	newface = new_comp_def.entities.add_face(points)

	# extend the face in the component definition into a cube
	# If the z face is pointing up, reverse it.  
	newface.reverse! if newface.normal.z < 0
	newface.pushpull size   # now the cube is defined
end
#
# generate 3 cube definitions
#
def ex_create3CubeDefs
	ex_addCubeDef(5)
	ex_addCubeDef(10)
	ex_addCubeDef(20)
	defs = Sketchup.active_model.definitions
	p "There are #{defs.length} definitions, [0] is the engineer"
end
#
# add an instances of each cube
#
def ex_generateInstances
	entities = Sketchup.active_model.active_entities
	defs = Sketchup.active_model.definitions
	[1,2,3].each do
		|n|
		# an instance must be placed at some location
		trans = Geom::Transformation.new([0,0,0])
		inst = entities.add_instance(defs[n], trans)
		p "definition #{n} has #{defs[n].instances.length} instances"
		p "NOTE: from the display, the transform point sets the bottom, left, front of the instance"
	end
end
#
# rotate the instances
#
def ex_rotateInstances
	defs = Sketchup.active_model.definitions
	#pt = blf of each instance
	angle = Math::PI/4
	# yes, this could be done with loops, try it
	# its just easier to follow if not in a loop
	#
	# instance 1
	inst = defs[1].instances[0]
	t = inst.transformation
	pt = t.origin # of this instance
	vector = Geom::Vector3d.new 1,0,0 # rotate around x axis
	transformation = Geom::Transformation.rotation pt, vector, angle
	inst.transform! transformation
	#
	# instance 2
	inst = defs[2].instances[0]
	t = inst.transformation
	pt = t.origin # of this instance
	vector = Geom::Vector3d.new 0,1,0 # rotate around y axis
	transformation = Geom::Transformation.rotation pt, vector, angle
	inst.transform! transformation
	#
	# instance 3
	inst = defs[3].instances[0]
	t = inst.transformation
	pt = t.origin # of this instance
	vector = Geom::Vector3d.new 0,0,1 # rotate around z axis
	transformation = Geom::Transformation.rotation pt, vector, angle
	inst.transform! transformation
end
#
# move the cubes 
#
def ex_moveCubeInstances
	defs = Sketchup.active_model.definitions
	[1,2,3].each do
		|n|
		defs[n].instances.each do 
			|i|
			p "Before move transform of instance #{n} is:"
			p "#{i.transformation.to_a}"
			transform = Geom::Transformation.new([10*n,15*n,10*n])
			p "transform from 0,0,0 to #{10*n}, #{15*n}, #{10*n}"
# 			i.move! transform # move! doesn't update the display
			i.transform! transform
			p "After move transform of instance #{n} is:"
			p "#{i.transformation.to_a}"
		end
	end
end
#
# translate cube 3
#
def ex_translate
	defs = Sketchup.active_model.definitions
	d = defs[3]
	v = Geom::Vector3d.new 10,10,10 # 45 degree angle
	t = Geom::Transformation.translation v
	i = d.instances[0]
	[1,2,3,4,5].each do
		|k|
		i.transform! t
		p "After translate transform of instance is:"
		p "#{i.transformation.to_a}"
	end
end

UI.messagebox "add 3 cube definitions - nothing will be displayed"
ex_create3CubeDefs
UI.messagebox "add and show 1 instance for each definition"
ex_generateInstances
UI.messagebox "move the instances"
ex_moveCubeInstances
UI.messagebox "rotate the instances"
ex_rotateInstances
UI.messagebox "translate instance #3 5 times in the same direction"
ex_translate




