bottom_thickness = 6;
left_wall_thickness = 6.415;
right_wall_thickness = 4;

socket_to_pcb_top = 3.5;

lo_pro_choc_ht = 2;
hi_pro_choc_ht = 6;
lo_pro_cherry_ht = 5; 
hi_pro_cherry_ht = 11.5;


case_height = socket_to_pcb_top + hi_pro_choc_ht;



module pcb_outline(ht) {
    linear_extrude(height=ht, center=false, convexity=1)
    import (file="../pcb/svg/u10e-Edge_Cuts-manual.svg");
}

module rounded_pcb(curve, height) {
    minkowski() {
        pcb_outline(ht=height);
        cylinder(r=curve/2, h=height, center=false, $fn=32);
    }
}

x_scale = 1.08;
y_scale = 1.06;
module scaled_rounded_pcb(height) {
    scale([x_scale, y_scale, 1]) rounded_pcb(2, height);
}

module holeless_case() {
    difference() {
        translate([x_scale, y_scale, 0]) scaled_rounded_pcb(case_height);
        scale([1.0105, 1.0105, 1]) translate([x_scale*5.85, y_scale*4.6, bottom_thickness]) pcb_outline(ht=case_height*1.75);
    }
}

module usb_c_port() {
    r=3.1;
    wall_offset = 5.5;
    floor_offset = 6;
    d = 8.8;
    translate([r+left_wall_thickness+wall_offset,   124, r+bottom_thickness+floor_offset]) rotate([90,90,0]) cylinder(left_wall_thickness+2, r,r, center=false, $fn=32);
    translate([r+left_wall_thickness+wall_offset+d, 124, r+bottom_thickness+floor_offset]) rotate([90,90,0]) cylinder(left_wall_thickness+2, r,r, center=false, $fn=32);
    translate([r+left_wall_thickness+wall_offset,   114, bottom_thickness+floor_offset]) cube([d, r*2, r*2], center=false);
}

difference() {
    holeless_case();
    usb_c_port();
//    translate([0, 0, 0]) cube([6.415, 50, 100]);
}


