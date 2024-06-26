include <BOSL2/std.scad>
include <BOSL2/screws.scad>

difference(){
  $fn = 100;
  cylinder(r=3, h=10);  
  screw_hole("M3,100", atype="threads", $slop=-0.1);
}

