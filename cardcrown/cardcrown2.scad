use <bend.scad>;
use <MCAD/2Dshapes.scad>;

/*
🂠 🂡 🂢 🂣 🂤 🂥 🂦 🂧 🂨 🂩 🂪 🂫 🂬 🂭 🂮
🂱 🂲 🂳 🂴 🂵 🂶 🂷 🂸 🂹 🂺 🂻 🂼 🂽 🂾 🂿
🃁 🃂 🃃 🃄 🃅 🃆 🃇 🃈 🃉 🃊 🃋 🃌 🃍 🃎 🃏
🃑 🃒 🃓 🃔 🃕 🃖 🃗 🃘 🃙 🃚 🃛 🃜 🃝 🃞 🃟
*/

// experimentally determined card dimensions
CARDH = 13.222;
CARDW = 10.382;
CARDRAT = CARDW/CARDH;
CARDOX = -0.344;
CARDOY = 2.66;

cardright = [ "🂫", "🂢", "🂡", "🂮", "🂭", "🂫", "🂪", "🂩", "🂨", "🂧", "🂦", "🂥", "🂤", "🂣"];
cardleft = [ "🂻", "🂲", "🂱", "🂾", "🂽", "🂻", "🂺", "🂹", "🂸", "🂷", "🂶", "🂵", "🂴", "🂳"];

rad = 260;
cent = 100;
dt = 10;
din = 8;
hstep = 5;
hmin = 40;
gangsta = 10;

scale([1,1,1]) {

for(dir = [-1:2:1]) {
    translate([dir*(cent/2*CARDRAT-cent*3/4*CARDRAT),0,0])
    cardrow2(dir > 0 ? cardright : cardleft, cent*3/4, hstep, hmin, dt, din, rad, dir);
}
//crownbase(len(cardright) - 1, cent*3/4, hstep, hmin, dt, din, rad);
rotate(gangsta, [1,0,0])
centerpiece(cent, dt, din);

}
// build the king and the bent jokers
module centerpiece(s, dt, din) {
	translate([-s*CARDRAT/2,0,0])
	card("🂾", s, s*CARDRAT, dt, din);
	//🃏🂿🃟 
	for(i = [-1:2:1]) {
		translate([0,0,s])
		translate([i*s*CARDRAT/3,0,0])
		rotate(25,[0,0,i])
		rotate(-20,[0,-i,0])
		rotate(-25,[1,0,0])
		translate([0,-s,0])
		rotate(22.5,[0,0,1])
		translate([0,s,0])
		rotate(-270,[1,0,0])
		rotate(-90,[0,0,1])
		translate([-s,0,0])
		cylindric_bend([s,s*CARDRAT,dt], s, 30)
		translate([s,0,dt])
		rotate(90,[0,0,1])
		rotate(270,[1,0,0])
		card("🃏", s, s*CARDRAT, dt, din);
	}
	translate([-s*CARDRAT/2 + dt/1.9,dt/2,s])
		rotate(90,[0,0,1]) rotate(90,[1,0,0]) linear_extrude(dt)
		polygon([[0,-dt*4],[dt,0],[dt,dt*3],[0,dt*2]]);
	mirror()
	translate([-s*CARDRAT/2 + dt/1.9,dt/2,s])
		rotate(90,[0,0,1]) rotate(90,[1,0,0]) linear_extrude(dt)
		polygon([[0,-dt*4],[dt,0],[dt,dt*3],[0,dt*2]]);
}

// calculate current distance for cardrow2 height magic
function calc_loc(c, cs, h, hstep, hmin, sum=0, x=0) =
	(x == c) ? sum :
	calc_loc(c, cs, max(h - hstep, hmin), hstep, hmin, sum + h, x + 1);

// Build cards in a curved row around radius r with connector tissue h is the
// starting height, hstep is the height decrease each card, hmin is when to
// stop decreasing
module cardrow2(cards, h, hstep, hmin, dt, din, r, dir) {
	cs = len(cards) - 1;
	steps = (h - hmin) / hstep;
	full = calc_loc(cs, cs, h, hstep, hmin);
	translate([dir*h*CARDRAT/2,r,0])
	rotate(-90,[0,0,1])
	for(c = [0:cs]) {
        // calc size and position around the ring
		size = (c < steps) ? h - c*hstep : hmin;
		loc = calc_loc(c+1, cs+1, h, hstep, hmin) * CARDRAT;
		angle = (180/PI) * loc / r * dir * 1.2;
        x = r*cos(angle);
        y = 0.9*r*sin(angle);
*		echo(loc,angle);
		translate([x,y,0])
		rotate(angle+90, [0,0,1])
        rotate(gangsta, [1,0,0])
        translate([-size*CARDRAT/2,0,0])
        card(cards[c], size, size*CARDRAT, dt, din);
        
        translate([x,y,0])
		rotate(angle+90, [0,0,1])
        difference() {
            // add attaching block to the back
            rotate(gangsta, [1,0,0])
            translate([-size*CARDRAT/2,0,0])
            if(dir < 0) {
                translate([0,dt-din,0]) rotate(5,[0,0,1]) {
                    translate([0,0,-size*0.2])
                    cube([size*1.25,din-1, size*1.1]);
                }
            } else {
                translate([size*CARDRAT,dt-din,0.01]) rotate(-5,[0,0,1]) {
                    mirror([1,0,0])
                    translate([0,0,-size*0.2])
                    cube([size*1.25,din-1, size*1.1]);
                }
            }
            translate([0,0,-size])
            cube([size*3,size*3,size*2], center=true);  
        };
	};
}

module crownbase(cs, h, hstep, hmin, dt, din, r) {
    full = calc_loc(cs, cs, h, hstep, hmin);
    
    color("red")
    translate([0,r,0])
    scale([0.9,1/1,1])
    rotate(270,[0,0,1])
    linear_extrude(hmin*0.5)
    donutSlice(r-hmin*CARDRAT*0.5, r-hmin*CARDRAT*0.1, -1 * (180/PI) * full / r, (180/PI) * full / r);
    //echo(r-hmin*CARDRAT, r, -1 * (180/PI) * full / r, (180/PI) * full / r);
}

// build a card with backing
// dt/din are for depth of the card face
module card(c, h, w, dt, din) {
    //$fn = 2;
	union() {
		rotate(90, [1,0,0]) scale([w/CARDW, h/CARDH, 1]) translate([CARDOX,CARDOY,-dt]) {
			color("black") linear_extrude(height = dt) offset(delta=0.04) text(c, font="Symbola");
			scale([1.001,1.001,1.001]) hull() translate([0,0,-0.01]) linear_extrude(height = din) offset(delta=0.04) text(c, font="Symbola");
		}
	}
}