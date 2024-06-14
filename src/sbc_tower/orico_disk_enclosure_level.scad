include <BOSL2/std.scad>
include <BOSL2/screws.scad>
xdistribute(spacing=0.75*INCH){
    nut("3/8",thickness="thin");
    nut("3/8",thickness="normal");
    nut("3/8",thickness="thick");
    nut("3/8",shape="square");
}
