include <platform.scad>
include <holder.scad>
include <my_own_lib/orange_pi_3b.scad>

LEVEL_ID = 1;

module main(){
  translate([HOLDER_X/2-20, HOLDER_Y/2, HOLDER_Z/2 - 40])
  rotate([90,0,0])
    holders_pair(z=10, screw=true);
  scb_holder();
}

main();
