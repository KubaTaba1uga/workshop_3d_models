module main() {
  // Define list of {z, number} pairs
  parts = [
    [1, "1"],
    [0.95, "2"],
    [0.90, "3"],
    [0.85, "4"],
    [0.80, "5"],
    [0.75, "6"],
    [0.70, "7"]    
  ];
  
  // Iterate over each item in parts list
  for (i = [0 : len(parts) - 1]) {
    translate([0,12*i,0])
    keyboard_part_tmp(parts[i][0], parts[i][1]); 
  }
}


module keyboard_part_tmp(z, number){
  KEYBOARD_PART_X = 50;
  KEYBOARD_PART_Y = 10;
  // KEYBOARD_PART_Z = 1;

  // Create the base square
  // linear_extrude(KEYBOARD_PART_Z){
  linear_extrude(z){
    square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
  }
  
  // Create a number in the center of the square
  translate([KEYBOARD_PART_X / 2, KEYBOARD_PART_Y / 2, z/1.1])
  linear_extrude(0.5){
    text(number, size = 5, valign = "center", halign = "center"); // adjust size as needed
  }
}

module keyboard_part(z, number){
  KEYBOARD_PART_X = 50;
  KEYBOARD_PART_Y = 10;
  KEYBOARD_PART_Z = 1;

  // Create the base square
  linear_extrude(KEYBOARD_PART_Z){
    square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
  }
  
}


main();
// module main(){
//   keyboard_part();
// }


// module keyboard_part(){
//   // KEYBOARD_PART_X = 75;
//     KEYBOARD_PART_X = 50;
//   KEYBOARD_PART_Y = 10;
//   KEYBOARD_PART_Z = 1;

//   linear_extrude(KEYBOARD_PART_Z){
//     square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
//   }

//   linear_extrude(KEYBOARD_PART_Z){
//     square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
//   }
  
// }

// main();
