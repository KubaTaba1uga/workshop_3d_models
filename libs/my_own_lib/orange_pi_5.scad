BOARD_X = 100;
BOARD_Y = 62;
BOARD_Z = 30;
HOLE_DIAMETER = 1.35;
HOLE_DISTANCE_FROM_VERTEX = 0.5;
SPACE_X_BETWEEN_HOLES = 93.3;
SPACE_Y_BETWEEN_HOLES = 55;
HOLDER_BASE = HOLE_DIAMETER + 1;

module holders_pair(z=0, spike=false, screw=false){
  // assert(spike || screw, "Error: holders_pair requires at least one of 'spike' or 'screw' to be true.");
  
  _holders_row(z, spike, screw);

  translate([SPACE_X_BETWEEN_HOLES, 0, 0])
  _holders_row(z, spike, screw);  

}

module _holders_row(z=0, spike=false, screw=false){
  translate([HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, HOLE_DISTANCE_FROM_VERTEX + HOLDER_BASE, 0]){
    _board_holder(z, spike, screw);
    
    translate([0, SPACE_Y_BETWEEN_HOLES, 0])    
    _board_holder(z, spike, screw);  
  }
}

module _board_holder(z=0, spike=false, screw=false){
  $fn = 100;
  
  local_z = (z == 0) ? BOARD_Z / 1.5 : z;
  
  if (spike)  
    cylinder(r1=HOLDER_BASE, r2=1, h=local_z);
  if (screw){
    difference(){
      cylinder(r=HOLDER_BASE+1, h=local_z);
      screw_hole("M2,100",atype="shaft",hole_oversize=-0.1);      
    }
  }
  if (!spike && !screw){
    // Default base needs to be a little smaller that screw_hole, this way
    //   we can create holes for screw heads.
    cylinder(r=HOLDER_BASE+0.7, h=local_z);
  }
}
