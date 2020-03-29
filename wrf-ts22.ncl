;TIME-SERIES FOR IAP POLLUTANT DATA FOR CONTROL RUN: 15OCT - 12NOV

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
print("Initializing arrays...")
;INITIALIZING OBS ARRAYS TO HOLD VALUES FROM 15OCT0000HRS TO 13NOV0000HRS MINUS 16OCT0000HRS
org = new(696,float)
so4 = new(696,float)
no3 = new(696,float)
nh4 = new(696,float)
chl = new(696,float)
bc  = new(696,float)
co  = new(696,float)
no  = new(696,float)
no2 = new(696,float)
o3  = new(696,float)
so2 = new(696,float)

org_260 = new(696,float)
so4_260 = new(696,float)
no3_260 = new(696,float)
nh4_260 = new(696,float)
chl_260 = new(696,float)

;INITIALIZING SIM ARRAYS FOR BEST-GUESS AND WHAT-IF RUNS WITH PROPER LENGTH 
so4_sim_subset_b = new(696,float)
no3_sim_subset_b = new(696,float)
nh4_sim_subset_b = new(696,float)
chl_sim_subset_b = new(696,float)
oc_sim_subset_b  = new(696,float)
bc_sim_subset_b  = new(696,float)
co_sim_subset_b  = new(696,float)
no2_sim_subset_b = new(696,float)
so2_sim_subset_b = new(696,float)
o3_sim_subset_b  = new(696,float)

so4_sim_260_subset_b = new(696,float)  
no3_sim_260_subset_b = new(696,float)
nh4_sim_260_subset_b = new(696,float)
chl_sim_260_subset_b = new(696,float)
oc_sim_260_subset_b  = new(696,float)


so4_sim_subset_c = new(696,float)
no3_sim_subset_c = new(696,float)
nh4_sim_subset_c = new(696,float)
chl_sim_subset_c = new(696,float)
oc_sim_subset_c  = new(696,float)
bc_sim_subset_c  = new(696,float)
co_sim_subset_c  = new(696,float)
no2_sim_subset_c = new(696,float)
so2_sim_subset_c = new(696,float)
o3_sim_subset_c  = new(696,float)

so4_sim_260_subset_c = new(696,float)
no3_sim_260_subset_c = new(696,float)
nh4_sim_260_subset_c = new(696,float)
chl_sim_260_subset_c = new(696,float)
oc_sim_260_subset_c  = new(696,float)

;so4_sim_subset_d = new(696,float)
;no3_sim_subset_d = new(696,float)
;nh4_sim_subset_d = new(696,float)
;so4_sim_260_subset_d = new(696,float)
;no3_sim_260_subset_d = new(696,float)
;nh4_sim_260_subset_d = new(696,float)


print("reading wrf directories...")
DATADir1 = "/data2/tabish/control-run-so4-ECMWF/"
DATADir2 = "/data2/tabish/best-guess_run/"
DATADir3 = "/data2/tabish/what-if_run/"
;DATADir4 = "/data2/tabish/NH3-sensitivity_run/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
FILES3 = systemfunc (" ls -1 " + DATADir3 + "wrfout_d03_2014-* ")
;FILES4 = systemfunc (" ls -1 " + DATADir4 + "wrfout_d03_2014-* ")
a = addfiles(FILES1,"r")
b = addfiles(FILES2,"r")
c = addfiles(FILES3,"r")
;d = addfiles(FILES4,"r")
print("all wrf files loaded.")
times  = wrf_times_c(a[:]->Times,0)
;print(times)
;times_crop = times(16:135)
I=79
J=144
so4_sim   = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) +a[:]->so4_a03(:,0,J,I) +a[:]->so4_a04(:,0,J,I) +a[:]->so4_a05(:,0,J,I) +a[:]->so4_a06(:,0,J,I)  
no3_sim   = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) +a[:]->no3_a03(:,0,J,I) +a[:]->no3_a04(:,0,J,I) +a[:]->no3_a05(:,0,J,I) +a[:]->no3_a06(:,0,J,I)  
nh4_sim   = a[:]->nh4_a01(:,0,J,I) + a[:]->nh4_a02(:,0,J,I) +a[:]->nh4_a03(:,0,J,I) +a[:]->nh4_a04(:,0,J,I) +a[:]->nh4_a05(:,0,J,I) +a[:]->nh4_a06(:,0,J,I)  
chl_sim   = a[:]->cl_a01(:,0,J,I)  + a[:]->cl_a02(:,0,J,I)  +a[:]->cl_a03(:,0,J,I)  +a[:]->cl_a04(:,0,J,I)  +a[:]->cl_a05(:,0,J,I)  +a[:]->cl_a06(:,0,J,I)   
oc_sim    = a[:]->oc_a01(:,0,J,I) + a[:]->oc_a02(:,0,J,I) +a[:]->oc_a03(:,0,J,I) +a[:]->oc_a04(:,0,J,I) +a[:]->oc_a05(:,0,J,I) +a[:]->oc_a06(:,0,J,I)  
bc_sim    = a[:]->bc_a01(:,0,J,I) + a[:]->bc_a02(:,0,J,I) +a[:]->bc_a03(:,0,J,I) +a[:]->bc_a04(:,0,J,I) +a[:]->bc_a05(:,0,J,I) +a[:]->bc_a06(:,0,J,I)  
co_sim    = a[:]->co(:,0,J,I)
no2_sim   = a[:]->no2(:,0,J,I)
so2_sim   = a[:]->so2(:,0,J,I)
o3_sim    = a[:]->o3(:,0,J,I)

so4_sim_260   = a[:]->so4_a01(:,3,J,I) + a[:]->so4_a02(:,3,J,I) +a[:]->so4_a03(:,3,J,I) +a[:]->so4_a04(:,3,J,I) +a[:]->so4_a05(:,3,J,I) +a[:]->so4_a06(:,3,J,I)
no3_sim_260   = a[:]->no3_a01(:,3,J,I) + a[:]->no3_a02(:,3,J,I) +a[:]->no3_a03(:,3,J,I) +a[:]->no3_a04(:,3,J,I) +a[:]->no3_a05(:,3,J,I) +a[:]->no3_a06(:,3,J,I)
nh4_sim_260   = a[:]->nh4_a01(:,3,J,I) + a[:]->nh4_a02(:,3,J,I) +a[:]->nh4_a03(:,3,J,I) +a[:]->nh4_a04(:,3,J,I) +a[:]->nh4_a05(:,3,J,I) +a[:]->nh4_a06(:,3,J,I)
chl_sim_260   = a[:]->cl_a01(:,3,J,I)  + a[:]->cl_a02(:,3,J,I)  +a[:]->cl_a03(:,3,J,I)  +a[:]->cl_a04(:,3,J,I)  +a[:]->cl_a05(:,3,J,I)  +a[:]->cl_a06(:,3,J,I)
oc_sim_260    = a[:]->oc_a01(:,3,J,I) + a[:]->oc_a02(:,3,J,I) +a[:]->oc_a03(:,3,J,I) +a[:]->oc_a04(:,3,J,I) +a[:]->oc_a05(:,3,J,I) +a[:]->oc_a06(:,3,J,I)
print("Arrays assigned for a")

