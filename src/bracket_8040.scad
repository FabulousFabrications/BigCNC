use <bracket_4080.scad>;

module bracket_8040(h=5) {
	rotate([0, 0, 90]) scale([1, -1, 1]) bracket_4080();
}

bracket_8040();