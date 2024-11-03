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
  // front_wall();
  
  // This needs to be print with infill 100%
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

// module main(){
//   parts = [
// 	   [[0.25, 0.1], "1"],
//   ];

//   difference(){
//     box_lid();

//     for (i = [0 : len(parts) - 1]) {
//       translate([2+30*i,4,0]){
// 	button_hole(parts[i][0][0], parts[i][0][1]);
//       }
//     }
//   }

//   for (i = [0 : len(parts) - 1]) {
//     translate([28+i*30.2,12,BOX_LID_Z-0.1]){
//       linear_extrude(1){
//       text(parts[i][1], size = 5, valign = "center", halign = "center"); // adjust size as needed
//       }
//     }
//   }
  
// }

// module box_lid(){
//   BOX_LID_X = 122;
//   BOX_LID_Y = 37;

//   linear_extrude(BOX_LID_Z){
//     square([BOX_LID_X, BOX_LID_Y]);
//   }
// }

main();
