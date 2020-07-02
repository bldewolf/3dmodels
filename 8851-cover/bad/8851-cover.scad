dim = [168,90];

sidebutton = [11,7];
side_offset = [11,31];
side_space = [0, 2.7 + sidebutton[1]];
sidebuttons = 5;
botbutton = [14,8];
bot_offset = [35,5];
bot_space = [14 + botbutton[0],0];
botbuttons = 4;

screen_dim = [109,66];
screen_off = [(dim[0] - screen_dim[0])/2,dim[1] - screen_dim[1] - 2];

echo(side_offset[1] + sidebuttons*sidebutton[1]+(sidebuttons-1)*side_space[1]);

echo(bot_offset[0]*2 + botbuttons*botbutton[0]+(botbuttons-1)*bot_space[0]);

linear_extrude(2)
difference() {
    square(dim);
    
    for(b=[0:sidebuttons-1]) {
        translate(side_offset+side_space*b)
        square(sidebutton);
    }
    translate([dim[0],0])
    mirror(v=[1,0,0])
    for(b=[0:sidebuttons-1]) {
        translate(side_offset+side_space*b)
        square(sidebutton);
    }
    
    for(b=[0:botbuttons-1]) {
        translate(bot_offset+bot_space*b)
        square(botbutton);
    }
    
    translate(screen_off)
    square(screen_dim);
}

color("red"){
translate([7,10,0])
translate([5,5,0])
cylinder(r=10/2,h=3.5);

translate([dim[0] - 7 - 10,10,0])
translate([5,5,0])
cylinder(r=10/2,h=3.5);

translate([7,dim[1] - 10 - 2])
translate([5,5,0])
cylinder(r=10/2,h=3.5);

translate([dim[0] - 10 - 7,dim[1] - 10 - 2])
translate([5,5,0])
cylinder(r=10/2,h=3.5);
}