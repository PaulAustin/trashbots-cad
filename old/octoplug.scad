$fn = 60;

step = 60;
diameter = 25.4;
radius = diameter/2;
halfStep = step/2 * 1.03;

rotate (-step/4) translate([0,0,-4]) linear_extrude(4) circle(d=25.4);

rotate (-step/4) 
linear_extrude(height=4) 
difference () {
    difference() {
        circle(d=25.4);
        circle(d=15.4);
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