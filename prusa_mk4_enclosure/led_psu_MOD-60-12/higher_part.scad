PSU_WIDTH = 75.85;
PSU_DEPTH = 110;
PSU_HEIGHT = 37;
LAYER_HEIGHT = 4;
OFFSET = 15;

module main(){
  base();
  translate([-OFFSET/2, PSU_DEPTH + OFFSET/2, LAYER_HEIGHT])
    high_low_connector();

  translate([PSU_WIDTH + OFFSET/2, -OFFSET/2, LAYER_HEIGHT])
    high_low_connector();  
}

module base(){
  linear_extrude(LAYER_HEIGHT)  
  difference(){
    translate([-OFFSET, -OFFSET])
    square([PSU_WIDTH + OFFSET*2, PSU_DEPTH + OFFSET*2]);

    translate([-OFFSET/2, PSU_DEPTH + OFFSET/2, 0])    
    m4_6_nut_2d();        

    translate([PSU_WIDTH + OFFSET/2, -OFFSET/2, 0])
    m4_6_nut_2d();              
  }  
}

module high_low_connector(){
  // First layer  
  linear_extrude(PSU_HEIGHT/2){
      difference(){
	circle(r=4.1+2);
	m4_6_nut_2d();
      }
    }

  // Second layer
  translate([0,0, PSU_HEIGHT/2]) {
    linear_extrude(PSU_HEIGHT/2 + 5){
      difference(){
	circle(r=4.1+2);
	m4_6_screw_2d();
      }      
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
