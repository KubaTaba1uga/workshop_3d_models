include <my_own_lib/orange_pi_3b.scad>

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
    square([BOARD_WIDTH + BIG_OFFSET, BOARD_DEPTH + BIG_OFFSET]);
}


main();
