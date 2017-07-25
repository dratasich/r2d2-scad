include <config/config.scad>;

use <r2d2/frame.scad>;
use <r2d2/dome.scad>;
use <r2d2/dome_rings.scad>;
use <mounts/cny70.scad>;


frame();

translate([0, 0, frame_total_h])
dome_rings();

translate([0, 0, frame_total_h + dome_bottom])
dome();

translate([150, 0, 0])
rotate([0, 0, 90])
mount_cny70(draw_parts=true);
