
include <constants.scad>
include <button_hole.scad>

module main(){
  parts = [
	   [[0.25, 0.1], "1"],
  ];

  difference(){
    box_lid();

    for (i = [0 : len(parts) - 1]) {
      translate([2+30*i,4,0]){
	button_hole(parts[i][0][0], parts[i][0][1]);
      }
    }
  }

  for (i = [0 : len(parts) - 1]) {
    translate([28+i*30.2,12,BOX_LID_Z-0.1]){
      linear_extrude(1){
      text(parts[i][1], size = 5, valign = "center", halign = "center"); // adjust size as needed
      }
    }
  }
  
}

module box_lid(){
  BOX_LID_X = 122;
  BOX_LID_Y = 37;

  linear_extrude(BOX_LID_Z){
    square([BOX_LID_X, BOX_LID_Y]);
  }
}

main();
