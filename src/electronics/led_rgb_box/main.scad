include <my_own_lib/text.scad>
include <constants.scad>
include <lid.scad>
include <walls.scad>
include <legs.scad>

module main(){
  // translate([0,-60,0])
  // box_lid();

  // translate([0,95,-0.5])
  //   rotate([90,0,0])
  //   front_wall(false);
  
  // For best quality print this part with infill 100%
  translate([0,0,-0.5])
  difference(){
    walls_with_connectors();
    mounting_holes(r_offset=-0.1);
  }

  // translate([BOX_LID_X + BOX_LID_X_Y_OFFSET + 10,0,BOX_LEGS_Z + BOX_LEGS_CONNECTORS_Z])
  //   rotate([180,0,0])
  // difference(){
  //   legs_with_connectors();
  //   mounting_holes();
  // }
}

main();
