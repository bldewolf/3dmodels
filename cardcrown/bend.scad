 // Place the target in the paralellepiped from [0,0,0] to ["dimension"].
 // Bend around axis parallel X and with Z-coordinate equal "radius", i.e. F(x,"0","radius")
 // The object will be divided into "nstep" pieces along the Y axis. First piece is not changes. Each next piece will be rotated relative to the axis F(x,"0","radius") arount piece center Y-coord.
 
// Bend flat object on the cylinder width specified radius
// dimensions: vector with dimensions of the object that should be bent
// radius:     distance of the cylinder axis
// nsteps:     number of parts the object will be split into before being bent 
module cylindric_bend(dimensions, radius, nsteps = $fn) {
	step_angle = nsteps == 0 ? $fa : atan(dimensions.y/(radius * nsteps));
	steps = ceil(nsteps == 0 ? dimensions.y/ (tan(step_angle) * radius) : nsteps);
	step_width = dimensions.y / steps;
	{
		intersection() {
			children();
			cube([dimensions.x, step_width/2, dimensions.z]);
		}      
		for (step = [1:steps]) {
			translate([0, radius * sin(step * step_angle), radius * (1 - cos(step * step_angle))])
   			rotate(step_angle * step, [1, 0, 0])
					translate([0, -step * step_width, 0])
						intersection() {
							children(0);
							translate([0, (step - 0.5) * step_width, 0])
								cube([dimensions.x, step_width, dimensions.z]);
						}
		}
	}
}

// Bend flat object on parabole
// dimensions: vector with dimensions of the object that should be bent
// steepness:  coeficient 'a' of the function 'y = a * x^2'
// nsteps:     number of parts the object will be split into before being bent 
module parabolic_bend(dimensions, steepness, nsteps = $fn) {
	function curr_z(step, ysw) = steepness * pow(step * ysw, 2);
	function flat_width(step, ysw) = 
		ysw * sqrt(pow(2 * steepness * step * ysw, 2) + 1);
	function acc_y(step, ysw) =
		step == 0 ? ysw / 2 : acc_y(step - 1, ysw) + flat_width(step, ysw);

	max_y = dimensions.y / sqrt(1 + steepness);
	ysw = nsteps == 0 ? tan($fa) / (2 * steepness) : max_y / nsteps;
	steps = ceil(nsteps == 0 ? max_y / ysw : nsteps);
	{
		intersection() {
			children(0);
			cube([dimensions.x, ysw/2, dimensions.z]);
		}      		

		for (step = [1:steps]) {
			curr_flat = flat_width(step, ysw);
			acc_flat = acc_y(step - 1, ysw);
			angle = atan(2 * steepness * step * ysw);
			{
				translate([0, step * ysw, curr_z(step, ysw)])
   				rotate(angle, [1, 0, 0])
						translate([0, -acc_flat - curr_flat/2, 0])
							intersection() {
								children(0);
								translate([0, acc_flat, 0])
									cube([dimensions.x, curr_flat, dimensions.z]);
							}
			}
		}
	}
}
