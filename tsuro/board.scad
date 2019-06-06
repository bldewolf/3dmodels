//$fa = 1;
//$fs = 0.5;

size = 40;
spacing = 0.3;
grid = [6,6];
exterior = 5;
height = 6;
bottom = 1;

transforms = [
    [2,3,4,5,6,7,0,1], // 90 degrees
    [4,5,6,7,0,1,2,3], // 180
    [6,7,0,1,2,3,4,5], // 270
    ];
       

*piece(40, 6, 1, paths=[[5, 6], [4, 7], [2, 3], [0, 1]]);
*translate([40.3,0,0])
piece(40, 6, 1, 2);

list = [ for(a=gen_pieces2()) quicksort(a) ];
//list = gen_pieces2();
dlist = dedup(list);

echo(len(list));
echo(len(dlist));
echo("pre", list[0]);
echo("trans",trans(transforms[0],list[0]));
echo("fix", fixpairs(list[0]));

*for(i = [0:len(list)]) {
    translate([i*40.3,0,0])
    piece(40, 6, 1, paths=list[i]);
}

for(x = [0:grid[0]-1], y = [0:grid[1]-1]) {
    translate([x*(size+spacing),y*(size+spacing),0])
    piece(size, height, bottom, paths=dlist[x+y*6]);
}

container();

// used to crush nesting of search() results so we can properly check array length
function flatten(l) = [ for (a = l) for (b = a) b ] ;

// re-orders pairs as [lower,higher] so search() will work
function fixpairs(x) = [ for(a = x) (a[0] < a[1]) ? a : [a[1],a[0]] ];

// apply transformation t to test pairs
function trans(t, test) = quicksort(fixpairs([ for(x = test) [ for(y = x) t[y]] ]));

// helper function to optionally concatenate the current candidate to the accepted list
//
// uses trans to generate all possible rotations and then search()'s them against
// the accepted list
function dedup_concat(test, l) =
    (len(flatten(search([ for(t = transforms) trans(t, test[0]) ], l))) == 0) ?
    concat(test, l) : l;
    
// removes mirrored pair sets (or really whatever you test for with transforms[])
function dedup(l) = (len(l) == 1) ? [l[0]] :
    dedup_concat([l[0]], dedup([ for(a=[1:len(l)-1]) l[a]]));

// generates all possible pair sets
function gen_pieces2(pairs = [], rem = [0:7]) =
    (len(rem) == 0) ? [pairs] :
        [for (a = [ for(p2 = rem) if(rem[0] != p2)
                gen_pieces2(concat([[rem[0],p2]],pairs),
                [ for(a = rem) if(a != rem[0] && a != p2) a ])]) for (b = a) b];


// prototype using module
module gen_pieces(pairs = [], rem = [0:7]) {
    if(len(rem) == 0) {
        echo(pairs);
    } else {
        p1 = rem[0];
        for(p2 = rem) {
            if(p1 != p2) {
                gen_pieces(concat([[p1,p2]],pairs),
                    [ for(a = rem) if(a != p1 && a != p2) a ]);
            }
        }
    }
}       

module container() {
    fgs = grid * (size+spacing) - [spacing,spacing];
    for(angle = [0:90:359]) {
        translate(fgs/2)
        rotate(angle,[0,0,1])
        translate(-fgs/2)
        union() {
            difference() {
                linear_extrude(height)
                difference() {
                    translate(-[exterior,exterior])
                    square(grid * (size+spacing) - [spacing,spacing] + 2*[exterior,exterior]);
                    translate(-[spacing,spacing])
                    square(grid * (size+spacing) + [spacing,spacing]);
                    translate([-grid[0]*(size+spacing)/2,0])
                    square(grid * (size+spacing)*2);
                }
                
                for(i=[0:grid[0]-1]) {
                    translate([i*(size+spacing),0,0])
                    translate([0,-(size+spacing),0])
                    translate([size,size,0])
                    rotate(180,[0,0,1])
                    translate([size - size/10,-0.01,-0.01])
                    socket(size*1.1,height+0.02);
                }
                for(i=[0:grid[0]-1]) {
                    translate([i*(size+spacing)+size/3,-size/3,1])
                    rotate(90,[0,0,1])
                    boltpath(size,height);
                    
                    translate([i*(size+spacing)+size*2/3,-size/3,1])
                    rotate(90,[0,0,1])
                    boltpath(size,height);
                }
            }
            for(i=[0:grid[1]-1]) {
                translate([i*(size+spacing),0,0])
                translate([0,-(size+spacing),0])
                translate([size,size,0])
                rotate(180,[0,0,1])
                translate([size/10,-size/10,0])
                connector(size,height);
            }
        }
    }
}

