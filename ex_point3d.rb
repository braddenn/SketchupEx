#####################################################
#	ex_point3d.rb
#	by Brad Denniston   Copyright (c) 2014
#
#	Demonstrate point3d module methods
#
#	THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# 	IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# 	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################
#
# ex_plus 
#
def ex_plus
	 pt1 = Geom::Point3d.new(10,10,10)
	 vector = Geom::Vector3d.new 1,2,3
	 pt3 = pt1 + vector
	 p "ex_plus, add vector, expect point Point3d(11,12,13)"
	 p "point #{pt3}"
	 p "note that pt1 + pt2 does not work, can't add points"
	 print "\n"
end
#
# ex_minus
#
def ex_minus
	 pt1 = Geom::Point3d.new(10,10,10)
	 pt2 = Geom::Point3d.new(15,15,15)
	 pt3 = pt2 - pt1
	 p "ex_minus, subtract point WORKS!, expect point Point3d(5,5,5)"
	 p "point #{pt3}"
	 print "\n"
	 vector = Geom::Vector3d.new 1,2,3
	 pt3 = pt1 - vector
	 p "ex_minus, subtract vector, expect point Point3d(9,8,7)"
	 p "point #{pt3}"
	 print "\n"
end
#
# ex_less_than
#
def ex_less_than
	pt1 = Geom::Point3d.new(10,10,10)
	pt2 = Geom::Point3d.new(20,20,20)
	result = pt1 < pt2
	p "ex_less_than, expect true, 10,10,10 closer than (10,10,11)"
	p "result = #{result}"
	print "\n"
end
#
# ex_equal
#
def ex_equal
	point1 = Geom::Point3d.new 1,1,1
	point2 = Geom::Point3d.new 10,10,4.145
	point3 = Geom::Point3d.new 10,10,4.145
	status = point1 == point2
	p "ex_equal, expect false, 1,1,1 not equal (10,10,4.145)"
	p "result = #{status}"
	status = point3 == point2
	p "ex_equal, expect true, 10,10,4.145 equals (10,10,4.145)"
	p "result = #{status}"
	print "\n"
 end
 #
 # ex_arrayIndex
 #
def ex_arrayIndex
	point = Geom::Point3d.new 1, 2, 3
	# retrieves the y value of 2
	yvalue = point[1]
	p "ex_arrayIndex, expect yvalue of 2"
	p "result = #{yvalue}"
	print "\n"
end
#
# ex_distance
#
def ex_distance
	point1 = Geom::Point3d.new 1,1,1
	point2 = Geom::Point3d.new 10,10,10
	distance = point1.distance point2
	p "ex_distance expect ~ 1' 3 9/16\""
	p "result is #{distance}"
	print "\n"
end 
#
# ex_distance_to_line
#
def ex_distance_to_line
	point1 = Geom::Point3d.new 1,1,1
	line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	distance = point1.distance_to_line line
	p "ex_distance_to_line. Expect sqrt(2)=1.414..."
	p "distance is #{distance}"
	print "\n"
end
#
# ex_distance_to_plane
#
def ex_distance_to_plane
	plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	point = Geom::Point3d.new 10,10,10
	distance = point.distance_to_plane plane
	p "ex_distance_to_plane(0,0,1) to point 10,10,10, expect 10.0"
	p "result: #{distance}"
	print "\n"
end
#
# ex_linear_combination
#
def ex_linear_combination
	point1 = Geom::Point3d.new 1,1,1
	point2 = Geom::Point3d.new 10,10,10
	# Gets the point on the line segment connecting point1 and point2 that is
	# 3/4 the way from point1 to point2.
	point = Geom::Point3d.linear_combination 0.25, point1, 0.75, point2
	p "ex_linear_combination - expect .75 of 1 to 10 -> 7.75"
	p "result (via inspect): #{point.inspect}"
	print "\n"
end
#
# ex_offset
#
def ex_offset
	point1 = Geom::Point3d.new(10,10,10)
	vector = Geom::Vector3d.new(0,0,1)
	point2 = point1.offset! vector
	p "ex_offset - expect 10,10,10 offset by vector 0,0,1 => 10,10,11"
	p "result: #{point2}"
	print "\n"
end
#
# ex_on_line?
#
def ex_on_line
	line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	point1 = Geom::Point3d.new 10,10,10
	point2 = Geom::Point3d.new 0,0,0.5
	statusf = point1.on_line? line
	statust = point2.on_line? line
	p "ex_on_line - is 10,10,10 on line 0,0,0 1,1,1"
	p "result: #{statusf}"
	p "ex_on_line - is 0,0,0.5 on line 0,0,0 1,1,1"
	p "result: #{statust}"
	print "\n"
end
#
# ex_on_plane?
#
def ex_on_plane
	plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	point1 = Geom::Point3d.new 10,10,10
	point2 = Geom::Point3d.new 0,0,0.5
	statusf = point1.on_plane? plane
	statust = point2.on_line? plane
	p "ex_on_plane - is 10,10,10 on plane 0,0,0 0,0,1"
	p "result: #{statusf}"
	p "ex_on_line - is 0,0,0.5 on plane 0,0,0 0,0,1"
	p "result: #{statust}"
	print "\n"
end
#
# ex_project_to_line
#
def ex_project_to_line
	line = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	point = Geom::Point3d.new 10,10,10
	projected_point = point.project_to_line line
	p "ex_project_to_line - line 0,0,0 0,0,1, point 10,10,10"
	p "expected result: 0,0,10"
	p "result #{projected_point}"
	print "\n"
end
#
# ex_project_to_plane
#
def ex_project_to_plane
	plane = [Geom::Point3d.new(0,0,0), Geom::Vector3d.new(0,0,1)]
	point = Geom::Point3d.new 10,10,10
	projected_point = point.project_to_plane plane
	p "ex_project_to_plane - plane 0,0,0 0,0,1, point 10,10,10"
	p "expected result: 10,10,0"
	p "result #{projected_point}"
	print "\n"
end
#
# ex_transform
#
def ex_transform
	point1 = Geom::Point3d.new 10,10,10
	point2 = Geom::Point3d.new 100,200,300
	transform = Geom::Transformation.new(point2)
	point3 = point1.transform transform
	p "ex_transform 10,10,10 to 100,200,300"
	p "point1: #{point1}, transform via point2: #{point2}"
	p "result is point3: #{point3}"
	p "point1 is still #{point1}"
	p "NOTE: this is equivalent to (pt2 + vector1)."
	print"\n"
 end
#
# ex_vector_to
#
def ex_vector_to
	pt1 = [1,1,0]
	pt2 = [3,1,0]
	pt3 = pt1.vector_to( pt2 ) # returns the vector (2,0,0)
	p "result is point3: #{pt3}"
	p "point1 is still #{pt1}"
	p "this is equivalent to (pt2 - pt1)"
	print "\n"
end
 
ex_plus
ex_minus
ex_less_than
ex_equal
ex_arrayIndex
ex_distance
ex_distance_to_line
ex_distance_to_plane
ex_linear_combination
ex_offset
ex_on_line
ex_on_plane
ex_project_to_line
ex_project_to_plane
ex_transform
ex_vector_to