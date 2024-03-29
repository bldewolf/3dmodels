
// handy flags
_BALCONIES = true;
// non-top balconies have pillars that cause trapped support material, this disables the pillaring
_PRINTABLE_BALCONIES = false;
_WINDOWS = true;
_VOID = true;
_LOVINGTEXT = true;
_STENCIL = false;
_CHOPPA = true;

// floor counts
botfl = 7;

// outer wall length
length = 275;
//length = 8  *0.32*5*2.8/sin(30);
// fs = length*sin(30)/2.8
// depth from point to back wall
depth = cos(30)*length;
// the top makes a 30 degree angle from back to the point
top_size = depth*tan(30);
top_hole_steps = 16;
top_hole_nose_inset = top_size*3/20;
top_hole_size = top_size - top_hole_nose_inset*(1+cos(30));
top_perimeter_wall = max(length/50, 1);
step_h = (depth - top_hole_nose_inset)*sin(30)/top_hole_steps;
step_l = tan(30)*(depth - top_hole_nose_inset)/2/top_hole_steps;
void_wall = min(top_perimeter_wall,2);
// floor size
fs = top_size / 2.8;
choppa_stacker = min(fs/2,10);
// 0.2 for 0.2, 0.32 for 0.32??
choppa_fuzz = 0.4;
choppa_focus = -1; // this picks which floor to render, -1 for all

// this is not actually the bottom size.  I should get rid of this
bot_size = (botfl + 0.2)*fs;

corner_whi = fs/3;
corner_win = 1.5;
corner_wout =  1.1;

void_taper = 0;
// let the taper grow up as long as we don't hit the balcony
//void_taper_gains = -fs/2;
// just kidding, let's leave just enough to socket safely
void_taper_gains = -fs+choppa_stacker+1;
//void_taper_gains = (top_hole_nose_inset*2 - top_perimeter_wall)*tan(void_taper) - fs*0.2 - top_perimeter_wall;
//void_taper_gains = fs*0.75;


window_depth = min(top_perimeter_wall/3,.5);

echo(top_size, top_hole_size, top_hole_nose_inset, top_perimeter_wall, window_depth, fs);

// left middle right facing point
// top down yeehaw
corners = [
    [1,"wwb"],
    [2,"bbb"],
    [3,"bww"],
    [4," w "],
    ];

// Windows by side, floor, [pos, type], pos is %, see winrow for types
windows = [
        [ 0,
            [
            [1, [[8,76],[1,69],[1,62],[7,51],[7,44],[2,35],[2,28],[7,12]
                ]],
            [2, [[4,78],[5,63],[7,55],[7,48],[7,41],[5,33],[1,22]
                ]],
            [3, [[2,83],[4,75],[5,66],[7,55],[7,48],[7,41],[1,32],[8,19]
                ]],
            [4, [[2,88],[1,80],[1,70],[2,64],[4,57],[10,50],[4,42],[1,33],[1,26],[1,18],[1,9]
                ]],
            [5, [[2,65.5],[4,76]
                ]],
            [6, [[1,73],[11,79]
                ]],
            //[6, [for (i = [0:10]) [0, 10*i+10]]],
            ],
        ],
        [ 120,
            [
            [0, [[0,20],[0,21.5],[0,23],[0,24.5],[0,26],[0,27.5],[0,29],[0,30.5],
                 [1,35],[2,38],[1,43],[3,47]
                ]],
            [1, [[4,10],[4,17],[5,23],[5,37],[5,46],[6,65],[7,82]
                ]],
            [2, [[5,21],[5,34],[4,41],[4,65],[6,76]
                ]],
            [3, [[4,14],[5,20],[5,28],[8,37],[2,46],[8,67],[1,77]
                ]],
            [4, [[1,12],[1,20],[1,31],[1,37],[2,41],[4,48],[1,65],[4,75],[6,80]
                ]],
            [5, [[1,14],[1,22],[8,29],[2,36],[1,42.5],[2,47],[2,65],[4,76],[5,84]
                ]],
            [6, [[12,8.5],[13,20],[12,26],[2,40],[2,48],[12,65],[13,76],[1,83],[2,87]
                ]],
            [7, [[1,21],[1,29],[1,33],[1,43],[1,50],[1,69],[1,77],[1,83],[1,94]
                ]],
            //[7, [for (i = [0:10]) [0, 10*i+10]]]
            ],
        ],
        [ 240,
            [
            [0, [[0,69.5],[0,71],[0,72.5],[0,74],[0,75.5],[0,77],[0,78.5],[0,80],
                 [4,61],[2,51]
                ]],
            [1, [[5,72],[2,57],[4,52],[2,32],[1,20]
                ]],
            [2, [[1,77],[4,67],[2,59],[5,51],[4,33],[6,16]
                ]],
            [3, [[9,49],[5,31],[1,20]
                ]],
            [4, [[9,49],[1,34],[1,23],[6,10]
                ]],
            [5, [[2,90],[9,49],[2,32],[1,23]
                ]],
            [6, [[9,49],[5,28],[11,7]
                ]],
            [7, [[1,80],[1,76],[1,70],[1,60],[1,1052],[1,28],[1,17],[1,9]
                ]],
            //[7, [for (i = [0:10]) [0, 10*i+10]]],
            //[0, [for (i = [0:6]) [i, 10*i+10]]],
            //[1, [for (i = [0:6]) [i, 10*i+10]]]
            ],
        ]
    ];

