include <BOSL2/std.scad>
include <BOSL2/screws.scad>

include <constants.scad>

CONNECTORS_COORDINATES_EVEN = [[0,0,0], [0, LEVEL_Y - CONNECTOR_Y, 0], [LEVEL_X - CONNECTOR_X, 0, 0], [LEVEL_X - CONNECTOR_X, LEVEL_Y - CONNECTOR_Y, 0]];

CONNECTORS_COORDINATES_ODD = [[CONNECTOR_X, 0, 0], [CONNECTOR_X, LEVEL_Y - CONNECTOR_Y, 0], [LEVEL_X - CONNECTOR_X*2, 0, 0], [LEVEL_X - CONNECTOR_X*2, LEVEL_Y - CONNECTOR_Y, 0]];

module platform(level_number, connector_z){
  connectors_coordinates = (level_number % 2 == 1) ? CONNECTORS_COORDINATES_ODD : CONNECTORS_COORDINATES_EVEN;
    
  difference(){
      _platform_with_connectors(connectors_coordinates ,connector_z);    
      _nuts(connectors_coordinates, connector_z);
  }
}

module _platform_with_connectors(connectors_coordinates, connector_z){
  _platform();
  for (i = [0:3]){ 
    translate(connectors_coordinates[i])
      _connector(connector_z);
  }
}

module _platform(){
  linear_extrude(LEVEL_Z){
    square([LEVEL_X, LEVEL_Y]);
  }
}

module _connector(connector_z){
  linear_extrude(connector_z){
      square([CONNECTOR_X, CONNECTOR_Y]);
  }
}

module _nuts(connectors_coordinates, connector_z){
  offset = 1;
  for (i = [0:3]){ 
    translate(connectors_coordinates[i]){
      
      translate([CONNECTOR_X/2, CONNECTOR_Y/2, -offset]){
	nut_trap_inline(h=connector_z - LEVEL_Z + offset, spec="M4", $slop=.1);

	translate([0,0, offset+connector_z])
	screw_hole("M4,10",atype="shaft");
      }
    }
  }
}



