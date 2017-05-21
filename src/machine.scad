section1_side = 100;
section1_thickness = 4;
section2_side = 50;
section2_thickness = 3;

// lengths in mm
length_a = 2100; // horizontal, red
length_b = 3000; // horizontal, blue
length_c = 300; // vertical, green
length_d = length_a + section1_side*2 + 100;
length_legs = 500;

//7500 - 3000 - 2100

$fn = 50;
totalSectionLength = length_a;

use <steel section.scad>;
use <box section guide.scad>;

machine();

module machine() {
	frame();
	gantry();
	//color("LightSteelBlue") brackets();
}

module gantry() {
	xMin = 100;
	xMax = 2700;
	translate([0, xMin + $t*(xMax-xMin), 0]) {
		translate([section1_side/2, 0, section1_side/2]) guide();
		translate([length_a - section1_side/2, 0, section1_side/2]) guide();
		translate([-50, 20, 40+section1_side+26])
		rotate([-90, 180, -90])
		HFS8_4080(length_d);
		translate([-50, 195, 40+section1_side+26])
		rotate([-90, 180, -90])
		HFS8_4080(length_d);
	}
}

module frame_top() {
	translate([0, 0, section1_side/2]) {
		translate([0, section1_side/2, 0])
		rotate([-90, 180, -90])
		{
			rotate([0, 0, 180]) a_section();
			translate([length_b - section1_side, 0, 0]) a_section();
		}
		translate([section1_side/2, 0, 0])
		rotate([-90, 0, 0])
		{
			rotate([0, 0, 180]) b_section();
			translate([length_a - section1_side, 0, 0]) b_section();
		}
	}
}

module frame_bottom() {
	translate([0, 0, -length_c-section1_side]) frame_top();
	/*color([0.5, 0.5, 0.5]) translate([0, 0, -(length_c - section2_side/2)]) {
		translate([section1_side, section2_side/2, 0])
		rotate([-90, 180, -90]) {
			rotate([0, 0, 180]) section2(length_a - section1_side*2, false);
			translate([length_b - section2_side, 0, 0]) section2(length_a - section1_side*2, false);
		}
		translate([section2_side/2, section1_side, 0])
		rotate([-90, 0, 0]) {
			rotate([0, 0, 180]) section2(length_b - section1_side*2, false);
			translate([length_a - section2_side, 0, 0]) section2(length_b - section1_side*2, false);
		}
	}*/
}

module frame_between() {
	translate([section1_side/2, section1_side/2, -(length_c)]) {
		c_section();
		translate([0, length_b - section1_side, 0])
		c_section();
		translate([length_a - section1_side, 0, 0])
		c_section();
		translate([length_a - section1_side, length_b - section1_side, 0])
		c_section();
	}
}

module frame_leg() {
	/*
	translate([section2_side/2 + section1_side/2, section2_side/2 + section1_side/2, -(100 + length_c - section2_side)]) { 
		translate([section2_side, 0, 0]) angle_join();
		
		translate([0, section2_side, 0]) rotate(0) angle_join();
	}
	*/
}

module frame_legs() {
	frame_leg();
}

module frame() {
	frame_top();
	frame_bottom();
	frame_between();
	frame_legs();
}

module a_section() {
	color([0.5, 0.25, 0.25]) section1(length_a, true);
}

module b_section() {
	color([0.25, 0.25, 0.5]) section1(length_b, true);
}

module c_section() {
	color([0.25, 0.5, 0.25]) section1(length_c, false);
}

module section1(l, miter) {
	square_section(section1_side, section1_thickness, l, miter);
}

module section2(l, miter) {
	square_section(section2_side, section2_thickness, l, miter);
}

module angle_join() {
	angle_section(50, 50, 3, 100);
}

module HFS8_4080(length) {
	linear_extrude(height=length) import("misumi/HFS8-4080.dxf", layer="vis");
}
module HFS8_4040(length) {
	linear_extrude(height=length) import("misumi/HFS8-4040.dxf", layer="vis");
}