so4_sim_b   = b[:]->so4_a01(:,0,J,I) + b[:]->so4_a02(:,0,J,I) +b[:]->so4_a03(:,0,J,I) +b[:]->so4_a04(:,0,J,I) +b[:]->so4_a05(:,0,J,I) +b[:]->so4_a06(:,0,J,I)
no3_sim_b   = b[:]->no3_a01(:,0,J,I) + b[:]->no3_a02(:,0,J,I) +b[:]->no3_a03(:,0,J,I) +b[:]->no3_a04(:,0,J,I) +b[:]->no3_a05(:,0,J,I) +b[:]->no3_a06(:,0,J,I)
nh4_sim_b   = b[:]->nh4_a01(:,0,J,I) + b[:]->nh4_a02(:,0,J,I) +b[:]->nh4_a03(:,0,J,I) +b[:]->nh4_a04(:,0,J,I) +b[:]->nh4_a05(:,0,J,I) +b[:]->nh4_a06(:,0,J,I)
chl_sim_b   = b[:]->cl_a01(:,0,J,I)  + b[:]->cl_a02(:,0,J,I)  +b[:]->cl_a03(:,0,J,I)  +b[:]->cl_a04(:,0,J,I)  +b[:]->cl_a05(:,0,J,I)  +b[:]->cl_a06(:,0,J,I)
oc_sim_b    = b[:]->oc_a01(:,0,J,I)  + b[:]->oc_a02(:,0,J,I)  +b[:]->oc_a03(:,0,J,I)  +b[:]->oc_a04(:,0,J,I)  +b[:]->oc_a05(:,0,J,I)  +b[:]->oc_a06(:,0,J,I)
bc_sim_b    = b[:]->bc_a01(:,0,J,I)  + b[:]->bc_a02(:,0,J,I)  +b[:]->bc_a03(:,0,J,I)  +b[:]->bc_a04(:,0,J,I)  +b[:]->bc_a05(:,0,J,I)  +b[:]->bc_a06(:,0,J,I)
co_sim_b    = b[:]->co(:,0,J,I)
no2_sim_b   = b[:]->no2(:,0,J,I)
so2_sim_b   = b[:]->so2(:,0,J,I)
o3_sim_b    = b[:]->o3(:,0,J,I)

so4_sim_260_b   = b[:]->so4_a01(:,3,J,I) + b[:]->so4_a02(:,3,J,I) +b[:]->so4_a03(:,3,J,I) +b[:]->so4_a04(:,3,J,I) +b[:]->so4_a05(:,3,J,I) +b[:]->so4_a06(:,3,J,I)
no3_sim_260_b   = b[:]->no3_a01(:,3,J,I) + b[:]->no3_a02(:,3,J,I) +b[:]->no3_a03(:,3,J,I) +b[:]->no3_a04(:,3,J,I) +b[:]->no3_a05(:,3,J,I) +b[:]->no3_a06(:,3,J,I)
nh4_sim_260_b   = b[:]->nh4_a01(:,3,J,I) + b[:]->nh4_a02(:,3,J,I) +b[:]->nh4_a03(:,3,J,I) +b[:]->nh4_a04(:,3,J,I) +b[:]->nh4_a05(:,3,J,I) +b[:]->nh4_a06(:,3,J,I)
chl_sim_260_b   = b[:]->cl_a01(:,3,J,I)  + b[:]->cl_a02(:,3,J,I)  +b[:]->cl_a03(:,3,J,I)  +b[:]->cl_a04(:,3,J,I)  +b[:]->cl_a05(:,3,J,I)  +b[:]->cl_a06(:,3,J,I)
oc_sim_260_b    = b[:]->oc_a01(:,3,J,I)  + b[:]->oc_a02(:,3,J,I)  +b[:]->oc_a03(:,3,J,I)  +b[:]->oc_a04(:,3,J,I)  +b[:]->oc_a05(:,3,J,I)  +b[:]->oc_a06(:,3,J,I)

print("Arrays assigned for b")

so4_sim_c   = c[:]->so4_a01(:,0,J,I) + c[:]->so4_a02(:,0,J,I) +c[:]->so4_a03(:,0,J,I) +c[:]->so4_a04(:,0,J,I) +c[:]->so4_a05(:,0,J,I) +c[:]->so4_a06(:,0,J,I)
no3_sim_c   = c[:]->no3_a01(:,0,J,I) + c[:]->no3_a02(:,0,J,I) +c[:]->no3_a03(:,0,J,I) +c[:]->no3_a04(:,0,J,I) +c[:]->no3_a05(:,0,J,I) +c[:]->no3_a06(:,0,J,I)
nh4_sim_c   = c[:]->nh4_a01(:,0,J,I) + c[:]->nh4_a02(:,0,J,I) +c[:]->nh4_a03(:,0,J,I) +c[:]->nh4_a04(:,0,J,I) +c[:]->nh4_a05(:,0,J,I) +c[:]->nh4_a06(:,0,J,I)
chl_sim_c   = c[:]->cl_a01(:,0,J,I)  + c[:]->cl_a02(:,0,J,I)  +c[:]->cl_a03(:,0,J,I)  +c[:]->cl_a04(:,0,J,I)  +c[:]->cl_a05(:,0,J,I)  +c[:]->cl_a06(:,0,J,I)
oc_sim_c    = c[:]->oc_a01(:,0,J,I)  + c[:]->oc_a02(:,0,J,I)  +c[:]->oc_a03(:,0,J,I)  +c[:]->oc_a04(:,0,J,I)  +c[:]->oc_a05(:,0,J,I)  +c[:]->oc_a06(:,0,J,I)
bc_sim_c    = c[:]->bc_a01(:,0,J,I)  + c[:]->bc_a02(:,0,J,I)  +c[:]->bc_a03(:,0,J,I)  +c[:]->bc_a04(:,0,J,I)  +c[:]->bc_a05(:,0,J,I)  +c[:]->bc_a06(:,0,J,I)
co_sim_c    = c[:]->co(:,0,J,I)
no2_sim_c   = c[:]->no2(:,0,J,I)
so2_sim_c   = c[:]->so2(:,0,J,I)
o3_sim_c    = c[:]->o3(:,0,J,I)

