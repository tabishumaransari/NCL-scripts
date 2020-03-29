; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
DATADir0 = "/mnt/rasher/zero-out_runs/run0/"
DATADir1 = "/mnt/rasher/zero-out_runs/run1/"
DATADir2 = "/mnt/rasher/zero-out_runs/run2/"
DATADir3 = "/mnt/rasher/zero-out_runs/run3/"
DATADir4 = "/mnt/rasher/zero-out_runs/run4/"
DATADir5 = "/mnt/rasher/zero-out_runs/run5/"
DATADir6 = "/mnt/rasher/zero-out_runs/run6/"
DATADir7 = "/mnt/rasher/zero-out_runs/run7/"
DATADir8 = "/mnt/rasher/zero-out_runs/run8/"
DATADir9 = "/mnt/rasher/zero-out_runs/run9/"
DATADir10 = "/mnt/rasher/zero-out_runs/run10/"
DATADir11 = "/mnt/rasher/zero-out_runs/run11/"
DATADir12 = "/mnt/rasher/zero-out_runs/run12/"
FILES0 = systemfunc (" ls -1 " + DATADir0 + "subset_d03_2014-* ")
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
FILES11= systemfunc (" ls -1 " + DATADir11 + "subset_d03_2014-* ")
FILES12= systemfunc (" ls -1 " + DATADir12 + "subset_d03_2014-* ")
a0 = addfiles(FILES0,"r")
a1 = addfiles(FILES1,"r")
a2 = addfiles(FILES2,"r")
a3 = addfiles(FILES3,"r")
a4 = addfiles(FILES4,"r")
a5 = addfiles(FILES5,"r")
a6 = addfiles(FILES6,"r")
a7 = addfiles(FILES7,"r")
a8 = addfiles(FILES8,"r")
a9 = addfiles(FILES9,"r")
a10= addfiles(FILES10,"r")
a11= addfiles(FILES11,"r")
a12= addfiles(FILES12,"r")


;INITIALIZING ALL rstbaseline-runs POLLUTANT ARRAYS WITH AOTIZHONGXIN VALUES

