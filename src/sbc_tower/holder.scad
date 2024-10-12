module scb_holders(){
  holder_start_x = CONNECTOR_X + 5;
  holder_start_y = 5;
  holder_start_z = LEVEL_Z / 2;
  holder_offset_x = 50;

  for(i = [0 : 3]){
    translate([holder_start_y,holder_start_x + holder_offset_x*i, holder_start_z])
    scb_holder();
  }
}

module scb_holder(){
  cube([HOLDER_X, HOLDER_Y, HOLDER_Z]);
}
