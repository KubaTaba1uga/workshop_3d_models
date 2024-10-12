include <platform.scad>
include <holder.scad>
include <my_own_lib/orange_pi_3b.scad>

LEVEL_ID = 1;

module main(){
  connector_z = HOLDER_Z;

  difference(){
    platform(LEVEL_ID, connector_z);
    scb_holders();
  }
}

main();
