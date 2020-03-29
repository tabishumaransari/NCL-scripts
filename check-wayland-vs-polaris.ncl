;ONLY FOR AOTIZHONGXIN FOR NOx
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
DATADir1 = "/rasher/tabish/zero-emis_run_wayland/"
DATADir2 = "/rasher/tabish/zero-emis_run_polaris/"
FILES1   = systemfunc (" ls -1 " + DATADir1 + "subset_d03_2014-* ")
FILES2   = systemfunc (" ls -1 " + DATADir2 + "subset_d03_2014-* ")
a1 = addfiles(FILES1,"r")
a2 = addfiles(FILES2,"r")

pm25_wayland = a1[:]->PM2_5_DRY(:,0,145,79)
pm25_polaris = a2[:]->PM2_5_DRY(:,0,145,79)

;pm25_baseline = decimalPlaces(pm25_baseline ,2,True)
;pm25_pulse    = decimalPlaces(pm25_pulse ,2,True)
print("wayland="+pm25_wayland+" polaris="+pm25_polaris)
;print((pm25_baseline-pm25_pulse)*100.0/pm25_baseline)


end
