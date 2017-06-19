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
            coreHub(coreH = slatWidth, splineCount = 21, splineH = 3, d = 10);
            translate([0,0,-0.5]) cylinder(h = slatWidth+1, d = coreDiameter);
            for(i=[0:(360/plugCount):360]) {
                translate([0,0,0])
                rotate(i)
                translate([hubDiameter-slatDepth,0,-0.5]) rotate([90,0,0])  {
                    rotate([90,0,0]){
                    // Slot for a popsicle stick
                    translate([0, -slatWidth/2, -(slatWidth/2+1.5)])   
                    linear_extrude(slatThickness) square([slatDepth,slatWidth]);
                    }
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

// Rotaate 15deg to aling a set of slots along hte 45deg axis, this helps with 
// default file and surface fills
rotate([0,0,-15]) plugHub(plugCount = 6);
