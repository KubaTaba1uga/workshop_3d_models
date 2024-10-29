include <constants.scad>

module button_hole(hole_x_offset, hole_y_offset){
  BUTTON_HOLE_X = 21;
  BUTTON_HOLE_Y = 26;

  translate([0,0,-0.5])
  linear_extrude(BOX_LID_Z + 1){
    square([BUTTON_HOLE_X + hole_x_offset, BUTTON_HOLE_Y + hole_y_offset]);
  }

  // translate([0,0,-0.5])
  // linear_extrude(BOX_LID_Z + 1){
  //   square([BUTTON_HOLE_X, BUTTON_HOLE_Y]);
  // }  
}
