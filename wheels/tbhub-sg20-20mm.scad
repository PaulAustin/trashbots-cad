


$fn=60;


// dimensions units in mm
servoSplines = 20;
servoDiameter = 5.0; 
slatWidth = 10;
slatDepth = 10;
slatThickness = 1.9;
stickDiameter = 6;
hubDiameter = 20;

// Strategy 
// 1. Core hub + spline core
// 2. Remove slots
// 3. Remove compression slots

// Hub
module plugHub(plugCount = 6) {
    difference() {
        color("cyan") rotate_extrude() {
            difference(){
                translate([0,-slatWidth/2,0]) square([hubDiameter,slatWidth]);
                translate([hubDiameter+2,0,0]) circle(d=slatWidth-1);
            }
        }

        #union () {
            translate([0,0,-((slatWidth+1)/2)]) cylinder(h = slatWidth+1, d = 8);
            for(i=[0:(360/plugCount):360]) {
                translate([0,0,-(slatWidth+1)])
                rotate(i)
                translate([hubDiameter-slatDepth,0,(slatWidth+1)/2]) rotate([90,0,0])  {
                    // Slot for a popsicle stick
                    translate([0,0,-slatThickness/2])   
                    linear_extrude(slatThickness) square([slatDepth,slatWidth+1]);
                    
                    // Carve out back of slot as well
                    translate([3.3,(slatWidth+1)/2,-slatThickness/2])   cylinder(h = slatThickness, d = slatWidth*1.2);
                    
                    // Cylinder for straw 
                    translate([0,(slatWidth+1)/2,0])
                    rotate([90,0,90]) cylinder(d=stickDiameter, h=slatDepth);
                }
            }
        }
    }
}

plugHub(plugCount = 6);
