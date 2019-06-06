use <bend.scad>


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

rad = 200;
cent = 100;
dt = 10;
din = 8;
hstep = 5;
hmin = 20;
gangsta = -7;

scale([1,1,1]) {

for(dir = [-1:2:1]) {
translate([dir*(cent/2*CARDRAT-cent*3/4*CARDRAT),0,0])
cardrow2(dir > 0 ? cardright : cardleft, cent*3/4, hstep, hmin, dt, din, rad, dir);
}
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
		cylindric_bend([s,s*CARDRAT,dt], s, 5)
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
		angle = (180/PI) * loc / r * dir * 1.1;
*		echo(loc,angle);
		translate([r*cos(angle),r*sin(angle),0])
		rotate(angle+90, [0,0,1])
        rotate(gangsta, [1,0,0])
		translate([-size*CARDRAT/2,0,0]) {
			card(cards[c], size, size*CARDRAT, dt, din);
            // add attaching block to the back
			if(dir < 0) {
				translate([0,dt-din,0]) rotate(5,[0,0,1]) cube([size*1.1,din-1, size*0.9]);
			} else {
				translate([size*CARDRAT,dt-din,0.01]) rotate(-5,[0,0,1]) mirror([1,0,0]) cube([size*1.1,din-1, size*0.9]);
			}
		}
	}
}

// build a card with backing
// dt/din are for depth of the card face
module card(c, h, w, dt, din) {
	union() {
		rotate(90, [1,0,0]) scale([w/CARDW, h/CARDH, 1]) translate([CARDOX,CARDOY,-dt]) {
			color("black") linear_extrude(height = dt) text(c, font="Symbola");
			scale([1.001,1.001,1.001]) hull() translate([0,0,-0.01]) linear_extrude(height = din) text(c, font="Symbola");
		}
	}
}