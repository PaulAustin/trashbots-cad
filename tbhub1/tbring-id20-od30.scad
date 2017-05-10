 /*
Copyright (c) 2017 Paul Austin - SDG

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notic and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

use <tbhub-core.scad>

thickness = 10;
hubDiameter = 10;
toothCount = 28;
odRadius = 31;
idRadius = 20.1;

$fn=60;

toothStep = 360/toothCount;

difference() {
    linear_extrude(thickness) {
        difference() {
            circle(odRadius);
            for(i=[0:toothStep:360]) {
                rotate(i) translate([odRadius+0.2,0,0]) circle(1.75);
            }
        }
        for(i=[0:toothStep:360]) {
            rotate(i + (toothStep/2)) translate([odRadius-0.2,0,0]) circle(1.73);
        }
    }
    linear_extrude(thickness) {
     union() {
        circle(r=idRadius);
        for(i=[0:360/6:360]) {
            rotate(i) translate([odRadius-6,0,0]) circle(3.0);
        }
     }
 }
    //simpleHub(d=hubDiameter, h=thickness);
}
