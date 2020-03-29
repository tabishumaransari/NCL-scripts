; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/home/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 5
data1 = readAsciiTable("windspeed_17Oct-15Nov_hourly.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2 = readAsciiTable("winddir_17Oct-15Nov_hourly.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data1@_FillValue = -999 
data2@_FillValue = -999 
print("tables read-in successfully")

ws_Beijingavg = (/data1(:,3)/)
wd_Beijingavg = (/data2(:,3)/)

ws_dailymean = new(29,float)
wd_dailymean = new(29,float)

sh =0
do i = 0,28
 print(sh)
 ws_dailymean(i) = avg(ws_Beijingavg(sh:sh+23))
 wd_dailymean(i) = avg(wd_Beijingavg(sh:sh+23))
 sh = sh + 24
end do

;;;;;WRITING ASCII FILE OF DAILY MEAN WIND SPEED AND DIRECTION;;;;;;
header = (/"WS_daily WD_daily"/)
hlist = [/header/]
alist = [/ws_dailymean,wd_dailymean/]
print("alist created...now writing")
fname = "windspeed_winddir_dailymean_18Oct-15Nov.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f")

end
