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

module gearSolid(d=20, h=10) {
    thickness = h;
    
    // Tooth radius is set by picking an dimension the yields
    // a 'reasonable' number of whole teeth at a defined radius
    toothRadius = 1.7453; 
    
    // The radius is the mid point on the tooth. So the over radius is
    // Geat radius +/- the tooth radius.  
    q = d/20;
    toothCount = 9 * q;
    offsetAngle  = 360 / toothCount * (toothRadius * 2);

    echo("Gear average radius = ", r);
    echo("Circumfrence = ", d * 3.14159);
    echo("ToothCount = ", toothCount);
    echo("ToothDiameter = ", toothRadius * 2);
    echo("NetToothCircumfrence = ", toothCount * toothRadius * 4);
    difference() {
        linear_extrude(thickness) {
            difference() {
                circle(d=d);
                for(i=[0:360/toothCount:360]) {
                    rotate(i) translate([(d/2) + 0.2,0,0]) circle(r = toothRadius);
                }
            }
            for(i=[0:360/toothCount:360]) {
                rotate(i+offsetAngle) translate([(d/2)-0.2,0,0]) circle(r = toothRadius);
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

// GearSolid(r=10);
gearHub(d=20);

// Other examples
translate([50,0,0]) gearSolid();
translate([80,0,0]) slottedShaft();
translate([0,40,0]) gearHub(d=60);

