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

$fn=60;

use <motor-shaft-adapter.scad>

// dimensions units in mm
slatWidth = 10;
slatDepth = 10;
slatThickness = 1.9;
stickDiameter = 6;
hubDiameter = 20;
coreDiameter = 6.9;

// Strategy
// 1. Core hub + spline core
// 2. Remove slots
// 3. Remove compression slots

// Version history
//  v0.1.0 Initial print test for Reynosa trip
//  v0.1.2 Widened slot to 10.2mm, and chamfer used vars
//  v0.1.3 Peg insets are 0.15mm deeper to allow for printing
//  v0.1.4 Peg insets are 0.2mm deeper to allow for printing

// Cylinder with slot in it for optional key, and bevel
module slottedShaft(d=8, h=10) {
    slotWidth = 10.2;
    slotThickness = 2.1;
    chamfer = 1.1;
    cylinder(d=d,h=h);
    translate([0,0,h-2.1]) cylinder(r2=(d/2)+chamfer, r1=(d/2), h=2.1);
    translate([-(slotWidth/2),-(slotThickness/2),0]) cube([slotWidth,slotThickness,h]);
    translate([0,0,0]) cylinder(r1=(d/2)+chamfer, r2=(d/2), h=2.1);
}

// Consolidate this wiht one above
// Cylinder with slot in it for optional key, and bevel
module slottedShaftGear(d=8, h=10) {
    cylinder(d=d,h=h);
    translate([0,0,h-2.1]) cylinder(r2=(d/2)+1,r1=(d/2),h=2.1);
    translate([-5.05,-1.05,0]) cube([10.1,2.1,h]);
}

// Cylinder with slot in it for optional key, and bevel
module slottedShaft2(d=8, h=10) {
    platThickness = 1.5;
    bevelThicknes = 1.0;
    cylinder(d=d,h=h);
    translate([0,0,h-platThickness-bevelThicknes])
        cylinder(r2=(d/2)+1,r1=(d/2),h=bevelThicknes);
    translate([0,0,platThickness]) cylinder(r1=(d/2)+1,r2=(d/2),h=bevelThicknes);
    translate([-5.05,-1.05,0]) cube([10.1,2.1,h]);
}



// Hub
module plugHub(plugCount = 6) {
    difference() {
        color("cyan") rotate_extrude() {
            difference(){
                translate([0,0,0]) square([hubDiameter,slatWidth]);
                translate([hubDiameter+2,slatWidth/2,0]) circle(d=slatWidth-1);
            }
        }

        #union () {
            slottedShaft();
           // coreHub(h = slatWidth, splineCount = 21, splineH = 3, d = 10.5);
           // translate([0,0,-0.5]) cylinder(h = slatWidth+1, d = coreDiameter);
            for(i=[0:(360/plugCount):360]) {
                translate([0,0,0])
                rotate(i)
                translate([hubDiameter-slatDepth,0,-0.5]) rotate([90,0,0])  {
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

module circlePegs (pegs = 6, diameter = 26.8, innerDiameter = 15, height = 3, fudge = 1.04) {
    step        = 360 / pegs;

    // Additional amount keeps the plug from binding too hard when
    // pluged into a complimentary part.
    halfStep    = (step / 2) * fudge;
    radius      = (diameter / 2);
    pegHeight   = height;

    rotate (-step/4)
    linear_extrude(height=pegHeight)
    difference () {
        difference() {
            circle(d=diameter);
            circle(d=innerDiameter);
        }
        for (i = [0:step:360]) {
            // The diameter is used so the triangle is much longer than the edges need
            // but long enough to clear out the entire wedge.
            polygon([
                    [0,0],
                    [diameter * cos(i), diameter * sin(i) ],
                    [diameter * cos(i + (halfStep)), diameter * sin(i+(halfStep)) ]
                    ]);
        }
    }
}

module circlePegsWithBase(pegs = 6, diameter = 26.8, innerDiameter = 15, heigth = 6) {
    baseHieght  = heigth / 2;

    translate([0,0,-baseHieght]) linear_extrude(heigth/2) circle(d=diameter);
    circlePegs(pegs, diameter, innerDiameter, heigth/2);
}


module pegPlugHub(pegCount = 6, pegHeight = 2.5) {

    // When subtracting teh pegs, make them bit larger, and deeper.
    // TODO pull these tweak to high level settings, they may apply to to multiple pieces.
    difference() {
        rotate([0,0,-15]) plugHub(plugCount = pegCount);
        rotate([0,0,-15]) circlePegs(pegs = pegCount, diameter=27.0, height=pegHeight+0.2, innerDiameter = 14.7, fudge = 0.99);
    }

    translate ([0,0,10]) rotate([0,0,-15]) circlePegs(pegs = pegCount, diameter=26.8, height=pegHeight);
}

module insetpegPlugHub(pegCount = 6, pegHeight = 2.5) {
    difference() {
        pegPlugHub(pegCount = 6, pegHeight = 2.5);
        union() {
            offset([0,0,8]) clyinder(r1=9,r2=9,h=2);
        }
    }
}

// Rotaate 15deg to aling a set of slots along hte 45deg axis, this helps with
// default file and surface fills
//rotate([0,0,-15]) plugHub(plugCount = 6);
intersect() {
    translate([60,0,0]) rotate([0,0,-15]) pegPlugHub(plugCount = 6, pegHeight = 2.5);

    // add cube so we can get a cross section.
}
