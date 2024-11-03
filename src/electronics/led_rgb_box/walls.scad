include <constants.scad>

module walls_with_connectors(){
  difference(){
    connectors();
    front_wall();
  }

  walls();
}

module walls(){
  WALL_X_Y = 1;
  WALL_OFFSET = 0.5;

  translate([0,0,WALL_OFFSET])
    linear_extrude(BOX_WALLS_Z + 1){
    difference(){
      square([BOX_LID_X + BOX_LID_X_Y_OFFSET, BOX_LID_Y + BOX_LID_X_Y_OFFSET]);
      
      translate([WALL_X_Y, -WALL_OFFSET, 0])
      
	square([BOX_LID_X + BOX_LID_X_Y_OFFSET - WALL_X_Y*2, BOX_LID_Y + BOX_LID_X_Y_OFFSET - WALL_X_Y + WALL_OFFSET]);
    }
  }
  
}


module connectors(){
  CONNECTOR_X = 5.5;
  CONNECTOR_Y = 5.5;
  CONNECTOR_OFFSET = 0.5;
  connectors = [
       [0, 0],
       [0, BOX_LID_Y + BOX_LID_X_Y_OFFSET - CONNECTOR_Y],
       [BOX_LID_X + BOX_LID_X_Y_OFFSET - CONNECTOR_X, 0],
       [BOX_LID_X + BOX_LID_X_Y_OFFSET - CONNECTOR_X, BOX_LID_Y + BOX_LID_X_Y_OFFSET - CONNECTOR_Y],
  ];


  for (i = [0 : len(connectors) - 1]) {
    translate([connectors[i][0], connectors[i][1]])
    translate([0,-CONNECTOR_OFFSET,CONNECTOR_OFFSET])
      linear_extrude(BOX_WALLS_Z + 1){
      square([CONNECTOR_X, CONNECTOR_Y+CONNECTOR_OFFSET]);
    }
  }  
}

module front_wall(){
   $fn=100;
   WALL_X_Y = 1;
   holes = [
	    0,
	    25.4,
	    50.038,
   ];

   
   translate([BOX_LID_X_Y_OFFSET+WALL_X_Y, +WALL_X_Y/2,+0.4]){
     difference(){
       linear_extrude(BOX_WALLS_Z + 1.2){
	 square([BOX_LID_X-BOX_LID_X_Y_OFFSET-WALL_X_Y*2, WALL_X_Y]);
       }

       translate([-1.5,0,0])
       for (i = [0 : len(holes) - 1]) {       
	 translate([15.24+holes[i],WALL_X_Y + 0.6,12.5])
	   rotate([90,0,0])
	   linear_extrude(WALL_X_Y*2){
	   circle(r=3.5);
	 }
       }
     }
   }
}
