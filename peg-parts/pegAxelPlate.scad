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


// v0.0.1 Initial checked in version 
// v0.0.2 Added Chamfer at base, still need to shorten the post.

use <hub.scad>;
$fn = 60;

module pegPlateAxel(pegCount = 6, pegHeight = 2.4) {
    shaftDiameter = 7.6;
    shaftRadius = shaftDiameter/2;
    plateThickness = 1.4;
    pLateDiameter = 27;
    postHeight = 10;

    translate([0,0,0]) color("orange") cylinder(r1=(pLateDiameter/2), r2 =(pLateDiameter/2)-1, h=plateThickness);
    translate([0,0,-2.4]) rotate([0,0,15]) circlePegs(pegs = pegCount, diameter=26.8, height=2.4);
    
    difference() {
        union() {
            // Primary Post
            color("red") translate([0,0,plateThickness]) cylinder(d=shaftDiameter, h=postHeight);
            // Create snap rigde
            color("green") translate([0,0,plateThickness+postHeight-2]) 
                cylinder(r1=shaftRadius, r2=shaftRadius+0.3, h=1);
            color("green") translate([0,0,plateThickness+postHeight-1]) 
                cylinder(r1=shaftRadius+0.3, r2=shaftRadius, h=1);
            // Chamfer on bottom for strength
            color("green") translate([0,0,plateThickness]) 
                cylinder(r2=shaftRadius, r1=shaftRadius+0.3, h=1);
        }
        union() {
            // Compression slot in middle. 
            translate([0,0,8])cube([2,10,8], center = true);
        }
    }
}

//rotate([180,0,0]) pegPlugHub(pegCount = 6, pegHeight = 2.5);

pegPlateAxel(pegCount = 6, pegHeight = 2.4);