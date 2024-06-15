module m4_screw_2d(){
  $fn = 100;
  circle(2);
}


module m4_screw_3d(length){
  linear_extrude(length)
    m4_screw_2d();
}

module m4_nut_2d(){
  $fn = 6;
  circle(4.1);
}

module m4_nut_3d(length){
  linear_extrude(length)
  m4_nut_2d();
}
