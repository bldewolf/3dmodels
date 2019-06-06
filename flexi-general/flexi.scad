*difference() {
    cube([25,12*2+6,7]);
    translate([15,0,0])
    rotate(90,[0,0,1])
    flexi(4, 2, 14, 2, 12, 5, 6, 7, 2.75, 1);
};

*flexi2([40,40,10], 4, 10, 10/2, 10, centers=[[0,0,0],[0,0,0]])
cube([40,40,10]);

module flexi(a, b, c, d, e, f, g, h, j, k) {
    difference() {
        // canyon
        translate([-0.01,0,-0.01])
        linear_extrude(h + 0.02)
        polygon([
        [0,0],
        [0,d],
        [e,d],
        [e,d + f],
        [e + g, d + f],
        [e + g, d],
        [e*2 + g + 0.02, d],
        [e*2 + g + 0.02, 0],
        ]);
        
        //rod-grabber
        translate([g+e-k,d+h/2,h])
        rotate(90,[0,1,0])
        rotate(180,[1,0,0])
        linear_extrude(g - k*2)
        difference() {
            square([h,f*2]);
            translate([h/2,h/2])
            circle(j);
        };
        
        // rod
        translate([e + g/2 - c/2, d, h/2])
        rotate(90,[0,1,0])
        translate([0,0,c/2])
        scale([1,0.75,1])
        translate([0,0,-c/2])
        rotate_extrude(angle= 360)
        polygon([
            [0,0],
            [b,a],
            [b,c - a],
            [0,c],
            ]);
    };
};

module flexi2(dim, steps, gap, hs, hw, center = [0,0,0], strips, centers) {
    sdim = [dim.x/steps,dim.y,dim.z];
//    hs = dim.z/2;
//    hw = dim.y/4;
    strips = (strips)?strips:[for(i =[0:sdim.x:sdim.x*steps]) i];
    for(step = [0:steps - 1]) {
        translate([step*gap,0,0])
        difference() {
            intersection() {
                children(0);
                translate([strips[step],0,0])
                cube([strips[step+1] - strips[step], sdim.y, sdim.z]);
            }
            translate(center)
            {
                // left gap
                translate((centers[step])?centers[step]:[0,0,0])
                if(step < steps - 1) {
                    translate([strips[step],0,0])
                    translate([-hs*cos(45) + strips[step + 1] - strips[step], hw*3/2 + sdim.y/2, sdim.z/2])
                    rotate(45,[0,1,0])
                    rotate(90,[1,0,0])
                    linear_extrude(hw*3)
                    square([hs,hs]);
                }
                // right gap
                translate((centers[step-1])?centers[step-1]:[0,0,0])
                if(step > 0) {
                    translate([strips[step],0,0])
                    translate([-hs*cos(45), hw*3/2 + sdim.y/2, sdim.z/2])
                    rotate(45,[0,1,0])
                    rotate(90,[1,0,0])
                    linear_extrude(hw*3)
                    square([hs,hs]);
                }
            }
        }
        translate([strips[step] + gap*step,0,0])
        translate(center) {
            // left hook
            translate((centers[step])?centers[step]:[0,0,0])
            if(step < steps - 1) {
                translate([-hs*cos(45) + strips[step + 1] - strips[step] - 0.01, hw*3/2 + sdim.y/2 - hw, sdim.z/2])
                rotate(45,[0,1,0])
                rotate(90,[1,0,0])
                linear_extrude(hw)
                difference() {
                    square([hs,hs]);
                    //translate([hs/2/2,hs/2/2])
                    square([hs/1.5,hs/1.5]);
                }
            }
            // right hooks plus bridge
            translate((centers[step-1])?centers[step-1]:[0,0,0])
            if(step > 0) {
                translate([hs*cos(45) + 0.01, hw*3/2 + sdim.y/2, sdim.z/2])
                mirror([1,0,0])
                rotate(45,[0,1,0])
                rotate(90,[1,0,0])
                translate([0,0,hw*.1])
                linear_extrude(hw*.8)
                difference() {
                    square([hs,hs]);
                    //translate([hs/2/2,hs/2/2])
                    square([hs/1.5,hs/1.5]);
                }
                translate([hs*cos(45) + 0.01, hw*3/2 + sdim.y/2 - hw*2, sdim.z/2])
                mirror([1,0,0])
                rotate(45,[0,1,0])
                rotate(90,[1,0,0])
                translate([0,0,hw*.1])
                linear_extrude(hw*.8)
                difference() {
                    square([hs,hs]);
                    //translate([hs/2/2,hs/2/2])
                    square([hs/1.5,hs/1.5]);
                }
                translate([-cos(45)*(hs - hs/1.5), hw*3/2 + sdim.y/2 - hw + hw*0.05, sdim.z/2])
                mirror([1,0,0])
                rotate(45,[0,1,0])
                rotate(90,[1,0,0])
                translate([0,0,-hw*.1])
                linear_extrude(hw*1.3)
                difference() {
                    square([hs - hs/1.5,hs - hs/1.5]);
                    //translate([hs/2/2,hs/2/2])
                    //square([hs/1.5,hs/1.5]);
                }
            }
        }
    }
    
    *translate([sdim.x - hs*cos(45), hs/2 + sdim.y/2 - hw/2, sdim.z/2])
    rotate(45,[0,1,0])
    rotate(90,[1,0,0])
    linear_extrude(hw)
    difference() {
        square([hs,hs]);
        //translate([hs/2/2,hs/2/2])
        square([hs/1.5,hs/1.5]);
    }
}