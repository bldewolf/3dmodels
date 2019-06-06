// http://kitwallace.tumblr.com/post/85636282539/oloid

module oloid(r) {
   hull() {
     cylinder(r=r,h=0.1);
     translate([0,r,0])
         rotate([0,90,0])
            cylinder(r=r,h=0.1);
   }
};
$fn=200;

rotate(270,[1,0,0])
difference() {
scale(0.3)
intersection() {
    scale([0.5,1,1])
    oloid(30);
    translate([0,50,0])
    cube([100,100,100],center=true);
}

rotate(270,[1,0,0])
cylinder(r=3/2,h=10);
}