so4_sim_260_c   = c[:]->so4_a01(:,3,J,I) + c[:]->so4_a02(:,3,J,I) +c[:]->so4_a03(:,3,J,I) +c[:]->so4_a04(:,3,J,I) +c[:]->so4_a05(:,3,J,I) +c[:]->so4_a06(:,3,J,I)
no3_sim_260_c   = c[:]->no3_a01(:,3,J,I) + c[:]->no3_a02(:,3,J,I) +c[:]->no3_a03(:,3,J,I) +c[:]->no3_a04(:,3,J,I) +c[:]->no3_a05(:,3,J,I) +c[:]->no3_a06(:,3,J,I)
nh4_sim_260_c   = c[:]->nh4_a01(:,3,J,I) + c[:]->nh4_a02(:,3,J,I) +c[:]->nh4_a03(:,3,J,I) +c[:]->nh4_a04(:,3,J,I) +c[:]->nh4_a05(:,3,J,I) +c[:]->nh4_a06(:,3,J,I)
chl_sim_260_c   = c[:]->cl_a01(:,3,J,I)  + c[:]->cl_a02(:,3,J,I)  +c[:]->cl_a03(:,3,J,I)  +c[:]->cl_a04(:,3,J,I)  +c[:]->cl_a05(:,3,J,I)  +c[:]->cl_a06(:,3,J,I)
oc_sim_260_c    = c[:]->oc_a01(:,3,J,I)  + c[:]->oc_a02(:,3,J,I)  +c[:]->oc_a03(:,3,J,I)  +c[:]->oc_a04(:,3,J,I)  +c[:]->oc_a05(:,3,J,I)  +c[:]->oc_a06(:,3,J,I)

print("Arrays assigned for c")
;so4_sim_d   = d[:]->so4_a01(:,0,J,I) + d[:]->so4_a02(:,0,J,I) +d[:]->so4_a03(:,0,J,I) +d[:]->so4_a04(:,0,J,I) +d[:]->so4_a05(:,0,J,I) +d[:]->so4_a06(:,0,J,I)
;no3_sim_d   = d[:]->no3_a01(:,0,J,I) + d[:]->no3_a02(:,0,J,I) +d[:]->no3_a03(:,0,J,I) +d[:]->no3_a04(:,0,J,I) +d[:]->no3_a05(:,0,J,I) +d[:]->no3_a06(:,0,J,I)
;nh4_sim_d   = d[:]->nh4_a01(:,0,J,I) + d[:]->nh4_a02(:,0,J,I) +d[:]->nh4_a03(:,0,J,I) +d[:]->nh4_a04(:,0,J,I) +d[:]->nh4_a05(:,0,J,I) +d[:]->nh4_a06(:,0,J,I)

;so4_sim_260_d   = d[:]->so4_a01(:,3,J,I) + d[:]->so4_a02(:,3,J,I) +d[:]->so4_a03(:,3,J,I) +d[:]->so4_a04(:,3,J,I) +d[:]->so4_a05(:,3,J,I) +d[:]->so4_a06(:,3,J,I)
;no3_sim_260_d   = d[:]->no3_a01(:,3,J,I) + d[:]->no3_a02(:,3,J,I) +d[:]->no3_a03(:,3,J,I) +d[:]->no3_a04(:,3,J,I) +d[:]->no3_a05(:,3,J,I) +d[:]->no3_a06(:,3,J,I)
;nh4_sim_260_d   = d[:]->nh4_a01(:,3,J,I) + d[:]->nh4_a02(:,3,J,I) +d[:]->nh4_a03(:,3,J,I) +d[:]->nh4_a04(:,3,J,I) +d[:]->nh4_a05(:,3,J,I) +d[:]->nh4_a06(:,3,J,I)

print("Stored relevant pollutant arrays.")

p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)

;APPLYING COMPONENT-CORRECTIONS TO MATCH WITH OBSERVATIONS
;bc_sim = 0.4 * bc_sim
;no3_sim = 0.4 * no3_sim
;so4_sim = 3 * so4_sim


;co_sim  = 1000* co_sim
no2_sim  = 1000* no2_sim
so2_sim  = 1000* so2_sim
o3_sim   = 1000* o3_sim

;co_sim_b   = 1000* co_sim_b
no2_sim_b  = 1000* no2_sim_b
so2_sim_b  = 1000* so2_sim_b
o3_sim_b   = 1000* o3_sim_b

;co_sim_c   = 1000* co_sim_c
no2_sim_c  = 1000* no2_sim_c
so2_sim_c  = 1000* so2_sim_c
o3_sim_c   = 1000* o3_sim_c

pblh = a[:]->PBLH(:,J,I)
pblh_subset = pblh(112:807)
times = times + 8
times_subset = times(112:807)
printVarSummary(times_subset)

timearr = ispan (1,696,1)
timearr@units = "hours since 2014-10-15 00:00:00"


so4_sim_subset = so4_sim(112:807)
no3_sim_subset = no3_sim(112:807)
nh4_sim_subset = nh4_sim(112:807)
chl_sim_subset = chl_sim(112:807)
oc_sim_subset = oc_sim(112:807)
bc_sim_subset = bc_sim(112:807)
co_sim_subset = co_sim(112:807)
no2_sim_subset = no2_sim(112:807)
so2_sim_subset = so2_sim(112:807)
o3_sim_subset = o3_sim(112:807)

so4_sim_260_subset = so4_sim_260(112:807)
no3_sim_260_subset = no3_sim_260(112:807)
nh4_sim_260_subset = nh4_sim_260(112:807)
chl_sim_260_subset = chl_sim_260(112:807)
oc_sim_260_subset = oc_sim_260(112:807)


