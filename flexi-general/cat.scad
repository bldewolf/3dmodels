include <flexi.scad>

dim = [150,70,60];
centers = [[0,0,0],[0,0,0],[0,0,5],[0,0,8],[0,0,10],[0,0,8]];
*%cube(dim);
flexi2(dim, 7, 2, 7, 6, [0,-5,-12],[0,57,67,77,87,97,107,150], centers = centers)
translate([dim.x/2, dim.y/2,0])
rotate(8,[0,0,1])
import("cat2.stl");