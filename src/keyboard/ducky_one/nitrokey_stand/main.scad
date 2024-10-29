module main() {
  keyboard_part();
}



module keyboard_part(){
  KEYBOARD_PART_X = 50;
  KEYBOARD_PART_Y = 10;
  KEYBOARD_PART_Z = 0.8; // this value is tested

  // Create the base square
  linear_extrude(KEYBOARD_PART_Z){
    square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
  }
  
}


main();

// module keyboard_part_tmp(z, number){
//   KEYBOARD_PART_X = 50;
//   KEYBOARD_PART_Y = 10;
//   KEYBOARD_PART_Z = 0.8; // this value is tested

//   // Create the base square
//   // linear_extrude(KEYBOARD_PART_Z){
//   linear_extrude(z){
//     square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
//   }
  
//   // Create a number in the center of the square
//   translate([KEYBOARD_PART_X / 2, KEYBOARD_PART_Y / 2, z/1.1])
//   linear_extrude(0.5){
//     text(number, size = 5, valign = "center", halign = "center"); // adjust size as needed
//   }
// }
