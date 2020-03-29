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
wd = wind_direction(u,v,1)
wd_subset = wd(16:711,:,:)
wd_subset_IAP = wd_subset(:,145,79)
wd_subset_d03avg1 = dim_avg(wd_subset)
wd_subset_d03avg = dim_avg(wd_subset_d03avg1)


mask3d = conform(wd_subset,mask2d,(/1,2/))

wd_subset_APEC2 = wd_subset ;INITIALIZATION
wd_subset_APEC2 = where(mask3d.ne.1,wd_subset,wd_subset_APEC2@_FillValue)
wd_subset_APEC2avg1 = dim_avg(wd_subset_APEC2)
wd_subset_APEC2avg = dim_avg(wd_subset_APEC2avg1)

wd_subset_Beijing = wd_subset ;INITIALIZATION
wd_subset_Beijing = where(mask3d.eq.3,wd_subset,wd_subset_Beijing@_FillValue)
wd_subset_Beijingavg1 = dim_avg(wd_subset_Beijing)
wd_subset_Beijingavg = dim_avg(wd_subset_Beijingavg1)

;FOR APEC3 REGION
delete([/u,v,wd,wd_subset/])
u = c[:]->U10
v = c[:]->V10
wd = wind_direction(u,v,1)
wd_subset = wd(16:711,:,:)
wd_subset_d02avg1 = dim_avg(wd_subset)
wd_subset_d02avg  = dim_avg(wd_subset_d02avg1)

printVarSummary(wd)
printVarSummary(wd_subset)
printVarSummary(wd_subset_d02avg1)
printVarSummary(wd_subset_d02avg)

print(wd_subset_d02avg+" "+wd_subset_d03avg+" "+wd_subset_APEC2avg+" "+wd_subset_Beijingavg+" "+wd_subset_IAP)

header = (/"D02avg D03avg APEC2avg Beijingavg IAP"/)
hlist = [/header/]
alist = [/wd_subset_d02avg, wd_subset_d03avg, wd_subset_APEC2avg, wd_subset_Beijingavg, wd_subset_IAP/]
print("alist created...now writing")
fname = "winddir_17Oct-15Nov_hourly.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f")
print("Success!")
end
