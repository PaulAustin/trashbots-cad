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

use <hub.scad>;
$fn = 60;

module pegPlateAxel(pegCount = 6, pegHeight = 2.4) {
    //translate ([0,0,10]) 
    translate([0,0,0]) cylinder(d = 28,h=2);
    translate([0,0,-2.4]) rotate([0,0,15]) circlePegs(pegs = pegCount, diameter=26.8, height=2.4);
    
    difference() {
        union() {
            translate([0,0,0]) cylinder(d=8, h=10);
            color("green") translate([0,0,8]) cylinder(r1=4, r2=5, h=1);
            color("green") translate([0,0,9]) cylinder(r1=5, r2=4, h=1);
        }
        union() {
            translate([0,0,8])cube([2,10,6], center = true);
        }
    }
}

module coreHub(splineCount = 20, coreH = 4.5, splineH = 3, splineD=5.0, d = 8.5) {
    
    // Approx spline shaft diameters
    // sg90(subMicro) - 5mm
    // micro          - 6mm
    screwFlangeThickness = 3.5;
    screwHeadDiameter = 5;
    screwShaftDiameter = 2.2;
    
    // The main shaft hub
    difference() {
        cylinder($fn = 6, d=d, h=splineH);
        cylinder(d=splineD+0.35, h=splineH);
    }

    // Splines on the inside of the hub
    color("red") linear_extrude(splineH)
    for ( rib = [0:(360/splineCount):360]) {
        // Pivot aroung origin
        rotate([0,0,rib])
        // Move out from origin
        translate([splineD/2+0.2,0,0])
        // Make corner face origin
        rotate([0,0,45])
        // Make a square
        square([0.7,0.7], center = true);
    }
    

    // Hole for the screw
    color("green") difference() {    
        translate([0,0,splineH]) cylinder($fn = 6, d=d,h=(coreH - splineH));
        {
        translate([0,0,splineH]) cylinder(d=screwShaftDiameter, h=screwFlangeThickness);
        translate([0,0,splineH+screwFlangeThickness]) cylinder(d=screwHeadDiameter,h=10);
        #translate([0,0,1.3])sphere(d=5.5);
        }
    }    
}



//rotate([180,0,0]) pegPlugHub(pegCount = 6, pegHeight = 2.5);

pegPlateAxel(pegCount = 6, pegHeight = 2.4);