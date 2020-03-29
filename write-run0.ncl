; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
DATADir0 = "/mnt/rasher/zero-out_runs/run0/"
FILES0 = systemfunc (" ls -1 " + DATADir0 + "subset_d03_2014-* ")
a0 = addfiles(FILES0,"r")
pm25_sim_a0    = a0[:]->PM2_5_DRY(:,0,145,79)

;NOW ADDING OTHER STATION VALUES TO CORRESPONDING ARRAYS
Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)

 pm25_sim_a0    = pm25_sim_a0 + a0[:]->PM2_5_DRY(:,0,J,I)
end do

pm25_sim_a0 = pm25_sim_a0 / 12.0
pm25_sim_a0_subset = (/pm25_sim_a0(15:278)/)

;print(pm25_sim_a0_subset)
;;;;;;DAILY MEAN ANALYSIS;;;;
;sh=0
;do i =0,10,1
; print("Day="+(i+21))
; print(avg(pm25_sim_a0_subset(sh:sh+23)))
; sh = sh + 24
;end do


header = (/"run0"/)
hlist = [/header/]
alist = [/pm25_sim_a0_subset/]
print("alist created...now writing")
fname = "run0_ts.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f")



end
