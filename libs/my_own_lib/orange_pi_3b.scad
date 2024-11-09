BOARD_WIDTH = 85;
BOARD_DEPTH = 56;
BOARD_HEIGHT = 30;
HOLE_DIAMETER = 1.35;
HOLE_DISTANCE_FROM_VERTEX = 2.15;
SPACE_WIDTH_BETWEEN_HOLES = 58;
SPACE_DEPTH_BETWEEN_HOLES = 49;
HOLDER_BASE = HOLE_DIAMETER + 1;


module holders_pair(z=0, spike=false, screw=false){
  _holders_row(z, spike, screw);

  translate([SPACE_WIDTH_BETWEEN_HOLES, 0, 0])
    _holders_row(z, spike, screw);  

}

module _holders_row(z=0, spike=false, screw=false){
  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, 0]){
    _board_holder(z, spike, screw);
    
    translate([0, SPACE_DEPTH_BETWEEN_HOLES, 0])    
      _board_holder(z, spike, screw);  
  }
}

module _board_holder(z=0, spike=false, screw=false){
  $fn = 100;

  local_z = (z == 0) ? BOARD_HEIGHT / 1.5 : z;
  
  if (spike)
    cylinder(r1=HOLDER_BASE, r2=1, h=local_z);
  if (screw){
    difference(){
      cylinder(r=HOLDER_BASE, h=local_z);
      screw_hole("M2,100",atype="shaft",hole_oversize=-0.1);      
    }

  }

}
