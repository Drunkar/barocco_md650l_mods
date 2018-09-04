use <openscad_modules/modules/RoundedRectangle.scad>

// 左は両方共内側
r_screw_inner = 2.0;
r_screw_outer = 3.0;
y_screw = -5.0;
d_base = 3.0;
x_base = 9.2;
y_base = 9;
h_foot = 8.4;
d_magnet = 2.2;
r_magnet = 3.8;
x_joint = x_base;
y_joint = d_magnet + 1.5;
RESOLUTION = 100;

PARTS_ID = 1;


module MD650L_base() {
    difference() {
        union() {
            translate([-x_base/2, -y_base, 0]) {
                RoundedRectangle(x=x_base, y=y_base, thickness=d_base, r=1, $fn=RESOLUTION);
                translate([0, y_base/2, 0])
                    cube([x_base, y_base/2, d_base]);
            }
        }
        
        translate([0, y_screw, 0])
            cylinder(r=r_screw_inner, h=d_base, $fn=RESOLUTION);
    }
    
    translate([0, 0, d_base])
        difference() {
            union() {
                translate([-x_base/2, -y_base, 0]) {
                    RoundedRectangle(x=x_base, y=y_base, thickness=1, r=1, $fn=RESOLUTION);
                    translate([0, y_base/2, 0])
                        cube([x_base, y_base/2, 1]);
                }
            }
            
            translate([0, y_screw, 0])
                cylinder(r=r_screw_outer, h=h_foot, $fn=RESOLUTION);
        }
}

MD650L_base();
if (PARTS_ID == 1) {
    translate([-x_joint/2, 0, -2]) {
        difference() {
            cube([x_joint, y_joint, h_foot+2]);
            translate([0, 0, h_foot+2-0.2])
                cube([x_base, 3.5, h_foot]);
            
            translate([x_joint/2-1.6, d_magnet+0.75, 1+r_magnet])
                rotate([90, 0, 0])
                    cylinder(r=r_magnet, h=d_magnet, $fn=RESOLUTION);
            translate([x_joint/2+1.6, d_magnet+0.75, 1+r_magnet])
                rotate([90, 0, 0])
                    cylinder(r=r_magnet, h=d_magnet, $fn=RESOLUTION);
            
            translate([x_joint/2, d_magnet+0.75, 1+r_magnet])
                rotate([90, 0, 0])
                    hull() {
                        cylinder(r=r_magnet-0.4, h=d_magnet, $fn=RESOLUTION);
                        translate([0, -10, 0])
                            cylinder(r=r_magnet-0.4, h=d_magnet, $fn=RESOLUTION);
                    }
        }
    }
}
