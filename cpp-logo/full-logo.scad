//for(x = [5,10,20,35,55,85,130,200]) {
for(x = [200]) {

width = x;
height = x/10;
bheight = 2;

fudge = 0.001;

//side = big / sin(22.5);
side = width /(sin(22.5) + cos(22.5)) / 2;
big = side * sin(22.5);
cs = 11/170 * 2 * side * (sin(22.5) + cos(22.5));
difference() {
union() {
for(i = [1:1:8]) {
rotate([0,0,i * 45]) translate([side * cos(22.5),0,0]) {
polyhedron(
  points=[
//    [0 - fudge,0,(i==8?height:0)+bheight],
    [0 - fudge,0,bheight],
    [big,0,bheight],
    [0 - fudge,side * cos(22.5),bheight],
//    [-1 * big * cos(45),side * cos(22.5) - big * cos(45),(i==7?0:0)+bheight],
    [-1 * big * cos(45),side * cos(22.5) - big * cos(45),bheight],
    [0,big,height + bheight] , // apex
    // first 4 but lower
    [0 - fudge,0,0], //5
    [big,0,0],
    [0 - fudge,side * cos(22.5),0],
    [-1 * big * cos(45),side * cos(22.5) - big * cos(45),0],
    ],
  faces=[
    [1,0,4],[2,1,4],[3,2,4],[0,3,4], // pyramid top
    [6,1,2,7],// outside face
    [8,3,0,5],// inside face
    [5,6,7,8],// bottom face
    [5,0,1,6],// side
    [7,2,3,8]
    ]
 );
};
};
};
union() {
for(i = [-45 : 90 : 45]) {
rotate([0,0,i]) translate([0,-cs/2,bheight]) cube([big*10,cs,bheight+height]);
rotate([0,0,i]) translate([width/2 - cs / 2,-cs/2,-1]) cube([big*10,cs,bheight+height+2]);
rotate([0,0,i]) translate([0,-cs/2,-1]) cube([width/2 - big,cs,bheight+height+2]);
};
};
};
};