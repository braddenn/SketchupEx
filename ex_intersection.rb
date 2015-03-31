#####################################################
#  ex_geom.rb
#  by Brad Denniston   Copyright 2014
#
#  Demonstrate geom module methods
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
# closest_points -
#
def SketchUpEx.closest_points
  line1 = [Geom::Point3d.new(0, 2, 0), Geom::Vector3d.new(1, 0, 0)]
  line2 = [Geom::Point3d.new(3, 0, 0), Geom::Vector3d.new(0, 1, 0)]
  points = Geom.closest_points(line1, line2)
  p "ex_closest_points, expect point Point3d(3, 2, 0)."
  p "print points as #{points}"
  p "print points as to_a #{points}"
  print "\n"
end
#
# fit_plane_to_points
#
def SketchUpEx.fit_plane_to_points
  point1 = Geom::Point3d.new(0, 0, 0)
  point2 = Geom::Point3d.new(10, 10, 10)
  point3 = Geom::Point3d.new(25, 25, 25)
  plane = Geom.fit_plane_to_points(point1, point2, point3)
  p "ex_fit_plane_to_points (0,0,0),(10,10,10), (25,25,25)"
  p "got plane #{plane}"
  print "\n"
end
#
# intersect_line_line - is this pro only?
#
def SketchUpEx.intersect_line_line
  # Defines a line parallel to the Y axis, offset 20 units.
  line1 = [Geom::Point3d.new(20, 0, 0), Geom::Vector3d.new(0, 1, 0)]
  # Defines a line parallel to the X axis, offset 10 units.
  line2 = [Geom::Point3d.new(0, 10, 0), Geom::Point3d.new(20, 10, 0)]
  # This will return a point Point3d(20, 10, 0).
  point = Geom.intersect_line_line(line1, line2)
  p "ex_intersect_line_line. Expect: Point3d(20, 10, 0)"
  p "got #{point}"
  print "\n"
end
#
#intersect_line_plane - is this pro only?
#
def SketchUpEx.intersect_line_plane
   # Defines a line parallel to the X axis, offset 20 units.
   line = [Geom::Point3d.new(-10, 20, 0), Geom::Vector3d.new(1, 0, 0)]
   # Defines a plane with it's normal parallel to the x axis.
   plane = [Geom::Point3d.new(10, 0 ,0), Geom::Vector3d.new(1, 0, 0)]
   # This will return a point Point3d(10, 20, 0).
   point = Geom.intersect_line_plane(line, plane)
   p "ex_intersect_line_plane expect Point3d(10, 20, 0)"
   p "got #{point}"
   print "\n"
 end
#
# intersect_plane_plane
#
  def SketchUpEx.intersect_plane_plane
  # Defines a plane with it's normal parallel to the x axis.
  plane1 = [Geom::Point3d.new(10, 0 ,0), Geom::Vector3d.new(1, 0, 0)]
  # Defines a plane with it's normal parallel to the y axis.
  plane2 = [Geom::Point3d.new(0, 20 ,0), Geom::Vector3d.new(0, 1, 0)]
  # This will return a line [Point3d(10, 20, 0), Vector3d(0, 0, 1)].
  line = Geom.intersect_plane_plane(plane1, plane2)
  p "ex_intersect_plane_plane, expect line [Point3d(10, 20, 0), Vector3d(0, 0, 1)]"
  p "got #{line}"
  print "\n"
end
#
# linear_combination
#
def SketchUpEx.linear_combination
  point1 = Geom::Point3d.new(1, 1, 1)
  point2 = Geom::Point3d.new(10, 10, 10)
  # Gets the point on the line segment connecting point1 and point2 that is
  # 3/4 the way from point1 to point2: Point3d(7.75, 7.75, 7.75).
  point = Geom.linear_combination(0.25, point1, 0.75, point2)
  p "ex_linear_combination, expect Point3d(7.75, 7.75, 7.75)"
  p "got #{point}"
  print "\n"
 end
#
# point_in_polygon_2D
#
def SketchUpEx.point_in_polygon_2D
  # Create a point that we want to check. (Note that the 3rd coordinate,
  # the z, is ignored for purposes of the check.)
  point = Geom::Point3d.new(5, 0, 10)

  # Create a series of points of a triangle we want to check against.
  triangle = []
  triangle << Geom::Point3d.new(0, 0, 0)
  triangle << Geom::Point3d.new(10, 0, 0)
  triangle << Geom::Point3d.new(0, 10, 0)

  # Test to see if our point is inside the triangle, counting hits on
  # the border as an intersection in this case.
  hits_on_border_count = true
  status = Geom.point_in_polygon_2D(point, triangle, hits_on_border_count)
  p "ex_point_in_polygon_2D. Expect true"
  p "got #{status}"
  print "\n"
 end
 #
 SketchUpEx.closest_points
 SketchUpEx.fit_plane_to_points
 SketchUpEx.intersect_line_line
 SketchUpEx.intersect_line_plane
 SketchUpEx.intersect_plane_plane
 SketchUpEx.linear_combination
 SketchUpEx.point_in_polygon_2D
 
 end #module
 