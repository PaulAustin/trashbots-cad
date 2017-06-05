/*bw = 64;
bl = 100;
bh = 12;
*/
bw = 34;
bl = 50;
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

difference() {
difference() {
    minkowski() {
        translate([cr,cr,cr]) sphere(r = cr);
        cube([bw+3,bl+3,bh]);
    }

    #translate([1.5,1.5, 1.5]) minkowski() {
        translate([cr,cr,cr]) sphere(r = cr);
        cube([bw,bl,bh]);
    }
}

#translate([-cr,-cr,10]) cube([bw+10,bl+10,10]);

}