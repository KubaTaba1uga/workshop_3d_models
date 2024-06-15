BOARD_WIDTH = 85;
BOARD_DEPTH = 56;
BOARD_HEIGHT = 30;
HOLE_DIAMETER = 1.35;
HOLE_DISTANCE_FROM_VERTEX = 2.15;
SPACE_WIDTH_BETWEEN_HOLES = 58;
SPACE_DEPTH_BETWEEN_HOLES = 49;
HOLDER_BASE = HOLE_DIAMETER + 1;


module holders_pair(){
  _holders_row();

  translate([SPACE_WIDTH_BETWEEN_HOLES, 0, 0])
  _holders_row();  

}

module _holders_row(){
  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, 0]){
    _board_holder();
    
    translate([0, SPACE_DEPTH_BETWEEN_HOLES, 0])    
    _board_holder();  
  }
}

module _board_holder(){
  cylinder(r1=HOLDER_BASE, r2=1, h=BOARD_HEIGHT/1.5);
}
