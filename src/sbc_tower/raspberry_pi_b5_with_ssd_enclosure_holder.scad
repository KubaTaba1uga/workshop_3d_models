include <platform.scad>
include <holder.scad>
include <my_own_lib/orange_pi_5.scad>

LEVEL_ID = 1;

module main(){


  difference(){
    platform();
    translate([HOLDER_X/2-40, HOLDER_Y/2+5, HOLDER_Z/2 - 40])
      rotate([90,0,0])
      holders_pair(z=10);
  }
}


module platform(){
     translate([HOLDER_X/2-40, HOLDER_Y/2, HOLDER_Z/2 - 40])
       rotate([90,0,0]){
       holders_pair(z=10, screw=true);
     }
     scb_holder();     
}


main();
