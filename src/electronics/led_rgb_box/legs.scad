include <constants.scad>

LEG_X = 10;
LEG_Y = BOX_LID_Y / 2;

module legs_with_connectors(){
  translate([0, LEG_Y / 2, 0])
  legs();
  legs_connectors();
}

module legs_connectors() {
  connectors = [
	  [0, 0],
	  [BOX_LID_X + BOX_LID_X_Y_OFFSET - LEG_X, 0],
  ];

  translate([0,0, BOX_LEGS_Z]){
    linear_extrude(BOX_LEGS_CONNECTORS_Z){
      for (i = [0 : len(connectors) - 1]) {
	translate([connectors[i][0],connectors[i][1],0])
	square([LEG_X, BOX_LID_Y + BOX_LID_X_Y_OFFSET]);
      }
      
      for (i = [0 : len(connectors) - 1]) {
	translate([0, i*(BOX_LID_Y + BOX_LID_X_Y_OFFSET - LEG_X/2),0])
	square([BOX_LID_X + BOX_LID_X_Y_OFFSET, LEG_X/2]);
      }

    }
  }
}

module legs(){
  legs = [
	  [0, 0],
	  [BOX_LID_X + BOX_LID_X_Y_OFFSET - LEG_X, 0],
  ];

  for (i = [0 : len(legs) - 1]) {
    translate([legs[i][0], legs[i][1], 0])
    translate([0,0,+0.5])
      linear_extrude(BOX_WALLS_Z + 1){
      square([LEG_X, LEG_Y]);
    }
  }    
}

