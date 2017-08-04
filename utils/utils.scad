//
// Useful Functions
//

// converts inch to mm (note, CS:R is specified in inch)
function metric(inch) = 25.4 * inch;
function imperial(mm) = mm / 25.4;

// creates ring with height, diameter and thickness
module ring(h, do, th) {
    /*
    // inner diameter, default 1mm ring
    d1 = do - 2;
    if (th) {
        d1 = do - 2*th;
    }
    if (di) {
        d1 = di;
    }
    */
    difference() {
        cylinder(h=h, d=do);
        translate([0, 0, -1]) // for cut
            cylinder(h=h+2, d=do-2*th);
    }
}

// radiant to degree
function deg(rad) = rad * 180 / PI;

// degree to radiants
function rad(deg) = deg * PI / 180;

// calculate elevation angle from arc length over bottom
// caveat: does not work with a dome_ratio != 1
function angle_from_arc(s, d) = deg(s / (d/2));

// calculate arc from chord
// caveat: does not work with a dome_ratio != 1
function arc_from_chord(c, d) = 2 * rad(asin(c/d)) * (d/2);

function poly_points(v) = v[0];
function poly_paths(v) = v[1];
function poly_az(v) = v[2];
function poly_ay(v) = -angle_from_arc(v[3], dome_diameter);
function poly_cx(points) = (points[1][0] - points[0][0])/2;
function poly_cy(points) = (points[2][1] - points[1][1])/2;

// operator module that moves an object to the outside of the dome on the
// specified position and intersects the object with the dome; this way the
// object's outside shape gets aligned to the dome (for psi, logic displays,
// etc.)
module move_intersect_sphere(d=0, ax=0, ay=0, az=0) {
    intersection() {
        rotate([ax, ay, az]) // rotate to position on dome
            translate([d/2, 0, 0]) // move to outside of the dome
            children();
        sphere(d=d); // intersect with dome
    }
}
