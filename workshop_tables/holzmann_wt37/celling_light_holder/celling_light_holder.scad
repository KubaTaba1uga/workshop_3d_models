BOARD_WIDTH = 150;
BOARD_DEPTH = 50;
LAYER_HEIGHT = 4;

module main(){
  board_first_layer();
  
  translate([0, 0, LAYER_HEIGHT]){
    board_second_layer();    
  }
}

module board_first_layer(){
  board_layer();
}

module board_second_layer(){
  translate([BOARD_WIDTH, 0, 0])
  mirror([1,0,0])
  board_layer();
}

module board_layer(reverse){
  linear_extrude(LAYER_HEIGHT){
    BOARD_CHUNK = BOARD_WIDTH / 3;
    DEPTH_CENTER = BOARD_DEPTH / 2;

    difference(){
      board_base();

      translate([BOARD_CHUNK, DEPTH_CENTER, 0])
	m4_6_screw();

      translate([BOARD_CHUNK*2, DEPTH_CENTER, 0])
	m4_6_nut();
    }
  }  
}

module board_base(){
  square([BOARD_WIDTH, BOARD_DEPTH]);
}

module m4_6_screw(){
  $fn = 100;
  circle(2);
}

module m4_6_nut(){
  $fn = 6;
  circle(3.9);
}

main();