pm25_sim_a0    = a0[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a0    = a0[:]->PM10(:,0,145,79)
co_sim_a0      = a0[:]->co(:,0,145,79)
no2_sim_a0     = a0[:]->no2(:,0,145,79)
so2_sim_a0     = a0[:]->so2(:,0,145,79)
o3_sim_a0      = a0[:]->o3(:,0,145,79)

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

pm25_sim_a11    = a11[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a11    = a11[:]->PM10(:,0,145,79)
co_sim_a11      = a11[:]->co(:,0,145,79)
no2_sim_a11     = a11[:]->no2(:,0,145,79)
so2_sim_a11     = a11[:]->so2(:,0,145,79)
o3_sim_a11      = a11[:]->o3(:,0,145,79)

pm25_sim_a12    = a12[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a12    = a12[:]->PM10(:,0,145,79)
co_sim_a12      = a12[:]->co(:,0,145,79)
no2_sim_a12     = a12[:]->no2(:,0,145,79)
so2_sim_a12     = a12[:]->so2(:,0,145,79)
o3_sim_a12      = a12[:]->o3(:,0,145,79)


;NOW ADDING OTHER STATION VALUES TO CORRESPONDING ARRAYS
Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)

 pm25_sim_a0    = pm25_sim_a0 + a0[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a0    = pm10_sim_a0 + a0[:]->PM10(:,0,J,I)
 co_sim_a0      = co_sim_a0 + a0[:]->co(:,0,J,I)
 no2_sim_a0     = no2_sim_a0 + a0[:]->no2(:,0,J,I)
 so2_sim_a0     = so2_sim_a0 + a0[:]->so2(:,0,J,I)
 o3_sim_a0      = o3_sim_a0 + a0[:]->o3(:,0,J,I)

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

 pm25_sim_a11    = pm25_sim_a11 + a11[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a11    = pm10_sim_a11 + a11[:]->PM10(:,0,J,I)
 co_sim_a11      = co_sim_a11 + a11[:]->co(:,0,J,I)
 no2_sim_a11     = no2_sim_a11 + a11[:]->no2(:,0,J,I)
 so2_sim_a11     = so2_sim_a11 + a11[:]->so2(:,0,J,I)
 o3_sim_a11      = o3_sim_a11 + a11[:]->o3(:,0,J,I)

 pm25_sim_a12    = pm25_sim_a12 + a12[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a12    = pm10_sim_a12 + a12[:]->PM10(:,0,J,I)
 co_sim_a12      = co_sim_a12 + a12[:]->co(:,0,J,I)
 no2_sim_a12     = no2_sim_a12 + a12[:]->no2(:,0,J,I)
 so2_sim_a12     = so2_sim_a12 + a12[:]->so2(:,0,J,I)
 o3_sim_a12      = o3_sim_a12 + a12[:]->o3(:,0,J,I)

end do

pm25_sim_a0 = pm25_sim_a0 / 12.0
pm10_sim_a0 = pm10_sim_a0/12.0
co_sim_a0   = 1000.0 * co_sim_a0/12.0
no2_sim_a0  = 1000.0 * no2_sim_a0/12.0
so2_sim_a0  = 1000.0 * so2_sim_a0/12.0
o3_sim_a0   = 1000.0 * o3_sim_a0/12.0

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

pm25_sim_a11 = pm25_sim_a11 / 12.0
pm10_sim_a11 = pm10_sim_a11/12.0
co_sim_a11   = 1000.0 * co_sim_a11/12.0
no2_sim_a11  = 1000.0 * no2_sim_a11/12.0
so2_sim_a11  = 1000.0 * so2_sim_a11/12.0
o3_sim_a11   = 1000.0 * o3_sim_a11/12.0

pm25_sim_a12 = pm25_sim_a12 / 12.0
pm10_sim_a12 = pm10_sim_a12/12.0
co_sim_a12   = 1000.0 * co_sim_a12/12.0
no2_sim_a12  = 1000.0 * no2_sim_a12/12.0
so2_sim_a12  = 1000.0 * so2_sim_a12/12.0
o3_sim_a12   = 1000.0 * o3_sim_a12/12.0

co_sim_a0_subset   = (/co_sim_a0(15:278)/)
no2_sim_a0_subset  = (/no2_sim_a0(15:278)/)
so2_sim_a0_subset  = (/so2_sim_a0(15:278)/)
o3_sim_a0_subset   = (/o3_sim_a0(15:278)/)
pm25_sim_a0_subset = (/pm25_sim_a0(15:278)/)
pm10_sim_a0_subset = (/pm10_sim_a0(15:278)/)

co_sim_a1_subset   = (/co_sim_a1(15:278)/)
no2_sim_a1_subset  = (/no2_sim_a1(15:278)/)
so2_sim_a1_subset  = (/so2_sim_a1(15:278)/)
o3_sim_a1_subset   = (/o3_sim_a1(15:278)/)
pm25_sim_a1_subset = (/pm25_sim_a1(15:278)/)
pm10_sim_a1_subset = (/pm10_sim_a1(15:278)/)

co_sim_a2_subset   = (/co_sim_a2(15:278)/)
no2_sim_a2_subset  = (/no2_sim_a2(15:278)/)
so2_sim_a2_subset  = (/so2_sim_a2(15:278)/)
o3_sim_a2_subset   = (/o3_sim_a2(15:278)/)
pm25_sim_a2_subset = (/pm25_sim_a2(15:278)/)
pm10_sim_a2_subset = (/pm10_sim_a2(15:278)/)

co_sim_a3_subset   = (/co_sim_a3(15:278)/)
no2_sim_a3_subset  = (/no2_sim_a3(15:278)/)
so2_sim_a3_subset  = (/so2_sim_a3(15:278)/)
o3_sim_a3_subset   = (/o3_sim_a3(15:278)/)
pm25_sim_a3_subset = (/pm25_sim_a3(15:278)/)
pm10_sim_a3_subset = (/pm10_sim_a3(15:278)/)

co_sim_a4_subset   = (/co_sim_a4(15:278)/)
no2_sim_a4_subset  = (/no2_sim_a4(15:278)/)
so2_sim_a4_subset  = (/so2_sim_a4(15:278)/)
o3_sim_a4_subset   = (/o3_sim_a4(15:278)/)
pm25_sim_a4_subset = (/pm25_sim_a4(15:278)/)
pm10_sim_a4_subset = (/pm10_sim_a4(15:278)/)

co_sim_a5_subset   = (/co_sim_a5(15:278)/)
no2_sim_a5_subset  = (/no2_sim_a5(15:278)/)
so2_sim_a5_subset  = (/so2_sim_a5(15:278)/)
o3_sim_a5_subset   = (/o3_sim_a5(15:278)/)
pm25_sim_a5_subset = (/pm25_sim_a5(15:278)/)
pm10_sim_a5_subset = (/pm10_sim_a5(15:278)/)

co_sim_a6_subset   = (/co_sim_a6(15:278)/)
no2_sim_a6_subset  = (/no2_sim_a6(15:278)/)
so2_sim_a6_subset  = (/so2_sim_a6(15:278)/)
o3_sim_a6_subset   = (/o3_sim_a6(15:278)/)
pm25_sim_a6_subset = (/pm25_sim_a6(15:278)/)
pm10_sim_a6_subset = (/pm10_sim_a6(15:278)/)

co_sim_a7_subset   = (/co_sim_a7(15:278)/)
no2_sim_a7_subset  = (/no2_sim_a7(15:278)/)
so2_sim_a7_subset  = (/so2_sim_a7(15:278)/)
o3_sim_a7_subset   = (/o3_sim_a7(15:278)/)
pm25_sim_a7_subset = (/pm25_sim_a7(15:278)/)
pm10_sim_a7_subset = (/pm10_sim_a7(15:278)/)

co_sim_a8_subset   = (/co_sim_a8(15:278)/)
no2_sim_a8_subset  = (/no2_sim_a8(15:278)/)
so2_sim_a8_subset  = (/so2_sim_a8(15:278)/)
o3_sim_a8_subset   = (/o3_sim_a8(15:278)/)
pm25_sim_a8_subset = (/pm25_sim_a8(15:278)/)
pm10_sim_a8_subset = (/pm10_sim_a8(15:278)/)

co_sim_a9_subset   = (/co_sim_a9(15:278)/)
no2_sim_a9_subset  = (/no2_sim_a9(15:278)/)
so2_sim_a9_subset  = (/so2_sim_a9(15:278)/)
o3_sim_a9_subset   = (/o3_sim_a9(15:278)/)
pm25_sim_a9_subset = (/pm25_sim_a9(15:278)/)
pm10_sim_a9_subset = (/pm10_sim_a9(15:278)/)

co_sim_a10_subset   = (/co_sim_a10(15:278)/)
no2_sim_a10_subset  = (/no2_sim_a10(15:278)/)
so2_sim_a10_subset  = (/so2_sim_a10(15:278)/)
o3_sim_a10_subset   = (/o3_sim_a10(15:278)/)
pm25_sim_a10_subset = (/pm25_sim_a10(15:278)/)
pm10_sim_a10_subset = (/pm10_sim_a10(15:278)/)

co_sim_a11_subset   = (/co_sim_a11(15:278)/)
no2_sim_a11_subset  = (/no2_sim_a11(15:278)/)
so2_sim_a11_subset  = (/so2_sim_a11(15:278)/)
o3_sim_a11_subset   = (/o3_sim_a11(15:278)/)
pm25_sim_a11_subset = (/pm25_sim_a11(15:278)/)
pm10_sim_a11_subset = (/pm10_sim_a11(15:278)/)

co_sim_a12_subset   = (/co_sim_a12(15:278)/)
no2_sim_a12_subset  = (/no2_sim_a12(15:278)/)
so2_sim_a12_subset  = (/so2_sim_a12(15:278)/)
o3_sim_a12_subset   = (/o3_sim_a12(15:278)/)
pm25_sim_a12_subset = (/pm25_sim_a12(15:278)/)
pm10_sim_a12_subset = (/pm10_sim_a12(15:278)/)


pm25_run1_effect = pm25_sim_a0_subset - pm25_sim_a1_subset
pm25_run2_effect = pm25_sim_a0_subset - pm25_sim_a2_subset 
pm25_run3_effect = pm25_sim_a0_subset - pm25_sim_a3_subset 
pm25_run4_effect = pm25_sim_a0_subset - pm25_sim_a4_subset 
pm25_run5_effect = pm25_sim_a0_subset - pm25_sim_a5_subset 
pm25_run6_effect = pm25_sim_a0_subset - pm25_sim_a6_subset 
pm25_run7_effect = pm25_sim_a0_subset - pm25_sim_a7_subset 
pm25_run8_effect = pm25_sim_a0_subset - pm25_sim_a8_subset 
pm25_run9_effect = pm25_sim_a0_subset - pm25_sim_a9_subset 
pm25_run10_effect = pm25_sim_a0_subset - pm25_sim_a10_subset 
pm25_run11_effect = pm25_sim_a0_subset - pm25_sim_a11_subset 
pm25_run12_effect = pm25_sim_a0_subset - pm25_sim_a12_subset 

var_matrix_pm25_effect = new((/12,264/),float)
var_matrix_pm25_effect(0,:) = pm25_run1_effect
var_matrix_pm25_effect(1,:) = pm25_run2_effect
var_matrix_pm25_effect(2,:) = pm25_run3_effect
var_matrix_pm25_effect(3,:) = pm25_run4_effect
var_matrix_pm25_effect(4,:) = pm25_run5_effect
var_matrix_pm25_effect(5,:) = pm25_run6_effect
var_matrix_pm25_effect(6,:) = pm25_run7_effect
var_matrix_pm25_effect(7,:) = pm25_run8_effect
var_matrix_pm25_effect(8,:) = pm25_run9_effect
var_matrix_pm25_effect(9,:) = pm25_run10_effect
var_matrix_pm25_effect(10,:) = pm25_run11_effect
var_matrix_pm25_effect(11,:) = pm25_run12_effect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printVarSummary(pm25_sim_a0_subset)




;var_matrix_pm25_effect = where(var_matrix_pm25_effect.lt.0,0.0,var_matrix_pm25_effect)


ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25obs      = (/data(143:478,0)/)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
header = (/"run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12"/)
hlist = [/header/]
alist = [/var_matrix_pm25_effect(0,:),var_matrix_pm25_effect(1,:),var_matrix_pm25_effect(2,:),var_matrix_pm25_effect(3,:),var_matrix_pm25_effect(4,:),var_matrix_pm25_effect(5,:),var_matrix_pm25_effect(6,:),var_matrix_pm25_effect(7,:),var_matrix_pm25_effect(8,:),var_matrix_pm25_effect(9,:),var_matrix_pm25_effect(10,:),var_matrix_pm25_effect(11,:)/]
print("alist created...now writing")
fname = "zero-out_runs_ts.txt"
;write_table(fname, "w", hlist, "%s")
;write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;---Start the graphics
wks = gsn_open_wks("x11","zerooutruns-benefit") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC2 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"red4","red3","red","orangered","navyblue","royalblue4","royalblue1","deepskyblue","forestgreen","green4","green","springgreen"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12
  timearr = ispan (1,264,1)
  timearr@units = "hours since 2014-10-21 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.04
  res@tmYLLabelFontHeightF = 0.04
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward

;  res@pmLegendDisplayMode    = "Always"            ; turn on legend
;  res@pmLegendSide           = "Top"               ; Change location of
;  res@pmLegendParallelPosF   = .85                  ; move units right
;  res@pmLegendOrthogonalPosF = 0              ; move units down
;  res@pmLegendWidthF         = 0.3                ; Change width and
;  res@pmLegendHeightF        = 0.8                ; height of legend.
;  res@lgAutoManage           = False
;  res@lgPerimOn              = False               ; turn off box around
;  res@lgLabelFontHeightF     = .04                 ; label font height
;  res@xyExplicitLegendLabels = (/"obs","baseline","pulse18","pulse19","pulse20","pulse21","pulse22","pulse23","pulse24","pulse25","pulse26","pulse27"/)         ; create explicit labels
;  res@xyExplicitLegendLabels = (/"obs","baseline","pulse","","","","","","","","",""/)         ; create explicit labels
;  res@gsnDraw  = False                          ; don't draw
;  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5 (ug/m3)"
  plot = gsn_csm_xy(wks,timearr,var_matrix_pm25_effect,res)    ; Create the four plots.

  gres = True
  gres@YPosPercent = 95.    ; expressed as %, 0->100, sets position of top border of legend 
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 5      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)

  lineres = True
  lineres@lgLineColors = (/"red"/) ; line colors
  lineres@lgLineThicknesses = 2.5                        ; line thicknesses
  lineres@LineLengthPercent = 9.                         ; expressed as %, 0->100, length of line

  textres = True
  textres@lgLabels = (/"pulse reduction"/)  ; legend labels (required)

  plot = simple_legend(wks,plot,gres,lineres,textres)
  
;  res1                     = True
;  res2                     = True
;  res1@gsnMaximize         = True
;  res2@gsnAttachPlotsXAxis = True

  ;plot1 will be the base plot.
;  amid = gsn_attach_plots(plot1,(/plot2,plot2,plot3,plot4/),res1,res2)
  ;amid = gsn_attach_plots(plot1,(/plot2/),res1,res2)

;  draw(plot1)    ; All four plots will be drawn.
;  frame(wks)

print(pm25_run11_effect)
print("time taken: " + (get_cpu_time() - begTime)/60.0)





end
