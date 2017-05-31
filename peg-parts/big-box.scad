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

/*
A box that can hold a control board and some motors
*/
use <hub.scad>;
use <peg-plug.scad>;

primaryUnit = 40;
wallThickness = 2.5;
wallThicknessP = 3.0;

// all units in mm
oWidth = 80;
oHeight = 40;
oDepth = 120;
 
// servo 

// plug 
plugDiameter = 27;
plugThickness = 3.5;

$fn = 40;
module sg90() {
    sg90Width = 12;
    width = 12.5;
    gearcCapThickness = 4.2;
    color("blue", 1.0 ) translate([0,0,width/2]) rotate([0,90,0]) union() {
        translate ([0,-width/2-4.5, 5]) cube([width, 31.8, 2]);
        translate ([0,-width/2,0]) cube([width,23.0, 22.8]);
        #translate([3.2, 4.2,-gearcCapThickness]) cube([6.0,3.0,4.3]);
        translate([width/2, 0.0,-gearcCapThickness]) cylinder(h=4.3, d = width);
        #translate([width/2, 7.0,-gearcCapThickness]) cylinder(h=4.3, d = 6);
    }
}

module negativePegRing (pegCount = 6, diameter = 26.8, innerDiameter = 15, height = 2.5) {
    od = diameter + 0.2;
    id = innerDiameter - 0.3;
    wedgeFuge = 0.99;
    circlePegs(pegs = pegCount, diameter=od, height=height, innerDiameter = id, fudge = wedgeFuge);
}

module mbcBoard() {
    // Place holder for circuit board
    translate([8, 18, 27]) union () { 
        color( "lime", alpha = 0.5) cube([63.5,99.5,3.7]);  
        //color("black",0.5)  
    }
}

module mbcBoardBracket() {
    translate([0,3,0]) rotate([90,0,0]) linear_extrude(height=6) {
        polygon([[0,-4],[13,9],[13,12],[0,13]]);  
    }  
//polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ...], convexity = N);
}



// Extras to turn on to help judge elements
//sg90(); 
//mbcBoard();

// main cube

intersection() {
    translate ([-20,-20,-20]) cube([400,350,500]);
    // Servo slice
    // translate ([0,5,0]) cube([60,15,50]);
    // translate ([0,5,0]) cube([80,35,50]);

difference() {
     
    // The main box is a cube with a cube removed from it
    // Need to round the edges
    union() {
        difference() {
            // The main box the every thin is removed from.    
            cube([oWidth, oDepth, oHeight]);
            
            translate([plugThickness+1, wallThickness + 0.5 , wallThickness + 0.5]) 
                cube([oWidth - (2*(plugThickness+1)), oDepth, (oHeight - 2.5)]);
        }
        color( "purple", 1.0 ) translate([25,15,wallThicknessP]) cube([30,10,13]);
        
        // Add thickness where servo goes.
        color( "purple", 1.0 ) translate([3,12,0]) cube([5,25,28]);
        color( "purple", 1.0 ) translate([oWidth-8,12,0]) cube([5,25,28]);

        // Add brackets to hold the board in place.
        translate([0,113,16]) mbcBoardBracket();
        translate([0,85,16]) mbcBoardBracket();
        translate([0,56,16]) mbcBoardBracket();
        translate([80,113,16]) rotate(180) mbcBoardBracket();
        translate([80,85,16]) rotate(180) mbcBoardBracket();
        translate([80,56,16]) rotate(180) mbcBoardBracket();
    }

union() {    

    // peg slots in bottom
    translate([20,20,0.0]) negativePegRing();
    translate([40,20,0.0]) negativePegRing();
    translate([60,20,0.0]) negativePegRing();

    translate([20,60,0.0]) negativePegRing();
    translate([40,60,0.0]) negativePegRing();
    translate([60,60,0.0]) negativePegRing();

    translate([20,100,0.0]) negativePegRing();
    translate([40,100,0.0]) negativePegRing();
    translate([60,100,0.0]) negativePegRing();

    translate([20,0,20]) rotate([90,0,0]) negativePegRing();
    translate([40,0,20]) rotate([90,0,0]) negativePegRing();
    translate([60,0,20]) rotate([90,0,0]) negativePegRing();

    #translate([0,60,20]) rotate([0,90,0]) negativePegRing();
    #translate([0,100,20]) rotate([0,90,0]) negativePegRing();
    
    #translate([80-2.5,60,20]) rotate([0,90,0]) negativePegRing();
    #translate([80-2.5,100,20]) rotate([0,90,0]) negativePegRing();


    
    #translate([7.3,20,20]) sg90();
    #translate([oWidth-7.3,20,20]) rotate([0,180,0]) sg90();

    #mbcBoard();

    // remove space for each plug
    
    // box top
    #translate([0,primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d2 = plugDiameter + 1, d1 = plugDiameter + 5,
        h = plugThickness);    

    #translate([(oWidth - plugThickness), primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d1 = plugDiameter + 1, d2 = plugDiameter + 5, 
        h = plugThickness);    

    // box bottom
   /* #translate([0,5*primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d = plugDiameter + 1, h = plugThickness);    
*/
  /*  #translate([(oWidth - plugThickness), 5*primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d = plugDiameter + 1, h = plugThickness);    
*/

}
}
}
