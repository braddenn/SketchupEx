#####################################################
#  ex_transforms.rb
#  by Brad Denniston   Copyright not 2014
#
#  Demonstrate Geom::Transform methods
#  ex_trans_trans - trans * point
#  ex_transaxes - move the origin to a new location
#  ex_new_identity - show what an identity transformation looks like
#  ex_is_identity - is this transformation an identity transformation
#  ex_interpolate
#  ex_inverse - show what inverting a transformation looks like
#  ex_origin
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
#   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
#   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#####################################################

module SketchUpEx
#
# transform * point: multiply
# trans_trans
#
def SketchUpEx.trans_trans
  point1 = Geom::Point3d.new 10,20,30
  point2 = Geom::Point3d.new 2,2,2
  t = Geom::Transformation.new point1
  point3 = t * point2
  p "point3 = t of point1(2,2,2) * point2(10,20,30)"
  p "point3 is = #{point3}"
  print "\n"
end
#
# transaxes
#
def SketchUpEx.transaxes
  # Geom::Transformation.axes
  vectorx = Geom::Vector3d.new 1,1,1
  vectory = Geom::Vector3d.new 0,1,0
  vectorz = Geom::Vector3d.new 0,0,1
  origin = [0,0,0]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  p "Geom::Transform.axes origin, vectors xaxis, yaxis, zaxis"
  p "origin is #{origin}"
  p "vectors: xaxis #{vectorx}, yaxis #{vectory} zaxis #{vectorz}"
  p "The transform that is created is:"
  p "#{t.to_a}"
  puts
  #
  # Geom::Transformation.axes with vectors
  vectorx = Geom::Vector3d.new 1,2,3
  vectory = Geom::Vector3d.new 0,1,0
  vectorz = Geom::Vector3d.new 0,0,1
  origin = [0,0,0]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  p "Geom::Transform.axes origin, vectors xaxis, yaxis, zaxis"
  p "origin is #{origin}"
  p "vectors: xaxis #{vectorx}, yaxis #{vectory} zaxis #{vectorz}"
  p "The transform that is created is:"
  p "#{t.to_a}"
  puts
  #
  # Geom::Transformation.axes with vectors
  vectorx = Geom::Vector3d.new 1,0,0
  vectory = Geom::Vector3d.new 1,2,3
  vectorz = Geom::Vector3d.new 0,0,1
  origin = [0,0,0]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  p "Geom::Transform.axes origin, vectors xaxis, yaxis, zaxis"
  p "origin is #{origin}"
  p "vectors: xaxis #{vectorx}, yaxis #{vectory} zaxis #{vectorz}"
  p "The transform that is created is:"
  p "#{t.to_a}"
  puts
  #
  # transform axis with vectors
  vectorx = Geom::Vector3d.new 1,2,3
  vectory = Geom::Vector3d.new 14,15,16
  vectorz = Geom::Vector3d.new 10,20,30
  origin = [0,0,0]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  p "Geom::Transform.axes origin, vectors xaxis, yaxis, zaxis"
  p "origin is #{origin}"
  p "vectors: xaxis #{vectorx}, yaxis #{vectory} zaxis #{vectorz}"
  p "The transform that is created is:"
  p "#{t.to_a}"
  puts
  #
  # move origin
  origin = [10,20,30]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  p "To move origin (0,0,0) to #{origin} the axis transform is"
  p " #{t.to_a}"
  print "\n"
end
#
# clone
#
def SketchUpEx.clone
  vectorx = Geom::Vector3d.new 1,0,0
  vectory = Geom::Vector3d.new 0,6,0
  vectorz = Geom::Vector3d.new 0,0,13
  origin = [10,20,30]
  t = Geom::Transformation.axes origin, vectorx, vectory, vectorz
  t2 = t.clone
  p "clone t to t2"
  p "t is #{t.to_a}"
  puts "clone is #{t2.to_a}"
  print "\n"
end
# 
# new_identity
#
def SketchUpEx.new_identity
  t0 = Geom::Transformation.new
  p "Identity transform useing Geom::Transformation.new looks like: "
  p "#{t0.to_a}"
  print "\n"
end
#
# is_identity
#
def SketchUpEx.is_identity
  t0 = Geom::Transformation.new
  p "Is this transform:"
  p "#{t0.to_a}"
  p " an identity? #{t0.identity?}"
  print "\n"
  #
  point = Geom::Point3d.new 10,20,30
  trans = Geom::Transformation.new point
  status = trans.identity?
  p "point #{point} Geom::Transformation.new point becomes transform:"
  p "#{trans.to_a}."
  p "Identity status is #{status}"
  print "\n"
  #
  point = Geom::Point3d.new 0,0,0
  trans = Geom::Transformation.new point
  status = trans.identity?
  p "Point #{point} Geom::Transformation.new point becomes transform:"
  p "#{trans.to_a}."
  p "Identity status is #{status}"
  print "\n"
  #
  point = Geom::Point3d.new 1,1,1
  trans = Geom::Transformation.new point
  status = trans.identity?
  p "Point #{point} by Geom::Transformation.new point becomes transform"
  p "#{trans.to_a}"
  p "Identity status is #{status}"
  print "\n"
end
 #
 # interpolate
 #
 def SketchUpEx.interpolate
   point1 = Geom::Point3d.new 10,20,30
   t1 = Geom::Transformation.new ORIGIN
   t2 = Geom::Transformation.new point1
   t3 = Geom::Transformation.interpolate t1, t2, 0.33
   p "Interpolate by 0.33 between origin and p1 at 10,20,30"
   p "Transform 1 is at #{ORIGIN}"
   p "Transform 2 is at #{point1}"
   p "0.33 of range Geom::Transformation.interpolate t1, t2, 0.33 is at"
   p "#{t3.to_a}"
   #
   t4 = Geom::Transformation.interpolate t1, t2, 33
   p "Transform 1 is at #{ORIGIN}"
   p "Transform 2 is at #{point1}"
   p "33 of range by Geom::Transformation.interpolate t1, t2, 33 is at"
   p "#{t4.to_a}"
   print "\n"
end
 #
 # inverse
 #
def SketchUpEx.inverse
  point1 = Geom::Point3d.new 10,20,30
  t2 = Geom::Transformation.new point1
  t0 = t2.inverse
  p "Transform at point 10,20,30"
  p "#{t2.to_a}"
  p "has an inverse of:"
  p "#{t0.to_a}."
  print "Note: Do not take inverse of 0,0,0.\n"
  print "\n"
end
 #
 # origin of a transform
 #
 def SketchUpEx.origin
  point1 = Geom::Point3d.new 10,20,30
  t = Geom::Transformation.new point1
  origin = t.origin
  p "A Geom::Transformation.new 10,20,30 has a t.origin of"
  p "#{origin}"
end

SketchUpEx.trans_trans
SketchUpEx.transaxes
SketchUpEx.clone
SketchUpEx.new_identity
SketchUpEx.is_identity
SketchUpEx.interpolate
SketchUpEx.inverse
SketchUpEx.origin

end #module

