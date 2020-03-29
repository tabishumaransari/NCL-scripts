begin
  filename = "/data1/tabish/surface_data/Beijing_AQ_data_APEC2014.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_Aotizhongxin = str_match(lines, "Aotizhongxin")
  delim = ", :" ; multiple delimiters to separate day from date to find missing times
  delim1 = "," ; multiple delimiters to separate day from date to find missing times
;print(lines_Aotizhongxin)
  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;  cumtime = new(dimsizes(time),float)
;  cumtime(0) = 0
;  do i=1,dimsizes(time)-1
;   cumtime(i) = cumtime(i-1) + time(i)
;  end do

;print ("Time="+time + " cumtime="+cumtime)



lines_full = new(1008,string)

fill =0
do i = 0, 935
; print("i="+i + " fill="+fill)
 n=(time(i+1)-time(i)) 
 if((n.eq.1).or.(n.eq.-23))then
  lines_full(fill) = lines_Aotizhongxin(i)
  fill = fill + 1
;  print("Fill="+fill)
 else
  lines_full(fill) = lines_Aotizhongxin(i)
  fill=fill+1
  do j=1,n-1
   lines_full(fill) = ",Aotizhongxin,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,1011A,missing missing missing"
   fill = fill +1
;   print("Fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_Aotizhongxin(936)
  stationname  = str_get_field(lines_full,1,delim)
  PM10         = tofloat(str_get_field(lines_full,6,delim))
  PM25         = tofloat(str_get_field(lines_full,7,delim))
  PM10         = where(PM10.eq.0, 9.96921e+36, PM10)
  PM25         = where(PM25.eq.0, 9.96921e+36, PM25)
  PM10_subset  = PM10(272:392)
  PM25_subset  = PM25(272:392)
  timefull     = tofloat(str_get_field(lines_full,11,delim))
  datetime     = str_get_field(lines_full,10,delim1)

;  time_float  = stringtofloat(str_get_cols(time, 10,15))
;---Print the information
; print("Station is '" + stationname + "', PM10 = " + PM10 + ", PM2.5 = " + PM25 + ", Date is " + datetime)
print("PM2.5= "+PM25_subset)


end

