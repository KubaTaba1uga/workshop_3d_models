include <constants.scad>

module main() {
    parts = [
        [90,  "1"],
        [95,  "2"],
        [100, "3"],
        [105, "4"],
        [110, "5"],
        [115, "6"],	
        [85,  "7"],
        [80,  "8"],
        [75,  "9"],
        [70,  "10"],
        [65,  "11"],
    ];
    
    // Iterate over parts to position, rotate, and render each nitrokey and keyboard part
    for (i = [0 : len(parts) - 1]) {
        part = parts[i];
        angle = part[0];
        label = part[1];
	x_coordinates = i * (STAND_X + 5);
	
        // Position and render each nitrokey part
        translate([x_coordinates, 0, 0])  // Adjust spacing between nitrokey parts
        nitrokey_part();

        // Rotate and translate each keyboard part individually
        translate([x_coordinates, STAND_Y, STAND_Z - 0.2])  // Position keyboard part relative to nitrokey
        rotate([angle, 0, 0])  // Rotate keyboard part based on specified angle	  
        keyboard_part();
        
        // Position text above each part
        translate([x_coordinates + 5, STAND_Y / 2, STAND_Z - 0.2])  // Adjust spacing for text
	  linear_extrude(1)
        text(label, size = 5, valign = "center", halign = "center");  // Set text size and alignment
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
    KEYBOARD_PART_Z = 0.8;

    // Create the base square
    linear_extrude(KEYBOARD_PART_Z)
        square([KEYBOARD_PART_X, KEYBOARD_PART_Y]);
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
