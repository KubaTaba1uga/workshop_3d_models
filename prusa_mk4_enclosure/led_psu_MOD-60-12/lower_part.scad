PSU_WIDTH = 82.5;
PSU_HEIGHT = 115.5;

module main(){
  linear_extrude(1)
  base_connector();
}

module base_connector(){
  difference(){
    square([PSU_WIDTH, PSU_HEIGHT]);

    translate([2.9, 2.9, 0])
    m4_6_screw_2d();

    translate([PSU_WIDTH-1, PSU_HEIGHT-3, 0])
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
