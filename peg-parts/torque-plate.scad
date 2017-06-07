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

$fn = 60;

use <hub.scad>;

// Use the basic peg plugs, but keep the outer diameter to 20mm ( not 27)
// if this can be brought down to 15mm then it woudl work wiht 20mm diameter gears

intersection() {
    difference() {
        union() {
            translate ([0,0,0]) rotate([0,0,0]) circlePegs(pegs = 6, diameter=26.8, height=6.5);
            // might make thickness a full 3mm, but try 2.5 first.
            translate ([0,0,2]) cylinder(d=20,h=2.5);
        }
        slottedShaft(d=8,h=7);
    }
    cylinder(d=20,h=7);
}
