//
// Dome Modules
//

include <../utils/utils.scad> // rad, deg
include <../config/config.scad>;


module dome() {
    if (draw_stl) {
        color(c_blue) radar_eye();
    }
    color(c_dome) dome_outer_skin();
}


//
// functions
//

// calculate elevation angle from height over bottom ring
function angle_from_height(h) =
    deg(asin((h/dome_ratio) / (dome_diameter/2)));


//
// parts
//

module dome_outer_skin() {
    scale([1, 1, dome_ratio]) // dome is stretched up
        difference() {
        // outer skin
        sphere(d=dome_diameter);
        // cut out to get a bowl
        sphere(d=dome_diameter-2*dome_thickness);
        // cut off bottom half of sphere below floor
        translate([-(dome_diameter+1)/2,-(dome_diameter+1)/2,-dome_diameter])
            cube([dome_diameter+1, dome_diameter+1, dome_diameter]);

        // cut circular holes (holo projector, lights)
        for (h = dome_holes_circular) {
            d = h[0];
            az = h[1]; // angle from front
            l = h[2] + arc_from_chord(d, dome_diameter)/2;
            ay = 90 - angle_from_arc(l, dome_diameter); // angle from bottom
            rotate([0, ay, az])
                cylinder(h=dome_diameter+1, d=d, center=true);
        }

        // cut polygonal holes (radar eye)
        for (h = dome_holes_polygonal) {
            points = h[0];
            paths = h[1];
            o = (points[0][0] - points[1][0])/2; // center of baseline offset
            az = 90 + h[2]; // move base line of polygon to y-axis
            ax = 90 - angle_from_arc(h[3], dome_diameter); // angle from bottom
            rotate([ax, 0, az])
                translate([o, 0, 0])
                linear_extrude(height=dome_diameter+1)
                polygon(points, paths);
        }
    }
}


//
// external: parts loaded from stl
//
// Positioning needs tweaking when the dome_ratio != 1, i.e., shape of your
// dome is not like original CS:R. Hence no constants are used, you will have
// to debug and place it anyway here.
//
// TODO: option for CS:R (to skip translate and rotate and just scale)
//

module radar_eye() {
    /*
    color([0,0,0.5], 0.5) sphere(d=dome_diameter);
    // original position for alignment
    #rotate([0, 0, stl_az])
        scale(dome_csr_factor)
        import("../stl/radar_eye.stl");
    */
    // apply radar eye from stl to the custom dome
    difference() {
        rotate([0, 0, stl_az])
            translate([0, 14, -15])
            rotate([-5, 0, 0])
            translate([0, -15, 0])
            scale(dome_csr_factor)
            import("../stl/radar_eye.stl");
        // cut overlapping parts
        //sphere(d=dome_diameter);
    }
}
