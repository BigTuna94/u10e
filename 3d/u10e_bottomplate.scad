bottom_thickness = 4;
left_wall_thickness = 4;
right_wall_thickness = 4;
case_height= 9.5; // Choc low profile - printed 7.5
//case_height = 16; // for kailh choc high profile
// case_height = 22; // for cherry style high profile


module pcb_outline(ht) {
    linear_extrude(height=ht, center=true, convexity=1)
       // import (file="u10e_topplate-Edge_Cuts_manual.svg");
        import (file="../pcb/svg/u10e-Edge_Cuts-manual.svg");
}

module rounded_pcb(curve, height) {
    minkowski() {
        pcb_outline(ht=height);
        cylinder(r=curve/2, h=height, $fn=32);
    }
}

module scaled_rounded_pcb(height) {
    scale([1.08, 1.06, 1]) rounded_pcb(2, height);
}

module shell_3d(th=0.1,N=4) {
 union() {
  // Top
  render() difference() {
    child(0);
    translate([0,0,-th]) child(0);
  }
  // Bottom
  render() difference() {
    child(0);
    translate([0,0,th]) child(0);
  }
  // In XY plane
  for(i=[0:N-1]) assign(rotAngle=360*i/N) {
    render() difference() {
      child(0);
      translate([th*cos(rotAngle),th*sin(rotAngle),0]) child(0);
    }
  }
  // In Top half at 45 degrees
  for(i=[0:N-1]) assign(rotAngle=360*(i+0.5)/N) {
    render() difference() {
      child(0);
      translate([th*sqrt(0.5)*cos(rotAngle),th*sqrt(0.5)*sin(rotAngle),th*sqrt(0.5)]) child(0);
    }
  }
  // In Bottom half at 45 degrees
  for(i=[0:N-1]) assign(rotAngle=360*(i+0.5)/N) {
    render() difference() {
      child(0);
      translate([th*sqrt(0.5)*cos(rotAngle),th*sqrt(0.5)*sin(rotAngle),-th*sqrt(0.5)]) child(0);
    }
  }
 }
}

module holeless_case() {
    difference() {
        translate([0.48,0,0]) scaled_rounded_pcb(case_height);
        scale([1.015, 1.015, 1]) translate([4.5, 3.0, 10])  pcb_outline(ht=case_height*1.4);
    }
}

module usb_c_port() {
    r=3.1;
    translate([r+8.96,118, bottom_thickness+r+5]) rotate([90,90,0]) cylinder(left_wall_thickness+2, r,r, center=false,$fn=32);
    translate([r+17.96,118,bottom_thickness+ r+5]) rotate([90,90,0]) cylinder(left_wall_thickness+2, r,r, center=false,$fn=32);
    translate([r+8.96,112, bottom_thickness+5]) cube([9,r*2,r*2], center=false);
}

difference() {
    holeless_case();
    usb_c_port();
}

