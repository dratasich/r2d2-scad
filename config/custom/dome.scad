//
// Dome Measures from Custom Build
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
// holes
//

// list of circular holes
// hole specified by [d, a, h]
// d .. diameter
// a .. angle counter-clockwise from front of circle center/bottom
// l .. length of arc to circle bottom from dome_bottom
dome_holes_circular = [
    // holo projectors
    [50, 30, 20]
    // front light
    // back light
    ];

// list of polygonal holes
// hole specified by a [points, paths, a, l]
// points .. list of points, first point should by [0,0] defining left bottom
//           corner of a polygon
// paths .. list of paths (leave empty or undef if the polygon is defined by
//          the points and its order
// a .. angle counter-clockwise from front of the point [0,0]
// l .. length of arc to polygon point [0,0]
dome_holes_polygonal = [
    // radar eye
    [ [[0,0], [60,0], [60,70], [20,70]], [], 50, 50]
    ];