module bolt() {
    linear_extrude(3)
    circle(5.5);
    linear_extrude(10)
    circle(2.8);
}

module bolt_slot() {
    translate([0,0,3.1])
    linear_extrude(5, scale=0.1)
    circle(5.5/2);
    linear_extrude(3.1)
    circle(5.5/2);
    linear_extrude(10)
    circle(2.8/2);
}

module bolt_slot_silh() {
    base = [6,3.1];
    neck = [3.1,10];
    translate([-base[0]/2,-base[1]])
    square(base);
    translate([-neck[0]/2,-neck[1]])
    square(neck);
    a = (base[0] - neck[0])/2;
    translate([-base[0]/2,-base[1]])
    polygon([[0,0],[base[0],0],[base[0]-a,-a*sin(60)],[a,-a*sin(60)]]);
    *projection()
    rotate(90,[1,0,0])
    bolt_slot();
}

module piece(l, h, b, lines=0, paths=[]) {
    difference() {
        cube([l,l,h]);
        if(lines == 1) {
            translate([0,l/3,b])
            boltpath(l,h);
            translate([0,l*2/3,b])
            boltpath(l,h);
            translate([0,l,0])
            rotate(-90,[0,0,1])
            translate([0,l/3,b])
            boltpath(l,h);
            translate([0,l,0])
            rotate(-90,[0,0,1])
            translate([0,l*2/3,b])
            boltpath(l,h);
        }
        if(lines == 2) {
            translate([0,0,b])
            boltpath2(l,h);
            
            translate([0,0,b])
            boltpath3(l,h);
            
            translate([l/2,l,b])
            boltpath4(l,h);
            
            translate([l,l/2,b])
            boltpath4(l,h);
        }
        for(p = paths) {
            side = floor(p[0]/2);
            hand = p[0]%2;
            type = p[1] - p[0];
            *echo(side, hand, type);
            translate([l/2,l/2,0])
            rotate(-90 * side,[0,0,1])
            translate([-l/2,-l/2,0]) {
                if(hand == 0) {
                    if(type == 1) {
                        translate([0,l/2,b])
                        boltpath4(l,h);
                    } else
                    if(type == 2) {
                        translate([0,l/2,b])
                        boltpath5(l,h);
                    } else
                    if(type == 3) {
                        translate([0,l,b])
                        boltpath3(l,h);
                    } else
                    if(type == 4) {
                        translate([0,l/3,b])
                        boltpath6(l,h);
                    } else
                    if(type == 5) {
                        translate([0,l/3,b])
                        boltpath(l,h);
                    } else
                    if(type == 6) {
                        translate([l*2/3,0,b])
                        rotate(90,[0,0,1])
                        translate([0,l/3/2,0])
                        boltpath5(l,h);
                    } else
                    if(type == 7) {
                        translate([0,0,b])
                        boltpath2(l,h);
                    } else {
                        echo("unhandled type: ", type);
                    }
                } else {
                    if(type == 1) {
                        translate([0,l,b])
                        boltpath2(l,h);
                    } else
                    if(type == 2) {
                        translate([l*2/3,l,b])
                        rotate(90,[0,0,1])
                        mirror([1,0,0])
                        translate([0,l/3/2,0])
                        boltpath5(l,h);
                    } else
                    if(type == 3) {
                        translate([0,l*2/3,b])
                        boltpath(l,h);
                    } else
                    if(type == 4) {
                        translate([l,l/3,b])
                        mirror([1,0,0])
                        boltpath6(l,h);
                    } else
                    if(type == 5) {
                        translate([0,0,b])
                        boltpath3(l,h);
                    } else
                    if(type == 6) {
                        translate([0,l*2/3,b])
                        mirror([0,1,0])
                        translate([0,l/3/2,0])
                        boltpath5(l,h);
                    } else {
                        echo("unhandled type: ", type);
                    }
                }
            }
        }
        
        translate([l - l/10,-0.01,-0.01])
        socket(l*1.1,h+0.02);
        
        translate([l,0,0])
        rotate(90,[0,0,1])
        translate([l - l/10,-0.01,-0.01])
        socket(l*1.1,h+0.02);
        
        translate([l,l,0])
        rotate(180,[0,0,1])
        translate([l - l/10,-0.01,-0.01])
        socket(l*1.1,h+0.02);
        
        translate([0,l,0])
        rotate(270,[0,0,1])
        translate([l - l/10,-0.01,-0.01])
        socket(l*1.1,h+0.02);
    }
    translate([l/10,-l/10,0])
    connector(l,h);
    
