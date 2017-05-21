use <bracket.scad>;

module bracket_4040(h=5) {
	bracket(h, 150, 40, 40) {
		bracket_holes(40, 150, 1.5, 6, 4);
		translate([0, 15, 0]) bracket_holes(40, 150, 15, 6, 3);
	}
}
bracket_4040();
