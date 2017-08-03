//
// Mount for PSI Light
//

include <../config/config.scad>; // clr
include <../utils/utils.scad>; // move_intersect_sphere


module psi(hole, th=1.5, draw_parts=false) {
    // extract hole vector
    d = hole[0];
    a = hole[1];
    l = hole[2];
    // placement in dome
    az = a; // angle from front
    s = l + arc_from_chord(d, dome_diameter)/2;
    ay = -angle_from_arc(s, dome_diameter); // angle from bottom

    // mount, aligned to dome shape
    color(c_print) psi_mount(d, ay, az, th=th);

    if (draw_parts) {
        // opal glass
        color(c_white, 0.7) psi_glass(d, ay, az, th=th, clearance=clr);
    }
}


//
// parts
//

module psi_led(diameter, clearance=0) {
    cylinder(h=7, d=diameter+clearance);
    cylinder(h=1, d=diameter+0.5+clearance);
}

module psi_glass(d, ay, az, th=1.5, clearance=0) {
    overlap = 0.1;
    ho = dome_thickness;
    hi = 3*th-clearance;
    // outer part (goes through dome)
    intersection() {
        rotate([0, ay+90, az])
            translate([0, 0, dome_diameter/4+1])
            cylinder(h=dome_diameter/2+2, d=d-clearance, center=true);
        difference() {
            sphere(d=dome_diameter);
            sphere(d=dome_diameter-2*ho);
        }
    }
    // inner part (sticked to mount)
    intersection() {
        rotate([0, ay, az])
            translate([dome_diameter/2-(ho+hi)/2, 0, 0])
            rotate([0, -90, 0])
            cylinder(h=ho+hi, d=d+2*th-clearance, center=true);
        sphere(d=dome_diameter-2*ho+overlap);
    }
}

module psi_mount(d, ay, az, th=1.5) {
    overlap = 0.1;
    h = 20;

    difference() {
        move_intersect_sphere(dome_diameter-2*dome_thickness, ay, az)
            rotate([0, -90, 0])
            difference() {
            // mount
            union() {
                // stick to dome (inner diameter must equal housing)
                ring(h=4*th, do=d+10*th, th=5*th);
                // housing
                translate([0, 0, th-overlap])
                    ring(h, d+2*th, th);
                // mount for LED
                translate([0, 0, h])
                    cylinder(h=th, d=d+2*th);
            }

            // hole for (center) LED
            translate([0, 0, h-2])
                psi_led(5, clr);
            // holes in case the LED produces heat (or for more LEDs ;)
            for (a = [0 : 60 : 360]) {
                rotate([0, 0, a])
                    translate([d/4+th, 0, h-2])
                    psi_led(5, clr);
            }
        }
        psi_glass(d, ay, az, th, 0);
    }
}