module CLA() {
    difference() {
        union() {
            translate([0,0,bot_size - 0.01])
            top();
            base();
        }
        
        // top balcony
        if(_BALCONIES)
        color("brown")
        translate([0,0,botfl*fs-0.01])
        intersection() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
            
            linear_extrude(top_size)
            union() {
                translate([0,length/3 * 2])
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset + top_perimeter_wall,length]);
            };
        };

        // nose balcony chop
        if(_BALCONIES)
        color("brown")
        translate([0,0,botfl*fs - 0.01])
        intersection() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
                [length*sin(60),length*cos(60)],
                [0,length]]);
            
            linear_extrude(top_size)
            translate([depth - top_hole_nose_inset - 0.01 - step_h*3,0])
            square([length,length]);
        };
        
        // downslope to the balcony
        color("lime")
        translate([0,0,bot_size])
        difference() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
            
            translate([0,0,-top_perimeter_wall/4])
            rotate(60,[0,1,0])
            //translate([-length,0,0])
            cube([length,length,length*2]);
        };
        
        // corners
        if(_BALCONIES)
        for(c = corners) {
            translate([0,0,bot_size - fs*c[0]]) {
                corner(c[1][0]);
                translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),0])
                rotate(120,[0,0,1])
                translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
                corner(c[1][1]);
                translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),0])
                rotate(240,[0,0,1])
                translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
                corner(c[1][2]);
            }
        };
        
        // space-saving void
        if(_VOID)
        translate([0,0,-0.01])
        translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),(_LOVINGTEXT?1.2:0)])
        //linear_extrude(bot_size - fs/2)
        tapertower(botfl*fs + void_taper_gains + (_LOVINGTEXT?-1.2:0), length/sin(60)*sin(30), void_taper)
        translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
        void_hole();
            
        // windows
        if(_WINDOWS)
        for(side = windows) {
            translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),0])
            rotate(side[0],[0,0,1])
            translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
            for(wins = side[1]) {
                translate([0,0,bot_size - fs*wins[0]])
                winrow(wins[1]);
            }
        };
        
        if(_WINDOWS && _BALCONIES)
        translate([top_hole_nose_inset + top_perimeter_wall,0,botfl*fs+fs/4])
        winrow([[10,50]])
        if(_STENCIL) {
            rotate(240,[0,0,1])
            cube([cos(30)*length*2 - top_perimeter_wall*2, length*2, length*4],center=true);
        }

        // inner letterings
        if(_VOID && _CHOPPA)
        for(f = [1:botfl-1]) {
            color("blue")
            translate([void_wall-0.2,length/2/sin(60)*cos(30),0])
            rotate(90,[0,0,1])
            rotate(90,[1,0,0])
            linear_extrude(void_wall)
            translate([0,fs*f-3*fs/4])
            text(text=str(f),size=fs/2,font="Centaur MT:style=Bold");
        }
    }

    // registrar's silhouette
    *translate([-0.01,length,0])
    rotate(-90,[0,0,1])
    rotate(90,[1,0,0])
    linear_extrude(top_perimeter_wall)
    polygon([[0,0],
    [0,fs*1.2],
    [top_perimeter_wall,fs*1.2],
    [top_perimeter_wall,fs*1],
    [length*0.46,fs*1],
    [length*0.46,fs*1.7],
    [length*0.38,fs*1.7],
    [length*0.38,fs*2.2],
    [length*0.38+top_perimeter_wall,fs*2.2],
    [length*0.38+top_perimeter_wall,fs*2],
    [length*0.46,fs*2],
    [length*0.46,fs*2.7],
    [length*0.41,fs*2.7],
    [length*0.41,fs*3.2],
    [length*0.41+top_perimeter_wall,fs*3.2],
    [length*0.41+top_perimeter_wall,fs*3],
    [length*0.83,fs*3],
    [length*0.83,fs*3.2],
    [length*0.83+top_perimeter_wall,fs*3.2],
    [length*0.83+top_perimeter_wall,fs*2],
    [length-top_perimeter_wall,fs*2],
    [length-top_perimeter_wall,fs*2.2],
    [length,fs*2.2],
    [length,0]]);
}


