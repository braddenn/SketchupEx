#####################################################
#  ex_transforms3.rb
#  by Brad Denniston   Copyright (c) 2015
#
# ex_create3CubeDefs - add 3 cube definitions
# ex_generateInstances - add and show 1 cube instance for each definition
# ex_moveCubeInstances  "move the instances
# ex_rotateInstances "rotate the instances
# ex_translate - translate cube #3 5 times in the same direction
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module Transform3

  # GLOBAL VARS ---------------------------------------
  #
  def self.reset
    $all_instances = Array.new   # normalized and sorted array of instances
    $exp_ents = Array.new    # all entities of one exploded instance
    $bricks = Array.new      # all bricks for one instance
    $outlist = Array.new    # all bricks in all instances
    $quadDef
    $pyramidDef
    $cubeDef
    $model = Sketchup.active_model
  end

  # print out all the component definitions for this model
  #
  def self.printComponents
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

  # print content of an exploded component instance
  #
  def self.printEntities( entities ) # this works
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

  # brickQuad - add a 4 sided component definition called quad
  #
  def self.makeQuadDef( length, width, height )
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
  end # self.makeQuadDef

  # makePymdDef - add a 5 sided component definition called pyramid
  #
  def self.makePymdDef( length, width, height )
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
  end # self.makePymdDef

  # makeCubeDef - add a 6-sided component definition called cube
  #
  def self.makeCubeDef( length, width, height )
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
    definition = $model.definitions.add( "cube"  )
    definition.entities.add_face( pts[0],pts[1], pts[2], pts[3]) #base
    definition.entities.add_face( pts[4],pts[5], pts[6], pts[7]) #top
    definition.entities.add_face( pts[0],pts[4], pts[7], pts[1]) #x
    definition.entities.add_face( pts[1],pts[7], pts[6], pts[2]) #xy
    definition.entities.add_face( pts[2],pts[6], pts[5], pts[3]) #yx
    definition.entities.add_face( pts[0],pts[3], pts[5], pts[4]) #y  
    return definition
  end # self.makeCubeDef

  # makeBrickDef - create a definition for a brick
  # params: number of faces, length, width, depth, definition name
  #
  def self.makeDefs
    $quadDef = self.makeQuadDef( 15, 15, 30 )
    $pymdDef = self.makePymdDef( 15, 15, 30 )
    $cubeDef = self.makeCubeDef( 60, 30, 15 )
  end

  # make one instance of each def
  #
  def self.makeInstances
    trans = Geom::Transformation.translation([0,-10,0])
    $model.entities.add_instance( $quadDef, trans )
    trans = Geom::Transformation.translation([-10,0,0])
    $model.entities.add_instance( $pymdDef, trans )
    trans = Geom::Transformation.translation([10,0,20])
    $model.entities.add_instance( $cubeDef, trans )
    puts "cube origin (10,0,20) is #{$cubeDef.instances[0].transformation.origin}"
  end

  # Brick.move - move to x, y, and z
  # inst - the instance to be moved
  # params: destination x,y,z
  #
  def self.move( inst, x, y, z )
    puts "before move of 15,15,15 inst.t is #{inst.transformation.to_a}"
    puts "origin is #{inst.transformation.origin.to_a}"
    t = Geom::Transformation.new([x,y,z])
    inst.transform! t
    puts "after move inst.t is #{inst.transformation.to_a}"
    puts "origin is #{inst.transformation.origin.to_a}"
  end # move

  # shift - add to x, y, and z
  # inst - the instance to be moved
  # params: inches added to current x, y, and z
  #
  def self.shift( inst, dx, dy, dz )
    puts "before shift of -15,-15,-15 inst.t is #{inst.transformation.to_a}, origin is #{inst.transformation.origin.to_a}"
    x = inst.transformation.origin.x + dx
    y = inst.transformation.origin.y + dy
    z = inst.transformation.origin.z + dz
    t = Geom::Transformation.new([x,y,z])
    inst.transform! t
    puts "after shift inst.t is #{inst.transformation.to_a}"
    puts "origin is #{inst.transformation.origin.to_a}"
  end # move

  # rotate - add to rotation
  # params - radians of rotation
  #
  def self.rotate( inst, rx, ry, rz, angle )
    vector = Geom::Vector3d.new rx,ry,rz # rotate around x axis
    t = inst.transformation
    pt = t.origin
    transformation = Geom::Transformation.rotation pt, vector, angle
    inst.transform! transformation
  end #rotate

  self.reset

  self.makeDefs
  self.makeInstances
  UI.messagebox "created quad, pyramid and cube"

  angle = Math::PI/8
  inst = $quadDef.instances[0]
  UI.messagebox "will rotate quad 22.5 degrees around x"
  self.rotate( inst, 1,0,0, angle)
  UI.messagebox "rotated quad 22.5 degrees around x"
  inst = $pymdDef.instances[0]
  UI.messagebox "will rotate pyramid 22.5 degrees around y"
  self.rotate( inst, 0,1,0, angle )
  UI.messagebox "rotated pyramid 22.5 degrees around y"
  UI.messagebox "will move pyramid to 10,10,10"
  self.move( inst, 10,10,10 )
  UI.messagebox "moved pyramid to 10,10,10"
  inst = $cubeDef.instances[0]
  puts "cube origin before rotation is #{inst.transformation.origin.to_a}"
  UI.messagebox "will rotate cube 22.5 degrees around z"
  self.rotate( inst, 0,0,1, angle )
  UI.messagebox "rotated cube 22.5 degrees around z"
  puts "cube origin after rotation is #{inst.transformation.origin.to_a}"
  UI.messagebox "will move cube to 15,15,15"
  self.move( inst, 15,15,15 )
  UI.messagebox "moved cube to 15,15,15"
  UI.messagebox "will shift cube by -15,-15,-15"
  self.shift( inst, -15, -15, -15)
  UI.messagebox "shifted cube by -15, -15, -15"

end #module
