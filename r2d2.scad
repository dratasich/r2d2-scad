include <config/config.scad>;

use <senna/frame.scad>;
use <csr/dome.scad>;
use <csr/dome_rings.scad>;
use <mounts/cny70.scad>;
use <mounts/psi.scad>;


frame();

translate([0, 0, frame_total_h])
dome_rings();

translate([0, 0, frame_total_h + dome_bottom])
dome();

translate([150, 0, 0])
rotate([0, 0, 90])
mount_cny70(draw_parts=true);

translate([0, 0, frame_total_h + dome_bottom])
psi(dome_psi_front, draw_parts=false);
