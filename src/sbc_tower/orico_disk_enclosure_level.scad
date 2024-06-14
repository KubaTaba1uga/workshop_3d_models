include <BOSL2/std.scad>
include <BOSL2/screws.scad>

CONNECTOR_X = 10;
CONNECTOR_Y = 10;
CONNECTOR_Z = 40;

LEVEL_X = 120 + CONNECTOR_X * 2;
LEVEL_Y = 200 + CONNECTOR_Y * 2;
LEVEL_Z = 5;

NUT_Z = 35;

_connectors_coordinates = [[0,0,0], [0, LEVEL_Y - CONNECTOR_Y, 0], [LEVEL_X - CONNECTOR_X, 0, 0], [LEVEL_X - CONNECTOR_X, LEVEL_Y - CONNECTOR_Y, 0]];

module main(){
  difference(){
    platform_with_connectors();    
    holes();
  }

  
}

module platform_with_connectors(){
  platform();
  for (i = [0:3]){ 
    translate(_connectors_coordinates[i])
      connector();
  }

}

module holes(){
  offset = 1;
  for (i = [0:3]){ 
    translate(_connectors_coordinates[i]){
      
      translate([CONNECTOR_X/2, CONNECTOR_Y/2, -offset]){
	nut_trap_inline(h=NUT_Z+offset,spec="M4", $slop=.1);

	translate([0,0, offset+NUT_Z])
	screw_hole("M4,10",atype="shaft");
      }
    }
  }
}

module platform(){
  linear_extrude(LEVEL_Z){
    square([LEVEL_X, LEVEL_Y]);
  }
}

module connector(){
  linear_extrude(CONNECTOR_Z){
      square([CONNECTOR_X, CONNECTOR_Y]);
  }
}

main();
