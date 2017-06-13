/*
Copyright 2017 Trashbots Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// Make the surfaces smooth by increasing the face count.
$fn=60;

//  v0.0.1  working on inset sides.

// Gear geometrey is based on 10 teeth on a 20mm wheel. At this size they are not too sharp.
// and there is some leway.

use <../hub.scad>;

module gearSolid(d=20, h=10) {
    thickness = h;
    
    // Tooth radius is set by picking an dimension the yields
    // a 'reasonable' number of whole teeth at a defined radius

    // with ten teeth the tooth diameter is pi.
    toothDiameter = 3.14159;
    toothRadius = toothDiameter/2; 
    
    // Inset radius for a bit of a gap.
    toothCenterOffset = (d/2) -0.25;
    
    // The old 9 tooth settings ( 62.8308 / 9 / 2) 
    // toothDiameter = 3.49065;
    // toothRadius = toothDiameter/2; 
    
    
    // The radius is the mid point on the tooth. So the over radius is
    // Geat radius +/- the tooth radius.  
    midlineCircumfrence = d * 3.14159;
    toothCount = midlineCircumfrence / (toothDiameter * 2);
    offsetAngle  = 360 / (toothCount * 2);

    echo("Gear average diameter = ", d);
    echo("Circumfrence = ", midlineCircumfrence);
    echo("ToothCount = ", toothCount);
    echo("ToothDiameter = ", toothDiameter);
    echo("NetToothCircumfrence = ", toothCount * toothDiameter * 2);
    difference() {
        linear_extrude(thickness) {
            // Valley of each tooth is subtracted out of larger disk.
            difference() {
                circle(r=toothCenterOffset);
                union() {
                    for(i=[0:360/toothCount:360]) {
                        rotate(i) translate([toothCenterOffset,0,0]) circle(d = toothDiameter);
                    }
                }
            }
            // Top of each tooth is added to the disk. Tweaks are based on visual inspection.
            for(i=[0:360/toothCount:360]) {
                rotate(i+offsetAngle) translate([toothCenterOffset,0,0]) circle(d = toothDiameter - 0.16);
            }
        }        
    }
}

module insetGearSolid(d=20, h=10) {
    plateDiameter = 27.5;
    platThickness = 1.5;
    plateRadius = plateDiameter/2;
    difference() {
        gearSolid(d,h);
        union() {
            cylinder(r1 = plateRadius, r2 = plateRadius-1, h = platThickness);
            translate([0,0,h-platThickness])
            cylinder(r2 = plateRadius, r1 = plateRadius-1, h = platThickness);
            
            #rotate([0,0,0]) circlePegs(pegs = 6, diameter=27.0, height=10, innerDiameter = 14.7, fudge = 0.99);

        }
    }
}

// A Gear with shaft and slot.
module gearHub(d, inset = false) {
    if (inset) {
        difference() {
            insetGearSolid(d);
            #slottedShaft2();
        }    
    } else {
        difference() {
            gearSolid(d);
            slottedShaftGear();
        }
    }
}

// Other examples
/*
translate([50,0,0]) gearSolid();
translate([80,0,0]) slottedShaft();
translate([0,0,0]) color("blue") gearHub(d=60);
translate([-40,0,0]) rotate(18) color("lightBlue") gearHub(d=20);
translate([-65,0,0]) rotate(0) color("lightBlue") gearHub(d=30);
translate([-100,0,0]) rotate(0) color("lightBlue") gearHub(d=40);
translate([-145,0,0]) rotate(7.05) color("lightBlue") gearHub(d=50);
*/

translate([0,0,0]) color("blue") gearHub(d=40, inset=true);


