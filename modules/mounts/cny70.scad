//
// Mount for CNY70 to measure dome speed
//

include <../../config/config.scad>; // clr

module mount_cny70(draw_parts=false) {
    // mount for CNY70 and 2 LEDs
    color(c_print) mount();
    // CNY70 and 2 LEDs
    if (draw_parts) {
        color(c_part)
            translate([0, 0, 17])
            rotate([90, 0, 0])
            cny70();
        color(c_part)
            translate([-9, 4, 17])
            rotate([90, 0, 0])
            led(5);
        color(c_part)
            translate([9, 4, 17])
            rotate([90, 0, 0])
            led(5);
    }
}


//
// parts
//

module cny70(clearance=0) {
    cny70_h = 6 + clearance;
    cube([7 + clearance, 7 + clearance, cny70_h], true);
    // simulate 4 pins
    pin_h = 6;
    translate([0, 0, -cny70_h/2-pin_h/2])
        cube([3, 3, pin_h], true);
}

module led(diameter, clearance=0) {
    cylinder(h=7, d=diameter+clearance);
    cylinder(h=1, d=diameter+0.5+clearance);
}

module mount() {
    overlap = 0.1;

    // cny70 mount
    off = 17;
    led_d = 5;
    th = 2;
    l = 7+4+2*led_d+5;
    h = 10;
    translate ([0, 0, off])
    rotate([90, 0, 0])
        difference() {
        cube([l, h+overlap, th], true);
        // holes for CNY70 and 2 LEDs
        cny70(clr);
        translate([led_d+4, 0, -4]) led(5, clr);
        translate([-(led_d+4), 0, -4]) led(5, clr);
    }

    // height
    conn_w = 10;
    points = [[conn_w/2,0], [-conn_w/2,0],
              [-conn_w/2,10], [-l/2,off-h/2],
              [l/2, off-h/2], [conn_w/2, 10]];
    translate([0, th/2, 0])
        rotate([90, 0, 0])
        linear_extrude(height=th)
        polygon(points);

    // ring mount
    screw_d = 3;
    base_l = conn_w+screw_d*2+6*th;
    translate([0, screw_d/2+th/2, 0])
        difference() {
        cube([base_l, screw_d+2*th, th], true);
        // holes for screws
        translate([base_l/2-screw_d/2-th, 0, -th/2-clr])
            cylinder(h=th+2*clr, d=screw_d);
        translate([-(base_l/2-screw_d/2-th), 0, -th/2-clr])
            cylinder(h=th+2*clr, d=screw_d);
    }
}
