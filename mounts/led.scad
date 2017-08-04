//
// LEDs
//

module led_3mm(clearance=0) {
    cylinder(h=5.3, d=3+clearance);
    cylinder(h=1, d=3.3+clearance);
}
