//
// Mount for Logic Display
//

include <../config/config.scad>; // clr
include <../utils/utils.scad>; // move_intersect_sphere
include <led.scad>;


module ld(hole, h=10, scale=0.75, th=1, draw_parts=false) {
    color(c_print) ld_mount(hole, h=h, th=th, clearance=clr);
    color(c_silver) ld_outer(hole, h=h, scale=scale, th=th, clearance=clr);

    if (draw_parts) {
        ld_electronics(hole, scale, h=h, th=th);
    }
}


//
// parts
//

// led matrix
module ld_leds(hole, scale, clearance=0) {
    points = poly_points(hole);
    dmin = 3 + clearance;
    l = scale * 2*poly_cx(points)-dmin/2;
    w = scale * 2*poly_cy(points)-dmin/2;
    nx = floor(l / dmin);
    ny = floor(w / dmin);
    dx = l / nx;
    dy = w / ny;
    translate([-l/2, (poly_cy(points)-w/2), 0])
        for(r = [0 : nx-1]) {
            for(c = [0 : ny-1]) {
                translate([dx/2+r*dx, dy/2+c*dy, 0])
                    rotate([180, 0, 0])
                    led_3mm(clearance);
            }
        }
}

module ld_outer(hole, h=10, scale=0.75, th=1, clearance=0) {
    overlap = 0.1;
    points = poly_points(hole);
    // outer part (aligned to outside of the dome)
    intersection() {
        rotate([90+poly_ay(hole), 0, 90+poly_az(hole)])
            translate([-poly_cx(points), 0, 0])
            linear_extrude(height=dome_diameter)
            difference() {
            offset(delta=1)
                polygon(points);
            offset(delta=-1)
                polygon(points);
            }
        difference() {
            sphere(d=dome_diameter+th);
            sphere(d=dome_diameter);
        }
    }
    // inner part (sticked to mount)
    move_intersect_sphere(d=dome_diameter+th,
                          ay=poly_ay(hole), az=poly_az(hole)) {
        translate([0, 0, 2*poly_cy(points)])
        rotate([-90, 0, 90])
            difference() {
                translate([-poly_cx(points), 0, 0])
                    linear_extrude(height=h)
                    offset(delta=-clearance)
                    polygon(points);
                translate([0, poly_cy(points), -overlap])
                    linear_extrude(height=h+overlap-th, scale=scale)
                    translate([-poly_cx(points), -poly_cy(points), 0])
                    offset(delta=-th)
                    polygon(points);
                translate([0, 0, h+overlap+1])
                    ld_leds(hole, scale, clearance=0.5*clearance);
            }
    }
}

module ld_mount(hole, h=10, th=1, clearance=0) {
    overlap = 0.1;
    points = poly_points(hole);
    move_intersect_sphere(d=dome_diameter-2*dome_thickness,
                          ay=poly_ay(hole), az=poly_az(hole)) {
        translate([0, 0, 2*poly_cy(points)])
            rotate([-90, 0, 90])
            translate([-poly_cx(points), 0, 0])
                difference() {
                    union() {
                        // stick to dome
                        linear_extrude(height=3*th)
                            offset(delta=4*th)
                            polygon(points);
                        // housing
                        linear_extrude(height=h-dome_thickness+th)
                            offset(delta=th)
                            polygon(points);
                        // pcb screw housing
                        translate([0, poly_cy(points), 0])
                            cylinder(d=8*th, h=h-dome_thickness+th);
                        translate([2*poly_cx(points), poly_cy(points), 0])
                            cylinder(d=8*th, h=h-dome_thickness+th);
                    }
                    translate([0, 0, -overlap])
                        linear_extrude(height=h-dome_thickness+clearance)
                        polygon(points);
                    linear_extrude(height=h)
                        offset(delta=-2*th)
                        polygon(points);
                    // pcb screw holes
                    translate([-2*th, poly_cy(points), h/2+overlap])
                        cylinder(d=2.5, h=h/2);
                    translate([2*poly_cx(points)+2*th, poly_cy(points),
                               h/2+overlap])
                        cylinder(d=2.5, h=h/2);
                }
    }
}

module ld_electronics(hole, scale, h=10, th=1) {
    hpcb = 1.6;
    points = poly_points(hole);
    rotate([0, poly_ay(hole), poly_az(hole)])
        translate([dome_diameter/2-h-dome_thickness-2*th,
                   0, 2*poly_cy(points)])
        rotate([-90, 0, 90])
        union() {
            color(c_white) ld_leds(hole, scale, 0.5*clr);
            color(c_part)
                translate([-poly_cx(points)-4*th, 0, -2])
                cube([2*poly_cx(points)+8*th, 2*poly_cy(points), hpcb]);
        }
}
