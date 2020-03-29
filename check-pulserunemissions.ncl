;ONLY FOR AOTIZHONGXIN FOR NOx
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
DATADir = "/data3/tabish/vert-MEIC-emis/pulse-wrfchemi/for6daypulse/"

FILES   = systemfunc (" ls -1 " + DATADir + "*d03")

a = addfiles(FILES,"r")

pm25_emissions  = a[:]->E_PM25J(:,0,145,79)
no2_emissions   = a[:]->E_NO2(:,0,145,79)

print(pm25_emissions)
end
