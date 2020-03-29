begin
DATADir = "/data3/tabish/control-run/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
b = addfile("/data3/tabish/control-run/surface-pollutants_controlrun_D03.nc","c")
pm25 = a[:]->PM2_5_DRY(:,0,:,:)
no2  = a[:]->no2(:,0,:,:)
o3   = a[:]->o3(:,0,:,:)
Times = a[:]->Times
XLAT = a[:]->XLAT
XLONG = a[:]->XLONG

b->Times = Times
b->XLAT = XLAT
b->XLONG = XLONG
b->PM2_5_DRY = pm25
b->no2 = no2
b->o3 = o3

print("Success!")


end
