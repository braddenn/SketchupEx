#####################################################
#	ex_rotate.rb
#	by Brad Denniston   Copyright (c) 2014, 2015
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################
#
$boxdef
$inst1
$inst2
$inst3
#
# create the definition of a box - 6 faces - a box
#
class CubeDef
{
	def initialize( id, length, width, height )
		@pts = []
		@definition = $model.definitions.add( "box#{id}" )
		@pts[0] = [0,0,0]
		@pts[1] = [length,0,0] # x
		@pts[2] = [length, width,0] # xy
		@pts[3] = [0,width,0]
		@pts[4] = [0, 0, height]
		@pts[5] = [0,width,height]
		@pts[6] = [length, width,height]
		@pts[7] = [length,0,height]
		# add the points to the active model defining a face
		@definition.entities.add_face( @pts[0],@pts[1], @pts[2], @pts[3]) #base
		@baseFace = @definition.entities[0]
		@definition.entities.add_face( @pts[4],@pts[5], @pts[6], @pts[7]) #top
		@definition.entities.add_face( @pts[0],@pts[4], @pts[7], @pts[1]) #x
		@definition.entities.add_face( @pts[1],@pts[7], @pts[6], @pts[2]) #xy
		@definition.entities.add_face( @pts[2],@pts[6], @pts[5], @pts[3]) #yx
		@definition.entities.add_face( @pts[0],@pts[3], @pts[5], @pts[4]) #y		
	end
	
	attr_reader( :@definition )
	attr_reader( :@baseFace )
end
#
# Another way to create a box
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
	newface.pushpull 10   # now this is the cube
end
#
# createInstances
#
def createInstance
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
#
# ex_explode - explode - returns array of all entities in instance
#
def ex_explode
	 # Assuming 'instance' is a ComponentInstance object
	 array = $inst3.explode
	 p "component instance has #{array.size} entities."
	 p "this component instance has now been destroyed."
	 print("\n")
end
#
# ex_intersect
#
def ex_intersect
	 p "!!! 'intersect' is a Pro only feature."
	 # result = $inst1.intersect($inst2)
end
#
# ex_is_manifold
#
def ex_is_manifold
	 status = $inst1.manifold?
	 p "is the cube manifold? #{status}"
	print "\n"
end
#
# ex_move
#
def ex_move
	 p "cube current location is #{$inst2.transformation.to_a}"
	 new_transformation = Geom::Transformation.new([100,0,0])
	 p "apply transformation [100,0,0]"
	 $inst2.move! new_transformation
	 p "cube new location is #{$inst2.transformation.to_a}"
	print "\n"
end
#
# ex_rotate
#
def ex_rotate
	 p "cube current location is #{$inst2.transformation.to_a}"
	 new_transformation = Geom::Transformation.new([0,0,0],[0,0,0], [Math::PI/4,0,0] )
	 p "apply transformation [0,0,0],[0,0,0], [PI/4,0,0]"
	 $inst2.move! new_transformation
	 p "cube new location is #{$inst2.transformation.to_a}"
	print "\n"
end
#
#scale
#
def ex_scale
	# Notes: scaling is by the same amount if all 6 directions (+/-3)
	# Picking a point on the instance to scale around fixes that point of the
	# instance and moves (scales) away from that point in all 6 directions
	 UI.messagebox "cube current location is #{$inst1.transformation.to_a}"
	 t = Geom::Transformation.scaling 5
	 $inst1.transform! t
	 UI.messagebox "scaled by 5 #{$inst1.transformation.to_a}"
	 t = Geom::Transformation.scaling 0.2
	 $inst1.transform! t
	 UI.messagebox "scaled back, by 0.2 #{$inst1.transformation.to_a}"
	 pt = [7,0,0]
	 t = Geom::Transformation.scaling pt, 2
	 $inst1.transform! t
	 UI.messagebox "scaled by 2 around 5,0,0 #{$inst1.transformation.to_a}"
	 t = Geom::Transformation.scaling pt, 2
	 $inst1.transform! t
	 UI.messagebox "scaled by 2 around 5,0,0 #{$inst1.transformation.to_a}"
 end
#
# ex_split
#
def ex_split
	entities = Sketchup.active_model.entities
	instance1 = entities[0]
	instance2 = entities[1]
	result = instance1.split(instance2)
	print "\n"
end
#
# ex_subtract
#
def ex_subtract
	entities = Sketchup.active_model.entities
	instance1 = entities[0]
	instance2 = entities[1]
	result = instance1.subtract(instance2)
	print "\n"
end
#
# ex_transform_me
#
def ex_transform_me
	entities = Sketchup.active_model.entities
	definition = Sketchup.active_model.definitions[0]
	transformation = Geom::Transformation.new([0,0,0])
	componentinstance = entities.add_instance(definition, transformation)
	new_transformation = Geom::Transformation.new([100,0,0])
	componentinstance.transform! new_transformation
	print "\n"
end
#
# ex_transformation
#
def ex_transformation
	print "\n"
	entities = Sketchup.active_model.entities
	definition = Sketchup.active_model.definitions[0]
	transformation = Geom::Transformation.new([0,0,0])
	componentinstance = entities.add_instance(definition, transformation)
	t = componentinstance.transformation
end
#
# ex_trim
#
def ex_trim
	entities = Sketchup.active_model.entities
	instance1 = entities[0]
	instance2 = entities[1]
	result = instance1.trim(instance2)
	print "\n"
end
#
# ex_union
#
def ex_union
	entities = Sketchup.active_model.entities
	instance1 = entities[0]
	instance2 = entities[1]
	result = instance1.union(instance2)
	print "\n"
end

cubecomp
ex_scale
ex_explode
ex_intersect
ex_is_manifold
ex_move
ex_rotate
ex_split
ex_subtract
ex_transform_me
ex_transformation
ex_trim
ex_union

 
