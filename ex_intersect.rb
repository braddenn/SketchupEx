#####################################################
#  intersect.rb
#  by Brad Denniston   Copyright 2015
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# Module  intersect - adds a simple intersect command to Sketchup
#   Sketchup Pro version, for $600, provides a component instance
# intersect operation. This is a substitute for a few special cases.
# Reference:
# http://geomalgorithms.com/a06-_intersect-2.html
#####################################################

module Intersect

  # closest_points -
  #
  def self.closest_points
    line1 = [Geom::Point3d.new(0, 2, 0), Geom::Vector3d.new(1, 0, 0)]
    line2 = [Geom::Point3d.new(3, 0, 0), Geom::Vector3d.new(0, 1, 0)]
    points = Geom.closest_points(line1, line2)
    p "ex_closest_points, expect point Point3d(3, 2, 0)."
    p "print points as #{points}"
    p "print points as to_a #{points}"
    print "\n"
  end

  # fit_plane_to_points
  #
  def self.fit_plane_to_points
    point1 = Geom::Point3d.new(0, 0, 0)
    point2 = Geom::Point3d.new(10, 10, 10)
    point3 = Geom::Point3d.new(25, 25, 25)
    plane = Geom.fit_plane_to_points(point1, point2, point3)
    p "ex_fit_plane_to_points (0,0,0),(10,10,10), (25,25,25)"
    p "got plane #{plane}"
    print "\n"
  end

  # intersection of line  and line
  #
  def self.int_line_line # OK
    # Defines a line parallel to the Y axis, offset 20 units.
    line1 = [Geom::Point3d.new(20, 0, 0), Geom::Vector3d.new(0, 1, 0)]
    # Defines a line parallel to the X axis, offset 10 units.
    line2 = [Geom::Point3d.new(0, 10, 0), Geom::Point3d.new(20, 10, 0)]
    # This will return a point Point3d(20, 10, 0).
    point = Geom.intersect_line_line(line1, line2)
  end

  # intersectin of line and plane
  #
  def self.int_line_plane # OK
    # Defines a line parallel to the X axis, offset 20 units.
    line = [Geom::Point3d.new(-10, 20, 0), Geom::Vector3d.new(1, 0, 0)]
    # Defines a plane with it's normal parallel to the x axis.
    plane = [Geom::Point3d.new(10, 0 ,0), Geom::Vector3d.new(1, 0, 0)]
    # This will return a point Point3d(10, 20, 0).
    point = Geom.intersect_line_plane(line, plane)
  end
   
  # intersection of plane and plane
  #
  def self.int_plane_plane #
    # Defines a plane with it's normal parallel to the x axis.
    plane1 = [Geom::Point3d.new(10, 0 ,0), Geom::Vector3d.new(1, 0, 0)]
    # Defines a plane with it's normal parallel to the y axis.
    plane2 = [Geom::Point3d.new(0, 20 ,0), Geom::Vector3d.new(0, 1, 0)]
    # This will return a line [Point3d(10, 20, 0), Vector3d(0, 0, 1)].
    line = Geom.intersect_plane_plane(plane1, plane2)
  end

  # linear combination - fractional distance along a line
  #
  def self.int_linear_combo
    point1 = Geom::Point3d.new(1, 1, 1)
    point2 = Geom::Point3d.new(10, 10, 10)
    # Gets the point on the line segment connecting point1 and point2 that is
    # 3/4 the way from point1 to point2: Point3d(7.75, 7.75, 7.75).
    point = Geom.linear_combination(0.25, point1, 0.75, point2)
  end

  # is point in a triangle
  #
  def self.point_in_triangle
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
   end
   
   # is a point in a quadrangle
   #
   def self.point_in_quadrangle
    # Create a point that we want to check. (Note that the 3rd coordinate,
    # the z, is ignored for purposes of the check.)
    point = Geom::Point3d.new(5, 0, 10)

    # Create a series of points of a triangle we want to check against.
    quadrangle = []
    quadrangle << Geom::Point3d.new(0, 0, 0)
    quadrangle << Geom::Point3d.new(10, 0, 0)
    quadrangle << Geom::Point3d.new(0, 10, 0)
    quadrangle << Geom::Point3d.new(10, 10, 0)

    # Test to see if our point is inside the triangle, counting hits on
    # the border as an intersection in this case.
    hits_on_border_count = true
    status = Geom.point_in_polygon_2D(point, quadrangle, hits_on_border_count)
   end

  p "find closest points between 2 lines #{self.closest_points}"
  p "fit a plane to a set of points #{self.fit_plane_to_points}"
  p "intersect line to line #{self.int_line_line}"
  p "intersect line to plane #{self.int_line_plane}"
  p "intersect plane to plane #{self.int_plane_plane}"
  p "linear combination, expect 7.75 #{self.int_linear_combo}"
  p "point_in_polygon_2D, triangle #{self.point_in_triangle}"
  p "point_in_polygon_2D, quad #{self.point_in_quadrangle}"

end # module




