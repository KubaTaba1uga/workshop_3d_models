include <constants.scad>

module main() {
  parts = [
    [51, "1"],
    [53, "2"],	   
    [55, "3"],
    [57, "4"],
    [59, "5"],
    [61, "6"],
    [63, "7"],
  ];

  // Iterate over parts to position, rotate, and render each nitrokey and keyboard part
  for (i = [0 : len(parts) - 1]) {
    x_coordinates = i * (STAND_X + 5);

    // Position and render each nitrokey part with a unique number label
    translate([x_coordinates, 0, 0])
      all(parts[i][0], parts[i][1]);
  }
}

module all(desk_part_base_z, number) {
  // Translate and render the part with the base Z height
  translate([0, 0, desk_part_base_z])
    nitorkey_and_keyboard_parts();

  // Render the desk part
  desk_part(desk_part_base_z);

  // Render the number label on the part with linear extrude to make it 3D
  translate([STAND_X/2,  9.9, desk_part_base_z / 2]) // Adjust positioning as needed
    rotate([90,0,180])
    linear_extrude(height = 1) // Set the height of the extruded text
      text(number, size = 5, valign = "center", halign = "center"); // Adjust size as appropriate
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

module desk_part(desk_part_base_z){
  DESK_PART_Z = desk_part_base_z - 1;
  DESK_PART_X = 10;
  DESK_PART_Y = 10;

  linear_extrude(DESK_PART_Z)
    square([DESK_PART_X, DESK_PART_Y]);
}

main();
