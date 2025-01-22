include <platform.scad>
include <holder.scad>
include <my_own_lib/orange_pi_3b.scad>

LEVEL_ID = 1;

module main(){
  difference(){
    platform();
    translate([HOLDER_X/2-40, HOLDER_Y/2+12, HOLDER_Z/2 - 40])
      rotate([90,0,0])
      holders_pair(z=20, cylinder_oversize=0.5);
  }
}


module platform(){
     translate([HOLDER_X/2-40, HOLDER_Y/2, HOLDER_Z/2 - 40])
       rotate([90,0,0]){
       holders_pair(z=10, screw=true, cylinder_oversize=0.5);
     }
     scb_holder();     
}


main();
