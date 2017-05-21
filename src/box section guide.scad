

guide();

gap_mult = 1.4;

color([0.2, 0.2, 0.2]) cube([100, 500, 100], center=true);

//defaults to 100mm box section with 6201-2Z
module guide(side=100, oside=30, bod=32, bid=12, bw=10, bearing_count=3, bolt_extra_length=30, extra_length = 80) {
	bl = side+oside*2+bolt_extra_length;
	tl = bod*gap_mult*bearing_count + extra_length;
	
	translate([0, extra_length/2+bod*gap_mult/4, 0]) {
		for(i = [0:bearing_count-1]) {
			translate([0, i*bod*gap_mult, 0]) {
				%guide_set(side, bod, bid, bw);
				mr([0, 90, 0], [0, (bod*gap_mult)/2, 0])
				translate([side/2 + bod/2, 0, -bl/2]) cylinder(d=bid, h = bl);
			}
		}
		
		mirror_keep([0, 0, 1])
		mirror_keep([1, 0, 0])
		translate([side/2 + bod/2, tl/2 - bod*gap_mult/4 - extra_length/2, side/2 + bod/2]) cube([oside, tl, oside], center=true);
	}
}

module guide_set(side, bod, bid, bw) {
	dmr([0, 90, 0], [0, (bod*gap_mult)/2, 0])
	translate([side/2 + bod/2, 0, side/2 - side/5]) bearing(bod, bid, bw);
}

module mr(v, o) {
	mirror_keep([1, 0, 0]) children();
	translate(o) rotate(v) mirror_keep([1, 0, 0]) children();
}

module dmr(v, o) {
	dm() children();
	translate(o) rotate(v) dm() children();
}

module dm() {
	mirror_keep([0, 0, 1])
	mirror_keep([1, 0, 0])
	children();
}

module mirror_keep(v) {
	children();
	mirror(v) children();
}

module bearing(outer, inner, width) {
	translate([0, 0, -width/2]) linear_extrude(width) difference() { circle(d=outer); circle(d=inner); }
}