so4_sim_subset_b(440:695) = so4_sim_b(0:255)
no3_sim_subset_b(440:695) = no3_sim_b(0:255)
nh4_sim_subset_b(440:695) = nh4_sim_b(0:255)
chl_sim_subset_b(440:695) = chl_sim_b(0:255)
oc_sim_subset_b(440:695) = oc_sim_b(0:255)
bc_sim_subset_b(440:695) = bc_sim_b(0:255)
co_sim_subset_b(440:695) = co_sim_b(0:255)
no2_sim_subset_b(440:695) = no2_sim_b(0:255)
so2_sim_subset_b(440:695) = so2_sim_b(0:255)
o3_sim_subset_b(440:695) = o3_sim_b(0:255)

so4_sim_260_subset_b(440:695) = so4_sim_260_b(0:255)
no3_sim_260_subset_b(440:695) = no3_sim_260_b(0:255)
nh4_sim_260_subset_b(440:695) = nh4_sim_260_b(0:255)
chl_sim_260_subset_b(440:695) = chl_sim_260_b(0:255)
oc_sim_260_subset_b(440:695) = oc_sim_260_b(0:255)


print(dimsizes(so4_sim_c))
so4_sim_subset_c(56:319) = so4_sim_c
no3_sim_subset_c(56:319) = no3_sim_c
nh4_sim_subset_c(56:319) = nh4_sim_c
chl_sim_subset_c(56:319) = chl_sim_c
oc_sim_subset_c(56:319)  = oc_sim_c
bc_sim_subset_c(56:319)  = bc_sim_c
co_sim_subset_c(56:319)  = co_sim_c
no2_sim_subset_c(56:319) = no2_sim_c
so2_sim_subset_c(56:319) = so2_sim_c
o3_sim_subset_c(56:319)  = o3_sim_c

so4_sim_260_subset_c(56:319) = so4_sim_260_c
no3_sim_260_subset_c(56:319) = no3_sim_260_c
nh4_sim_260_subset_c(56:319) = nh4_sim_260_c
chl_sim_260_subset_c(56:319) = chl_sim_260_c
oc_sim_260_subset_c(56:319) = oc_sim_260_c

;so4_sim_subset_d(128:271) = so4_sim_d
;no3_sim_subset_d(128:271) = no3_sim_d
;nh4_sim_subset_d(128:271) = nh4_sim_d
;so4_sim_260_subset_d(128:271) = so4_sim_260_d
;no3_sim_260_subset_d(128:271) = no3_sim_260_d
;nh4_sim_260_subset_d(128:271) = nh4_sim_260_d
print("Subsetted the arrays for IAP obs times.")

d = ((p+pb)/(287.058*t2))
d_subset = d(111:806)
print("computed the density array")
print("Multiplying corresponding elements of pollutant arrays and density array in a loop")
do i = 0, 695
 so4_sim_subset(i) = so4_sim_subset(i) * d_subset(i)
 no3_sim_subset(i) = no3_sim_subset(i) * d_subset(i)
 nh4_sim_subset(i) = nh4_sim_subset(i) * d_subset(i)
 chl_sim_subset(i) = chl_sim_subset(i) * d_subset(i)
 oc_sim_subset(i)  = oc_sim_subset(i) * d_subset(i)
 bc_sim_subset(i)  = bc_sim_subset(i) * d_subset(i)
 co_sim_subset(i)  = co_sim_subset(i) * d_subset(i)
 no2_sim_subset(i) = no2_sim_subset(i) * d_subset(i)
 so2_sim_subset(i) = so2_sim_subset(i) * d_subset(i)
 o3_sim_subset(i)  = o3_sim_subset(i) * d_subset(i)

 so4_sim_subset_b(i) = so4_sim_subset_b(i) * d_subset(i)
 no3_sim_subset_b(i) = no3_sim_subset_b(i) * d_subset(i)
 nh4_sim_subset_b(i) = nh4_sim_subset_b(i) * d_subset(i)
 chl_sim_subset_b(i) = chl_sim_subset_b(i) * d_subset(i)
 oc_sim_subset_b(i)  = oc_sim_subset_b(i) * d_subset(i)
 bc_sim_subset_b(i)  = bc_sim_subset_b(i) * d_subset(i)
 co_sim_subset_b(i)  = co_sim_subset_b(i) * d_subset(i)
 no2_sim_subset_b(i) = no2_sim_subset_b(i) * d_subset(i)
 so2_sim_subset_b(i) = so2_sim_subset_b(i) * d_subset(i)
 o3_sim_subset_b(i)  = o3_sim_subset_b(i) * d_subset(i)

 so4_sim_subset_c(i) = so4_sim_subset_c(i) * d_subset(i)
 no3_sim_subset_c(i) = no3_sim_subset_c(i) * d_subset(i)
 nh4_sim_subset_c(i) = nh4_sim_subset_c(i) * d_subset(i)
 chl_sim_subset_c(i) = chl_sim_subset_c(i) * d_subset(i)
 oc_sim_subset_c(i)  = oc_sim_subset_c(i) * d_subset(i)
 bc_sim_subset_c(i)  = bc_sim_subset_c(i) * d_subset(i)
 co_sim_subset_c(i)  = co_sim_subset_c(i) * d_subset(i)
 no2_sim_subset_c(i) = no2_sim_subset_c(i) * d_subset(i)
 so2_sim_subset_c(i) = so2_sim_subset_c(i) * d_subset(i)
 o3_sim_subset_c(i)  = o3_sim_subset_c(i) * d_subset(i)

; so4_sim_subset_d(i) = so4_sim_subset_d(i) * d_subset(i)
; no3_sim_subset_d(i) = no3_sim_subset_d(i) * d_subset(i)
; nh4_sim_subset_d(i) = nh4_sim_subset_d(i) * d_subset(i)


end do

so4_sim_260_subset = 1.15 * so4_sim_260_subset 
no3_sim_260_subset = 1.15 * no3_sim_260_subset
nh4_sim_260_subset = 1.15 * nh4_sim_260_subset
chl_sim_260_subset = 1.15 * chl_sim_260_subset
oc_sim_260_subset  = 1.15 * oc_sim_260_subset


so4_sim_260_subset_b = 1.15 * so4_sim_260_subset_b
no3_sim_260_subset_b = 1.15 * no3_sim_260_subset_b
nh4_sim_260_subset_b = 1.15 * nh4_sim_260_subset_b
chl_sim_260_subset_b = 1.15 * chl_sim_260_subset_b
oc_sim_260_subset_b  = 1.15 * oc_sim_260_subset_b