if(!_CHOPPA)
CLA();


// choppa choppa
if(_CHOPPA)
for(flrv = concat([for(i=[0:5]) [i,i*fs,fs,true]],[[6,6*fs,length,false]])) {
//for(flrv = [[0,0,6*fs,true],[1,6*fs,length,false]]) {
    flr = flrv[0];
    flrh = flrv[1];
    flrl = flrv[2];
    flrc = flrv[3];
    if(choppa_focus == -1 || flr == choppa_focus) {
        translate([flr/2*length,flr%2*length,-flrh]) {
            // stacking hooks
            if(flrc) {
                translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),flrh+flrl])
                linear_extrude(choppa_stacker,scale=(depth-void_wall-choppa_fuzz*2)/(depth-void_wall-choppa_fuzz))
                translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
                difference() {
                    // magic number to make them fit
                    offset(r=-choppa_fuzz)
                    void_hole();
                    offset(r=-void_wall)
                    void_hole();
                }
                translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),flrh+flrl])
                mirror([0,0,1])
                // fix magic number for scale
                linear_extrude(fs/4,scale=length/2/sin(60)*sin(30)/(length/2/sin(60)*sin(30)-void_wall))
                translate([-length/2/sin(60)*sin(30),-length/2/sin(60)*cos(30),0])
                difference() {
                    void_hole();
                    offset(r=-void_wall)
                    void_hole();
                }
            }
            // old bad stack hooks
            *if(flrc) {
                translate([0,0,flrl-fs])
                translate([length/2/sin(60)*sin(30),length/2/sin(60)*cos(30),0])
                for(ang = [0,120,240]) {
                    rotate(ang,[0,0,1])
                    translate([length/2 - top_hole_nose_inset*corner_win*sin(30),0,fs]) {
                        mirror([0,0,1])
                        translate([top_hole_nose_inset/4,0])
                        linear_extrude(fs/2,scale=0)
                        translate([-top_hole_nose_inset/4,0])
                        square([top_hole_nose_inset/2,top_hole_nose_inset/2],center=true);
                        translate([0,0,fs/8 - 0.01])
                        cube([top_hole_nose_inset/3,top_hole_nose_inset/2,fs/4],center=true);
                    }
                }
            }
            intersection() {
                translate([0,0,flrh])
                    cube([length,length,flrl]);
                CLA();
            }
        }
    }
}

