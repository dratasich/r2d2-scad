//
// Dome Ring Modules
//

include <../utils/utils.scad> // ring
include <../config/config.scad>; // measures, colors

module dome_rings() {
    color(c_dome_panel) ring_middle();
    color(c_dome) ring_base();
}

//
// parts
//

module ring_middle() {
    translate ([0, 0, dome_middle_ring_offset])
        ring(h=dome_middle_ring_h, do=dome_middle_ring_d,
             th=dome_middle_ring_th);
}

module ring_base() {
    ring(h=dome_base_ring_h, do=dome_base_ring_d, th=dome_base_ring_th);
}
