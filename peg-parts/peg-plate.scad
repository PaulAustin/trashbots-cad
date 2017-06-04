

plateWidth = 80;
plateWidth = 80;
plateThickness = 80;
use <hub.scad>;
use <peg-plug.scad>;

module negativePegRing (pegCount = 6, diameter = 26.8, innerDiameter = 15, height = 2.5) {
    od = diameter + 0.2;
    id = innerDiameter - 0.3;
    wedgeFuge = 0.99;
    circlePegs(pegs = pegCount, diameter=od, height=height, innerDiameter = id, fudge = wedgeFuge);
}
       
difference() {
    cube([plateWidth, 40.0, 3.0]);
    translate([20,20,0.5]) negativePegRing();
    // slight rotate to align dufference due to wedgeFuge. Make it look symetrical.
    translate([40,20,0.5]) negativePegRing();
    translate([60,20,0.5]) negativePegRing();
}
