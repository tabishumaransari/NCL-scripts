load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
begin

DATADir = "/data2/tabish/forMSCstudent/Beijing-run/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
b = addfile("/data2/tabish/forMSCstudent/Beijing-run/surfacepol_d03_Beijingrun.nc","c")
times       = a[:]->Times
;times       = wrf_user_getvar(a,"times",-1)
printVarSummary(times)

XLAT    = a[:]->XLAT
XLONG   = a[:]->XLONG
pm25    = a[:]->PM2_5_DRY
no2     = a[:]->no2
o3      = a[:]->o3

pm25_sur = pm25(:,0,:,:)
no2_sur  = no2(:,0,:,:)
o3_sur   = o3(:,0,:,:)

no2_sur  = 1000* no2_sur
o3_sur   = 1000* o3_sur

b->Times = times
b->XLAT  = XLAT 
b->XLONG = XLONG 
b->pm25  = pm25_sur 
b->no2   = no2_sur 
b->o3    = o3_sur

print("Success")
end
