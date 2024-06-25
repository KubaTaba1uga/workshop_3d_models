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
CONNECTOR_OFFSET_X_Y = BASE_OFFSET_Y/2;
UPPER_CONNECTORS_COORDINATES = [[CONNECTOR_OFFSET_X_Y, CONNECTOR_OFFSET_X_Y, 0], [CONNECTOR_OFFSET_X_Y, BASE_Y - CONNECTOR_OFFSET_X_Y, 0], [BASE_X - CONNECTOR_OFFSET_X_Y, CONNECTOR_OFFSET_X_Y, 0], [BASE_X - CONNECTOR_OFFSET_X_Y, BASE_Y - CONNECTOR_OFFSET_X_Y, 0]];
LOWER_CONNECTORS_COORDINATES = [[0,0,0]];
PCB_CONNECTORS_COORDINATES = [[0,0,0]];

module main(){
  base_with_connectors();

  translate([BASE_OFFSET_X, BASE_OFFSET_Y, BASE_Z])
  %pcb_board();
}

module base_with_connectors(){
  $fn = 100;
  
  difference(){
    base();
    upper_connectors();    
  }
}

module upper_connectors(){
  offset = 0.1;

  for (i = [0 : len(UPPER_CONNECTORS_COORDINATES) - 1]){
    coordinates = [UPPER_CONNECTORS_COORDINATES[i][0], UPPER_CONNECTORS_COORDINATES[i][1], -offset];
    translate(coordinates){
       screw_hole("M4,10",atype="shaft");
       nut_trap_inline(h=BASE_Z - 1 + offset, spec="M4", $slop=.05);      
     }
  }
}

module base(){
  linear_extrude(BASE_Z){
    square([BASE_X, BASE_Y]);
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