*tapertower(200, 100, 20)
square([100,100], center=true);

module void_hole() {
    offset(r=void_wall, $fn=20)
    offset(r=-void_wall*2)
    polygon([
        [0,top_hole_nose_inset*corner_win],
        [0,length - top_hole_nose_inset*corner_win],
        [top_hole_nose_inset*corner_win*cos(30),
            length - top_hole_nose_inset*corner_win*sin(30)],
        [(length - top_hole_nose_inset*corner_win)*sin(60),
            (length - top_hole_nose_inset*corner_win)*cos(60) + top_hole_nose_inset*corner_win],
        [(length - top_hole_nose_inset*corner_win)*sin(60),
            (length - top_hole_nose_inset*corner_win)*cos(60)],
        [top_hole_nose_inset*corner_win*cos(30),
            top_hole_nose_inset*corner_win*sin(30)],
        ]);
}
module tapertower(h, w, a) {
    y = w / 2 / sin(90 - a) * sin(a);
    x = h - y;
    translate([0,0,x])
    linear_extrude(y, scale=0)
    children(0);
    linear_extrude(x + 0.01)
    children(0);
}

module window_cube(s) {
    cube60(s);
}

module cube45(s) {
    *cube(s);
    x = s[1];
    y = s[2];
    z = s[0];
    xscale = max((x - z*2)/x, 0.001);
    yscale = max((y - z*2)/y, 0.001);
    if(xscale <= 0 || yscale <= 0) {
        echo(x, y, z, xscale, yscale);
    }
    rotate(90,[0,0,1])
    rotate(90,[1,0,0])
    translate([x/2, y/2])
    linear_extrude(z, scale=[xscale,yscale])
    translate([-x/2, -y/2])
    square([x,y]);
}

module cube60(s) {
    *cube(s);
    x = s[1];
    y = s[2];
    z = s[0];
    xscale = max((x - z*2*sqrt(3))/x, 0.001);
    yscale = max((y - z*2*sqrt(3))/y, 0.001);
    if(xscale <= 0 || yscale <= 0) {
        echo(x, y, z, xscale, yscale);
    }
    rotate(90,[0,0,1])
    rotate(90,[1,0,0])
    translate([x/2, y/2])
    linear_extrude(z, scale=[xscale,yscale])
    translate([-x/2, -y/2])
    square([x,y]);
}


