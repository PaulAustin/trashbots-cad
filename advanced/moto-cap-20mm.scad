$fn = 50;


difference() {
    difference() {
        sphere(d=21);
        translate([0,0,-10.5]) cube(21, center=true);
    }
    union() {
        cylinder(h=9.5, d=3);
        cylinder(h=5, d=5);
        translate([0,0,5]) cylinder(h=1.5, d1=5, d2=3);
    }
}


for(i = [0:120:360]) {
    rotate(i) translate([5,-1.5,-3]) cube(size=[2,3,5]);
}
/*
    union() {
        cylinder(h=9.5, d=3);
        cylinder(h=5, d=5);
        translate([0,0,5]) cylinder(h=1.5, d1=5, d2=3);
    }
*/