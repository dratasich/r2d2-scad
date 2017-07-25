//
// Dome Modules
//

include <../utils/utils.scad> // rad, deg
include <../config/config.scad>;


module dome() {
    color(c_dome) dome_outer_skin();
}


//
// functions
//

// calculate elevation angle from height over bottom ring
function angle_from_height(h) =
    asin((h/dome_ratio) / (dome_diameter/2));

// calculate elevation angle from arc length over bottom
// caveat: does not work with a dome_ratio != 1
function angle_from_arc(s) = s / (dome_diameter/2);

// calculate arc from chord
// caveat: does not work with a dome_ratio != 1
function arc_from_chord(c) = 2 * rad(asin(c/dome_diameter))
    * (dome_diameter/2);


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
        for (h = dome_holes) {
            d = h[0];
            az = h[1]; // angle from front
            l = h[2] + arc_from_chord(d)/2;
            ay = 90-deg(angle_from_arc(l)); // angle from bottom
            rotate([0, ay, az])
                cylinder(h=dome_diameter+1, d=d, center=true);
        }
    }
}
