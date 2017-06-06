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

// Gear geometrey is based on 10 teeth on a 20mm wheel. At this size they are not too sharp.
// and there is some leway.


module gearSolid(d=20, h=10) {
    thickness = h;
    
    // Tooth radius is set by picking an dimension the yields
    // a 'reasonable' number of whole teeth at a defined radius

    // with ten teeth the tooth diameter is pi.
    toothDiameter = 3.14159;
    toothRadius = toothDiameter/2; 
    
    
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
                circle(d=d);
                for(i=[0:360/toothCount:360]) {
                    rotate(i) translate([(d/2) - 0.06,0,0]) circle(d = toothDiameter);
                }
            }
            // Top of each tooth is added to the disk. Tweaks are based on visual inspection.
            for(i=[0:360/toothCount:360]) {
                rotate(i+offsetAngle) translate([(d/2) - 0.06,0,0]) circle(d = toothDiameter - 0.06);
            }
        }        
    }
}

// Cylinder with slot in it for optional key, and bevel
module slottedShaft(d=8, h=10) {
    cylinder(d=d,h=h);
    translate([0,0,h-2.1])cylinder(r2=(d/2)+1,r1=(d/2),h=2.1);
    translate([-5.05,-1.05,0]) cube([10.1,2.1,h]);
}

// A Gear with shaft and slot.
module gearHub(d) {
    difference() {
        gearSolid(d);
        slottedShaft();
    }
}

// Other examples
translate([50,0,0]) gearSolid();
translate([80,0,0]) slottedShaft();
translate([0,0,0]) color("blue") gearHub(d=60);
translate([-40,0,0]) rotate(18) color("lightBlue") gearHub(d=20);
translate([-65,0,0]) rotate(0) color("lightBlue") gearHub(d=30);
translate([-100,0,0]) rotate(0) color("lightBlue") gearHub(d=40);
translate([-145,0,0]) rotate(7.05) color("lightBlue") gearHub(d=50);