so4_sim_260_subset_c = 1.15 * so4_sim_260_subset_c
no3_sim_260_subset_c = 1.15 * no3_sim_260_subset_c
nh4_sim_260_subset_c = 1.15 * nh4_sim_260_subset_c
chl_sim_260_subset_c = 1.15 * chl_sim_260_subset_c
oc_sim_260_subset_c  = 1.15 * oc_sim_260_subset_c

;so4_sim_260_subset_d = 1.15 * so4_sim_260_subset_d
;no3_sim_260_subset_d = 1.15 * no3_sim_260_subset_d
;nh4_sim_260_subset_d = 1.15 * nh4_sim_260_subset_d
print("All sim arrays prepared now")

;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   filename = "/data1/tabish/surface_data/IAPdata-pollutant.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_useful = str_match(lines, ":00"); SEARCH FOR 00HRS OBSERVATIONS
  str = "," + lines_useful@_FillValue + ","
  lines_useful = str_sub_str(lines_useful,",,",str); REPLACE BLANK SPACES WITH MISSING VALUES

  delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
  delim = "," ; delimiter
  print(lines_useful)
  datetime         = str_get_field(lines_useful,2,delim)
;  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;  print ("Time="+datetime)

print(dimsizes(lines_useful))

; READ IN AEROSOL SPECIES AT GROUND SITE
  org_full         = tofloat(str_get_field(lines_useful,3,delim))
  org(0:31)        = org_full(0:31)
  org(32:695)      = org_full(33:696)
  so4_full         = tofloat(str_get_field(lines_useful,4,delim))
  so4(0:31)        = so4_full(0:31)
  so4(32:695)      = so4_full(33:696)
  no3_full         = tofloat(str_get_field(lines_useful,5,delim))
  no3(0:31)        = no3_full(0:31)
  no3(32:695)      = no3_full(33:696)
  nh4_full         = tofloat(str_get_field(lines_useful,6,delim))
  nh4(0:31)        = nh4_full(0:31)
  nh4(32:695)      = nh4_full(33:696)
  chl_full         = tofloat(str_get_field(lines_useful,7,delim))
  chl(0:31)        = chl_full(0:31)
  chl(32:695)      = chl_full(33:696)
  bc_full          = tofloat(str_get_field(lines_useful,8,delim))
  bc(0:31)         = bc_full(0:31)
  bc(32:695)       = bc_full(33:696)

; READ IN GASEOUS SPECIES AT GROUND SITE
  co_full         = tofloat(str_get_field(lines_useful,15,delim))
  co(0:31)        = co_full(0:31)
  co(32:695)      = co_full(33:696)
  no_full         = tofloat(str_get_field(lines_useful,16,delim))
  no(0:31)        = no_full(0:31)
  no(32:695)      = no_full(33:696)
  no2_full        = tofloat(str_get_field(lines_useful,17,delim))
  no2(0:31)       = no2_full(0:31)
  no2(32:695)     = no2_full(33:696)
  o3_full         = tofloat(str_get_field(lines_useful,19,delim))
  o3(0:31)        = o3_full(0:31)
  o3(32:695)      = o3_full(33:696)
  so2_full        = tofloat(str_get_field(lines_useful,20,delim))
  so2(0:31)       = so2_full(0:31)
  so2(32:695)     = so2_full(33:696)
  
;  co              = co*1000
  so2	          = so2*10
  so2 = where(so2.lt.0,0,so2)
  so2 = where(so2.gt.80,so2@_FillValue,so2)
  no2 = where(no2.lt.0,0,no2)
  o3  = where(o3.lt.0,0,o3)

; READ IN AEROSOL SPECIES AT 260M
  org_260_full    = tofloat(str_get_field(lines_useful,22,delim))
  org_260(0:31)   = org_260_full(0:31)
  org_260(32:695) = org_260_full(33:696)

  so4_260_full    = tofloat(str_get_field(lines_useful,23,delim))
  so4_260(0:31)   = so4_260_full(0:31)
  so4_260(32:695) = so4_260_full(33:696)

  no3_260_full    = tofloat(str_get_field(lines_useful,24,delim))
  no3_260(0:31)   = no3_260_full(0:31)
  no3_260(32:695) = no3_260_full(33:696)

  nh4_260_full    = tofloat(str_get_field(lines_useful,25,delim))
  nh4_260(0:31)   = nh4_260_full(0:31)
  nh4_260(32:695) = nh4_260_full(33:696)

  chl_260_full    = tofloat(str_get_field(lines_useful,26,delim))
  chl_260(0:31)   = chl_260_full(0:31)
  chl_260(32:695) = chl_260_full(33:696)
 
;REMOVE THE OUTLIERS
undef("remoutlier")
function remoutlier(var)
begin
 n = dimsizes(var)
 do i=1,n-2
  prev = var(i-1)
  now  = var(i)
  next = var(i+1)
  miss = var@_FillValue
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.gt.2*prev).and.(now>2*next)) then
    var(i) = miss
  end if
 end do
 return(var)
end


co = remoutlier(co)
so2 = remoutlier(so2)
no2 = remoutlier(no2)
o3 = remoutlier(o3)
so4 = remoutlier(so4)
no3 = remoutlier(no3)
nh4 = remoutlier(nh4)

org_260 = remoutlier(org_260)
org_260 = where(org_260.lt.0,org_260@_FillValue,org_260)
so4_260 = remoutlier(so4_260)
no3_260 = remoutlier(no3_260)
nh4_260 = remoutlier(nh4_260)
chl_260 = remoutlier(chl_260)
so4_260 = where(so4_260.lt.0,so4_260@_FillValue,so4_260)
no3_260 = where(no3_260.lt.0,no3_260@_FillValue,no3_260)
nh4_260 = where(nh4_260.lt.0,nh4_260@_FillValue,nh4_260)
chl_260 = where(chl_260.lt.0,chl_260@_FillValue,chl_260)
;print ("co="+co_subset +" so2="+so2_subset)
print("All obs arrays prepared now")
;  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

  var_matrix_no3  = new((/4,696/),float)  
  var_matrix_nh4  = new((/4,696/),float)  
  var_matrix_so4  = new((/4,696/),float)  
  var_matrix_oc  = new((/4,696/),float)  
  var_matrix_bc  = new((/4,696/),float)  
  var_matrix_chl  = new((/4,696/),float)  
  var_matrix_co   = new((/4,696/),float)  
  var_matrix_no2  = new((/4,696/),float)  
  var_matrix_so2  = new((/4,696/),float)  
  var_matrix_o3   = new((/4,696/),float)  
 
  var_matrix_oc_260  = new((/4,696/),float)  
  var_matrix_so4_260  = new((/4,696/),float)  
  var_matrix_no3_260  = new((/4,696/),float)  
  var_matrix_nh4_260  = new((/4,696/),float)  
  var_matrix_chl_260  = new((/4,696/),float)  

