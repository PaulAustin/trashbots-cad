


$fn=30;


// dimensions units in mm
servoSplines = 20;
servoDiameter = 5.0; 
slatWidth = 10;
slatDepth = 10;
slatThickness = 2;
hubDiameter = 20;

spread = 0;

// Strategy 
// 1. Core hub + spline core
// 2. Remove slots
// 3. Remove compression slots

// Hub

color("cyan") rotate_extrude() {
    difference(){
        translate([0,-slatWidth/2,0]) square([hubDiameter,slatWidth]);
        translate([hubDiameter+2,0,0]) circle(d=slatWidth-1);
    }
}

translate([hubDiameter-slatDepth,0,spread-slatWidth/2]) rotate([90,0,0])  square([slatDepth,slatWidth]);