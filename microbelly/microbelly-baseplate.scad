/*

Copyright (c) 2017 Paul Austin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

$fn = 40;


// Units are in millimeters

// Board is just over 50 mm wide
board_width = 51.4;
pin_pitch = 1.27;

difference() {
    difference() {        
        // Base board
        translate([22, 0, -1.5])
        cube([75, 60, 2], true);
        
        // Hole for cnnector
        translate([42, 15, -1.5])
        cube([10, 20, 4], true);

    }
    
    union() {
        translate([4, 0, 0])
        cube([6, 57, 2], true);
        // Partial cylinders for pins
        translate([-.6, -board_width/2, -4])
        for (i = [0:1:39]) { 
            translate([0, ((pin_pitch / 2)+0.25) + i * pin_pitch, -2])
            cylinder(10, d=1.1);
         }
    }    
}
/*
// Connector
rotate([0, 90, 0])
translate([0, 0, 4])
rotate([0,180,0])
difference() {
    
    // 1. The box that makes up outer shell
    translate([0,0,1])
    cube([6, 56, 6], true);

    // 2. The slot and holes for wires
    {
        // The slot
        cube([1.8, board_width, 4.0], true);
        
        // Partial cylinders for pins
        translate([1.10,-board_width/2,-2])
        for (i = [0:1:39]) { 
            translate([0, ((pin_pitch / 2)+0.25) + i * pin_pitch, 0])
            cylinder(7, d=0.9);
         }
         
         // Vias for wires
        translate([1.10,-board_width/2,-1.5])
        rotate([0,90,0])
        for (i = [0:1:39]) { 
            translate([0, ((pin_pitch / 2)+0.25) + i * pin_pitch, 0])
            cylinder(7, d=0.9);
         }
     }
 }
*/