include <my_own_lib/universal_pcb_board.scad>

PCB_BOARD_X = 50;
PCB_BOARD_Y = 70;
PCB_BOARD_Z = 1;
PCB_HOLE_R = 1.4;
PCB_HOLE_FROM_X = 0.8;
PCB_HOLE_FROM_Y = 0.8;
PCB_HOLES_COORDINATES = get_pcb_board_holes_coordinates(PCB_BOARD_X, PCB_BOARD_Y, PCB_HOLE_FROM_X, PCB_HOLE_FROM_Y, PCB_HOLE_R);


module main(){
  difference(){
    pcb_board();
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

main();
