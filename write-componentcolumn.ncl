begin
;LET'S EXTRACT VERTICAL COLUMNS (BOTTOM 10 MODEL LEVELS) FOR EACH PM1 AEROSOL COMPONENT AT IAP GRID FOR ALL TIMES
print("now extracting aerosol component vertical columns from wrfout...")
DATADir = "/mnt/rasher/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
b = addfile("component-column-ts_IAP.nc","c")
I=79
J=144
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;EFFICIENT WAY OF EXTRACTING COMPONENTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
oc1 = a[:]->oc_a01(:,0:9,J,I)
oc2 = a[:]->oc_a02(:,0:9,J,I)
oc3 = a[:]->oc_a03(:,0:9,J,I)
oc4 = a[:]->oc_a04(:,0:9,J,I)
oc5 = 0.60 * a[:]->oc_a05(:,0:9,J,I)
oc = oc1+oc2+oc3+oc4+oc5
oc!0 = "time"
oc!1 = "vert_lev"
print("oc extracted")
bc1 = a[:]->bc_a01(:,0:9,J,I)
bc2 = a[:]->bc_a02(:,0:9,J,I)
bc3 = a[:]->bc_a03(:,0:9,J,I)
bc4 = a[:]->bc_a04(:,0:9,J,I)
bc5 = 0.60 * a[:]->bc_a05(:,0:9,J,I)
bc = bc1+bc2+bc3+bc4+bc5
bc!0 = "time"
bc!1 = "vert_lev"
print("bc extracted")
no31 = a[:]->no3_a01(:,0:9,J,I)
no32 = a[:]->no3_a02(:,0:9,J,I)
no33 = a[:]->no3_a03(:,0:9,J,I)
no34 = a[:]->no3_a04(:,0:9,J,I)
no35 = 0.60 * a[:]->no3_a05(:,0:9,J,I)
no3 = no31+no32+no33+no34+no35
no3!0 = "time"
no3!1 = "vert_lev"
print("no3 extracted")
so41 = a[:]->so4_a01(:,0:9,J,I)
so42 = a[:]->so4_a02(:,0:9,J,I)
so43 = a[:]->so4_a03(:,0:9,J,I)
so44 = a[:]->so4_a04(:,0:9,J,I)
so45 = 0.60 * a[:]->so4_a05(:,0:9,J,I)
so4 = so41+so42+so43+so44+so45
so4!0 = "time"
so4!1 = "vert_lev"
print("so4 extracted")
nh41 = a[:]->nh4_a01(:,0:9,J,I)
nh42 = a[:]->nh4_a02(:,0:9,J,I)
nh43 = a[:]->nh4_a03(:,0:9,J,I)
nh44 = a[:]->nh4_a04(:,0:9,J,I)
nh45 = 0.60 * a[:]->nh4_a05(:,0:9,J,I)
nh4 = nh41+nh42+nh43+nh44+nh45
nh4!0 = "time"
nh4!1 = "vert_lev"
print("nh4 extracted")

b->oc = oc
b->bc = bc
b->no3 = no3
b->so4 = so4
b->nh4 = nh4
print("success!")
end
