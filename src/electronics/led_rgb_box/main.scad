include <constants.scad>
include <button_hole.scad>

module main(){
  parts = [
	   [[0.05,0.05] ,  "1"],
	   [[0.1, 0.1],    "2"],
	   [[0.15,0.15],   "3"],
	   [[-0.5,-0.5],   "5"],
	   [[-0.1,-0.1],   "6"],
	   [[-0.15,-0.15], "7"]    
  ];
  
  // Iterate over each item in parts list

  difference(){
    box_lid();

    for (i = [0 : len(parts) - 1]) {
      translate([2+30*i,2,0]){
	button_hole(parts[i][0][0], parts[i][0][1]);
      }
    }
  }

  for (i = [0 : len(parts) - 1]) {
    translate([28+i*29.8,12,0.5]){
      text(parts[i][1], size = 5, valign = "center", halign = "center"); // adjust size as needed
    }
  }
  
}

module box_lid(){
  BOX_LID_X = 185;
  BOX_LID_Y = 30;

  linear_extrude(BOX_LID_Z){
    square([BOX_LID_X, BOX_LID_Y]);
  }
}

main();
