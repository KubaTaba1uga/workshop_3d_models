include <BOSL2/std.scad>
include <BOSL2/screws.scad>

include <my_own_lib/universal_pcb_board.scad>

include <shared.scad>
include <constants.scad>

CEILING_Z = 2;

module main(){
  base_with_connectors();
  walls();
}

module base_with_connectors(){
  $fn = 100;
  
  difference(){
    base_with_perforation();
    upper_connectors();
  }
}

module base_with_perforation(){
  perforation_x = 2;
  
  linear_extrude(CEILING_Z){
    difference(){
      square([BASE_X, BASE_Y]);

      for (i = [1:3]){
	translate([i*20, i*10, 0])
	square([perforation_x, BASE_Y/4]);

	translate([i*20, BASE_Y - 30 - 10*i, 0])
	square([perforation_x, BASE_Y/4]);	
      }
    }
  }

}

module upper_connectors(){
  offset = 0.1;

  for (i = [0 : len(UPPER_CONNECTORS_COORDINATES) - 1]){
    coordinates = [UPPER_CONNECTORS_COORDINATES[i][0], UPPER_CONNECTORS_COORDINATES[i][1], -offset];
    translate(coordinates){
       screw_hole("M4,100",atype="shaft");
     }
  }
}

module walls(){
  space_z = 2;
  wall_thickness = 2;

  difference(){
    cube([BASE_X, BASE_Y, CONNECTOR_Z - space_z]);
    translate([wall_thickness, wall_thickness, 0])
    cube([BASE_X - wall_thickness*2, BASE_Y - wall_thickness*2, CONNECTOR_Z]);
    translate([0,0, -space_z*2])
    upper_level_connectors(offset=-space_z);
  }
}

main();
