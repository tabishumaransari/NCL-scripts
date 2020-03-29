; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()

DATADir1 = "/mnt/rasher/pulse-runs/APEC3Nov2/"
DATADir2 = "/mnt/rasher/pulse-runs/APEC3Nov3/"
DATADir3 = "/mnt/rasher/pulse-runs/APEC3Nov4/"
DATADir4 = "/mnt/rasher/pulse-runs/APEC3Nov5/"
DATADir5 = "/mnt/rasher/pulse-runs/APEC3Nov6/"
DATADir6 = "/mnt/rasher/pulse-runs/APEC3Nov7/"
DATADir7 = "/mnt/rasher/pulse-runs/APEC3Nov8/"
DATADir8 = "/mnt/rasher/pulse-runs/APEC3Nov9/"
DATADir9 = "/mnt/rasher/pulse-runs/APEC3Nov10/"
DATADir10= "/mnt/rasher/pulse-runs/APEC3Nov11/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "subset_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "subset_d03_2014-* ")
FILES3 = systemfunc (" ls -1 " + DATADir3 + "subset_d03_2014-* ")
FILES4 = systemfunc (" ls -1 " + DATADir4 + "subset_d03_2014-* ")
FILES5 = systemfunc (" ls -1 " + DATADir5 + "subset_d03_2014-* ")
FILES6 = systemfunc (" ls -1 " + DATADir6 + "subset_d03_2014-* ")
FILES7 = systemfunc (" ls -1 " + DATADir7 + "subset_d03_2014-* ")
FILES8 = systemfunc (" ls -1 " + DATADir8 + "subset_d03_2014-* ")
FILES9 = systemfunc (" ls -1 " + DATADir9 + "subset_d03_2014-* ")
FILES10= systemfunc (" ls -1 " + DATADir10 + "subset_d03_2014-* ")
b1 = addfiles(FILES1,"r")
b2 = addfiles(FILES2,"r")
b3 = addfiles(FILES3,"r")
b4 = addfiles(FILES4,"r")
b5 = addfiles(FILES5,"r")
b6 = addfiles(FILES6,"r")
b7 = addfiles(FILES7,"r")
b8 = addfiles(FILES8,"r")
b9 = addfiles(FILES9,"r")
b10= addfiles(FILES10,"r")

DATADir11 = "/mnt/rasher/pulse-runs/rstbaseline2nov/"
DATADir12 = "/mnt/rasher/pulse-runs/rstbaseline3nov/"
DATADir13 = "/mnt/rasher/pulse-runs/rstbaseline4nov/"
DATADir14 = "/mnt/rasher/pulse-runs/rstbaseline5nov/"
DATADir15 = "/mnt/rasher/pulse-runs/rstbaseline6nov/"
DATADir16 = "/mnt/rasher/pulse-runs/rstbaseline7nov/"
DATADir17 = "/mnt/rasher/pulse-runs/rstbaseline8nov/"
DATADir18 = "/mnt/rasher/pulse-runs/rstbaseline9nov/"
DATADir19 = "/mnt/rasher/pulse-runs/rstbaseline10nov/"
DATADir20 = "/mnt/rasher/pulse-runs/rstbaseline11nov/"
FILES11 = systemfunc (" ls -1 " + DATADir11 + "subset_d03_2014-* ")
FILES12 = systemfunc (" ls -1 " + DATADir12 + "subset_d03_2014-* ")
FILES13 = systemfunc (" ls -1 " + DATADir13 + "subset_d03_2014-* ")
FILES14 = systemfunc (" ls -1 " + DATADir14 + "subset_d03_2014-* ")
FILES15 = systemfunc (" ls -1 " + DATADir15 + "subset_d03_2014-* ")
FILES16 = systemfunc (" ls -1 " + DATADir16 + "subset_d03_2014-* ")
FILES17 = systemfunc (" ls -1 " + DATADir17 + "subset_d03_2014-* ")
FILES18 = systemfunc (" ls -1 " + DATADir18 + "subset_d03_2014-* ")
FILES19 = systemfunc (" ls -1 " + DATADir19 + "subset_d03_2014-* ")
FILES20= systemfunc (" ls -1 " + DATADir20 + "subset_d03_2014-* ")
a1 = addfiles(FILES11,"r")
a2 = addfiles(FILES12,"r")
a3 = addfiles(FILES13,"r")
a4 = addfiles(FILES14,"r")
a5 = addfiles(FILES15,"r")
a6 = addfiles(FILES16,"r")
a7 = addfiles(FILES17,"r")
a8 = addfiles(FILES18,"r")
a9 = addfiles(FILES19,"r")
a10= addfiles(FILES20,"r")