module winrow(ws) {
    for(w = ws) {
        t = w[0];
        pos = w[1];
        translate([0,length*pos/100,0])
        if(t == 0) { // tall thin
            translate([0,0,-fs*2/5/2])
            window_cube([window_depth,length*2/400,fs*2/5]);
        } else if(t == 1) { // center narrow
            window_cube([window_depth,length*7/400,fs*1/5]);
        } else if(t == 2) { // center medium
            window_cube([window_depth,length*15/400,fs*1/5]);
        } else if(t == 3) { // high wide thin
            translate([0,0,fs*2/5/2])
            window_cube([window_depth,length*27/400,fs*1/20]);
        } else if(t == 4) { // high narrow
            translate([0,0,fs*1/10])
            window_cube([window_depth,length*7/400,fs*1/5]);
        } else if(t == 5) { // center wider
            window_cube([window_depth,length*20/400,fs*1/5]);
        } else if(t == 6) { // 4 grid
            //bsize = length*4/400;
            size = fs/2;
            bsize = size/7;
            *translate([0,0,-size/2])
            window_cube([window_depth,size,size]);
            translate([0,0,fs/8])
            translate([0,0,-size/2])
            for(x = [0:bsize*2*.8:size*.8], y = [0:bsize*2*.8:size*.8]) {
                translate([0,x,y])
                window_cube([window_depth,bsize,bsize]);
            }
        } else if(t == 7) { // high wider
            translate([0,0,fs*1/5/2])
            window_cube([window_depth,length*23/400,fs*1/5]);
        } else if(t == 8) { // high medium
            translate([0,0,fs*1/5/2])
            window_cube([window_depth,length*15/400,fs*1/5]);
        } else if(t == 9) { // 19 grid
            //bsize = length*4/400;
            size = fs/2;
            bsize = size/8;
            *translate([0,0,-size/2])
            window_cube([window_depth,size,size]);
            translate([0,0,fs/8])
            translate([0,0,-size/2])
            for(x = [0:bsize*2*.8:bsize*18*2*.8], y = [0:bsize*2:bsize*7]) {
                translate([0,x,y])
                window_cube([window_depth,bsize,bsize]);
            }
        } else if(t == 10) { // DOORS
            h = fs*4/10;
            w = fs*3/10;
            translate([0,-w/2,-fs*0.2])
            window_cube([window_depth,w,h]);
        } else if(t == 11) { // 3x8 grid
            //bsize = length*4/400;
            size = fs/2;
            bsize = size/8;
            *translate([0,0,-size/2])
            window_cube([window_depth,size,size]);
            translate([0,0,fs/8])
            translate([0,0,-size/2])
            for(x = [0:bsize*2*.8:bsize*7*2*.8], y = [bsize*2.5:bsize*2:bsize*7]) {
                translate([0,x,y])
                window_cube([window_depth,bsize,bsize]);
            }
        } else if(t == 12) { // 3x5 grid
            //bsize = length*4/400;
            size = fs/2;
            bsize = size/8;
            *translate([0,0,-size/2])
            window_cube([window_depth,size,size]);
            translate([0,0,fs/8])
            translate([0,0,-size/2])
            for(x = [0:bsize*2*.8:bsize*4*2*.8], y = [bsize*2.5:bsize*2:bsize*7]) {
                translate([0,x,y])
                window_cube([window_depth,bsize,bsize]);
            }
        } else if(t == 13) { // 3x2 grid
            //bsize = length*4/400;
            size = fs/2;
            bsize = size/8;
            *translate([0,0,-size/2])
            window_cube([window_depth,size,size]);
            translate([0,0,fs/8])
            translate([0,0,-size/2])
            for(x = [0:bsize*2*.8:bsize*1*2*.8], y = [bsize*2.5:bsize*2:bsize*7]) {
                translate([0,x,y])
                window_cube([window_depth,bsize,bsize]);
            }
        }
    }
};
                        

module corner(t) {
    whi = corner_whi;
    win = corner_win;
    wout =  corner_wout;
    if(t != " ") {
        linear_extrude(whi)
        polygon([[-0.01,-0.01],
            [top_hole_nose_inset*0.8*sin(60),top_hole_nose_inset*0.8*cos(60)-0.01],
            [-0.01,top_hole_nose_inset*0.8]]);
    }
    if(t == "b") {
        linear_extrude(whi)
        polygon([[-0.01,top_hole_nose_inset*win],
            [top_hole_nose_inset*win*sin(60),top_hole_nose_inset*win*cos(60)-0.01],
            [top_hole_nose_inset*wout*sin(60),top_hole_nose_inset*wout*cos(60)-0.01],
            [-0.01,top_hole_nose_inset*wout]]);
        if(!_PRINTABLE_BALCONIES)
        color("pink")
        //translate([0,0,-fs/6])
        linear_extrude(whi)
        offset(delta=-top_perimeter_wall/1.2)
        polygon([[0,0],
            [top_hole_nose_inset*win*sin(60),top_hole_nose_inset*win*cos(60)],
            [0,top_hole_nose_inset*win]]);
    }
};

