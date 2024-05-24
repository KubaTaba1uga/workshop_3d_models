PSU_WIDTH = 77.85;
PSU_DEPTH = 115.5;
PSU_HEIGHT = 37;
LAYER_HEIGHT = 5;
OFFSET = 15;

module main(){
  base_connector();
}

module base_connector(){
  // First layer
  linear_extrude(LAYER_HEIGHT)  
  difference(){
    translate([-OFFSET, -OFFSET])
    square([PSU_WIDTH + OFFSET*2, PSU_DEPTH + OFFSET*2]);

    translate([2.9, 2.9, 0])
    m4_6_screw_2d();

    translate([PSU_WIDTH-1, PSU_DEPTH-3, 0])
    m4_6_screw_2d();

    translate([-OFFSET/2, PSU_DEPTH + OFFSET/2, 0])    
    m4_6_screw_2d();        

    translate([PSU_WIDTH + OFFSET/2, -OFFSET/2, 0])
    m4_6_screw_2d();

    translate([PSU_WIDTH/2, -OFFSET/2, 0])
    m4_6_nut_2d();              
    
  }

  // Second layer
  translate([0,0,LAYER_HEIGHT])
  linear_extrude(LAYER_HEIGHT)  
  difference(){
    translate([-OFFSET, -OFFSET])
    square([PSU_WIDTH + OFFSET*2, PSU_DEPTH + OFFSET*2]);

    translate([2.9, 2.9, 0])
    m4_6_nut_2d();

    translate([PSU_WIDTH-1, PSU_DEPTH-3, 0])
    m4_6_nut_2d();

    translate([-OFFSET/2, PSU_DEPTH + OFFSET/2, 0])    
    m4_6_nut_2d();

    translate([PSU_WIDTH + OFFSET/2, -OFFSET/2, 0])    
    m4_6_nut_2d();

    translate([PSU_WIDTH/2, -OFFSET/2, 0])
    m4_6_screw_2d();    
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
