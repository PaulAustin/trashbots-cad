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

// rotate (-step/4) translate([0,0,-baseHieght]) linear_extrude(baseHieght) circle(d=diameter);

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


circlePegsWithBase();