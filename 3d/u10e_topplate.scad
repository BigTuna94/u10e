plate_thickness = 1.8;

module plate(ht) {
    linear_extrude(height=ht, center=true, convexity=1)
        import (file="../pcb/svg/u10e_topplate-with-holes.svg", $fn=32);
}
//scaling is off???
plate(plate_thickness);