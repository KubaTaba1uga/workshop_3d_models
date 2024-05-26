BOARD_WIDTH = 85;
BOARD_DEPTH = 56;
BOARD_HEIGHT = 30;
HOLE_DIAMETER = 2.7;
HOLE_DISTANCE_FROM_VERTEX = 2.15;
SPACE_WIDTH_BETWEEN_HOLES = 58;
BIG_OFFSET = 5;

ENCLOSURE_LAYER = 4;
HOLDER_BASE = HOLE_DIAMETER + 1;

module main(){
  board_base_with_holders();
}

module board_base_with_holders(){
  translate([0,0,-ENCLOSURE_LAYER + 0.1])
  board_base();

  holders_pair();

  translate([SPACE_WIDTH_BETWEEN_HOLES, 0, 0])
  holders_pair();  
  
  
}

module holders_pair(){
  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, 0])
  board_holder();

  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, BOARD_DEPTH - (HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE), 0])
  board_holder();  
}

module board_base(){
  linear_extrude(ENCLOSURE_LAYER)
    translate([-BIG_OFFSET/2, -BIG_OFFSET/2])
  square([BOARD_WIDTH + BIG_OFFSET, BOARD_DEPTH + BIG_OFFSET]);
}

module board_holder(){
  cylinder(r1=HOLDER_BASE, r2=0, h=BOARD_HEIGHT);
}

main();
