BOARD_WIDTH = 150;
BOARD_DEPTH = 50;
LAYER_HEIGHT = 5;
FIRST_CHUNK = 50;
SECOND_CHUNK = FIRST_CHUNK + 75;

module main(){
  difference()
    {
    board_layers();
    horizontal_screws();
  }
}

module board_layers(){
  board_first_layer();
  
  translate([0, 0, LAYER_HEIGHT]){
    board_second_layer();    
  }  
}

module horizontal_screws(){
  SCREW_OFFSET = 5;
  SCREW_LENGTH = 20;
  SCREW_SIZE = SCREW_LENGTH + SCREW_OFFSET;
  NUT_LENGTH = BOARD_DEPTH - SCREW_LENGTH + SCREW_OFFSET;
  
  translate([10, SCREW_SIZE - SCREW_OFFSET, LAYER_HEIGHT]) {
    rotate([90,0,0]) {
      m4_6_screw_3d(SCREW_SIZE);

      translate([0, 0, -NUT_LENGTH + 1])
      m4_6_nut_3d(NUT_LENGTH);
    }
  }  
}


module board_first_layer(){
  linear_extrude(LAYER_HEIGHT){
    DEPTH_CENTER = BOARD_DEPTH / 2;

    difference(){
      board_base();

      translate([FIRST_CHUNK, DEPTH_CENTER, 0])
	m4_6_screw_2d();

      translate([SECOND_CHUNK, DEPTH_CENTER, 0])
	m4_6_nut_2d();
    }
  }  
}

module board_second_layer(){
  linear_extrude(LAYER_HEIGHT){
    DEPTH_CENTER = BOARD_DEPTH / 2;

    difference(){
      board_base();

      translate([FIRST_CHUNK, DEPTH_CENTER, 0])
	m4_6_nut_2d();

      translate([SECOND_CHUNK, DEPTH_CENTER, 0])
	m4_6_screw_2d();
    }
  }  
}

module board_layer(reverse){
}

module board_base(){
  square([BOARD_WIDTH, BOARD_DEPTH]);
}

module m4_6_screw_2d(){
  $fn = 100;
  circle(2);
}


module m4_6_screw_3d(length){
  linear_extrude(length)
    m4_6_screw_2d();
}

module m4_6_nut_2d(){
  $fn = 6;
  circle(4.1);
}
module m4_6_nut_3d(length){
  linear_extrude(length)
  m4_6_nut_2d();
}


main();
