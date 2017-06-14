use <hub.scad>;
$fn = 60;

module pegPlateAxel(pegCount = 6, pegHeight = 2.4) {
    shaftDiameter = 7.6;
    shaftRadius = shaftDiameter/2;
    plateThickness = 1.4;
    pLateDiameter = 27;
    postHeight = 8;

    translate([0,0,0]) color("orange") cylinder(r1=(pLateDiameter/2), r2 =(pLateDiameter/2)-1, h=plateThickness);
    translate([0,0,-2.4]) rotate([0,0,0]) circlePegs(pegs = pegCount, diameter=26.8, height=2.4);
    
    difference() {
        union() {
            // Primary Post
            color("red") translate([8,0,plateThickness]) cylinder(d=shaftDiameter, h=postHeight);
            // Create snap rigde
            color("green") translate([8,0,plateThickness+postHeight-2]) 
                cylinder(r1=shaftRadius, r2=shaftRadius+0.3, h=1);
            color("green") translate([8,0,plateThickness+postHeight-1]) 
                cylinder(r1=shaftRadius+0.3, r2=shaftRadius, h=1);
            // Chamfer on bottom for strength
            color("green") translate([8,0,plateThickness]) 
                cylinder(r2=shaftRadius, r1=shaftRadius+0.3, h=1);
        }
        union() {
            // Compression slot in middle. 
            translate([8,0,8])cube([2,10,8], center = true);
        }
    }
}

//rotate([180,0,0]) pegPlugHub(pegCount = 6, pegHeight = 2.5);

pegPlateAxel(pegCount = 6, pegHeight = 2.4);