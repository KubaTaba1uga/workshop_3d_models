include <platform.scad>

LEVEL_ID = 0;
CONNECTOR_Z = 40;


module main(){
  platform(LEVEL_ID, CONNECTOR_Z);
}

main();
