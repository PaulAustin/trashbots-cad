bw = 64;
bl = 100;
bh = 12;

bxh = 30;
bxw = 70;
bxl = 100;

cr = 2;

$fn = 20;
/*
minkowski() {
    translate([cr,cr,cr]) sphere(r = cr);
    translate([cr,cr,cr]) cube([bw,bl,bh]);
}
*/

minkowski() {
    translate([cr,cr,cr]) sphere(r = cr);
    cube([bw,bl,bh]);
}