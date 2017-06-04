$fn = 40;
difference() {
cube([30,30,10], center = true);
    union() {
        translate ([0,14,0]) cube([30,20,10], center =true);
        translate ([0,0,-5]) cylinder(d=26.5,h=10);
    }
}