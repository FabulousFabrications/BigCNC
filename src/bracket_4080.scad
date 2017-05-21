use <bracket.scad>;

module bracket_4080(h=5, l=200) {
	bracket(h, l, 80, 40) {
		translate([0, 55, 0]) bracket_holes(40, l, 10, 6, 4);
		bracket_holes(80, l, -6.6666, 6, 4, 2);
	}
}

bracket_4080();