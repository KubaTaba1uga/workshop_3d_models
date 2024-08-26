include <BOSL2/std.scad>
include <BOSL2/screws.scad>

STAND_X = 80;
STAND_Z = 40;
STAND_HOLE_X = [5, STAND_X - 45];

module main(){
  // test_head_hole();
  head_stand();
}

module lionhead(){
  scale([2.5,2.5,2.5])
  import("lionhead.stl");  
}

module head_stand(){
  $fn = 100;
  
  difference(){
    equilateral_triangle(STAND_X);
    head_stand_holes();
  }
}

module equilateral_triangle(side_length = 60) {
    // Calculate the height of the equilateral triangle
    height = (sqrt(3) / 2) * side_length;

    // Define the points of the triangle
    points = [
        [0, 0],
        [side_length, 0],
        [side_length / 2, height]
    ];

    // Draw the triangle
    linear_extrude(STAND_Z)
    polygon(points);
}

module head_stand_holes(should_hold_screw = false){
  for (i = [0 : len(STAND_HOLE_X) - 1]){      
    translate([10,-33,STAND_HOLE_X[i]])
      rotate([90,90,180]){

      if (!should_hold_screw){
	screw_hole("M4,100",atype="shaft", head="socket", counterbore=10);	
      } else {
	screw_hole("M4,100",atype="shaft", head="socket", counterbore=10, $slop=-0.1, hole_oversize=-0.1);	
      }
    }
  }
}

module test_head_hole(){
  $fn = 100;
  
  difference(){
    translate([0,-10,0])
    cube([10,20,10]);
    
    translate([5,-45,5])
      rotate([90,90,180]){
      screw_hole("M4,100",atype="shaft", head="socket", counterbore=10, $slop=-0.1, hole_oversize=-0.1);
    }
  }  
}


main();
