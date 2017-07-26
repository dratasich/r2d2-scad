//
// Frame Modules
//

include <../utils/utils.scad>;
include <../config/config.scad>;

module frame() {
    color(c_wood) {
        frame_base();
        frame_middle_ring();
        frame_top_plate();
        frame_side_plates();
        frame_uprights();
    }
}

//
// parts
//

module frame_base() {
    difference() {
        intersection() {
            cylinder(d=frame_ring_d, h=frame_ring_h);
            // flatten sides (for legs)
            cube([frame_ring_d+2, frame_base_w, 4*frame_ring_h], true);
        }

        // bottom hole
        cube([frame_base_hole[0], frame_base_hole[1], 4*frame_ring_h], true);
    }
}

module frame_middle_ring() {
    translate([0, 0, frame_middle_ring_o])
        ring(h=frame_ring_h, do=frame_ring_d, th=frame_middle_ring_th);
}

module frame_top_plate() {
    translate([0, 0, frame_top_plate_o])
        ring(h=frame_ring_h, do=frame_ring_d, th=frame_top_plate_th);
}

module frame_side_plates() {
    translate([0, -frame_side_plates_c, frame_side_plates[2]/2])
        cube(frame_side_plates, true);
    translate([0, frame_side_plates_c, frame_side_plates[2]/2])
        cube(frame_side_plates, true);
}

module frame_uprights() {
    translate([0, 0, frame_uprights_o]) {
        for (u = frame_uprights_ha) {
            h = u[0]; // height
            a = u[1]; // angle from front
            rotate([0, 0, a])
                translate([frame_ring_d/2-frame_uprights_x,
                           -frame_uprights_y/2, 0])
                cube([frame_uprights_x, frame_uprights_y, h]);
        }
    }
}
