//
// Dome Measures from Custom Builds
// (metric)
//

// dome
dome_diameter = 360; // dome diameter at ring
dome_height = 180; // height of dome from top of 1 inch ring
dome_ratio = dome_height / (dome_diameter/2);

dome_ring_d = 363;

// base ring (1 inch)
dome_base_ring_h = 20;
dome_base_ring_d = dome_ring_d;
dome_base_ring_th = 22;

// middle ring (between base ring and dome)
dome_middle_ring_h = 10;
dome_middle_ring_d = dome_ring_d;
dome_middle_ring_th = 20;

// ring gaps
dome_base_middle_ring_gap = 2;
dome_middle_ring_gap = 0.5;

// offsets
dome_middle_ring_offset = dome_base_ring_h + dome_base_middle_ring_gap;
dome_bottom = dome_middle_ring_offset + dome_middle_ring_h
    + dome_middle_ring_gap;
dome_rings_total_h = dome_bottom;

dome_thickness = 1.5;


//
// holes (circular)
//

// list of holes
// hole specified by [d, a, h]
// d .. diameter
// a .. angle counter-clockwise from front
// l .. length of arc to circle bottom from dome_bottom
dome_holes = [
    // holo projectors
    [50, 30, 20]
    // front light
    // back light
    ];
