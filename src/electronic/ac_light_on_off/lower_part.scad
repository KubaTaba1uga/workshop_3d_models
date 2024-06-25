include <BOSL2/std.scad>
include <BOSL2/screws.scad>

include <my_own_lib/universal_pcb_board.scad>

PCB_BOARD_X = 70;
PCB_BOARD_Y = 90;
PCB_HOLE_R = 1.5;
PCB_HOLE_FROM_X = 1;
PCB_HOLE_FROM_Y = 2.2;
PCB_HOLES_COORDINATES = get_pcb_board_holes_coordinates(PCB_BOARD_X, PCB_BOARD_Y, PCB_HOLE_FROM_X, PCB_HOLE_FROM_Y, PCB_HOLE_R);
BASE_OFFSET_X = 5;
BASE_OFFSET_Y = 15;
BASE_X = PCB_BOARD_X + BASE_OFFSET_X*2;
BASE_Y = PCB_BOARD_Y + BASE_OFFSET_Y*2;
BASE_Z = 4;
CONNECTOR_X_Y = BASE_OFFSET_Y;
CONNECTOR_OFFSET_X_Y = CONNECTOR_X_Y/2;
CONNECTOR_Z = 30;
UPPER_CONNECTORS_COORDINATES = [[CONNECTOR_OFFSET_X_Y, CONNECTOR_OFFSET_X_Y, 0],
				[CONNECTOR_OFFSET_X_Y, BASE_Y - CONNECTOR_OFFSET_X_Y, 0],
				[BASE_X - CONNECTOR_OFFSET_X_Y, CONNECTOR_OFFSET_X_Y, 0],
				[BASE_X - CONNECTOR_OFFSET_X_Y, BASE_Y - CONNECTOR_OFFSET_X_Y, 0]];
LOWER_CONNECTORS_COORDINATES = [[BASE_X/2, BASE_Y/2, 0]];
PCB_CONNECTORS_COORDINATES = PCB_HOLES_COORDINATES;

DISTANCE_Z = 5;
Z_OFFSET = 1.5;

module main(){
  base_with_connectors();

  translate([BASE_OFFSET_X, BASE_OFFSET_Y, BASE_Z + DISTANCE_Z])
  %pcb_board();
}

module base_with_connectors(){
  $fn = 100;
  
  difference(){
    base();
    upper_connectors();
    lower_connectors();
    
    translate([BASE_OFFSET_X, BASE_OFFSET_Y, BASE_Z])    
    pcb_connectors();
  }
}

module upper_connectors(){
  offset = 0.1;

  for (i = [0 : len(UPPER_CONNECTORS_COORDINATES) - 1]){
    coordinates = [UPPER_CONNECTORS_COORDINATES[i][0], UPPER_CONNECTORS_COORDINATES[i][1], -offset];
    translate(coordinates){
       screw_hole("M4,100",atype="shaft");
       nut_trap_inline(h=CONNECTOR_Z + BASE_Z - Z_OFFSET + offset, spec="M4", $slop=.05);
     }
  }
}

module lower_connectors(){
  offset = 0.1;

  for (i = [0 : len(LOWER_CONNECTORS_COORDINATES) - 1]){
    coordinates = [LOWER_CONNECTORS_COORDINATES[i][0], LOWER_CONNECTORS_COORDINATES[i][1], -offset];
    translate(coordinates){
       screw_hole("M4,10",atype="shaft");
       translate([0,0,Z_OFFSET + offset])
       nut_trap_inline(h=BASE_Z - Z_OFFSET + offset, spec="M4", $slop=.05);      
     }
  }
}

module pcb_connectors(){
  offset = 0.1;

  for (i = [0 : len(PCB_CONNECTORS_COORDINATES) - 1]){
    coordinates = [PCB_CONNECTORS_COORDINATES[i][0], PCB_CONNECTORS_COORDINATES[i][1], -offset];
    translate(coordinates){
       screw_hole("M3,10",atype="shaft");
     }
  }
}

module base(){
  linear_extrude(BASE_Z){
    square([BASE_X, BASE_Y]);
  }

  upper_level_connectors();

  translate([BASE_OFFSET_X, BASE_OFFSET_Y, 0])
  pcb_distances();
}

module upper_level_connectors(){
  offset = 0.2;
  for (i = [0 : len(UPPER_CONNECTORS_COORDINATES) - 1]){
    _offset = i%2==0 ? 0 : offset;
    
    coordinates = [UPPER_CONNECTORS_COORDINATES[i][0]-CONNECTOR_OFFSET_X_Y, UPPER_CONNECTORS_COORDINATES[i][1]-CONNECTOR_OFFSET_X_Y+_offset, BASE_Z-offset];
    translate(coordinates){
      linear_extrude(CONNECTOR_Z){
	square([CONNECTOR_X_Y, CONNECTOR_X_Y - offset]);
      }
     }
  }    
}

module pcb_distances(){
  offset = 0.1;
  
  for (i = [0 : len(PCB_CONNECTORS_COORDINATES) - 1]){
    coordinates = [PCB_CONNECTORS_COORDINATES[i][0], PCB_CONNECTORS_COORDINATES[i][1], BASE_Z - offset];
    translate(coordinates){
      cylinder(r=2.5, h=DISTANCE_Z);
     }
  }  
}

module pcb_board(){
  $fn = 100;
  linear_extrude(2.82){
    difference(){
      square([PCB_BOARD_X, PCB_BOARD_Y]);

      for (i = [0 : len(PCB_HOLES_COORDINATES) - 1]){
	translate(PCB_HOLES_COORDINATES[i])
	circle(r=PCB_HOLE_R);
      }
    }
  }
}

main();