var_matrix_no3(0,:) = (/no3_sim_subset/)
var_matrix_no3(1,:) = (/no3_sim_subset_b/)
var_matrix_no3(2,:) = (/no3_sim_subset_c/)
var_matrix_no3(3,:) = no3

no3Octavg_Obs = avg(no3(71:286))
no3Octavg_baseline = avg(no3_sim_subset(71:286))
no3Octavg_controls = avg(no3_sim_subset_c(71:286))

no3Novavg_Obs = avg(no3(455:670))
no3Novavg_baseline = avg(no3_sim_subset(455:670))
no3Novavg_controls = avg(no3_sim_subset_b(455:670))


var_matrix_nh4(0,:) = (/nh4_sim_subset/)
var_matrix_nh4(1,:) = (/nh4_sim_subset_b/)
var_matrix_nh4(2,:) = (/nh4_sim_subset_c/)
var_matrix_nh4(3,:) = nh4

nh4Octavg_Obs = avg(nh4(71:286))
nh4Octavg_baseline = avg(nh4_sim_subset(71:286))
nh4Octavg_controls = avg(nh4_sim_subset_c(71:286))

nh4Novavg_Obs = avg(nh4(455:670))
nh4Novavg_baseline = avg(nh4_sim_subset(455:670))
nh4Novavg_controls = avg(nh4_sim_subset_b(455:670))



var_matrix_so4(0,:) = (/so4_sim_subset/)
var_matrix_so4(1,:) = (/so4_sim_subset_b/)
var_matrix_so4(2,:) = (/so4_sim_subset_c/)
var_matrix_so4(3,:) = so4

so4Octavg_Obs = avg(so4(71:286))
so4Octavg_baseline = avg(so4_sim_subset(71:286))
so4Octavg_controls = avg(so4_sim_subset_c(71:286))

so4Novavg_Obs = avg(so4(455:670))
so4Novavg_baseline = avg(so4_sim_subset(455:670))
so4Novavg_controls = avg(so4_sim_subset_b(455:670))


var_matrix_oc(0,:) = (/oc_sim_subset/)
var_matrix_oc(1,:) = (/oc_sim_subset_b/)
var_matrix_oc(2,:) = (/oc_sim_subset_c/)
var_matrix_oc(3,:) = org

ocOctavg_Obs = avg(org(71:286))
ocOctavg_baseline = avg(oc_sim_subset(71:286))
ocOctavg_controls = avg(oc_sim_subset_c(71:286))

ocNovavg_Obs = avg(org(455:670))
ocNovavg_baseline = avg(oc_sim_subset(455:670))
ocNovavg_controls = avg(oc_sim_subset_b(455:670))

var_matrix_bc(0,:) = (/bc_sim_subset/)
var_matrix_bc(1,:) = (/bc_sim_subset_b/)
var_matrix_bc(2,:) = (/bc_sim_subset_c/)
var_matrix_bc(3,:) = bc

bcOctavg_Obs = avg(bc(71:286))
bcOctavg_baseline = avg(bc_sim_subset(71:286))
bcOctavg_controls = avg(bc_sim_subset_c(71:286))

bcNovavg_Obs = avg(bc(455:670))
bcNovavg_baseline = avg(bc_sim_subset(455:670))
bcNovavg_controls = avg(bc_sim_subset_b(455:670))


var_matrix_chl(0,:) = (/chl_sim_subset/)
var_matrix_chl(1,:) = (/chl_sim_subset_b/)
var_matrix_chl(2,:) = (/chl_sim_subset_c/)
var_matrix_chl(3,:) = chl

chlOctavg_Obs = avg(chl(71:286))
chlOctavg_baseline = avg(chl_sim_subset(71:286))
chlOctavg_controls = avg(chl_sim_subset_c(71:286))

chlNovavg_Obs = avg(chl(455:670))
chlNovavg_baseline = avg(chl_sim_subset(455:670))
chlNovavg_controls = avg(chl_sim_subset_b(455:670))


var_matrix_co(0,:)  = (/co_sim_subset/)
var_matrix_co(1,:)  = (/co_sim_subset_b/)
var_matrix_co(2,:)  = (/co_sim_subset_c/)
var_matrix_co(3,:)  = co

coOctavg_Obs = avg(co(71:286))
coOctavg_baseline = avg(co_sim_subset(71:286))
coOctavg_controls = avg(co_sim_subset_c(71:286))

coNovavg_Obs = avg(co(455:670))
coNovavg_baseline = avg(co_sim_subset(455:670))
coNovavg_controls = avg(co_sim_subset_b(455:670))


var_matrix_no2(0,:) = (/no2_sim_subset/)
var_matrix_no2(1,:) = (/no2_sim_subset_b/)
var_matrix_no2(2,:) = (/no2_sim_subset_c/)
var_matrix_no2(3,:) = no2

no2Octavg_Obs = avg(no2(71:286))
no2Octavg_baseline = avg(no2_sim_subset(71:286))
no2Octavg_controls = avg(no2_sim_subset_c(71:286))

no2Novavg_Obs = avg(no2(455:670))
no2Novavg_baseline = avg(no2_sim_subset(455:670))
no2Novavg_controls = avg(no2_sim_subset_b(455:670))

var_matrix_so2(0,:) = (/so2_sim_subset/)
var_matrix_so2(1,:) = (/so2_sim_subset_b/)
var_matrix_so2(2,:) = (/so2_sim_subset_c/)
var_matrix_so2(3,:) = so2

so2Octavg_Obs = avg(so2(71:286))
so2Octavg_baseline = avg(so2_sim_subset(71:286))
so2Octavg_controls = avg(so2_sim_subset_c(71:286))

so2Novavg_Obs = avg(so2(455:670))
so2Novavg_baseline = avg(so2_sim_subset(455:670))
so2Novavg_controls = avg(so2_sim_subset_b(455:670))

