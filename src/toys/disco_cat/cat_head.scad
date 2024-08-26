include <BOSL2/std.scad>
include <BOSL2/screws.scad>

module main(){
  scale([2.5,2.5,2.5])
  import("lionhead.stl");
}

main();
