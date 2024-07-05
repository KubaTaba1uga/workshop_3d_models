BOARD_X = 100;
BOARD_Y = 62;
BOARD_Z = 30;
HOLE_DIAMETER = 1.35;
HOLE_DISTANCE_FROM_VERTEX = 0.5;
SPACE_X_BETWEEN_HOLES = 93.3;
SPACE_Y_BETWEEN_HOLES = 55;
HOLDER_BASE = HOLE_DIAMETER + 1;

BIG_OFFSET = 20;
ENCLOSURE_LAYER = 4;


module main(){
  board_base_with_holders();
}

module board_base_with_holders(){
  translate([0,0,-ENCLOSURE_LAYER + 0.1])
  board_base();

  holders_pair();
}

module board_base(){
  linear_extrude(ENCLOSURE_LAYER)
    translate([-BIG_OFFSET/2, -BIG_OFFSET/2])
    square([BOARD_X + BIG_OFFSET, BOARD_Y + BIG_OFFSET]);
}

module holders_pair(){
  _holders_row();

  translate([SPACE_X_BETWEEN_HOLES, 0, 0])
  _holders_row();  

}

module _holders_row(){
  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, 0]){
    _board_holder();
    
    translate([0, SPACE_Y_BETWEEN_HOLES, 0])    
    _board_holder();  
  }
}

module _board_holder(){
  cylinder(r1=HOLDER_BASE, r2=1, h=BOARD_Z/1.5);
}


main();
