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

use <tbhub-core.scad>

difference() {
    cylinder(d=26.5,h=3);
    union() {
        cylinder(d=7,h=3);
        translate([0,0,1])
        circlePegs(pegs = 6, diameter=27.0, height=2, innerDiameter = 14.7, fudge = 0.99);
    }
}

intersection() {
    cylinder(d=7.5,h=10);
    rotate([0,0,0]) coreHub(splineCount = 21, h= 5, coreH = 11, d = 9.4);
}
