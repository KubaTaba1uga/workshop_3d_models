
module main(){
  dimmensions = [
		 [5.10, 6],
		 [5.15, 6.05],
		 [5.15, 6.10],
		 [5.20, 6.05],
		 [5.25, 6.05],
		 [5.20, 6.10],
		 [5.20, 6.15],
		 [5.25, 6.10],
		 [5.30, 6.10],
		 [5.25, 6.15],
		 [5.25, 6.20],
		 [5.30, 6.15],
		 [5.35, 6.15],		 
		 [5.30, 6.20],
		 [5.30, 6.25],
		 [5.35, 6.20],
		 [5.40, 6.20],
		 ];

  for (i = [0 : len(dimmensions) - 1]){
    translate([0, i*15, 0])
    door_shorts_row(in=dimmensions[i][0], out=dimmensions[i][1]);    
  }

  for (i = [0 : len(dimmensions) - 1]){
    translate([0, i*15, 0])
    door_shorts_row(in=dimmensions[i][0], out=dimmensions[i][1]);    
  }  
}

module door_shorts_row(in, out){
  heights = [5, 10, 15, 20, 25];
  
  for (i = [0 : len(heights) - 1]){
    translate([i*15, 0, 0])
    door_short(in=in, out=out, h=heights[i]);    
  }
  
}

module door_short(in, out, h){
  $fn = 100;

  linear_extrude(h){
    difference(){
      circle(out/2);      
      circle(in/2);    
    }
  }
}


main();
