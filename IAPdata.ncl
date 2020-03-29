begin
  filename = "/data1/tabish/surface_data/IAPdata-pollutant.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_useful = str_match(lines, ":00")
  lines_useful = str_sub_str(lines_useful,",,",",lines_useful@_FillValue,")

  delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
  delim = "," ; multiple delimiters to separate day from date to find missing times
;  print(lines_useful)
  datetime         = str_get_field(lines_useful,2,delim)
;  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;  print ("Time="+datetime)



; READ IN AEROSOL SPECIES AT GROUND SITE
  org         = tofloat(str_get_field(lines_useful,3,delim))
  so4         = tofloat(str_get_field(lines_useful,4,delim))
  no3         = tofloat(str_get_field(lines_useful,5,delim))
  nh4         = tofloat(str_get_field(lines_useful,6,delim))
  chl         = tofloat(str_get_field(lines_useful,7,delim))
  bc          = tofloat(str_get_field(lines_useful,8,delim))
; READ IN GASEOUS SPECIES AT GROUND SITE  
  co         = tofloat(str_get_field(lines_useful,15,delim))
  no         = tofloat(str_get_field(lines_useful,16,delim))
  no2        = tofloat(str_get_field(lines_useful,17,delim))
  o3         = tofloat(str_get_field(lines_useful,19,delim))
  so2        = tofloat(str_get_field(lines_useful,20,delim))
; READ IN AEROSOL SPECIES AT 260M  
  org_260    = tofloat(str_get_field(lines_useful,21,delim))
  so4_260    = tofloat(str_get_field(lines_useful,22,delim))
  no3_260    = tofloat(str_get_field(lines_useful,23,delim))
  nh4_260    = tofloat(str_get_field(lines_useful,24,delim))
  chl_260    = tofloat(str_get_field(lines_useful,25,delim))

;  PM10         = where(PM10.eq.0, 9.96921e+36, PM10)
;  PM25         = where(PM25.eq.0, 9.96921e+36, PM25)
;  PM10_subset  = PM10(272:392)
;  PM25_subset  = PM25(272:392)
;  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime     = str_get_field(lines_full,10,delim1)
;  time_float  = stringtofloat(str_get_cols(time, 10,15))


;---Print the information
print(datetime + " org="+org + " so4="+so4)


end
