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

