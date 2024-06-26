include <BOSL2/std.scad>
include <BOSL2/screws.scad>

include <constants.scad>
include <shared.scad>

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
      screw_hole("M3,100", atype="threads", $slop=-0.1);
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
