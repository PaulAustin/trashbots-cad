/*
Copyright (c) 2017 Paul Austin - SDG

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


$fn=60;

use <tbhub-core.scad>

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

use <peg-plug.scad>;

module pegPlugHub(pegCount = 6, pegHeight = 2.5) {

    difference() {
        rotate([0,0,-15]) plugHub(plugCount = pegCount);
        rotate([0,0,-15]) circlePegs(pegs = pegCount, diameter=27.0, height=pegHeight, innerDiameter = 14.7, fudge = 0.99);
    }

    translate ([0,0,10]) rotate([0,0,-15]) circlePegs(pegs = pegCount, diameter=26.8, height=pegHeight);
}
// Rotaate 15deg to aling a set of slots along hte 45deg axis, this helps with 
// default file and surface fills
rotate([0,0,-15]) plugHub(plugCount = 6);
