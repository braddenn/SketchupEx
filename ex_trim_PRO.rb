# ConBot
# Author Brad Denniston   4 Jan 2015
#
# This is the ConBot design and contruction demonstration
#
# See ConBotInit.rb at SketchUp/Plugins for startup as
# SketchUp loads all .rb files at this location when it starts up
#
# ConBot breaks a CAG model into bricks. Then in the physical world
# construction robots (ConBots) move the bricks to the correct locations at 
# the construction site as
# they physically construct the item in the model. 
# This is similar to 3-D printing however in this case small nanobots do 
# the construction. In early implementations these could be millibots or 
# centibots.
#
# ConBot proceeds in the following steps:
# # Sketchup Design
# 1 - Design - buid a model in a CAG program
# 2 - Save to Sketchup file
#
# ConBotAnalyze
# 1 - Read the design file
# 2 - normalize - move vertically till lowest point is at z=0
# 3 - sort - build an instance array with max y first, then min x, then min z
#		This sets the build order
# 4 - Analyze - parse the model breaking it up into small pieces with location data
# 5 - Order - put the pieces into an array in the sequence of construction
# 6 - Scaffold - insert required scaffolding activity
# 7 - Transmit - save to ConBot file, send the file to the construction site
#
# ConBotBuild
# 1 - Load the ConBot file
# 2 - Construct - ConBots move scaffolding and pieces as needed to construct
# ##################################################################3

# First pull in the standard API hooks.
require 'sketchup.rb'
SKETCHUP_CONSOLE.show
#
# GLOBAL VARS ---------------------------------------
#
$all_instances = Array.new 	# normalized and sorted array of instances
$exp_ents = Array.new		# all entities of one exploded instance
$bricks = Array.new			# all bricks for one instance
$outlist = Array.new		# all bricks in all instances
$quadDef
$pyramidDef
$cubeDef
$model = Sketchup.active_model
#
# UTILITIES ----------------------------------------------
#
# print out all the component definitions for this model
#
def printComponents
	compdefs = Sketchup.active_model.definitions
	index = 1
	for compdef in compdefs
		if( index > 1 )
			printf "\nComponent #{index} definition desc is #{compdef.description}\n"
			entities = compdef.entities
			num = entities.size
			p "Number of entities in the component def is #{num}\n"
			if num > 0
				entities.each { |ent|
					p "Entity type is #{ent.typename} with vertices"
					for vert in ent.vertices
						puts( "vert #{vert.position}")
					end
				}
			end
		end
		index = index + 1
	end
end
#
# print content of an exploded component instance
#
def printEntities( entities ) # this works
	num = entities.size
	printf "Number of entities is #{num}\n"
	for ent in entities
		p "Entity type is #{ent.typename} with vertices"
		if ent.typename != "Vertex" && ent.typename != "EdgeUse"
			for vert in ent.vertices
				puts( "vert #{vert.position}")
			end
		end
	end
end
#
# brickQuad - add a 4 sided component definition called quad
#
def makeQuadDef( length, width, height )
	pts = Array.new
	pts[0] = [0,0,0]
	pts[1] = [length,0,0] # x
	pts[2] = [0, width,0] # y
	pts[3] = [0,0,height] # z
	definition = $model.definitions.add( "quad" )
	definition.entities.add_face( pts[0],pts[1], pts[2] ) #base
	definition.entities.add_face( pts[0],pts[1], pts[3]) # x side
	definition.entities.add_face( pts[1],pts[2], pts[3]) # xy side
	definition.entities.add_face( pts[0], pts[2], pts[3]) # y side
	return definition
end # makeQuadDef
#
# makePymdDef - add a 5 sided component definition called pyramid
#
def makePymdDef( length, width, height )
	pts = Array.new	
	pts[0] = [0,0,0]
	pts[1] = [length,0,0] # x
	pts[2] = [length, width,0] # xy
	pts[3] = [0,width,0] # y
	pts[4] = [length/2, width/2, height]
	definition = $model.definitions.add( "pymd" )	
	definition.entities.add_face( pts[0],pts[1], pts[2], pts[3] ) #base
	definition.entities.add_face( pts[0], pts[1], pts[4]) # x side
	definition.entities.add_face( pts[1], pts[2], pts[4]) # yx side
	definition.entities.add_face( pts[2], pts[3], pts[4]) # xy side
	definition.entities.add_face( pts[3], pts[0], pts[4]) # y side
	return definition
end # makePymdDef
#
# makeCubeDef - add a 6-sided component definition called cube
#
def makeCubeDef( length, width, height )
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
	definition = $model.definitions.add( "cube"	)
	definition.entities.add_face( pts[0],pts[1], pts[2], pts[3]) #base
	definition.entities.add_face( pts[4],pts[5], pts[6], pts[7]) #top
	definition.entities.add_face( pts[0],pts[4], pts[7], pts[1]) #x
	definition.entities.add_face( pts[1],pts[7], pts[6], pts[2]) #xy
	definition.entities.add_face( pts[2],pts[6], pts[5], pts[3]) #yx
	definition.entities.add_face( pts[0],pts[3], pts[5], pts[4]) #y	
	return definition
end # makeCubeDef
#
# OPERATIONS
#
# makeBrickDef - create a definition for a brick
# params: number of faces, length, width, depth, definition name
#
def makeDefs
	$cubeDef = makeCubeDef( 10, 10, 10 )
end
#
# make one instance of each def
#
def makeInstances
	trans = Geom::Transformation.translation([0,0,0])
	$model.entities.add_instance( $cubeDef, trans )
	trans = Geom::Transformation.translation([12,0,0])
	$model.entities.add_instance( $cubeDef, trans )
end
#
# Brick.move - move to x, y, and z
# inst - the instance to be moved
# params: destination x,y,z
#
def move( inst, x, y, z )
	t = Geom::Transformation.new([x,y,z])
	inst.transform! t
end # move
#
# shift - add to x, y, and z
# inst - the instance to be moved
# params: inches added to current x, y, and z
#
def shift( inst, dx, dy, dz )
	x = inst.transformation.origin.x + dx
	y = inst.transformation.origin.y + dy
	z = inst.transformation.origin.z + dz
	t = Geom::Transformation.new([x,y,z])
	inst.transform! t
end # move
#
# rotate - add to rotation
# params - radians of rotation
#
def rotate( inst, rx, ry, rz, angle )
	vector = Geom::Vector3d.new rx,ry,rz # rotate around x axis
	t = inst.transformation
	pt = t.origin
	transformation = Geom::Transformation.rotation pt, vector, angle
	inst.transform! transformation
end #rotate

def trim( instA, instB )
	grp = instA.trim instB
	printEntities grp.entities
end
	
makeDefs
makeInstances
move $cubeDef.instances[1], 8, 0, 0
trim $cubeDef.instances[0], $cubeDef.instances[1]

