//
// Configuration
//

// globals
$fn=30;

// load all official measures
/* include <csr/droid.scad> */
/* include <csr/dome.scad> */
/* include <senna/frame.scad> */

// load custom measures (overwrites variables)
include <custom/droid.scad>
include <custom/dome.scad>
include <custom/frame.scad>
include <custom/color.scad>

// activate stl imports
draw_stl = false;

// clearance for mounts
clr = 0.5;