var_matrix_o3(0,:)  = (/o3_sim_subset/)
var_matrix_o3(1,:)  = (/o3_sim_subset_b/)
var_matrix_o3(2,:)  = (/o3_sim_subset_c/)
var_matrix_o3(3,:)  = o3

o3Octavg_Obs = avg(o3(71:286))
o3Octavg_baseline = avg(o3_sim_subset(71:286))
o3Octavg_controls = avg(o3_sim_subset_c(71:286))

o3Novavg_Obs = avg(o3(455:670))
o3Novavg_baseline = avg(o3_sim_subset(455:670))
o3Novavg_controls = avg(o3_sim_subset_b(455:670))



var_matrix_oc_260(0,:)  = oc_sim_260_subset
var_matrix_oc_260(1,:)  = oc_sim_260_subset_b
var_matrix_oc_260(2,:)  = oc_sim_260_subset_c
var_matrix_oc_260(3,:)  = org_260
var_matrix_so4_260(0,:)  = so4_sim_260_subset
var_matrix_so4_260(1,:)  = so4_sim_260_subset_b
var_matrix_so4_260(2,:)  = so4_sim_260_subset_c
var_matrix_so4_260(3,:)  = so4_260
var_matrix_no3_260(0,:)  = no3_sim_260_subset
var_matrix_no3_260(1,:)  = no3_sim_260_subset_b
var_matrix_no3_260(2,:)  = no3_sim_260_subset_c
var_matrix_no3_260(3,:)  = no3_260
var_matrix_nh4_260(0,:)  = nh4_sim_260_subset
var_matrix_nh4_260(1,:)  = nh4_sim_260_subset_b
var_matrix_nh4_260(2,:)  = nh4_sim_260_subset_c
var_matrix_nh4_260(3,:)  = nh4_260
var_matrix_chl_260(0,:)  = chl_sim_260_subset
var_matrix_chl_260(1,:)  = chl_sim_260_subset_b
var_matrix_chl_260(2,:)  = chl_sim_260_subset_c
var_matrix_chl_260(3,:)  = chl_260

;---Start the graphics
wks = gsn_open_wks("eps","IAP-pol-ts_surface") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at IAP ground site"          ; add title
;res@gsnMaximize = True
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0  /)          ; make second line thicker
res@xyLineColors      = (/"blue","black","black","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
  restick@ttmNumTicks = 15
;  restick@ttmMajorStride= 12
;  restick@ttmMinorStride= 1
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.05
  res@tiYAxisFontHeightF = 0.05
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = False   ; Turn off left tickmarks
  res@tmYROn               = True    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = 0               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.30                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .03                 ; label font height
  res@xyExplicitLegendLabels = (/"baseline","APEC-controls","Oct-controls","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

printVarSummary(times_subset)
; Change y axis string and color for each plot.
  res@tiYAxisString = "OC"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_oc,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
  res@tiYAxisString = "BC"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_bc,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "NH4"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)

  res@tiYAxisString = "CHL"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_chl,res)

  res@tiYAxisString = "CO"
  xy7 = gsn_csm_xy(wks,timearr,var_matrix_co,res)

  res@tiYAxisString = "SO2"
  xy8 = gsn_csm_xy(wks,timearr,var_matrix_so2,res)

  res@tiYAxisString = "NO2"
  xy9 = gsn_csm_xy(wks,timearr,var_matrix_no2,res)

  res@tiYAxisString = "O3"
  xy10 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy11 = gsn_csm_xy(wks,timearr,pblh_subset,res)

  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy9,xy10,xy11/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)
