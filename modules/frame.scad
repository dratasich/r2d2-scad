//
// Frame Modules
//

include <../utils/utils.scad>;
include <../config/config.scad>;

module frame() {
    color(c_wood) frame_rings();
}

//
// parts
//

module frame_rings() {
    translate ([0, 0, -frame_ring_h])
        ring(h=frame_ring_h, do=frame_ring_d, th=frame_ring_th);
}
