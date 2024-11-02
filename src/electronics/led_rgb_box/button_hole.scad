include <constants.scad>

module button_hole(){  
  // BUTTON_HOLE_OFFSET_X = 0.25;
  BUTTON_HOLE_OFFSET_X = -0.25;  
  BUTTON_HOLE_OFFSET_Y = 0.2;
  
  translate([0,0,-0.5])
  linear_extrude(BOX_LID_Z + 1){
    square([BUTTON_HOLE_X + BUTTON_HOLE_OFFSET_X, BUTTON_HOLE_Y + BUTTON_HOLE_OFFSET_Y]);
  }
}