print(d_subset)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Surface pollutants at IAP 260m site"          ; add title
  res@tiYAxisString = "OC"
  xy12 = gsn_csm_xy(wks,timearr,var_matrix_oc_260,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "Chl"
  xy13 = gsn_csm_xy(wks,timearr,var_matrix_chl_260,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy14 = gsn_csm_xy(wks,timearr,var_matrix_no3_260,res)

  res@tiYAxisString = "SO4"
  xy15 = gsn_csm_xy(wks,timearr,var_matrix_so4_260,res)

  res@tiYAxisString = "Nh4"
  xy16 = gsn_csm_xy(wks,timearr,var_matrix_nh4_260,res)

amid1 = gsn_attach_plots(xy12,(/xy13,xy14,xy15,xy16/),res1,res2)

;plot = gsn_csm_xy(wks,times,chl,res1)

;draw(xy12)
;frame(wks)

;************************************************
; create panel
;************************************************
;resP                 = True
;resP@gsnPanelYWhiteSpacePercent = 5
;resP@gsnPanelXWhiteSpacePercent = 5
;resP@gsnPanelLeft    = 0.5                 ; draw from left edge to center
;resP@gsnPanelRight    = 0.25                 ; draw from left edge to center
;resP@gsnPaperOrientation = "auto"          
;resP@gsnMaximize         = True        ; must include w/ Paper Orientation
;resP@wkPaperWidthF = 10
;gsn_panel(wks,(/xy1,xy12/),(/1,2/),resP)             ; now draw as one plot

print("org(0) = " + org(0))
print("so4(0) = " + so4(0))
print("no3(0) = " + no3(0))
print("nh4(0) = " + nh4(0))
print("chl(0) = " + chl(0))
print("bc(0) = " + bc(0))

print("co(0) = " + co(0))
print("no2(0) = " + no2(0))
print("o3(0) = " + o3(0))
print("so2(0) = " + so2(0))

print("org_260(0) = " + org_260(0))
print("so4_260(0) = " + so4_260(0))
print("no3_260(0) = " + no3_260(0))
print("nh4_260(0) = " + nh4_260(0))
print("chl_260(0) = " + chl_260(0))

print("#~~~~~~~~~~~~~~~#~~~~~~~~~~~~~#~~~~~~~~~~~~~~#~~~~~~~~~~~~~~#")
print("#~~~~~~~~~~~~~~~#~~~~~~~APEC Period~~~#~~~October Period~~~~#")
print("#~~~~~~~~~~~~~~~#~~~~~~~~~~~~~#~~~~~~~~~~~~~~#~~~~~~~~~~~~~~#")
print("OC")
print("Oberved mean:        "+ocNovavg_Obs+"       "+ocOctavg_Obs)
print("Sim mean (baseline): "+ocNovavg_baseline+"       "+ocOctavg_baseline)
print("Sim mean (controls): "+ocNovavg_controls+"       "+ocOctavg_controls)
print("Absolute improvement: "+(ocNovavg_baseline-ocNovavg_controls)+"       "+(ocOctavg_baseline-ocOctavg_controls))
print("Relative improvement(%): "+((ocNovavg_baseline-ocNovavg_controls)*100/ocNovavg_baseline)+"       "+((ocOctavg_baseline-ocOctavg_controls)*100/ocOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("BC")
print("Oberved mean:        "+bcNovavg_Obs+"       "+bcOctavg_Obs)
print("Sim mean (baseline): "+bcNovavg_baseline+"       "+bcOctavg_baseline)
print("Sim mean (controls): "+bcNovavg_controls+"       "+bcOctavg_controls)
print("Absolute improvement: "+(bcNovavg_baseline-bcNovavg_controls)+"       "+(bcOctavg_baseline-bcOctavg_controls))
print("Relative improvement(%): "+((bcNovavg_baseline-bcNovavg_controls)*100/bcNovavg_baseline)+"       "+((bcOctavg_baseline-bcOctavg_controls)*100/bcOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO3")
print("Oberved mean:        "+no3Novavg_Obs+"       "+no3Octavg_Obs)
print("Sim mean (baseline): "+no3Novavg_baseline+"       "+no3Octavg_baseline)
print("Sim mean (controls): "+no3Novavg_controls+"       "+no3Octavg_controls)
print("Absolute improvement: "+(no3Novavg_baseline-no3Novavg_controls)+"       "+(no3Octavg_baseline-no3Octavg_controls))
print("Relative improvement(%): "+((no3Novavg_baseline-no3Novavg_controls)*100/no3Novavg_baseline)+"       "+((no3Octavg_baseline-no3Octavg_controls)*100/no3Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NH4")
print("Oberved mean:        "+nh4Novavg_Obs+"       "+nh4Octavg_Obs)
print("Sim mean (baseline): "+nh4Novavg_baseline+"       "+nh4Octavg_baseline)
print("Sim mean (controls): "+nh4Novavg_controls+"       "+nh4Octavg_controls)
print("Absolute improvement: "+(nh4Novavg_baseline-nh4Novavg_controls)+"       "+(nh4Octavg_baseline-nh4Octavg_controls))
print("Relative improvement(%): "+((nh4Novavg_baseline-nh4Novavg_controls)*100/nh4Novavg_baseline)+"       "+((nh4Octavg_baseline-nh4Octavg_controls)*100/nh4Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO4")
print("Oberved mean:        "+so4Novavg_Obs+"       "+so4Octavg_Obs)
print("Sim mean (baseline): "+so4Novavg_baseline+"       "+so4Octavg_baseline)
print("Sim mean (controls): "+so4Novavg_controls+"       "+so4Octavg_controls)
print("Absolute improvement: "+(so4Novavg_baseline-so4Novavg_controls)+"       "+(so4Octavg_baseline-so4Octavg_controls))
print("Relative improvement(%): "+((so4Novavg_baseline-so4Novavg_controls)*100/so4Novavg_baseline)+"       "+((so4Octavg_baseline-so4Octavg_controls)*100/so4Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("CHL")
print("Oberved mean:        "+chlNovavg_Obs+"       "+chlOctavg_Obs)
print("Sim mean (baseline): "+chlNovavg_baseline+"       "+chlOctavg_baseline)
print("Sim mean (controls): "+chlNovavg_controls+"       "+chlOctavg_controls)
print("Absolute improvement: "+(chlNovavg_baseline-chlNovavg_controls)+"       "+(chlOctavg_baseline-chlOctavg_controls))
print("Relative improvement(%): "+((chlNovavg_baseline-chlNovavg_controls)*100/chlNovavg_baseline)+"       "+((chlOctavg_baseline-chlOctavg_controls)*100/chlOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("CO")
print("Oberved mean:        "+coNovavg_Obs+"       "+coOctavg_Obs)
print("Sim mean (baseline): "+coNovavg_baseline+"       "+coOctavg_baseline)
print("Sim mean (controls): "+coNovavg_controls+"       "+coOctavg_controls)
print("Absolute improvement: "+(coNovavg_baseline-coNovavg_controls)+"       "+(coOctavg_baseline-coOctavg_controls))
print("Relative improvement(%): "+((coNovavg_baseline-coNovavg_controls)*100/coNovavg_baseline)+"       "+((coOctavg_baseline-coOctavg_controls)*100/coOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO2")
print("Oberved mean:        "+no2Novavg_Obs+"       "+no2Octavg_Obs)
print("Sim mean (baseline): "+no2Novavg_baseline+"       "+no2Octavg_baseline)
print("Sim mean (controls): "+no2Novavg_controls+"       "+no2Octavg_controls)
print("Absolute improvement: "+(no2Novavg_baseline-no2Novavg_controls)+"       "+(no2Octavg_baseline-no2Octavg_controls))
print("Relative improvement(%): "+((no2Novavg_baseline-no2Novavg_controls)*100/no2Novavg_baseline)+"       "+((no2Octavg_baseline-no2Octavg_controls)*100/no2Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO2")
print("Oberved mean:        "+so2Novavg_Obs+"       "+so2Octavg_Obs)
print("Sim mean (baseline): "+so2Novavg_baseline+"       "+so2Octavg_baseline)
print("Sim mean (controls): "+so2Novavg_controls+"       "+so2Octavg_controls)
print("Absolute improvement: "+(so2Novavg_baseline-so2Novavg_controls)+"       "+(so2Octavg_baseline-so2Octavg_controls))
print("Relative improvement(%): "+((so2Novavg_baseline-so2Novavg_controls)*100/so2Novavg_baseline)+"       "+((so2Octavg_baseline-so2Octavg_controls)*100/so2Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("O3")
print("Oberved mean:        "+o3Novavg_Obs+"       "+o3Octavg_Obs)
print("Sim mean (baseline): "+o3Novavg_baseline+"       "+o3Octavg_baseline)
print("Sim mean (controls): "+o3Novavg_controls+"       "+o3Octavg_controls)
print("Absolute improvement: "+(o3Novavg_baseline-o3Novavg_controls)+"       "+(o3Octavg_baseline-o3Octavg_controls))
print("Relative improvement(%): "+((o3Novavg_baseline-o3Novavg_controls)*100/o3Novavg_baseline)+"       "+((o3Octavg_baseline-o3Octavg_controls)*100/o3Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

print("Total time taken in minutes: "+((get_cpu_time() - begTime)/60.0))

end
