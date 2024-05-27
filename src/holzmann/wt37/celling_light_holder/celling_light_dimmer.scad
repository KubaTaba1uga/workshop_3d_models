CONNECTOR_WIDTH = 50;
CONNECTOR_DEPTH = 20;
CONNECTOR_HEIGHT = 50;
CONNECTOR_LAYER = CONNECTOR_DEPTH / 2;
HANGER_WIDTH = CONNECTOR_WIDTH;
HANGER_DEPTH = 15;
HANGER_HEIGHT = 150;
HANGER_LAYER = HANGER_DEPTH / 2;
HANGER_FIRST_HOLE = 30;
HANGER_SECOND_HOLE = HANGER_HEIGHT - HANGER_FIRST_HOLE;


module main(){
  CONNECTION_OFFSET = 5;
  
  connector();
  translate([0, CONNECTOR_HEIGHT - CONNECTION_OFFSET, 0])
    rotate([45, 0, 0])
  hanger();
}

module connector(){
  linear_extrude(CONNECTOR_LAYER) {
    difference(){
      square([CONNECTOR_WIDTH, CONNECTOR_HEIGHT]);
      translate([CONNECTOR_WIDTH/2, CONNECTOR_HEIGHT/2])
      m4_6_nut_2d();
    }
  }

  translate([0, 0, CONNECTOR_LAYER])
  linear_extrude(CONNECTOR_LAYER) {
    difference(){
      square([CONNECTOR_WIDTH, CONNECTOR_HEIGHT]);
      translate([CONNECTOR_WIDTH/2, CONNECTOR_HEIGHT/2])
      m4_6_screw_2d();
    }
  }
}

module hanger(){
  
  linear_extrude(HANGER_LAYER) {
    difference(){
      square([HANGER_WIDTH, HANGER_HEIGHT]);
      translate([HANGER_WIDTH/2, HANGER_FIRST_HOLE])
      m4_6_nut_2d();
      translate([HANGER_WIDTH/2, HANGER_SECOND_HOLE])
      m4_6_nut_2d();      
    }
  }

  translate([0, 0, HANGER_LAYER])
  linear_extrude(HANGER_LAYER) {
    difference(){
      square([HANGER_WIDTH, HANGER_HEIGHT]);
      translate([HANGER_WIDTH/2, HANGER_FIRST_HOLE])
      m4_6_screw_2d();
      translate([HANGER_WIDTH/2, HANGER_SECOND_HOLE])
      m4_6_screw_2d();      
    }
  }
  
}

module m4_6_screw_2d(){
  $fn = 100;
  circle(2);
}


module m4_6_screw_3d(length){
  linear_extrude(length)
    m4_6_screw_2d();
}

module m4_6_nut_2d(){
  $fn = 6;
  circle(4.1);
}
module m4_6_nut_3d(length){
  linear_extrude(length)
  m4_6_nut_2d();
}


main();
