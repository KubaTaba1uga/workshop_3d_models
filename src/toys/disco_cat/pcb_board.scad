include <my_own_lib/universal_pcb_board.scad>

PCB_BOARD_X = 50;
PCB_BOARD_Y = 70;
PCB_BOARD_Z = 1;
PCB_HOLE_R = 1.4;
PCB_HOLE_FROM_X = 0.7;
PCB_HOLE_FROM_Y = 0.7;
PCB_HOLES_COORDINATES = get_pcb_board_holes_coordinates(PCB_BOARD_X, PCB_BOARD_Y, PCB_HOLE_FROM_X, PCB_HOLE_FROM_Y, PCB_HOLE_R);
CONNECTOR_HOLE_R = 1 - 0.01;

module pcb_connector_hole(){
  $fn = 100;
  
  hole_z = 6;
  
  for (i = [0 : len(PCB_HOLES_COORDINATES) - 1]){
    translate(PCB_HOLES_COORDINATES[i])
      linear_extrude(hole_z){
      circle(r=CONNECTOR_HOLE_R);      
    } 
  }
}

module pcb_connector_distance(){
  $fn = 100;
  
  connector_x = 5;
  connector_y = 5;
  connector_z = 5;
  
  linear_extrude(connector_z){
    difference(){
      square([connector_x, connector_y]);

      translate([connector_x / 2, connector_y / 2])
      circle(r=CONNECTOR_HOLE_R);      
    }
    
  }  
}

module pcb_board(){
  $fn = 100;
  linear_extrude(1){
    difference(){
      square([PCB_BOARD_X, PCB_BOARD_Y]);

      for (i = [0 : len(PCB_HOLES_COORDINATES) - 1]){
	translate(PCB_HOLES_COORDINATES[i])
	circle(r=PCB_HOLE_R);
      }
    }
  }
}

