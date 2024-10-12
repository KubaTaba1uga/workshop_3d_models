include <platform.scad>
include <holder.scad>

LEVEL_ID = 0;
CONNECTOR_Z = 40;


module main(){

  difference(){
    platform(LEVEL_ID, CONNECTOR_Z);
    translate([0,0, -HOLDER_Z])
      scb_holders();
  }
}

main();
