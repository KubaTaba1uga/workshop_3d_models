include <BOSL2/std.scad>
include <BOSL2/screws.scad>

BASE_X = 30;
BASE_Y = 70;
BASE_Z = 2;
SWITCH_CONNECTOR_R = 6.6;
HANGER_Y = 5;
HANGER_Z = 30;
HANGERS_DISTANCE = 22;

module main(){
  base_with_hangers();
}

module base_with_hangers(){
  base();
  hangers();
}

module base(){
  $fn=100;
  offset=0.1;
  linear_extrude(BASE_Z){
    difference(){
      square([BASE_X, BASE_Y]);
      translate([BASE_X/2, BASE_Y*3/4])
      circle(r=SWITCH_CONNECTOR_R+offset);
    }
  }
}

module hangers(){
  $fn = 100;
  
  difference(){
    linear_extrude(HANGER_Z){
      square([BASE_X, HANGER_Y]);
      translate([0, HANGERS_DISTANCE + HANGER_Y])
      square([BASE_X, HANGER_Y]);      
    }

    hanger(HANGERS_DISTANCE, HANGER_Y);
    translate([20,0,0])
    hanger(HANGERS_DISTANCE, HANGER_Y);    
  }

}

module hanger(hangers_distance, hanger_y){
  NUT_Z = hanger_y - 1;
  offset = 0.1;
  
  rotate([90,90,0]){
    translate([-25,5,0]){
      screw_hole("M4,100",atype="shaft");
      translate([0,0,-hanger_y-offset])
	nut_trap_inline(h=NUT_Z + offset, spec="M4", $slop=.05);
      translate([0,0,-hangers_distance - hanger_y - NUT_Z])
	nut_trap_inline(h=NUT_Z + offset, spec="M4", $slop=.05);		
    }
  }
}

main();
