include <constants.scad>
include <button_hole.scad>

module main(){
  parts = [
	   [[0.7, 0.7],  "1"],
	   [[0.85,0.85], "2"],
	   [[1,1],       "3"],
	   [[1.1,1.1],   "4"],
	   [[1.2,1.2],   "5"],
	   [[1.3,1.3],   "6"],	   	   
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
    translate([28+i*29.8,12,BOX_LID_Z-0.1]){
      linear_extrude(1){
      text(parts[i][1], size = 5, valign = "center", halign = "center"); // adjust size as needed
      }
    }
  }
  
}

module box_lid(){
  BOX_LID_X = 185;
  BOX_LID_Y = 34;

  linear_extrude(BOX_LID_Z){
    square([BOX_LID_X, BOX_LID_Y]);
  }
}

main();
