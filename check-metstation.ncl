load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


begin
z1 = asciiread("/data1/tabish/nclscripts/stn-combined.txt",-1,"string")
stnnumber   = stringtofloat(str_get_cols(z1, 0,6))
stnname   = str_get_cols(z1, 13,33)
lat       = stringtofloat(str_get_cols(z1, 128,134))
lon       = stringtofloat(str_get_cols(z1, 137,144))
print(stnname)

a = addfile("/data3/tabish/control-run/wrfout_d01_2014-10-11_00:00:00.nc","r")
b = addfile("/data3/tabish/control-run/wrfout_d02_2014-10-11_00:00:00.nc","r")
c = addfile("/data3/tabish/control-run/wrfout_d03_2014-10-11_00:00:00.nc","r")
opt = True

c0=0
c1=0
c2=0
c3=0
c4=0

do i=0,405

 loc1  = wrf_user_ll_to_ij(a,lon(i),lat(i),opt)    ;lon,lat for various stations
 loc2  = wrf_user_ll_to_ij(b,lon(i),lat(i),opt)    ;lon,lat for various stations
 loc3  = wrf_user_ll_to_ij(c,lon(i),lat(i),opt)    ;lon,lat for various stations
 loc1 = loc1 -1
 loc2 = loc2 -1
 loc3 = loc3 -1
 lon1 = loc1(0)
 lat1 = loc1(1)
 lon2 = loc2(0)
 lat2 = loc2(1)
 lon3 = loc3(0)
 lat3 = loc3(1)

if(lat(i).ge.39.44).and.(lat(i).le.41.07).and.(lon(i).le.117.52).and.(lon(i).ge.115.40) then
 print(stnnumber(i)+" "+stnname(i)+" "+sprintf("%9.3f", lat(i))+" "+sprintf("%9.3f", lon(i))+" lies within D01-D02-D03-Beijing")
 c4 =c4 + 1
else
 if((lat3.le.243).and.(lat3.ge.0).and.(lon3.le.177).and.(lon3.ge.0))then
   print(stnnumber(i)+" "+stnname(i)+" "+sprintf("%9.3f", lat(i))+" "+sprintf("%9.3f", lon(i))+" lies within D01-D02-D03")
   c3 = c3 + 1
 else
  if((lat2.le.123).and.(lat2.ge.0).and.(lon2.le.135).and.(lon2.ge.0))then
   print(stnnumber(i)+" "+stnname(i)+" "+sprintf("%9.3f", lat(i))+" "+sprintf("%9.3f", lon(i))+" lies outside D03 but within D02")
   c2 = c2 + 1
  else
   if((lat1.le.120).and.(lat1.ge.0).and.(lon1.le.147).and.(lon1.ge.0))then
    print(stnnumber(i)+" "+stnname(i)+" "+sprintf("%9.3f", lat(i))+" "+sprintf("%9.3f", lon(i))+" lies outside D03 and D02 but within D01")
    c1 = c1 + 1
   else
    print(stnnumber(i)+" "+stnname(i)+" "+sprintf("%9.3f", lat(i))+" "+sprintf("%9.3f", lon(i))+" lies outside D01")
    c0 = c0 + 1
   end if
  end if
 end if
end if
end do

print("Total no. of stations within Beijing area= "+c4)
print("Total no. of stations within D03= "+(c3+c4))
print("Total no. of stations within D02= "+(c2+c3+c4))
print("Total no. of stations within D01= "+(c1+c2+c3+c4))
print("Total no. of stations outside D01= "+c0)


end
