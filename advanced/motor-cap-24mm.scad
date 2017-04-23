$fn = 50;

rotate([180,0,0]) translate([0,0,-17]) difference() {
    // Outer shell
    union() {
        cylinder(h=11, d=26.5);
        translate([0,0,11]) cylinder(h=6, d1=26.5, d2=19);
    }
    // Inside
    union() {
        // Shaft
        translate([0,0,9]) cylinder(h=3.5, d=5);
        translate([0,0,12.5]) cylinder(h=1.5, d1=5, d2=3);
        translate([0,0,13.5]) cylinder(h=3, d=3);
        
        // Motor base
        cylinder(h=4, d=24.2);
        translate([0,0,4]) cylinder(h=5, d1=24.2, d2=22);
    }
}


/*
        translate([0,0,9]) cylinder(h=3.5, d=5);
        translate([0,0,12.5]) cylinder(h=1.5, d1=5, d2=3);
        translate([0,0,13.5]) cylinder(h=3, d=3);
*/

/*
        translate([0,0,9]) cylinder(h=5, d=5);
        translate([0,0,14]) cylinder(h=1.5, d1=5, d2=3);
        translate([0,0,15.5]) cylinder(h=3, d=3);
*/

