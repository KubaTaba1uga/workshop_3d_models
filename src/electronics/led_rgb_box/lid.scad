include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <constants.scad>
include <button_hole.scad>


module box_lid(){
  difference(){
    linear_extrude(BOX_LID_Z){
      square([BOX_LID_X + BOX_LID_X_Y_OFFSET, BOX_LID_Y + BOX_LID_X_Y_OFFSET]);
    }

    mounting_holes();
    button_holes();
    led_hole();
  }
}

module mounting_holes(r_offset=0){
  HOLES_OFFSET = 0.25;
  BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE = 2.54 - HOLES_OFFSET;
  BOX_LID_X_Y_OFFSET_LOCAL = BOX_LID_X_Y_OFFSET / 2;
  holes = [
	   [BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL,
	    BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL],
   	   [BOX_LID_X - BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL,
	    BOX_LID_Y - BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL],
	   [BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL - 0.2,
	    BOX_LID_Y - BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL],
   	   [BOX_LID_X - BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL - 0.2,
	    BOX_LID_MOUNTING_HOLE_X_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL],

  ];

  $fn = 100;
  
  for (i = [0 : len(holes) - 1]) {
   translate([holes[i][0], holes[i][1], 0])
     screw_hole("M2,100",atype="shaft",hole_oversize=r_offset);
  }
}

module button_holes(){
  BOX_LID_BUTTON_HOLE_X_DISTANCE = 15.33;
  BOX_LID_BUTTON_HOLE_Y_DISTANCE = BOX_LID_Y - BUTTON_HOLE_Y - 6.6;  
  BOX_LID_X_Y_OFFSET_LOCAL = BOX_LID_X_Y_OFFSET / 2;

  holes_distances = [-3.5, 23.4, 49.9];

  $fn = 100;
  
  for (i = [0 : len(holes_distances) - 1]) {
   translate([BOX_LID_BUTTON_HOLE_X_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL + holes_distances[i],
	      BOX_LID_BUTTON_HOLE_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL,
	      0])
     button_hole();
  }
}

module led_hole(){
  $fn = 100;

  BOX_LID_LED_HOLE_X_DISTANCE = 7;
  BOX_LID_LED_HOLE_Y_DISTANCE = 8;  
  BOX_LID_X_Y_OFFSET_LOCAL = BOX_LID_X_Y_OFFSET / 2;

  
  translate([BOX_LID_LED_HOLE_X_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL, BOX_LID_LED_HOLE_Y_DISTANCE + BOX_LID_X_Y_OFFSET_LOCAL, 0])
  translate([0,0, -0.5])
  linear_extrude(BOX_LID_Z + 1){
    circle(r=2.5);
  }

}
