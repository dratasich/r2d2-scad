include <config/config.scad>;

use <modules/frame.scad>;
use <modules/dome_rings.scad>;
use <modules/mounts/cny70.scad>;


frame();

translate([0, 0, frame_total_h])
dome_rings();

translate([150, 0, 0])
rotate([0, 0, 90])
mount_cny70(draw_parts=true);
