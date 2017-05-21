module bracket(h, l, a, b) {
	linear_extrude(h) {
		difference() {
			polygon([[0,0], [l, 0], [l, a], [b, l], [0, l]]);
			children(0);
			rotate([0, 180, -90]) children(1);
		}
	}
}

module bracket_holes(width, length, offset_, diameter, holes, rows=1) {
	between_rows = (width)/(rows);
	between_holes = (length - offset_*2)/(holes);
	wcenter = (width-((rows-1)*between_rows))/2;
	lcenter = (length-((holes-1)*between_holes))/2;
	for (r = [0:rows-1]) {
		row = wcenter + r*between_rows;
		for (i = [0:holes-1]) {
			translate([row, lcenter + i*between_holes]) circle(r=diameter/2);
		}
	}
}

