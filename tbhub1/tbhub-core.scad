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

module simpleHub(splineCount = 20, h = 4.5, d = 8.5) {
    // Six sides cylinder is a short cut for extruded hexagon. Its also
    // much faster than constructing one from polygons.
    // Use the simple hub to create plug hole for a hub.
    cylinder($fn = 6, d=d, h=h);
}

module coreHub(splineCount = 20, h = 4.5, splineH = 3, splineD=5.0, d = 8.5) {
    
    // Approx spline shaft diameters
    // sg90(subMicro) - 5mm
    // micro          - 6mm
    screwFlangeThickness = 3.7;
    screwHeadDiameter = 5;
    screwShaftDiameter = 2.2;
    coreH= h;
    
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
        union() {
            translate([0,0,splineH]) cylinder(d=screwShaftDiameter, h=screwFlangeThickness);
            translate([0,0,splineH+screwFlangeThickness]) cylinder(d=screwHeadDiameter,h=5);
            translate([0,0,1.9]) cylinder(h=2.5, d1 = 7, d2 = screwShaftDiameter);
        }
    }
    
}

rotate([0,0,0]) coreHub(splineCount = 21, coreH = 10, d = 8.4);
