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

$fn = 50;

module coreHub(spineCount = 20, coreH = 4, splineH = 3, d = 7) {
    
    
    // Approx spline shaft diameters
    // sg90(subMicro) - 5mm
    // micro          - 6mm
    

    // The main shaft hub
    difference() {
        cylinder(d=d, h=splineH);
        cylinder(d=4.7, h=splineH);
    }

    // Hole for the screw
    difference() {    
        translate([0,0,splineH]) cylinder(d=d,0,h=1);
        translate([0,0,splineH]) cylinder(d=2,h=1);
    }
    
    // Splines on the inside of the hub
    color("red") linear_extrude(splineH)
    for ( rib = [0:(360/spineCount):360]) {
        // Pivot aroung origin
        rotate([0,0,rib])
        // Move out from origin
        translate([2.38,0,0])
        // Make corner face origin
        rotate([0,0,45])
        // Make a square
        square([0.43,0.43], center = true);
    }
}
#coreHub(coreH = 5);