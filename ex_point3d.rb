#####################################################
#  point3d.rb
#  by Brad Denniston   Copyright (c) 2014
#
#  Demonstrate point3d module methods
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module Point3D

  # plus 
  #
  def self.plus
     pt1 = Geom::Point3d.new(10,10,10)
     vector = Geom::Vector3d.new 1,2,3
     pt3 = pt1 + vector
     p "plus, add vector, expect point Point3d(11,12,13)"
     p "point #{pt3}"
     p "note that pt1 + pt2 does not work, can't add points"
     print "\n"
  end

  # minus
  #
  def self.minus
     pt1 = Geom::Point3d.new(10,10,10)
     pt2 = Geom::Point3d.new(15,15,15)
     pt3 = pt2 - pt1
     p "minus, subtract point WORKS!, expect point Point3d(5,5,5)"
     p "point #{pt3}"
     print "\n"
     vector = Geom::Vector3d.new 1,2,3
     pt3 = pt1 - vector
     p "minus, subtract vector, expect point Point3d(9,8,7)"
     p "point #{pt3}"
     print "\n"
  end

  # less_than
  #
  def self.less_than
    pt1 = Geom::Point3d.new(10,10,10)
    pt2 = Geom::Point3d.new(20,20,20)
    result = pt1 < pt2
    p "less_than, expect true, 10,10,10 closer than (10,10,11)"
    p "result = #{result}"
    print "\n"
  end

  # equal
  #
  def self.equal
    point1 = Geom::Point3d.new 1,1,1
    point2 = Geom::Point3d.new 10,10,4.145
    point3 = Geom::Point3d.new 10,10,4.145
    status = point1 == point2
    p "equal, expect false, 1,1,1 not equal (10,10,4.145)"
    p "result = #{status}"
    status = point3 == point2
    p "equal, expect true, 10,10,4.145 equals (10,10,4.145)"
    p "result = #{status}"
    print "\n"
   end
   
  # arrayIndex
  #
  def self.arrayIndex
    point = Geom::Point3d.new 1, 2, 3
    # retrieves the y value of 2
    yvalue = point[1]
    p "arrayIndex, expect yvalue of 2"
    p "result = #{yvalue}"
    print "\n"
  end

  # distance
  #
  def self.distance
    point1 = Geom::Point3d.new 1,1,1
    point2 = Geom::Point3d.new 10,10,10
    distance = point1.distance point2
    p "distance expect ~ 1' 3 9/16\""
    p "result is #{distance}"
    print "\n"
  end 

  # distance_to_line
  #
  def self.distance_to_line
    point1 = Geom::Point3d.new 1,1,1
    line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    distance = point1.distance_to_line line
    p "distance_to_line. Expect sqrt(2)=1.414..."
    p "distance is #{distance}"
    print "\n"
  end

  # distance_to_plane
  #
  def self.distance_to_plane
    plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    point = Geom::Point3d.new 10,10,10
    distance = point.distance_to_plane plane
    p "distance_to_plane(0,0,1) to point 10,10,10, expect 10.0"
    p "result: #{distance}"
    print "\n"
  end

  # linear_combination
  #
  def self.linear_combination
    point1 = Geom::Point3d.new 1,1,1
    point2 = Geom::Point3d.new 10,10,10
    # Gets the point on the line segment connecting point1 and point2 that is
    # 3/4 the way from point1 to point2.
    point = Geom::Point3d.linear_combination 0.25, point1, 0.75, point2
    p "linear_combination - expect .75 of 1 to 10 -> 7.75"
    p "result (via inspect): #{point.inspect}"
    print "\n"
  end

  # self.offset
  #
  def self.offset
    point1 = Geom::Point3d.new(10,10,10)
    vector = Geom::Vector3d.new(0,0,1)
    point2 = point1.offset! vector
    p "offset - expect 10,10,10 offset by vector 0,0,1 => 10,10,11"
    p "result: #{point2}"
    print "\n"
  end

  # on_line?
  #
  def self.on_line
    line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    point1 = Geom::Point3d.new 10,10,10
    point2 = Geom::Point3d.new 0,0,0.5
    statusf = point1.on_line? line
    statust = point2.on_line? line
    p "self.on_line - is 10,10,10 on line 0,0,0 1,1,1"
    p "result: #{statusf}"
    p "self.on_line - is 0,0,0.5 on line 0,0,0 1,1,1"
    p "result: #{statust}"
    print "\n"
  end

  # on_plane?
  #
  def self.on_plane
    plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    point1 = Geom::Point3d.new 10,10,10
    point2 = Geom::Point3d.new 0,0,0.5
    statusf = point1.on_plane? plane
    statust = point2.on_line? plane
    p "self.on_plane - is 10,10,10 on plane 0,0,0 0,0,1"
    p "result: #{statusf}"
    p "self.on_line - is 0,0,0.5 on plane 0,0,0 0,0,1"
    p "result: #{statust}"
    print "\n"
  end

  # project_to_line
  #
  def self.project_to_line
    line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    point = Geom::Point3d.new 10,10,10
    projected_point = point.project_to_line line
    p "self.project_to_line - line 0,0,0 0,0,1, point 10,10,10"
    p "expected result: 0,0,10"
    p "result #{projected_point}"
    print "\n"
  end

  # project_to_plane
  #
  def self.project_to_plane
    plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
    point = Geom::Point3d.new 10,10,10
    projected_point = point.project_to_plane plane
    p "self.project_to_plane - plane 0,0,0 0,0,1, point 10,10,10"
    p "expected result: 10,10,0"
    p "result #{projected_point}"
    print "\n"
  end

  # transform
  #
  def self.transform
    point1 = Geom::Point3d.new 10,10,10
    point2 = Geom::Point3d.new 100,200,300
    transform = Geom::Transformation.new(point2)
    point3 = point1.transform transform
    p "self.transform 10,10,10 to 100,200,300"
    p "point1: #{point1}, transform via point2: #{point2}"
    p "result is point3: #{point3}"
    p "point1 is still #{point1}"
    p "NOTE: this is equivalent to (pt2 + vector1)."
    print"\n"
   end

  # vector_to
  #
  def self.vector_to
    pt1 = [1,1,0]
    pt2 = [3,1,0]
    pt3 = pt1.vector_to( pt2 ) # returns the vector (2,0,0)
    p "result is point3: #{pt3}"
    p "point1 is still #{pt1}"
    p "this is equivalent to (pt2 - pt1)"
    print "\n"
  end
   
  self.plus
  self.minus
  self.less_than
  self.equal
  self.arrayIndex
  self.distance
  self.distance_to_line
  self.distance_to_plane
  self.linear_combination
  self.offset
  self.on_line
  self.on_plane
  self.project_to_line
  self.project_to_plane
  self.transform
  self.vector_to

end # module

