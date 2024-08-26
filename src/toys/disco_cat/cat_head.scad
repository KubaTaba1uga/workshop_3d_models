include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <pcb_board.scad>

STAND_X = 80;
STAND_Z = 40;
STAND_HOLE_X = [5, STAND_X - 45];

module main(){
  difference(){
    lionhead();
    head_holes();
  }

  translate([20,10,-40])
  rotate([0,270,0])
  head_stand();

  // test_head_hole();
}

module lionhead(){
  translate([0,-30,0])
  scale([2.5,2.5,2.5])
  import("lionhead.stl");  
}

module head_holes(){
  translate([-20, 40, -8])
    rotate([270,0,0])
    head_stand_holes(should_hold_screw=true);

  translate([-35,15,90])
    rotate([90,90,0])
    pcb_connector_hole();

  translate([-28, 34.5, 94])
    rotate([90,0,0])    
  led_holes();
}

module head_stand(){
  difference(){
  
    equilateral_triangle(STAND_X);

    translate([STAND_X/2.5, -STAND_X/2.5, STAND_Z])    
      rotate([90,90,180]){
      head_stand_holes();
    }
    
  }
}

module equilateral_triangle(side_length = 60) {
    // Calculate the height of the equilateral triangle
    height = (sqrt(3) / 2) * side_length;

    // Define the points of the triangle
    points = [
        [0, 0],
        [side_length, 0],
        [20, height]
    ];

    // Draw the triangle
    linear_extrude(STAND_Z)
    polygon(points);
}

module head_stand_holes(should_hold_screw = false){
  $fn = 100;

  for (i = [0 : len(STAND_HOLE_X) - 1]){      
    translate([STAND_HOLE_X[i],-33,0]){      
      if (!should_hold_screw){
	screw_hole("M4,100",atype="shaft", head="socket", counterbore=20);	
      } else {
	screw_hole("M4,100",atype="shaft", head="socket", counterbore=20, $slop=-0.1, hole_oversize=-0.1);	
      }
    }
  }
}

module led_holes(){
  $fn = 100;

  square_x = 20;
  square_y = 20;
  square_z = 7;

  led_holes_x = [0, 35];

  for (i = [0 : len(led_holes_x) - 1]){
    translate([led_holes_x[i],0,0]){
      // linear_extrude(square_z){
      // 	square([square_x,square_y]);
      // }
  
      linear_extrude(square_z*12){  
	translate([square_x/2, square_y/2, 0])
	  circle(r=2.5);
      }

      linear_extrude(square_z*11){  
	translate([square_x/2, square_y/2, 0])
	  circle(r=7);
      }
      
    }
  }
}

module test_head_hole(){
  $fn = 100;

  square_x = 20;
  square_y = 20;
  square_z = 7;
  
  linear_extrude(square_z)
  difference(){
    square([square_x,square_y]);

    translate([square_x/2, square_y/2, 0])
      circle(r=2.5);
  }  
}


main();
