use <bracket.scad>;

module bracket_8080(h=5) {
	bracket(h, 200, 80, 80) {
		bracket_holes(80, 200, 10, 6, 3, 2);
		translate([0, 30, 0]) bracket_holes(80, 200, 30, 6, 3, 2);
	}
}
bracket_8080();