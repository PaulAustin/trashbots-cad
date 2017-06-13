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

use <hub.scad>
#difference() {
    cylinder(d=30, h=15);
    cylinder(d=27, h=15);
}

difference() {
    cylinder(d=30, h=6);
    union() {
        translate([0,0,-2]) slottedShaft2();
        circlePegs(diameter=27.0, height=6, innerDiameter = 14.7, fudge = 0.99);
    }
}
/*
linear_extrude(height=15, twist = 720) {
    translate([12,0,0]) square([2,2]);
}
*/
