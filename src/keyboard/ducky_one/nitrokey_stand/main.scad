include <constants.scad>

module main() {
  all();

}

module all() {
  // Translate and render the part with the base Z height
  translate([0, 0, DESK_DISTANCE_Z])
    nitorkey_and_keyboard_parts();

  // Render the desk part
  desk_part();
}

module nitorkey_and_keyboard_parts(){
  translate([STAND_X, 0, 0])
    rotate([90 - NITORKEY_KEYBOARD_ANGLE, 180, 0]){
    
    nitrokey_part();
  
    translate([0, STAND_Y, STAND_Z - 0.2])  // Position keyboard part relative to nitrokey
      rotate([NITORKEY_KEYBOARD_ANGLE, 0, 0])  // Rotate keyboard part based on specified angle	  
      keyboard_part();
  }
}

module nitrokey_part(){
  NITROKEY_PART_X = STAND_X;
  NITROKEY_PART_Y = STAND_Y;
  NITROKEY_PART_Z = STAND_Z;

  // Create the base square
  linear_extrude(NITROKEY_PART_Z)
    square([NITROKEY_PART_X, NITROKEY_PART_Y]);
}

module keyboard_part(){
  KEYBOARD_PART_X = STAND_X;
  KEYBOARD_PART_Y = 5;
  KEYBOARD_PART_Z = 0.75;

  // Create the base square
  linear_extrude(KEYBOARD_PART_Z)
    square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
}

module desk_part(){
  DESK_PART_Z = DESK_DISTANCE_Z - 1;
  DESK_PART_X = STAND_X;
  DESK_PART_Y = 10;

  linear_extrude(DESK_PART_Z)
    square([DESK_PART_X, DESK_PART_Y]);
}

main();
