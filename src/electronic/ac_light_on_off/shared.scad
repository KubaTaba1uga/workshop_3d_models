module upper_level_connectors(offset=0.2){
  for (i = [0 : len(UPPER_CONNECTORS_COORDINATES) - 1]){
    _offset = i%2==0 ? 0 : offset;
    
    coordinates = [UPPER_CONNECTORS_COORDINATES[i][0]-CONNECTOR_OFFSET_X_Y, UPPER_CONNECTORS_COORDINATES[i][1]-CONNECTOR_OFFSET_X_Y+_offset, BASE_Z-offset];
    translate(coordinates){
      linear_extrude(CONNECTOR_Z){
	square([CONNECTOR_X_Y, CONNECTOR_X_Y - offset]);
      }
     }
  }    
}
