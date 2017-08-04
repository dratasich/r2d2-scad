include <config/config.scad>;

use <senna/frame.scad>;
use <csr/dome.scad>;
use <csr/dome_rings.scad>;
use <mounts/cny70.scad>;
use <mounts/psi.scad>;
use <mounts/logic_display.scad>;


frame();

translate([0, 0, frame_total_h])
dome_rings();

translate([0, 0, frame_total_h + dome_bottom])
dome();

translate([150, 0, 0])
rotate([0, 0, 90])
mount_cny70(draw_parts=true);

translate([0, 0, frame_total_h + dome_bottom])
psi(dome_psi_front, th=1.2, draw_parts=false);

translate([0, 0, frame_total_h + dome_bottom])
ld(dome_ld_front_up, h=10, scale=0.8, th=1, draw_parts=false);