module top() {
    difference() {
        color("blue")
        linear_extrude(top_size)
        polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
        
        // make a point
        color("red")
        rotate(60,[0,1,0])
        translate([-length,0,0])
        cube([length,length,length*2]);
        
        
        // horizontal hole
        
        color("aqua")
        translate([depth,length,top_hole_size])
        rotate(90,[1,0,0])
        rotate(180,[0,0,1])
        linear_extrude(length)
        translate([top_hole_nose_inset,0,0])
        // center triangle
        polygon([[0,0],
            [top_hole_size*sin(60),top_hole_size*cos(60)],
            [0,top_hole_size]]);

       // horizontal hole top poke
        color("purple")
        intersection() {
            translate([depth,length,length])
            rotate(90,[1,0,0])
            rotate(180,[0,0,1])
            linear_extrude(length)
            translate([top_hole_nose_inset,0,0])
            // center triangle
            polygon([[0,0],
                [length*sin(60),length*cos(60)],
                [0,length]]);
            
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
                [length*sin(60),length*cos(60)],
                [0,length]]);
        };  

        // nose chop
        color("brown")
        translate([0,0,-0.01])
        intersection() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
                [length*sin(60),length*cos(60)],
                [0,length]]);
            
            linear_extrude(top_size)
            translate([depth - top_hole_nose_inset - 0.01,0])
            square([top_hole_nose_inset,length]);
        };
 
        // define the the perimeter wall
        /*
        *
        linear_extrude(top_size)
        offset(delta=-top_perimeter_wall)
        polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
        */

/*        
        // downslope to the balcony
        color("lime")
        difference() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
            
            translate([0,0,-top_perimeter_wall/4])
            rotate(60,[0,1,0])
            //translate([-length,0,0])
            cube([length,length,length*2]);
        };
*/ 
 
        /*
        // balcony
        color("tan")
        translate([0,0,-0.01])
        intersection() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
            
            linear_extrude(top_size)
            union() {
                translate([0,length/3 * 2])
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset + top_perimeter_wall,length]);
            };
        }
        */
            
            
    }
    // add stair steps
    color("pink")
    intersection() {
        translate([depth - top_hole_nose_inset,length,0])
        rotate(180,[0,0,1])
        for(step = [0:top_hole_steps - 1]) {
            linear_extrude(step_l*(step + 1))
            translate([step_h*step,0])
            square([step_h,length]);
        };
        
        linear_extrude(top_size)
        offset(delta=-0.01)
        polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
    };
        
}

module base() {
    difference() {
        linear_extrude(bot_size)
        polygon([[0,0],[length*sin(60),length*cos(60)],[0,length]]);
/*        
        // balcony dip
        color("brown")
        translate([0,0,botfl*fs - fs/5])
        intersection() {
            linear_extrude(top_size)
            offset(delta=-top_perimeter_wall)
            polygon([[0,0],
            [length*sin(60),length*cos(60)],
            [0,length]]);
            
            linear_extrude(top_size)
            union() {
                translate([0,length/3 * 2])
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset*2 + top_perimeter_wall,length/3]);
                square([top_hole_nose_inset + top_perimeter_wall,length]);
            };
        }
        */
        
        // in loving memory
        if(_LOVINGTEXT) {
            $fn=10;
            tsize = length/9.5;
            translate([tsize*4.1,length/2,-0.01])
            rotate(90,[0,0,1])
            mirror([1,0,0])
            linear_extrude(0.8) {
                translate([0,tsize*2.8])
                text(text="CLA TOWER", size=tsize, halign="center", font="Centaur MT:style=Bold");
                translate([0,tsize*1.5])
                text(text="1992–2019", size=tsize*.9, halign="center", font="Centaur MT:style=Bold");
                translate([0,tsize*.4])
                text(text="In loving", size=tsize*.9, halign="center", font="Z003:style=Medium Italic");
                translate([0,-tsize*.7])
                text(text="memory", size=tsize*.9, halign="center", font="Z003:style=Medium Italic");
            }
        }
    }
}