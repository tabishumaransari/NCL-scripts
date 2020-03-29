load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
z1 = asciiread("/data1/tabish/nclscripts/NCDC-combined.txt",-1,"string")

;print(HOUR)
;print(TEMP)
;TEMPC = (TEMP - 32) / 1.8
;print(TEMPC)

z1_station = str_match(z1, stnnumber); SEARCH FOR THE PARTICULAR STATION
print("dimension of this station")
print(dimsizes(z1_station))

emptyrow = stnnumber + " ***** ************ ***   * *** *** *** * * *  *** ** ** ** ** ** ** ** ** *   **   ** ****** ***** ****** *** *** ***** ***** ***** ***** **"

HOUR   = stringtofloat(str_get_cols(z1_station, 21,22)) 
fullhour=0
fill=0
z1_station_full = new(1008, string)

do i = 0,1005
 if(fullhour.eq.24) then
  fullhour = 0
 end if
 print("i="+i + " fill="+fill + " fullhour="+fullhour) 
 if(HOUR(fill).eq.fullhour) then
  z1_station_full(i) = z1_station(fill)
  fill = fill + 1
 else
  z1_station_full(i) = emptyrow  
 end if
 fullhour = fullhour + 1
end do

z1_station_full(1006) = emptyrow
z1_station_full(1007) = emptyrow

if(dimsizes(z1_station).eq.dimsizes(z1_station_full))then
 z1_station_full = z1_station
end if

USAF   = stringtofloat(str_get_cols(z1_station_full, 1,6))
YEAR   = stringtofloat(str_get_cols(z1_station_full, 13,16))
MONTH  = stringtofloat(str_get_cols(z1_station_full, 17,18))
DAY    = stringtofloat(str_get_cols(z1_station_full, 19,20))
HR     = stringtofloat(str_get_cols(z1_station_full, 21,22))
MIN    = stringtofloat(str_get_cols(z1_station_full, 23,24))
WDIR   = stringtofloat(str_get_cols(z1_station_full, 26,28))
WDIR   = where(WDIR.eq.990,9.96921e+36,WDIR)
WSPEED = stringtofloat(str_get_cols(z1_station_full, 30,32))
TEMP   = stringtofloat(str_get_cols(z1_station_full, 83,86))
DEWP   = stringtofloat(str_get_cols(z1_station_full, 88,91))
SLP    = stringtofloat(str_get_cols(z1_station_full, 93,98))
STP    = stringtofloat(str_get_cols(z1_station_full, 106,111))

TEMPC = (TEMP - 32) / 1.8
print(TEMPC +" "+WSPEED+" "+WDIR)

;print(z1_station_full)

end
