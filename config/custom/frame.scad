//
// inner frame
//

frame_d = 360;

frame_ring_d = 360;
frame_ring_h = 10;
frame_ring_th = 59;

frame_base_w = 345;
frame_base_hole = [250, 180];

frame_middle_ring_th = 20;
frame_middle_ring_o = 150;

frame_top_plate_th = 60;
frame_top_plate_o = 370;

frame_side_plates_c = 120;
frame_side_plates = [150, 10, frame_top_plate_o];

frame_uprights_x = 15;
frame_uprights_y = 10;
frame_uprights_ha = [
    [200, 0],
    [200, 30],
    [frame_top_plate_o, 60],
    [frame_top_plate_o, 120],
    [frame_top_plate_o, 170],
    [180, 190],
    [180, 220],
    [180, 250],
    [frame_top_plate_o, 300],
    [frame_top_plate_o, 330]
];
frame_uprights_o = 5;

frame_total_h = frame_top_plate_o + frame_ring_h;
