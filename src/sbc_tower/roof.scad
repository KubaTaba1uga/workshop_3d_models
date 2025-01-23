include <platform.scad>
include <holder.scad>

LEVEL_ID = 3;

module main(){
  difference(){
    platform(LEVEL_ID, 5);
    scb_holders();
  }
}

main();