;INITIALIZING ALL pulse-runs POLLUTANT ARRAYS WITH AOTIZHONGXIN VALUES
pm25_sim_b1    = b1[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b1    = b1[:]->PM10(:,0,145,79)
co_sim_b1      = b1[:]->co(:,0,145,79)
no2_sim_b1     = b1[:]->no2(:,0,145,79)
so2_sim_b1     = b1[:]->so2(:,0,145,79)
o3_sim_b1      = b1[:]->o3(:,0,145,79)


pm25_sim_b2    = b2[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b2    = b2[:]->PM10(:,0,145,79)
co_sim_b2      = b2[:]->co(:,0,145,79)
no2_sim_b2     = b2[:]->no2(:,0,145,79)
so2_sim_b2     = b2[:]->so2(:,0,145,79)
o3_sim_b2      = b2[:]->o3(:,0,145,79)

pm25_sim_b3    = b3[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b3    = b3[:]->PM10(:,0,145,79)
co_sim_b3      = b3[:]->co(:,0,145,79)
no2_sim_b3     = b3[:]->no2(:,0,145,79)
so2_sim_b3     = b3[:]->so2(:,0,145,79)
o3_sim_b3      = b3[:]->o3(:,0,145,79)

pm25_sim_b4    = b4[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b4    = b4[:]->PM10(:,0,145,79)
co_sim_b4      = b4[:]->co(:,0,145,79)
no2_sim_b4     = b4[:]->no2(:,0,145,79)
so2_sim_b4     = b4[:]->so2(:,0,145,79)
o3_sim_b4      = b4[:]->o3(:,0,145,79)

pm25_sim_b5    = b5[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b5    = b5[:]->PM10(:,0,145,79)
co_sim_b5      = b5[:]->co(:,0,145,79)
no2_sim_b5     = b5[:]->no2(:,0,145,79)
so2_sim_b5     = b5[:]->so2(:,0,145,79)
o3_sim_b5      = b5[:]->o3(:,0,145,79)

pm25_sim_b6    = b6[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b6    = b6[:]->PM10(:,0,145,79)
co_sim_b6      = b6[:]->co(:,0,145,79)
no2_sim_b6     = b6[:]->no2(:,0,145,79)
so2_sim_b6     = b6[:]->so2(:,0,145,79)
o3_sim_b6      = b6[:]->o3(:,0,145,79)

pm25_sim_b7    = b7[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b7    = b7[:]->PM10(:,0,145,79)
co_sim_b7      = b7[:]->co(:,0,145,79)
no2_sim_b7     = b7[:]->no2(:,0,145,79)
so2_sim_b7     = b7[:]->so2(:,0,145,79)
o3_sim_b7      = b7[:]->o3(:,0,145,79)

pm25_sim_b8    = b8[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b8    = b8[:]->PM10(:,0,145,79)
co_sim_b8      = b8[:]->co(:,0,145,79)
no2_sim_b8     = b8[:]->no2(:,0,145,79)
so2_sim_b8     = b8[:]->so2(:,0,145,79)
o3_sim_b8      = b8[:]->o3(:,0,145,79)

pm25_sim_b9    = b9[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b9    = b9[:]->PM10(:,0,145,79)
co_sim_b9      = b9[:]->co(:,0,145,79)
no2_sim_b9     = b9[:]->no2(:,0,145,79)
so2_sim_b9     = b9[:]->so2(:,0,145,79)
o3_sim_b9      = b9[:]->o3(:,0,145,79)

pm25_sim_b10    = b10[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b10    = b10[:]->PM10(:,0,145,79)
co_sim_b10      = b10[:]->co(:,0,145,79)
no2_sim_b10     = b10[:]->no2(:,0,145,79)
so2_sim_b10     = b10[:]->so2(:,0,145,79)
o3_sim_b10      = b10[:]->o3(:,0,145,79)

;INITIALIZING ALL rstbaseline-runs POLLUTANT ARRAYS WITH AOTIZHONGXIN VALUES
pm25_sim_a1    = a1[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a1    = a1[:]->PM10(:,0,145,79)
co_sim_a1      = a1[:]->co(:,0,145,79)
no2_sim_a1     = a1[:]->no2(:,0,145,79)
so2_sim_a1     = a1[:]->so2(:,0,145,79)
o3_sim_a1      = a1[:]->o3(:,0,145,79)


pm25_sim_a2    = a2[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a2    = a2[:]->PM10(:,0,145,79)
co_sim_a2      = a2[:]->co(:,0,145,79)
no2_sim_a2     = a2[:]->no2(:,0,145,79)
so2_sim_a2     = a2[:]->so2(:,0,145,79)
o3_sim_a2      = a2[:]->o3(:,0,145,79)

pm25_sim_a3    = a3[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a3    = a3[:]->PM10(:,0,145,79)
co_sim_a3      = a3[:]->co(:,0,145,79)
no2_sim_a3     = a3[:]->no2(:,0,145,79)
so2_sim_a3     = a3[:]->so2(:,0,145,79)
o3_sim_a3      = a3[:]->o3(:,0,145,79)

pm25_sim_a4    = a4[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a4    = a4[:]->PM10(:,0,145,79)
co_sim_a4      = a4[:]->co(:,0,145,79)
no2_sim_a4     = a4[:]->no2(:,0,145,79)
so2_sim_a4     = a4[:]->so2(:,0,145,79)
o3_sim_a4      = a4[:]->o3(:,0,145,79)

pm25_sim_a5    = a5[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a5    = a5[:]->PM10(:,0,145,79)
co_sim_a5      = a5[:]->co(:,0,145,79)
no2_sim_a5     = a5[:]->no2(:,0,145,79)
so2_sim_a5     = a5[:]->so2(:,0,145,79)
o3_sim_a5      = a5[:]->o3(:,0,145,79)

pm25_sim_a6    = a6[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a6    = a6[:]->PM10(:,0,145,79)
co_sim_a6      = a6[:]->co(:,0,145,79)
no2_sim_a6     = a6[:]->no2(:,0,145,79)
so2_sim_a6     = a6[:]->so2(:,0,145,79)
o3_sim_a6      = a6[:]->o3(:,0,145,79)

pm25_sim_a7    = a7[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a7    = a7[:]->PM10(:,0,145,79)
co_sim_a7      = a7[:]->co(:,0,145,79)
no2_sim_a7     = a7[:]->no2(:,0,145,79)
so2_sim_a7     = a7[:]->so2(:,0,145,79)
o3_sim_a7      = a7[:]->o3(:,0,145,79)

pm25_sim_a8    = a8[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a8    = a8[:]->PM10(:,0,145,79)
co_sim_a8      = a8[:]->co(:,0,145,79)
no2_sim_a8     = a8[:]->no2(:,0,145,79)
so2_sim_a8     = a8[:]->so2(:,0,145,79)
o3_sim_a8      = a8[:]->o3(:,0,145,79)

pm25_sim_a9    = a9[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a9    = a9[:]->PM10(:,0,145,79)
co_sim_a9      = a9[:]->co(:,0,145,79)
no2_sim_a9     = a9[:]->no2(:,0,145,79)
so2_sim_a9     = a9[:]->so2(:,0,145,79)
o3_sim_a9      = a9[:]->o3(:,0,145,79)

pm25_sim_a10    = a10[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a10    = a10[:]->PM10(:,0,145,79)
co_sim_a10      = a10[:]->co(:,0,145,79)
no2_sim_a10     = a10[:]->no2(:,0,145,79)
so2_sim_a10     = a10[:]->so2(:,0,145,79)
o3_sim_a10      = a10[:]->o3(:,0,145,79)






;NOW ADDING OTHER STATION VALUES TO CORRESPONDING ARRAYS
Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)

 pm25_sim_b1    = pm25_sim_b1 + b1[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b1    = pm10_sim_b1 + b1[:]->PM10(:,0,J,I)
 co_sim_b1      = co_sim_b1 + b1[:]->co(:,0,J,I)
 no2_sim_b1     = no2_sim_b1 + b1[:]->no2(:,0,J,I)
 so2_sim_b1     = so2_sim_b1 + b1[:]->so2(:,0,J,I)
 o3_sim_b1      = o3_sim_b1 + b1[:]->o3(:,0,J,I)

 pm25_sim_b2    = pm25_sim_b2 + b2[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b2    = pm10_sim_b2 + b2[:]->PM10(:,0,J,I)
 co_sim_b2      = co_sim_b2 + b2[:]->co(:,0,J,I)
 no2_sim_b2     = no2_sim_b2 + b2[:]->no2(:,0,J,I)
 so2_sim_b2     = so2_sim_b2 + b2[:]->so2(:,0,J,I)
 o3_sim_b2      = o3_sim_b2 + b2[:]->o3(:,0,J,I)

 pm25_sim_b3    = pm25_sim_b3 + b3[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b3    = pm10_sim_b3 + b3[:]->PM10(:,0,J,I)
 co_sim_b3      = co_sim_b3 + b3[:]->co(:,0,J,I)
 no2_sim_b3     = no2_sim_b3 + b3[:]->no2(:,0,J,I)
 so2_sim_b3     = so2_sim_b3 + b3[:]->so2(:,0,J,I)
 o3_sim_b3      = o3_sim_b3 + b3[:]->o3(:,0,J,I)

 pm25_sim_b4    = pm25_sim_b4 + b4[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b4    = pm10_sim_b4 + b4[:]->PM10(:,0,J,I)
 co_sim_b4      = co_sim_b4 + b4[:]->co(:,0,J,I)
 no2_sim_b4     = no2_sim_b4 + b4[:]->no2(:,0,J,I)
 so2_sim_b4     = so2_sim_b4 + b4[:]->so2(:,0,J,I)
 o3_sim_b4      = o3_sim_b4 + b4[:]->o3(:,0,J,I)

 pm25_sim_b5    = pm25_sim_b5 + b5[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b5    = pm10_sim_b5 + b5[:]->PM10(:,0,J,I)
 co_sim_b5      = co_sim_b5 + b5[:]->co(:,0,J,I)
 no2_sim_b5     = no2_sim_b5 + b5[:]->no2(:,0,J,I)
 so2_sim_b5     = so2_sim_b5 + b5[:]->so2(:,0,J,I)
 o3_sim_b5      = o3_sim_b5 + b5[:]->o3(:,0,J,I)

 pm25_sim_b6    = pm25_sim_b6 + b6[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b6    = pm10_sim_b6 + b6[:]->PM10(:,0,J,I)
 co_sim_b6      = co_sim_b6 + b6[:]->co(:,0,J,I)
 no2_sim_b6     = no2_sim_b6 + b6[:]->no2(:,0,J,I)
 so2_sim_b6     = so2_sim_b6 + b6[:]->so2(:,0,J,I)
 o3_sim_b6      = o3_sim_b6 + b6[:]->o3(:,0,J,I)

 pm25_sim_b7    = pm25_sim_b7 + b7[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b7    = pm10_sim_b7 + b7[:]->PM10(:,0,J,I)
 co_sim_b7      = co_sim_b7 + b7[:]->co(:,0,J,I)
 no2_sim_b7     = no2_sim_b7 + b7[:]->no2(:,0,J,I)
 so2_sim_b7     = so2_sim_b7 + b7[:]->so2(:,0,J,I)
 o3_sim_b7      = o3_sim_b7 + b7[:]->o3(:,0,J,I)

 pm25_sim_b8    = pm25_sim_b8 + b8[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b8    = pm10_sim_b8 + b8[:]->PM10(:,0,J,I)
 co_sim_b8      = co_sim_b8 + b8[:]->co(:,0,J,I)
 no2_sim_b8     = no2_sim_b8 + b8[:]->no2(:,0,J,I)
 so2_sim_b8     = so2_sim_b8 + b8[:]->so2(:,0,J,I)
 o3_sim_b8      = o3_sim_b8 + b8[:]->o3(:,0,J,I)

 pm25_sim_b9    = pm25_sim_b9 + b9[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b9    = pm10_sim_b9 + b9[:]->PM10(:,0,J,I)
 co_sim_b9      = co_sim_b9 + b9[:]->co(:,0,J,I)
 no2_sim_b9     = no2_sim_b9 + b9[:]->no2(:,0,J,I)
 so2_sim_b9     = so2_sim_b9 + b9[:]->so2(:,0,J,I)
 o3_sim_b9      = o3_sim_b9 + b9[:]->o3(:,0,J,I)

 pm25_sim_b10    = pm25_sim_b10 + b10[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b10    = pm10_sim_b10 + b10[:]->PM10(:,0,J,I)
 co_sim_b10      = co_sim_b10 + b10[:]->co(:,0,J,I)
 no2_sim_b10     = no2_sim_b10 + b10[:]->no2(:,0,J,I)
 so2_sim_b10     = so2_sim_b10 + b10[:]->so2(:,0,J,I)
 o3_sim_b10      = o3_sim_b10 + b10[:]->o3(:,0,J,I)

 pm25_sim_a1    = pm25_sim_a1 + a1[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a1    = pm10_sim_a1 + a1[:]->PM10(:,0,J,I)
 co_sim_a1      = co_sim_a1 + a1[:]->co(:,0,J,I)
 no2_sim_a1     = no2_sim_a1 + a1[:]->no2(:,0,J,I)
 so2_sim_a1     = so2_sim_a1 + a1[:]->so2(:,0,J,I)
 o3_sim_a1      = o3_sim_a1 + a1[:]->o3(:,0,J,I)

 pm25_sim_a2    = pm25_sim_a2 + a2[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a2    = pm10_sim_a2 + a2[:]->PM10(:,0,J,I)
 co_sim_a2      = co_sim_a2 + a2[:]->co(:,0,J,I)
 no2_sim_a2     = no2_sim_a2 + a2[:]->no2(:,0,J,I)
 so2_sim_a2     = so2_sim_a2 + a2[:]->so2(:,0,J,I)
 o3_sim_a2      = o3_sim_a2 + a2[:]->o3(:,0,J,I)

 pm25_sim_a3    = pm25_sim_a3 + a3[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a3    = pm10_sim_a3 + a3[:]->PM10(:,0,J,I)
 co_sim_a3      = co_sim_a3 + a3[:]->co(:,0,J,I)
 no2_sim_a3     = no2_sim_a3 + a3[:]->no2(:,0,J,I)
 so2_sim_a3     = so2_sim_a3 + a3[:]->so2(:,0,J,I)
 o3_sim_a3      = o3_sim_a3 + a3[:]->o3(:,0,J,I)

 pm25_sim_a4    = pm25_sim_a4 + a4[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a4    = pm10_sim_a4 + a4[:]->PM10(:,0,J,I)
 co_sim_a4      = co_sim_a4 + a4[:]->co(:,0,J,I)
 no2_sim_a4     = no2_sim_a4 + a4[:]->no2(:,0,J,I)
 so2_sim_a4     = so2_sim_a4 + a4[:]->so2(:,0,J,I)
 o3_sim_a4      = o3_sim_a4 + a4[:]->o3(:,0,J,I)

 pm25_sim_a5    = pm25_sim_a5 + a5[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a5    = pm10_sim_a5 + a5[:]->PM10(:,0,J,I)
 co_sim_a5      = co_sim_a5 + a5[:]->co(:,0,J,I)
 no2_sim_a5     = no2_sim_a5 + a5[:]->no2(:,0,J,I)
 so2_sim_a5     = so2_sim_a5 + a5[:]->so2(:,0,J,I)
 o3_sim_a5      = o3_sim_a5 + a5[:]->o3(:,0,J,I)

 pm25_sim_a6    = pm25_sim_a6 + a6[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a6    = pm10_sim_a6 + a6[:]->PM10(:,0,J,I)
 co_sim_a6      = co_sim_a6 + a6[:]->co(:,0,J,I)
 no2_sim_a6     = no2_sim_a6 + a6[:]->no2(:,0,J,I)
 so2_sim_a6     = so2_sim_a6 + a6[:]->so2(:,0,J,I)
 o3_sim_a6      = o3_sim_a6 + a6[:]->o3(:,0,J,I)

 pm25_sim_a7    = pm25_sim_a7 + a7[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a7    = pm10_sim_a7 + a7[:]->PM10(:,0,J,I)
 co_sim_a7      = co_sim_a7 + a7[:]->co(:,0,J,I)
 no2_sim_a7     = no2_sim_a7 + a7[:]->no2(:,0,J,I)
 so2_sim_a7     = so2_sim_a7 + a7[:]->so2(:,0,J,I)
 o3_sim_a7      = o3_sim_a7 + a7[:]->o3(:,0,J,I)

 pm25_sim_a8    = pm25_sim_a8 + a8[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a8    = pm10_sim_a8 + a8[:]->PM10(:,0,J,I)
 co_sim_a8      = co_sim_a8 + a8[:]->co(:,0,J,I)
 no2_sim_a8     = no2_sim_a8 + a8[:]->no2(:,0,J,I)
 so2_sim_a8     = so2_sim_a8 + a8[:]->so2(:,0,J,I)
 o3_sim_a8      = o3_sim_a8 + a8[:]->o3(:,0,J,I)

 pm25_sim_a9    = pm25_sim_a9 + a9[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a9    = pm10_sim_a9 + a9[:]->PM10(:,0,J,I)
 co_sim_a9      = co_sim_a9 + a9[:]->co(:,0,J,I)
 no2_sim_a9     = no2_sim_a9 + a9[:]->no2(:,0,J,I)
 so2_sim_a9     = so2_sim_a9 + a9[:]->so2(:,0,J,I)
 o3_sim_a9      = o3_sim_a9 + a9[:]->o3(:,0,J,I)

 pm25_sim_a10    = pm25_sim_a10 + a10[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a10    = pm10_sim_a10 + a10[:]->PM10(:,0,J,I)
 co_sim_a10      = co_sim_a10 + a10[:]->co(:,0,J,I)
 no2_sim_a10     = no2_sim_a10 + a10[:]->no2(:,0,J,I)
 so2_sim_a10     = so2_sim_a10 + a10[:]->so2(:,0,J,I)
 o3_sim_a10      = o3_sim_a10 + a10[:]->o3(:,0,J,I)

end do

pm25_sim_b1 = pm25_sim_b1 / 12.0
pm10_sim_b1 = pm10_sim_b1/12.0
co_sim_b1   = 1000.0 * co_sim_b1/12.0
no2_sim_b1  = 1000.0 * no2_sim_b1/12.0
so2_sim_b1  = 1000.0 * so2_sim_b1/12.0
o3_sim_b1   = 1000.0 * o3_sim_b1/12.0

pm25_sim_b2 = pm25_sim_b2 / 12.0
pm10_sim_b2 = pm10_sim_b2/12.0
co_sim_b2   = 1000.0 * co_sim_b2/12.0
no2_sim_b2  = 1000.0 * no2_sim_b2/12.0
so2_sim_b2  = 1000.0 * so2_sim_b2/12.0
o3_sim_b2   = 1000.0 * o3_sim_b2/12.0

pm25_sim_b3 = pm25_sim_b3 / 12.0
pm10_sim_b3 = pm10_sim_b3/12.0
co_sim_b3   = 1000.0 * co_sim_b3/12.0
no2_sim_b3  = 1000.0 * no2_sim_b3/12.0
so2_sim_b3  = 1000.0 * so2_sim_b3/12.0
o3_sim_b3   = 1000.0 * o3_sim_b3/12.0

pm25_sim_b4 = pm25_sim_b4 / 12.0
pm10_sim_b4 = pm10_sim_b4/12.0
co_sim_b4   = 1000.0 * co_sim_b4/12.0
no2_sim_b4  = 1000.0 * no2_sim_b4/12.0
so2_sim_b4  = 1000.0 * so2_sim_b4/12.0
o3_sim_b4   = 1000.0 * o3_sim_b4/12.0

pm25_sim_b5 = pm25_sim_b5 / 12.0
pm10_sim_b5 = pm10_sim_b5/12.0
co_sim_b5   = 1000.0 * co_sim_b5/12.0
no2_sim_b5  = 1000.0 * no2_sim_b5/12.0
so2_sim_b5  = 1000.0 * so2_sim_b5/12.0
o3_sim_b5   = 1000.0 * o3_sim_b5/12.0

pm25_sim_b6 = pm25_sim_b6 / 12.0
pm10_sim_b6 = pm10_sim_b6/12.0
co_sim_b6   = 1000.0 * co_sim_b6/12.0
no2_sim_b6  = 1000.0 * no2_sim_b6/12.0
so2_sim_b6  = 1000.0 * so2_sim_b6/12.0
o3_sim_b6   = 1000.0 * o3_sim_b6/12.0

pm25_sim_b7 = pm25_sim_b7 / 12.0
pm10_sim_b7 = pm10_sim_b7/12.0
co_sim_b7   = 1000.0 * co_sim_b7/12.0
no2_sim_b7  = 1000.0 * no2_sim_b7/12.0
so2_sim_b7  = 1000.0 * so2_sim_b7/12.0
o3_sim_b7   = 1000.0 * o3_sim_b7/12.0

pm25_sim_b8 = pm25_sim_b8 / 12.0
pm10_sim_b8 = pm10_sim_b8/12.0
co_sim_b8   = 1000.0 * co_sim_b8/12.0
no2_sim_b8  = 1000.0 * no2_sim_b8/12.0
so2_sim_b8  = 1000.0 * so2_sim_b8/12.0
o3_sim_b8   = 1000.0 * o3_sim_b8/12.0

pm25_sim_b9 = pm25_sim_b9 / 12.0
pm10_sim_b9 = pm10_sim_b9/12.0
co_sim_b9   = 1000.0 * co_sim_b9/12.0
no2_sim_b9  = 1000.0 * no2_sim_b9/12.0
so2_sim_b9  = 1000.0 * so2_sim_b9/12.0
o3_sim_b9   = 1000.0 * o3_sim_b9/12.0

pm25_sim_b10 = pm25_sim_b10 / 12.0
pm10_sim_b10 = pm10_sim_b10/12.0
co_sim_b10   = 1000.0 * co_sim_b10/12.0
no2_sim_b10  = 1000.0 * no2_sim_b10/12.0
so2_sim_b10  = 1000.0 * so2_sim_b10/12.0
o3_sim_b10   = 1000.0 * o3_sim_b10/12.0


pm25_sim_a1 = pm25_sim_a1 / 12.0
pm10_sim_a1 = pm10_sim_a1/12.0
co_sim_a1   = 1000.0 * co_sim_a1/12.0
no2_sim_a1  = 1000.0 * no2_sim_a1/12.0
so2_sim_a1  = 1000.0 * so2_sim_a1/12.0
o3_sim_a1   = 1000.0 * o3_sim_a1/12.0

pm25_sim_a2 = pm25_sim_a2 / 12.0
pm10_sim_a2 = pm10_sim_a2/12.0
co_sim_a2   = 1000.0 * co_sim_a2/12.0
no2_sim_a2  = 1000.0 * no2_sim_a2/12.0
so2_sim_a2  = 1000.0 * so2_sim_a2/12.0
o3_sim_a2   = 1000.0 * o3_sim_a2/12.0

pm25_sim_a3 = pm25_sim_a3 / 12.0
pm10_sim_a3 = pm10_sim_a3/12.0
co_sim_a3   = 1000.0 * co_sim_a3/12.0
no2_sim_a3  = 1000.0 * no2_sim_a3/12.0
so2_sim_a3  = 1000.0 * so2_sim_a3/12.0
o3_sim_a3   = 1000.0 * o3_sim_a3/12.0

pm25_sim_a4 = pm25_sim_a4 / 12.0
pm10_sim_a4 = pm10_sim_a4/12.0
co_sim_a4   = 1000.0 * co_sim_a4/12.0
no2_sim_a4  = 1000.0 * no2_sim_a4/12.0
so2_sim_a4  = 1000.0 * so2_sim_a4/12.0
o3_sim_a4   = 1000.0 * o3_sim_a4/12.0

pm25_sim_a5 = pm25_sim_a5 / 12.0
pm10_sim_a5 = pm10_sim_a5/12.0
co_sim_a5   = 1000.0 * co_sim_a5/12.0
no2_sim_a5  = 1000.0 * no2_sim_a5/12.0
so2_sim_a5  = 1000.0 * so2_sim_a5/12.0
o3_sim_a5   = 1000.0 * o3_sim_a5/12.0

pm25_sim_a6 = pm25_sim_a6 / 12.0
pm10_sim_a6 = pm10_sim_a6/12.0
co_sim_a6   = 1000.0 * co_sim_a6/12.0
no2_sim_a6  = 1000.0 * no2_sim_a6/12.0
so2_sim_a6  = 1000.0 * so2_sim_a6/12.0
o3_sim_a6   = 1000.0 * o3_sim_a6/12.0

pm25_sim_a7 = pm25_sim_a7 / 12.0
pm10_sim_a7 = pm10_sim_a7/12.0
co_sim_a7   = 1000.0 * co_sim_a7/12.0
no2_sim_a7  = 1000.0 * no2_sim_a7/12.0
so2_sim_a7  = 1000.0 * so2_sim_a7/12.0
o3_sim_a7   = 1000.0 * o3_sim_a7/12.0

pm25_sim_a8 = pm25_sim_a8 / 12.0
pm10_sim_a8 = pm10_sim_a8/12.0
co_sim_a8   = 1000.0 * co_sim_a8/12.0
no2_sim_a8  = 1000.0 * no2_sim_a8/12.0
so2_sim_a8  = 1000.0 * so2_sim_a8/12.0
o3_sim_a8   = 1000.0 * o3_sim_a8/12.0

pm25_sim_a9 = pm25_sim_a9 / 12.0
pm10_sim_a9 = pm10_sim_a9/12.0
co_sim_a9   = 1000.0 * co_sim_a9/12.0
no2_sim_a9  = 1000.0 * no2_sim_a9/12.0
so2_sim_a9  = 1000.0 * so2_sim_a9/12.0
o3_sim_a9   = 1000.0 * o3_sim_a9/12.0

pm25_sim_a10 = pm25_sim_a10 / 12.0
pm10_sim_a10 = pm10_sim_a10/12.0
co_sim_a10   = 1000.0 * co_sim_a10/12.0
no2_sim_a10  = 1000.0 * no2_sim_a10/12.0
so2_sim_a10  = 1000.0 * so2_sim_a10/12.0
o3_sim_a10   = 1000.0 * o3_sim_a10/12.0

co_sim_b1_subset   = (/co_sim_b1(15:134)/)
no2_sim_b1_subset  = (/no2_sim_b1(15:134)/)
so2_sim_b1_subset  = (/so2_sim_b1(15:134)/)
o3_sim_b1_subset   = (/o3_sim_b1(15:134)/)
pm25_sim_b1_subset = (/pm25_sim_b1(15:134)/)
pm10_sim_b1_subset = (/pm10_sim_b1(15:134)/)

co_sim_b2_subset   = (/co_sim_b2(15:134)/)
no2_sim_b2_subset  = (/no2_sim_b2(15:134)/)
so2_sim_b2_subset  = (/so2_sim_b2(15:134)/)
o3_sim_b2_subset   = (/o3_sim_b2(15:134)/)
pm25_sim_b2_subset = (/pm25_sim_b2(15:134)/)
pm10_sim_b2_subset = (/pm10_sim_b2(15:134)/)

co_sim_b3_subset   = (/co_sim_b3(15:134)/)
no2_sim_b3_subset  = (/no2_sim_b3(15:134)/)
so2_sim_b3_subset  = (/so2_sim_b3(15:134)/)
o3_sim_b3_subset   = (/o3_sim_b3(15:134)/)
pm25_sim_b3_subset = (/pm25_sim_b3(15:134)/)
pm10_sim_b3_subset = (/pm10_sim_b3(15:134)/)

co_sim_b4_subset   = (/co_sim_b4(15:134)/)
no2_sim_b4_subset  = (/no2_sim_b4(15:134)/)
so2_sim_b4_subset  = (/so2_sim_b4(15:134)/)
o3_sim_b4_subset   = (/o3_sim_b4(15:134)/)
pm25_sim_b4_subset = (/pm25_sim_b4(15:134)/)
pm10_sim_b4_subset = (/pm10_sim_b4(15:134)/)

co_sim_b5_subset   = (/co_sim_b5(15:134)/)
no2_sim_b5_subset  = (/no2_sim_b5(15:134)/)
so2_sim_b5_subset  = (/so2_sim_b5(15:134)/)
o3_sim_b5_subset   = (/o3_sim_b5(15:134)/)
pm25_sim_b5_subset = (/pm25_sim_b5(15:134)/)
pm10_sim_b5_subset = (/pm10_sim_b5(15:134)/)

co_sim_b6_subset   = (/co_sim_b6(15:134)/)
no2_sim_b6_subset  = (/no2_sim_b6(15:134)/)
so2_sim_b6_subset  = (/so2_sim_b6(15:134)/)
o3_sim_b6_subset   = (/o3_sim_b6(15:134)/)
pm25_sim_b6_subset = (/pm25_sim_b6(15:134)/)
pm10_sim_b6_subset = (/pm10_sim_b6(15:134)/)

co_sim_b7_subset   = (/co_sim_b7(15:134)/)
no2_sim_b7_subset  = (/no2_sim_b7(15:134)/)
so2_sim_b7_subset  = (/so2_sim_b7(15:134)/)
o3_sim_b7_subset   = (/o3_sim_b7(15:134)/)
pm25_sim_b7_subset = (/pm25_sim_b7(15:134)/)
pm10_sim_b7_subset = (/pm10_sim_b7(15:134)/)

co_sim_b8_subset   = (/co_sim_b8(15:134)/)
no2_sim_b8_subset  = (/no2_sim_b8(15:134)/)
so2_sim_b8_subset  = (/so2_sim_b8(15:134)/)
o3_sim_b8_subset   = (/o3_sim_b8(15:134)/)
pm25_sim_b8_subset = (/pm25_sim_b8(15:134)/)
pm10_sim_b8_subset = (/pm10_sim_b8(15:134)/)

co_sim_b9_subset   = (/co_sim_b9(15:134)/)
no2_sim_b9_subset  = (/no2_sim_b9(15:134)/)
so2_sim_b9_subset  = (/so2_sim_b9(15:134)/)
o3_sim_b9_subset   = (/o3_sim_b9(15:134)/)
pm25_sim_b9_subset = (/pm25_sim_b9(15:134)/)
pm10_sim_b9_subset = (/pm10_sim_b9(15:134)/)

co_sim_b10_subset   = (/co_sim_b10(15:134)/)
no2_sim_b10_subset  = (/no2_sim_b10(15:134)/)
so2_sim_b10_subset  = (/so2_sim_b10(15:134)/)
o3_sim_b10_subset   = (/o3_sim_b10(15:134)/)
pm25_sim_b10_subset = (/pm25_sim_b10(15:134)/)
pm10_sim_b10_subset = (/pm10_sim_b10(15:134)/)


co_sim_a1_subset   = (/co_sim_a1(15:134)/)
no2_sim_a1_subset  = (/no2_sim_a1(15:134)/)
so2_sim_a1_subset  = (/so2_sim_a1(15:134)/)
o3_sim_a1_subset   = (/o3_sim_a1(15:134)/)
pm25_sim_a1_subset = (/pm25_sim_a1(15:134)/)
pm10_sim_a1_subset = (/pm10_sim_a1(15:134)/)

co_sim_a2_subset   = (/co_sim_a2(15:134)/)
no2_sim_a2_subset  = (/no2_sim_a2(15:134)/)
so2_sim_a2_subset  = (/so2_sim_a2(15:134)/)
o3_sim_a2_subset   = (/o3_sim_a2(15:134)/)
pm25_sim_a2_subset = (/pm25_sim_a2(15:134)/)
pm10_sim_a2_subset = (/pm10_sim_a2(15:134)/)

co_sim_a3_subset   = (/co_sim_a3(15:134)/)
no2_sim_a3_subset  = (/no2_sim_a3(15:134)/)
so2_sim_a3_subset  = (/so2_sim_a3(15:134)/)
o3_sim_a3_subset   = (/o3_sim_a3(15:134)/)
pm25_sim_a3_subset = (/pm25_sim_a3(15:134)/)
pm10_sim_a3_subset = (/pm10_sim_a3(15:134)/)

co_sim_a4_subset   = (/co_sim_a4(15:134)/)
no2_sim_a4_subset  = (/no2_sim_a4(15:134)/)
so2_sim_a4_subset  = (/so2_sim_a4(15:134)/)
o3_sim_a4_subset   = (/o3_sim_a4(15:134)/)
pm25_sim_a4_subset = (/pm25_sim_a4(15:134)/)
pm10_sim_a4_subset = (/pm10_sim_a4(15:134)/)

co_sim_a5_subset   = (/co_sim_a5(15:134)/)
no2_sim_a5_subset  = (/no2_sim_a5(15:134)/)
so2_sim_a5_subset  = (/so2_sim_a5(15:134)/)
o3_sim_a5_subset   = (/o3_sim_a5(15:134)/)
pm25_sim_a5_subset = (/pm25_sim_a5(15:134)/)
pm10_sim_a5_subset = (/pm10_sim_a5(15:134)/)

co_sim_a6_subset   = (/co_sim_a6(15:134)/)
no2_sim_a6_subset  = (/no2_sim_a6(15:134)/)
so2_sim_a6_subset  = (/so2_sim_a6(15:134)/)
o3_sim_a6_subset   = (/o3_sim_a6(15:134)/)
pm25_sim_a6_subset = (/pm25_sim_a6(15:134)/)
pm10_sim_a6_subset = (/pm10_sim_a6(15:134)/)

co_sim_a7_subset   = (/co_sim_a7(15:134)/)
no2_sim_a7_subset  = (/no2_sim_a7(15:134)/)
so2_sim_a7_subset  = (/so2_sim_a7(15:134)/)
o3_sim_a7_subset   = (/o3_sim_a7(15:134)/)
pm25_sim_a7_subset = (/pm25_sim_a7(15:134)/)
pm10_sim_a7_subset = (/pm10_sim_a7(15:134)/)

co_sim_a8_subset   = (/co_sim_a8(15:134)/)
no2_sim_a8_subset  = (/no2_sim_a8(15:134)/)
so2_sim_a8_subset  = (/so2_sim_a8(15:134)/)
o3_sim_a8_subset   = (/o3_sim_a8(15:134)/)
pm25_sim_a8_subset = (/pm25_sim_a8(15:134)/)
pm10_sim_a8_subset = (/pm10_sim_a8(15:134)/)

co_sim_a9_subset   = (/co_sim_a9(15:134)/)
no2_sim_a9_subset  = (/no2_sim_a9(15:134)/)
so2_sim_a9_subset  = (/so2_sim_a9(15:134)/)
o3_sim_a9_subset   = (/o3_sim_a9(15:134)/)
pm25_sim_a9_subset = (/pm25_sim_a9(15:134)/)
pm10_sim_a9_subset = (/pm10_sim_a9(15:134)/)

co_sim_a10_subset   = (/co_sim_a10(15:134)/)
no2_sim_a10_subset  = (/no2_sim_a10(15:134)/)
so2_sim_a10_subset  = (/so2_sim_a10(15:134)/)
o3_sim_a10_subset   = (/o3_sim_a10(15:134)/)
pm25_sim_a10_subset = (/pm25_sim_a10(15:134)/)
pm10_sim_a10_subset = (/pm10_sim_a10(15:134)/)

header = (/"18-22B 18-22P 19-23B 19-23P 20-24B 20-24P 21-25B 21-25P 22-26B 22-26P 23-27B 23-27P 24-28B 24-28P 25-29B 25-29P 26-30B 26-30P 27-31B 27-31P"/)
hlist = [/header/]
alist = [/pm25_sim_a1_subset,pm25_sim_b1_subset,pm25_sim_a2_subset,pm25_sim_b2_subset,pm25_sim_a3_subset,pm25_sim_b3_subset,pm25_sim_a4_subset,pm25_sim_b4_subset,pm25_sim_a5_subset,pm25_sim_b5_subset,pm25_sim_a6_subset,pm25_sim_b6_subset,pm25_sim_a7_subset,pm25_sim_b7_subset,pm25_sim_a8_subset,pm25_sim_b8_subset,pm25_sim_a9_subset,pm25_sim_b9_subset,pm25_sim_a10_subset,pm25_sim_b10_subset/]
print("alist created...now writing")
fname = "pm25_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

alist = [/pm10_sim_a1_subset,pm10_sim_b1_subset,pm10_sim_a2_subset,pm10_sim_b2_subset,pm10_sim_a3_subset,pm10_sim_b3_subset,pm10_sim_a4_subset,pm10_sim_b4_subset,pm10_sim_a5_subset,pm10_sim_b5_subset,pm10_sim_a6_subset,pm10_sim_b6_subset,pm10_sim_a7_subset,pm10_sim_b7_subset,pm10_sim_a8_subset,pm10_sim_b8_subset,pm10_sim_a9_subset,pm10_sim_b9_subset,pm10_sim_a10_subset,pm10_sim_b10_subset/]
print("alist created...now writing")
fname = "pm10_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

alist = [/co_sim_a1_subset,co_sim_b1_subset,co_sim_a2_subset,co_sim_b2_subset,co_sim_a3_subset,co_sim_b3_subset,co_sim_a4_subset,co_sim_b4_subset,co_sim_a5_subset,co_sim_b5_subset,co_sim_a6_subset,co_sim_b6_subset,co_sim_a7_subset,co_sim_b7_subset,co_sim_a8_subset,co_sim_b8_subset,co_sim_a9_subset,co_sim_b9_subset,co_sim_a10_subset,co_sim_b10_subset/]
print("alist created...now writing")
fname = "co_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

alist = [/no2_sim_a1_subset,no2_sim_b1_subset,no2_sim_a2_subset,no2_sim_b2_subset,no2_sim_a3_subset,no2_sim_b3_subset,no2_sim_a4_subset,no2_sim_b4_subset,no2_sim_a5_subset,no2_sim_b5_subset,no2_sim_a6_subset,no2_sim_b6_subset,no2_sim_a7_subset,no2_sim_b7_subset,no2_sim_a8_subset,no2_sim_b8_subset,no2_sim_a9_subset,no2_sim_b9_subset,no2_sim_a10_subset,no2_sim_b10_subset/]
print("alist created...now writing")
fname = "no2_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

alist = [/so2_sim_a1_subset,so2_sim_b1_subset,so2_sim_a2_subset,so2_sim_b2_subset,so2_sim_a3_subset,so2_sim_b3_subset,so2_sim_a4_subset,so2_sim_b4_subset,so2_sim_a5_subset,so2_sim_b5_subset,so2_sim_a6_subset,so2_sim_b6_subset,so2_sim_a7_subset,so2_sim_b7_subset,so2_sim_a8_subset,so2_sim_b8_subset,so2_sim_a9_subset,so2_sim_b9_subset,so2_sim_a10_subset,so2_sim_b10_subset/]
print("alist created...now writing")
fname = "so2_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

alist = [/o3_sim_a1_subset,o3_sim_b1_subset,o3_sim_a2_subset,o3_sim_b2_subset,o3_sim_a3_subset,o3_sim_b3_subset,o3_sim_a4_subset,o3_sim_b4_subset,o3_sim_a5_subset,o3_sim_b5_subset,o3_sim_a6_subset,o3_sim_b6_subset,o3_sim_a7_subset,o3_sim_b7_subset,o3_sim_a8_subset,o3_sim_b8_subset,o3_sim_a9_subset,o3_sim_b9_subset,o3_sim_a10_subset,o3_sim_b10_subset/]
print("alist created...now writing")
fname = "o3_pulseruns_APEC3_Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

print("time taken: " + (get_cpu_time() - begTime)/60.0)


end
