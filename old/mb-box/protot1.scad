
bw = 64;
bl = 100;
bh = 12;

bxh = 30;
bxw = 70;
bxl = 100;

// Corner radius
cr = 4;

$fn = 20;

#translate([2,0,0]) cube([bw, bl, bh]);
translate([0, 0, 0]) cylinder(d=cr, h = bxh);
translate([bxw,0,0]) cylinder(d=cr, h = bxh);
translate([0,bxl,0]) cylinder(d=cr, h = bxh);
translate([bxw,bxl,0]) cylinder(d=cr, h = bxh);

cube([bw, bl,10]);
//cube([bxh, bxw,
