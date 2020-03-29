;ONLY FOR AOTIZHONGXIN FOR NOx
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
;DATADir  = "/data2/tabish/control-run-so4-ECMWF/forpulse18oct/"
;DATADir1 = "/rasher/tabish/pulse-runs/BeijingOct18/"
DATADir = "/data3/tabish/vert-MEIC-emis/pulse-wrfchemi/for6daypulsenov/"

FILES    = systemfunc (" ls -1 " + DATADir + "*d03")
;FILES1   = systemfunc (" ls -1 " + DATADir1 + "subset_d03_2014-* ")
;FILES2   = systemfunc (" ls -1 " + DATADir2 + "*d03")
;FILES3   = systemfunc (" ls -1 " + DATADir2 + "*d01")

print(FILES)
;print(FILES1)
;print(FILES2)

a  = addfiles(FILES,"r")
;a1 = addfiles(FILES1,"r")
;a2 = addfiles(FILES2,"r")
;a3 = addfiles(FILES3,"r")

;pm25_baseline   = a[:]->PM2_5_DRY(:,0,145,79)
;pm25_pulse      = a1[:]->PM2_5_DRY(:,0,145,79)
;pm25_emissions  = a2[:]->E_PM25I(:,0,145,79)
;pm25_emissions  = a[:]->E_PM25I(:,0,62,89)
pm25_emissions  = a[:]->E_ORGJ(:,0,145,79)

;no2_baseline  = a[:]->no2(:,0,145,79)
;no2_pulse     = a1[:]->no2(:,0,145,79)
no2_emissions = a[:]->E_NO2(:,0,145,79)

;pm25_baseline = decimalPlaces(pm25_baseline ,2,True)
;pm25_pulse    = decimalPlaces(pm25_pulse ,2,True)

;no2_baseline = decimalPlaces(no2_baseline ,2,True)
;no2_pulse    = decimalPlaces(no2_pulse ,2,True)

;print("baseline="+pm25_baseline+" pulse="+pm25_pulse)
;pm25pcbenefit = (pm25_baseline-pm25_pulse)*100.0/pm25_baseline
;no2pcbenefit = (no2_baseline-no2_pulse)*100.0/no2_baseline

;pm25pcbenefit = decimalPlaces(pm25pcbenefit ,2,True)
;no2pcbenefit = decimalPlaces(no2pcbenefit ,2,True)

;print(no2_emissions+"	"+no2pcbenefit)
print(pm25_emissions)
end
