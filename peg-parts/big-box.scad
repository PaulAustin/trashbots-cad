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
oCapThickness = 6;
 
// servo 

// plug 
plugDiameter = 27;
plugThickness = 3.5;

$fn = 40;

// Model of an sg90 servo. Thre is a fair amount of variance in these parts.
// so beware
module sg90() {
    width = 12.6;
    gearcCapThickness = 4.2;
    color("blue", 1.0 ) translate([0,0,width/2]) rotate([0,90,0]) union() {
        // Slab that makes tabs on the end.
        translate ([0,-width/2-4.5, 5]) cube([width, 31.8, 2]);
        // Main servo body
        translate ([0,-width/2,0]) cube([width,23.0, 22.8]);
        // Gear caps on top
        #translate([3.2, 4.2,-gearcCapThickness]) cube([6.0,3.0,4.3]);
        translate([width/2, 0.0,-gearcCapThickness]) cylinder(h=4.3, d = width);
        #translate([width/2, 7.0,-gearcCapThickness]) cylinder(h=4.3, d = 6);
    }
}

// This is a special version of the ring of wedges. When the wedges are used
// for adifference operation the dimensions are tweaked a bit so parts fit better.
module negativePegRing (pegCount = 6, diameter = 26.8, innerDiameter = 15, height = 2.5) {
    od = diameter + 0.2;
    id = innerDiameter - 0.3;
    wedgeFuge = 0.99;
    circlePegs(pegs = pegCount, diameter=od, height=height, innerDiameter = id, fudge = wedgeFuge);
}

// Simple shell that represents the microbit controller shell.
module mbcBoard() {
    // Place holder for circuit board
     translate([4.5, 14, 27]) union () { 
         color( "lime", alpha = 0.5) cube([63.5,100.0,3.7]);  
        translate ([5,90,-10])cube([10,10,10]);
        //color("black",0.5)  
    }
}

module cover() {
    // Top
    /*
    #translate([0,0,oHeight-3]) union () {
        #translate([5,oDepth-5,-2]) rotate([15,0,0]) cube([oWidth-13,2,5]);
        // ridges
        translate([4.5,oDepth-68,-3])  cube([2,64,3]);
        translate([oWidth - 6.5,oDepth-68,-2])  cube([2,64,2]);
        // main slab
        cube([oWidth, oDepth, 3]);
    }
    */
    /*
    // End plate
    #translate([0,oDepth-5,3.5])
        cube([oWidth,5, oHeight]);
    */
}

module mbcBoardBracket() {
    translate([0,3,0]) rotate([90,0,0]) linear_extrude(height=6) {
        polygon([[0,-4],[13,9],[13,12],[0,13]]);  
    }  
}

module edgeBrace() {
    translate([0,3,0]) rotate([90,0,0]) linear_extrude(height=64) {
        polygon([[0,0],[0,-7],[4,-3],[4,0],[0,0]]);  
    }  
}


// translate ([0,0,60]) color("orange",1.0) cover();

// Extras to turn on to help judge elements
//sg90(); 
translate ([0,0,50]) mbcBoard();

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
            // Add some rounding to the edge.
            minkowski() {
                translate([1.5,1.5,1.5]) cube([oWidth-3, oDepth-3, oHeight-3]);
                sphere(r=1.5);
            }
            // remove the main chunk,and trim off the top and end plate.
            union() {
                //color("orange",1.0) cover();
                // clear out core of box
                translate([plugThickness+1, wallThickness + 1.5 , wallThickness + 1.0]) 
                    cube([oWidth - (2*(plugThickness+1)), oDepth-(8), (oHeight - 2.5)]);
                
            }
        }
        

        // Add a top edge to hold in the top
        translate([0,4,oHeight- 3]) rotate ([90,0,90]) linear_extrude(height=oWidth) {polygon([[0,0],[0,-4],[3,-1],[3,0],[0,0]]);}  

        
        // Center post to support servos. Has tight clearance with battery.
        color( "purple", 1.0 ) translate([25,12,wallThicknessP]) cube([30,10,13]);
        
        // Add thickness where servo goes.
        color( "purple", 1.0 ) translate([3,12,0]) cube([5,25,28]);
        color( "purple", 1.0 ) translate([oWidth-8,12,0]) cube([5,25,28]);

        // Add brackets to hold the board in place.
        translate([0,109,16]) mbcBoardBracket();
        translate([78,109,16]) rotate(180) mbcBoardBracket();
        translate([0,88.5,16]) mbcBoardBracket();
        translate([78,88.5,16]) rotate(180) mbcBoardBracket();
        translate([0,58,16]) mbcBoardBracket();
        translate([78,58,16]) rotate(180) mbcBoardBracket();
        
        translate([80-4.5,55,oHeight-3]) rotate(180) edgeBrace();

    }

union() {    

    #color("orange",0.5) cover();

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

    // put them on the sides
    #translate([0,60,20]) rotate([0,90,0]) negativePegRing();
    #translate([0,100,20]) rotate([0,90,0]) negativePegRing();
    
    #translate([80-2.5,60,20]) rotate([0,90,0]) negativePegRing();
    #translate([80-2.5,100,20]) rotate([0,90,0]) negativePegRing();

    // put them on the end
    #translate([20,2.5,20]) rotate([90,30,0]) negativePegRing();
    #translate([40,2.5,20]) rotate([90,30,0]) negativePegRing();
    #translate([60,2.5,20]) rotate([90,30,0]) negativePegRing();

    
    #translate([7.3,20,20]) sg90();
    #translate([oWidth-7.3,20,20]) rotate([0,180,0]) sg90();

    #mbcBoard();

    // remove space for each plug
    
    // box top
    #translate([0,primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d2 = plugDiameter + 1, d1 = plugDiameter + 2,
        h = plugThickness);    

    #translate([(oWidth - plugThickness), primaryUnit/2,oHeight/2]) rotate ([0,90,0]) 
        cylinder(d1 = plugDiameter + 1, d2 = plugDiameter + 2, 
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
