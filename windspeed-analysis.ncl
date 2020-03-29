load "/home/tabish/NCL/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "/home/tabish/NCL/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/home/tabish/NCL/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "/home/tabish/NCL/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/home/tabish/NCL/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
DATADir = "/home/tabish/nclscripts/forpulseruns/"
FILES1 = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-*")
FILES2 = systemfunc (" ls -1 " + DATADir + "wrfout_d02_2014-*")
a = addfiles(FILES1,"r")
b = addfile("/home/tabish/nclscripts/BTHmask.nc","r")
c = addfiles(FILES2,"r")
mask4d = b->ABCmask_d03
mask2d = mask4d(0,0,:,:)

u = a[:]->U10
v = a[:]->V10
ws = wind_speed(u,v)
ws_subset = ws(16:711,:,:)
ws_subset_IAP = ws_subset(:,145,79)
ws_subset_d03avg1 = dim_avg(ws_subset)
ws_subset_d03avg = dim_avg(ws_subset_d03avg1)


mask3d = conform(ws_subset,mask2d,(/1,2/))

ws_subset_APEC2 = ws_subset ;INITIALIZATION
ws_subset_APEC2 = where(mask3d.ne.1,ws_subset,ws_subset_APEC2@_FillValue)
ws_subset_APEC2avg1 = dim_avg(ws_subset_APEC2)
ws_subset_APEC2avg = dim_avg(ws_subset_APEC2avg1)

ws_subset_Beijing = ws_subset ;INITIALIZATION
ws_subset_Beijing = where(mask3d.eq.3,ws_subset,ws_subset_Beijing@_FillValue)
ws_subset_Beijingavg1 = dim_avg(ws_subset_Beijing)
ws_subset_Beijingavg = dim_avg(ws_subset_Beijingavg1)

;FOR APEC3 REGION
delete([/u,v,ws,ws_subset/])
u = c[:]->U10
v = c[:]->V10
ws = wind_speed(u,v)
ws_subset = ws(16:711,:,:)
ws_subset_d02avg1 = dim_avg(ws_subset)
ws_subset_d02avg  = dim_avg(ws_subset_d02avg1)

printVarSummary(ws)
printVarSummary(ws_subset)
printVarSummary(ws_subset_d02avg1)
printVarSummary(ws_subset_d02avg)

print(ws_subset_d02avg+" "+ws_subset_d03avg+" "+ws_subset_APEC2avg+" "+ws_subset_Beijingavg+" "+ws_subset_IAP)

header = (/"D02avg D03avg APEC2avg Beijingavg IAP"/)
hlist = [/header/]
alist = [/ws_subset_d02avg, ws_subset_d03avg, ws_subset_APEC2avg, ws_subset_Beijingavg, ws_subset_IAP/]
print("alist created...now writing")
fname = "windspeed_17Oct-15Nov_hourly.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f")
print("Success!")
end
