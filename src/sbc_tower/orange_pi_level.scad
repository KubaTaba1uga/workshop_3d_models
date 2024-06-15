include <platform.scad>
include <my_own_lib/orange_pi_3b.scad>

LEVEL_ID = 1;
CONNECTOR_Z = 40;

module main(){
  platform(LEVEL_ID, CONNECTOR_Z);

  chunk_y = LEVEL_Y / 2;
  offset = 20;
  distance_between_holders_pairs = 40;
  

  translate([LEVEL_X/3, CONNECTOR_Y + offset, 0]){
  holders_pair();

  translate([0, SPACE_WIDTH_BETWEEN_HOLES + distance_between_holders_pairs, 0])
    holders_pair();
  }
}

main();