    translate([l,0,0])
    rotate(90,[0,0,1])
    translate([l/10,-l/10,0])
    connector(l,h);

    translate([l,l,0])
    rotate(180,[0,0,1])
    translate([l/10,-l/10,0])
    connector(l,h);

    translate([0,l,0])
    rotate(270,[0,0,1])
    translate([l/10,-l/10,0])
    connector(l,h);
}

module socket(l, h) {
    l = l + 5;
    translate([0,l/10 - l/100,0])
    mirror([0,1,0])
    connector(l,h);
}

module connector(l, h) {
    translate([-l/10/2,0,0])
    linear_extrude(h, scale=1)
    polygon([[0,l/20],[l/10 - l/12,l/10],[l/12,l/10],[l/10,l/20]]);
}

module boltpath(l,h) { 
    rotate(90,[0,1,0])
    rotate(-90,[0,0,1])
    translate([0,0,-1])
    linear_extrude(l+2)
    bolt_slot_silh();
}

module old_boltpath(l,h) {
    minkowski() {
        bolt_slot();
        translate([-1,0,0])
        cube([l+2,0.01,0.01]);
    }
}

module boltpath2(l,h) {
    rotate(180,[1,0,0])
    rotate_extrude()
    translate([l/3,0])
    bolt_slot_silh();
}

module old_boltpath2(l,h) {
    minkowski() {
        bolt_slot();
        translate([-1,0,0])
        linear_extrude(0.1)
        intersection() {
            square(l);
            difference() {
                circle(l/3);
                circle(l/3 - 0.1);
            }
        };
        //cube([l+2,0.01,0.01]);
    }
}

module boltpath3(l,h) {
    rotate(180,[1,0,0])
    rotate_extrude()
    translate([l*2/3,0])
    bolt_slot_silh();
}

module boltpath3_bumpy(l,h) {
    %rotate(180,[1,0,0])
    rotate_extrude()
    translate([l*2/3,0])
    bolt_slot_silh();
    translate([l/3,0,0])
    rotate(45,[0,0,1])
    translate([0,-l,0])
    rotate(-90,[1,0,0])
    linear_extrude(l*2)
    bolt_slot_silh();
}

module old_boltpath3(l,h) {
    minkowski() {
        bolt_slot();
        translate([-1,0,0])
        linear_extrude(0.1)
        intersection() {
            square(l);
            difference() {
                circle(l*2/3);
                circle(l*2/3 - 0.1);
            }
        };
        //cube([l+2,0.01,0.01]);
    }
}

module boltpath4(l,h) {
    rotate(180,[1,0,0])
    rotate_extrude()
    translate([l/3/2,0])
    bolt_slot_silh();
}

module old_boltpath4(l,h) {
    minkowski() {
        bolt_slot();
        translate([-1,0,0])
        linear_extrude(0.1)
        intersection() {
            square(l);
            %translate([l/3,0])
            difference() {
                circle(l/3);
                circle(l/3 - 0.1);
            }
        };
        //cube([l+2,0.01,0.01]);
    }
}

module boltpath5(l,h) {
    translate([l/3,l/3/2 - 0.01,0])
    rotate(-90,[1,0,0])
    linear_extrude(l/2)
    bolt_slot_silh();
    translate([-0.01,l/3/2,0])
    intersection() {
        translate([0,-l,0])
        cube(l);
        rotate(180,[1,0,0])
        rotate_extrude()
        translate([l/3,0])
        bolt_slot_silh();
    }
}

module boltpath6(l,h) {
    rotate(atan(l/l/3),[0,0,1])
    rotate(90,[0,1,0])
    rotate(-90,[0,0,1])
    translate([0,0,-l/2])
    linear_extrude(l*2)
    bolt_slot_silh();
}


function qcmp(a, b) =
    a[0] - b[0] == 0 ?
        a[1] - b[1] == 0 ? 0
            :a[1] - b[1]
        :a[0] - b[0];

function quicksort(arr) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (qcmp(y,pivot) < 0) y ],
    equal   = [ for (y = arr) if (qcmp(y,pivot) == 0) y ],
    greater = [ for (y = arr) if (qcmp(y,pivot) > 0) y ]
) concat(
    quicksort(lesser), equal, quicksort(greater)
);