;SIMILAR TO WRITE-12STMEAN.NCL EXCEPT IT WRITES ZEROEMIS-RUN INSTEAD OF OCT-CONTROLS

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
undef("stationpol") ; function name
function stationpol(stationname:string) 
begin ; begin function
filename = "/data1/tabish/surface_data/Beijing_AQ_data_APEC2014_dingling.csv"
lines_full = new(1008,string)

;---Read in file as 1d array of strings so we can parse each line
lines = asciiread(filename,-1,"string")

print(stationname)
  lines_station = str_match(lines, stationname)
  delim = ", :" ; multiple delimiters to separate day from date to find missing times
  delim1 = "," ; multiple delimiters to separate day from date to find missing times
  time         = tofloat(str_get_field(lines_station,11,delim))
;print(time)

fill =0
do i = 0, dimsizes(lines_station)-2
 print("i="+i + " fill="+fill)
 n=(time(i+1)-time(i))
 if((n.eq.1).or.(n.eq.-23))then
  lines_full(fill) = lines_station(i)
  fill = fill + 1
  print("fill="+fill)
 else
  lines_full(fill) = lines_station(i)
  fill=fill+1
  print("fill="+fill)
  do j=1,n-1
   lines_full(fill) = ","+stationname+",9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,1011A,missing missing missing"
   fill = fill +1
;  print("fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_station(dimsizes(lines_station)-1)
print(lines_full)
;  stationname  = str_get_field(lines_full,1,delim)

  co_trim     = new(1007,float)
  so2_trim    = new(1007,float)
  no2_trim    = new(1007,float)
  o3_trim     = new(1007,float)
  PM10_trim   = new(1007,float)
  PM25_trim   = new(1007,float)
 


  co         = tofloat(str_get_field(lines_full,2,delim))
  so2        = tofloat(str_get_field(lines_full,8,delim))
  no2        = tofloat(str_get_field(lines_full,3,delim))
  o3         = tofloat(str_get_field(lines_full,4,delim))
  PM10       = tofloat(str_get_field(lines_full,6,delim))
  PM25       = tofloat(str_get_field(lines_full,7,delim))

  co         = where(co.eq.0 .or. co.eq.9.96921e+36, co@_FillValue, co)
  co         = 1000*co
  so2        = where(so2.eq.0 .or. so2.eq.9.96921e+36, so2@_FillValue, so2)
  no2        = where(no2.eq.0 .or. no2.eq.9.96921e+36, no2@_FillValue, no2)
  o3         = where(o3.eq.0 .or. o3.eq.9.96921e+36, o3@_FillValue, o3)
  PM10       = where(PM10.eq.0 .or. PM10.eq.9.96921e+36, PM10@_FillValue, PM10)
  PM25       = where(PM25.eq.0 .or. PM25.eq.9.96921e+36, PM25@_FillValue, PM25)

;CORRECTING EACH POLLUTANT ARRAY FOR 16OCT 0800 HRS

  co_trim(0:151)      = co(0:151)
  co_trim(152:1006)   = co(153:1007)
  so2_trim(0:151)     = so2(0:151)
  so2_trim(152:1006)  = so2(153:1007)
  no2_trim(0:151)     = no2(0:151)
  no2_trim(152:1006)  = no2(153:1007)
  o3_trim(0:151)      = o3(0:151)
  o3_trim(152:1006)   = o3(153:1007)
  PM10_trim(0:151)    = PM10(0:151)
  PM10_trim(152:1006) = PM10(153:1007)
  PM25_trim(0:151)    = PM25(0:151)
  PM25_trim(152:1006) = PM25(153:1007)


delete(lines_station)
delete(time)

return([/co_trim, so2_trim, no2_trim, o3_trim, PM25_trim, PM10_trim/])

end   ; end function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("polmean") ; function name
function polmean(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12)
begin ; begin function
c = 0.0
s =0.0
polavg = new (dimsizes(p1),typeof(p1),p1@_FillValue)
do t=0,1006

 if (.not.ismissing(p1(t))) then
  s = s + p1(t)
  c = c +1
 end if

 if (.not.ismissing(p2(t))) then
  s = s + p2(t)
  c = c +1
 end if

 if (.not.ismissing(p3(t))) then
  s = s + p3(t)
  c = c +1
 end if

 if (.not.ismissing(p4(t))) then
  s = s + p4(t)
  c = c +1
 end if

 if (.not.ismissing(p5(t))) then
  s = s + p5(t)
  c = c +1
 end if

 if (.not.ismissing(p6(t))) then
  s = s + p6(t)
  c = c +1
 end if

 if (.not.ismissing(p7(t))) then
  s = s + p7(t)
  c = c +1
 end if

 if (.not.ismissing(p8(t))) then
  s = s + p8(t)
  c = c +1
 end if

 if (.not.ismissing(p9(t))) then
  s = s + p9(t)
  c = c +1
 end if

 if (.not.ismissing(p10(t))) then
  s = s + p10(t)
  c = c +1
 end if

 if (.not.ismissing(p11(t))) then
  s = s + p11(t)
  c = c +1
 end if

 if (.not.ismissing(p12(t))) then
  s = s + p12(t)
  c = c +1
 end if

 if(c.eq.0.0) then
  polavg(t) = polavg@_FillValue
 else
  polavg(t) = s/c
 end if
 s=0.0
 c=0.0
end do
return(polavg)
end ; end function
;;;;;;;;;;;;;;;;MAIN PROGRAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
begin

pm25_sim =new(169,float)  ; 120 for 21-25 Oct runs
pm10_sim =new(169,float)  
pmcoarse_sim =new(169,float)  
co_sim =new(169,float)  
no2_sim =new(169,float)  
so2_sim =new(169,float)  
o3_sim =new(169,float)  

PM25_sum =new(1008,float,0)  
PM10_sum =new(1008,float)  
;PMcoarse_sum =new(1008,float,0)  
co_sum =new(1008,float,0)  
no2_sum =new(1008,float,0)  
so2_sum =new(1008,float,0)  
o3_sum =new(1008,float,0)  

DATADir1 = "/data2/tabish/control-run-so4-ECMWF/"
DATADir2 = "/data2/tabish/best-guess_run/"
DATADir3 = "/rasher/tabish/zero-emis_run_polaris/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
FILES3 = systemfunc (" ls -1 " + DATADir3 + "subset_d03_2014-* ")
a = addfiles(FILES1,"r")
b = addfiles(FILES2,"r")
c = addfiles(FILES3,"r")
times  = wrf_times_c(a[:]->Times,0)
;print(times)
;times_crop = times(16:135)

;INITIALIZING WITH THE FIRST STATION VALUES(Aotizhongxin)
pm25_sim_a    = a[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_a    = a[:]->PM10(:,0,145,79)
co_sim_a      = a[:]->co(:,0,145,79)
no2_sim_a     = a[:]->no2(:,0,145,79)
so2_sim_a     = a[:]->so2(:,0,145,79)
o3_sim_a      = a[:]->o3(:,0,145,79)
pblh          = a[:]->PBLH(:,145,79)

pm25_sim_b    = b[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_b    = b[:]->PM10(:,0,145,79)
co_sim_b      = b[:]->co(:,0,145,79)
no2_sim_b     = b[:]->no2(:,0,145,79)
so2_sim_b     = b[:]->so2(:,0,145,79)
o3_sim_b      = b[:]->o3(:,0,145,79)

pm25_sim_c    = c[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_c    = c[:]->PM10(:,0,145,79)
co_sim_c      = c[:]->co(:,0,145,79)
no2_sim_c     = c[:]->no2(:,0,145,79)
so2_sim_c     = c[:]->so2(:,0,145,79)
o3_sim_c      = c[:]->o3(:,0,145,79)


Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)
 pm25_sim_a    = pm25_sim_a + a[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_a    = pm10_sim_a + a[:]->PM10(:,0,J,I)
 co_sim_a      = co_sim_a + a[:]->co(:,0,J,I)
 no2_sim_a     = no2_sim_a + a[:]->no2(:,0,J,I)
 so2_sim_a     = so2_sim_a + a[:]->so2(:,0,J,I)
 o3_sim_a      = o3_sim_a + a[:]->o3(:,0,J,I)
 pblh          = pblh + a[:]->PBLH(:,J,I)

 pm25_sim_b    = pm25_sim_b + b[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_b    = pm10_sim_b + b[:]->PM10(:,0,J,I)
 co_sim_b      = co_sim_b + b[:]->co(:,0,J,I)
 no2_sim_b     = no2_sim_b + b[:]->no2(:,0,J,I)
 so2_sim_b     = so2_sim_b + b[:]->so2(:,0,J,I)
 o3_sim_b      = o3_sim_b + b[:]->o3(:,0,J,I)

 pm25_sim_c    = pm25_sim_c + c[:]->PM2_5_DRY(:,0,J,I)
 pm10_sim_c    = pm10_sim_c + c[:]->PM10(:,0,J,I)
 co_sim_c      = co_sim_c + c[:]->co(:,0,J,I)
 no2_sim_c     = no2_sim_c + c[:]->no2(:,0,J,I)
 so2_sim_c     = so2_sim_c + c[:]->so2(:,0,J,I)
 o3_sim_c      = o3_sim_c + c[:]->o3(:,0,J,I)
end do

pm25_sim_a = pm25_sim_a/12.0
pm10_sim_a = pm10_sim_a/12.0
pmcoarse_sim_a = pm10_sim_a - pm25_sim_a
co_sim_a      = 1000.0* co_sim_a/12.0
no2_sim_a     = 1000.0* no2_sim_a/12.0
so2_sim_a     = 1000.0* so2_sim_a/12.0
o3_sim_a      = 1000.0* o3_sim_a/12.0
pblh          = pblh/12.0

pm25_sim_b = pm25_sim_b/12.0
pm10_sim_b = pm10_sim_b/12.0
pmcoarse_sim_b = pm10_sim_b - pm25_sim_b
co_sim_b      = 1000.0* co_sim_b/12.0
no2_sim_b     = 1000.0* no2_sim_b/12.0
so2_sim_b     = 1000.0* so2_sim_b/12.0
o3_sim_b      = 1000.0* o3_sim_b/12.0

pm25_sim_c = pm25_sim_c/12.0
pm10_sim_c = pm10_sim_c/12.0
pmcoarse_sim_c = pm10_sim_c - pm25_sim_c
co_sim_c      = 1000.0* co_sim_c/12.0
no2_sim_c     = 1000.0* no2_sim_c/12.0
so2_sim_c     = 1000.0* so2_sim_c/12.0
o3_sim_c      = 1000.0* o3_sim_c/12.0

co_sim_a_subset   = (/co_sim_a(40:975)/)
no2_sim_a_subset  = (/no2_sim_a(40:975)/)
so2_sim_a_subset  = (/so2_sim_a(40:975)/)
o3_sim_a_subset   = (/o3_sim_a(40:975)/)
pm25_sim_a_subset = (/pm25_sim_a(40:975)/)
pm10_sim_a_subset = (/pm10_sim_a(40:975)/)
pblh_subset       = (/pblh(40:975)/)

co_sim_b_subset   = new(936,float)
no2_sim_b_subset  = new(936,float)
so2_sim_b_subset  = new(936,float)
o3_sim_b_subset   = new(936,float)
pm25_sim_b_subset = new(936,float)
pm10_sim_b_subset = new(936,float)

co_sim_c_subset   = new(936,float)
no2_sim_c_subset  = new(936,float)
so2_sim_c_subset  = new(936,float)
o3_sim_c_subset   = new(936,float)
pm25_sim_c_subset = new(936,float)
pm10_sim_c_subset = new(936,float)

co_sim_b_subset(512:935)     = (/co_sim_b(0:423)/)
no2_sim_b_subset(512:935)    = (/no2_sim_b(0:423)/)
so2_sim_b_subset(512:935)    = (/so2_sim_b(0:423)/)
o3_sim_b_subset(512:935)     = (/o3_sim_b(0:423)/)
pm25_sim_b_subset(512:935)   = (/pm25_sim_b(0:423)/)
pm10_sim_b_subset(512:935)   = (/pm10_sim_b(0:423)/)

co_sim_c_subset(128:391)     = (/co_sim_c/)
no2_sim_c_subset(128:391)    = (/no2_sim_c/)
so2_sim_c_subset(128:391)    = (/so2_sim_c/)
o3_sim_c_subset(128:391)     = (/o3_sim_c/)
pm25_sim_c_subset(128:391)   = (/pm25_sim_c/)
pm10_sim_c_subset(128:391)   = (/pm10_sim_c/)






times = times + 8




;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Aotizhongxin_pol = stationpol("Aotizhongxin")
Wanshouxigong_pol = stationpol("Wanshouxigong")
Dongsi_pol = stationpol("Dongsi")
Dingling_pol = stationpol("Dingling")
Tiantan_pol = stationpol("Tiantan")
Nongzhanguan_pol = stationpol("Nongzhanguan")
Guanyuan_pol = stationpol("Guanyuan")
Haidianwanliu_pol = stationpol("Haidianwanliu")
Shunyixincheng_pol = stationpol("Shunyixincheng")
Huairouzhen_pol = stationpol("Huairouzhen")
Changpingzheng_pol = stationpol("Changpingzheng")
Gucheng_pol = stationpol("Gucheng")

printVarSummary(Aotizhongxin_pol)

co_Aotizhongxin   = Aotizhongxin_pol[0]
so2_Aotizhongxin  = Aotizhongxin_pol[1]
no2_Aotizhongxin  = Aotizhongxin_pol[2]
o3_Aotizhongxin   = Aotizhongxin_pol[3]
pm25_Aotizhongxin = Aotizhongxin_pol[4]
pm10_Aotizhongxin = Aotizhongxin_pol[5]

co_Wanshouxigong   = Wanshouxigong_pol[0]
so2_Wanshouxigong  = Wanshouxigong_pol[1]
no2_Wanshouxigong  = Wanshouxigong_pol[2]
o3_Wanshouxigong   = Wanshouxigong_pol[3]
pm25_Wanshouxigong = Wanshouxigong_pol[4]
pm10_Wanshouxigong = Wanshouxigong_pol[5]

co_Dongsi   = Dongsi_pol[0]
so2_Dongsi  = Dongsi_pol[1]
no2_Dongsi  = Dongsi_pol[2]
o3_Dongsi   = Dongsi_pol[3]
pm25_Dongsi = Dongsi_pol[4]
pm10_Dongsi = Dongsi_pol[5]

co_Dingling   = Dingling_pol[0]
so2_Dingling  = Dingling_pol[1]
no2_Dingling  = Dingling_pol[2]
o3_Dingling   = Dingling_pol[3]
pm25_Dingling = Dingling_pol[4]
pm10_Dingling = Dingling_pol[5]

co_Tiantan   = Tiantan_pol[0]
so2_Tiantan  = Tiantan_pol[1]
no2_Tiantan  = Tiantan_pol[2]
o3_Tiantan   = Tiantan_pol[3]
pm25_Tiantan = Tiantan_pol[4]
pm10_Tiantan = Tiantan_pol[5]

co_Nongzhanguan   = Nongzhanguan_pol[0]
so2_Nongzhanguan  = Nongzhanguan_pol[1]
no2_Nongzhanguan  = Nongzhanguan_pol[2]
o3_Nongzhanguan   = Nongzhanguan_pol[3]
pm25_Nongzhanguan = Nongzhanguan_pol[4]
pm10_Nongzhanguan = Nongzhanguan_pol[5]

co_Guanyuan   = Guanyuan_pol[0]
so2_Guanyuan  = Guanyuan_pol[1]
no2_Guanyuan  = Guanyuan_pol[2]
o3_Guanyuan   = Guanyuan_pol[3]
pm25_Guanyuan = Guanyuan_pol[4]
pm10_Guanyuan = Guanyuan_pol[5]

co_Haidianwanliu   = Haidianwanliu_pol[0]
so2_Haidianwanliu  = Haidianwanliu_pol[1]
no2_Haidianwanliu  = Haidianwanliu_pol[2]
o3_Haidianwanliu   = Haidianwanliu_pol[3]
pm25_Haidianwanliu = Haidianwanliu_pol[4]
pm10_Haidianwanliu = Haidianwanliu_pol[5]

co_Shunyixincheng   = Shunyixincheng_pol[0]
so2_Shunyixincheng  = Shunyixincheng_pol[1]
no2_Shunyixincheng  = Shunyixincheng_pol[2]
o3_Shunyixincheng   = Shunyixincheng_pol[3]
pm25_Shunyixincheng = Shunyixincheng_pol[4]
pm10_Shunyixincheng = Shunyixincheng_pol[5]

co_Huairouzhen   = Huairouzhen_pol[0]
so2_Huairouzhen  = Huairouzhen_pol[1]
no2_Huairouzhen  = Huairouzhen_pol[2]
o3_Huairouzhen   = Huairouzhen_pol[3]
pm25_Huairouzhen = Huairouzhen_pol[4]
pm10_Huairouzhen = Huairouzhen_pol[5]

co_Changpingzheng   = Changpingzheng_pol[0]
so2_Changpingzheng  = Changpingzheng_pol[1]
no2_Changpingzheng  = Changpingzheng_pol[2]
o3_Changpingzheng   = Changpingzheng_pol[3]
pm25_Changpingzheng = Changpingzheng_pol[4]
pm10_Changpingzheng = Changpingzheng_pol[5]

co_Gucheng   = Gucheng_pol[0]
so2_Gucheng  = Gucheng_pol[1]
no2_Gucheng  = Gucheng_pol[2]
o3_Gucheng   = Gucheng_pol[3]
pm25_Gucheng = Gucheng_pol[4]
pm10_Gucheng = Gucheng_pol[5]


;NOW ALL VALUES ARE STORED IN THE RESPECTIVE STATION VARIABLE- WE NEED TO SUM THEM UP

co_obsmean = polmean(co_Aotizhongxin, co_Wanshouxigong, co_Dongsi, co_Dingling, co_Tiantan, co_Nongzhanguan, co_Guanyuan, co_Haidianwanliu, co_Shunyixincheng, co_Huairouzhen, co_Changpingzheng, co_Gucheng)
so2_obsmean = polmean(so2_Aotizhongxin, so2_Wanshouxigong, so2_Dongsi, so2_Dingling, so2_Tiantan, so2_Nongzhanguan, so2_Guanyuan, so2_Haidianwanliu, so2_Shunyixincheng, so2_Huairouzhen, so2_Changpingzheng, so2_Gucheng)
no2_obsmean = polmean(no2_Aotizhongxin, no2_Wanshouxigong, no2_Dongsi, no2_Dingling, no2_Tiantan, no2_Nongzhanguan, no2_Guanyuan, no2_Haidianwanliu, no2_Shunyixincheng, no2_Huairouzhen, no2_Changpingzheng, no2_Gucheng)
o3_obsmean = polmean(o3_Aotizhongxin, o3_Wanshouxigong, o3_Dongsi, o3_Dingling, o3_Tiantan, o3_Nongzhanguan, o3_Guanyuan, o3_Haidianwanliu, o3_Shunyixincheng, o3_Huairouzhen, o3_Changpingzheng, o3_Gucheng)
pm25_obsmean = polmean(pm25_Aotizhongxin, pm25_Wanshouxigong, pm25_Dongsi, pm25_Dingling, pm25_Tiantan, pm25_Nongzhanguan, pm25_Guanyuan, pm25_Haidianwanliu, pm25_Shunyixincheng, pm25_Huairouzhen, pm25_Changpingzheng, pm25_Gucheng)
pm10_obsmean = polmean(pm10_Aotizhongxin, pm10_Wanshouxigong, pm10_Dongsi, pm10_Dingling, pm10_Tiantan, pm10_Nongzhanguan, pm10_Guanyuan, pm10_Haidianwanliu, pm10_Shunyixincheng, pm10_Huairouzhen, pm10_Changpingzheng, pm10_Gucheng)




  co_obsmean_subset    = (/co_obsmean(48:983)/)/1.1642 ;CONSIDERING ONLY 12OCT 0000HRS BJT - 20NOV 0000 HRS BJT and also converting ug/m3 to ppb
  so2_obsmean_subset   = (/so2_obsmean(48:983)/)/2.6609
  no2_obsmean_subset   = (/no2_obsmean(48:983)/)/1.9125
  o3_obsmean_subset    = (/o3_obsmean(48:983)/)/1.9957
  pm10_obsmean_subset  = (/pm10_obsmean(48:983)/)
  pm25_obsmean_subset  = (/pm25_obsmean(48:983)/)
;  PMcoarse_subset = new(dimsizes(PM10_subset), typeof(PM10_subset), PM10_subset@_FillValue)
  
;  do count =0,(dimsizes(PM10_subset)-1)
;   print("PM10="+PM10_subset(count) + " PM2.5=" + PM25_subset(count))
;   if(ismissing(PM10_subset(count)).or.ismissing(PM25_subset(count))) then
;    PMcoarse_subset(count) = PM10_subset@_FillValue
;   else
;    PMcoarse_subset(count) = PM10_subset(count) - PM25_subset(count)
;   end if
;  end do

; timefull     = tofloat(str_get_field(lines_full,11,delim))
; datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;printVarSummary(PM25_subset)

 ; pmcoarse_obs = pm10_obs - pm25_obs
  var_matrix_pm25  = new((/4,936/),float) ;120 for 21-25oct 
  var_matrix_pm10  = new((/4,936/),float)  
  var_matrix_pmcoarse  = new((/4,936/),float)  
  var_matrix_co  = new((/4,936/),float)  
  var_matrix_no2  = new((/4,936/),float)  
  var_matrix_so2  = new((/4,936/),float)  
  var_matrix_o3  = new((/4,936/),float)  
  
var_matrix_pm25(0,:) = (/pm25_obsmean_subset/)
var_matrix_pm25(1,:) = (/pm25_sim_a_subset/)
var_matrix_pm25(2,:) = (/pm25_sim_b_subset/)
var_matrix_pm25(3,:) = (/pm25_sim_c_subset/)

pm25Octavg_Obs = avg(pm25_obsmean_subset(143:358))
pm25Octavg_baseline = avg(pm25_sim_a_subset(143:358))
pm25Octavg_control = avg(pm25_sim_c_subset(143:358))
 
pm25Novavg_Obs = avg(pm25_obsmean_subset(527:742))    
pm25Novavg_baseline = avg(pm25_sim_a_subset(527:742))
pm25Novavg_control = avg(pm25_sim_b_subset(527:742))



var_matrix_pm10(0,:) = (/pm10_obsmean_subset/)
var_matrix_pm10(1,:) = (/pm10_sim_a_subset/)
var_matrix_pm10(2,:) = (/pm10_sim_b_subset/)
var_matrix_pm10(3,:) = (/pm10_sim_c_subset/)

pm10Octavg_Obs = avg(pm10_obsmean_subset(143:358))
pm10Octavg_baseline = avg(pm10_sim_a_subset(143:358))
pm10Octavg_control = avg(pm10_sim_c_subset(143:358))
                     
pm10Novavg_Obs = avg(pm10_obsmean_subset(527:742))
pm10Novavg_baseline = avg(pm10_sim_a_subset(527:742))
pm10Novavg_control = avg(pm10_sim_b_subset(527:742))


;var_matrix_pmcoarse(0,:) = (/pmcoarse_sim/)
;var_matrix_pmcoarse(1,:) = PMcoarse_subset

var_matrix_co(0,:) = (/co_obsmean_subset/)
var_matrix_co(1,:) = (/co_sim_a_subset/)
var_matrix_co(2,:) = (/co_sim_b_subset/)
var_matrix_co(3,:) = (/co_sim_c_subset/)

coOctavg_Obs = avg(co_obsmean_subset(143:358))
coOctavg_baseline = avg(co_sim_a_subset(143:358))
coOctavg_control = avg(co_sim_c_subset(143:358))

coNovavg_Obs = avg(co_obsmean_subset(527:742))
coNovavg_baseline = avg(co_sim_a_subset(527:742))
coNovavg_control = avg(co_sim_b_subset(527:742))


var_matrix_no2(0,:) = (/no2_obsmean_subset/)
var_matrix_no2(1,:) = (/no2_sim_a_subset/)
var_matrix_no2(2,:) = (/no2_sim_b_subset/)
var_matrix_no2(3,:) = (/no2_sim_c_subset/)

no2Octavg_Obs = avg(no2_obsmean_subset(143:358))
no2Octavg_baseline = avg(no2_sim_a_subset(143:358))
no2Octavg_control = avg(no2_sim_c_subset(143:358))

no2Novavg_Obs = avg(no2_obsmean_subset(527:742))
no2Novavg_baseline = avg(no2_sim_a_subset(527:742))
no2Novavg_control = avg(no2_sim_b_subset(527:742))


var_matrix_so2(0,:) = (/so2_obsmean_subset/)
var_matrix_so2(1,:) = (/so2_sim_a_subset/)
var_matrix_so2(2,:) = (/so2_sim_b_subset/)
var_matrix_so2(3,:) = (/so2_sim_c_subset/)

so2Octavg_Obs = avg(so2_obsmean_subset(143:358))
so2Octavg_baseline = avg(so2_sim_a_subset(143:358))
so2Octavg_control = avg(so2_sim_c_subset(143:358))

so2Novavg_Obs = avg(so2_obsmean_subset(527:742))
so2Novavg_baseline = avg(so2_sim_a_subset(527:742))
so2Novavg_control = avg(so2_sim_b_subset(527:742))


var_matrix_o3(0,:) = (/o3_obsmean_subset/)
var_matrix_o3(1,:) = (/o3_sim_a_subset/)
var_matrix_o3(2,:) = (/o3_sim_b_subset/)
var_matrix_o3(3,:) = (/o3_sim_c_subset/)

o3Octavg_Obs = avg(o3_obsmean_subset(143:358))
o3Octavg_baseline = avg(o3_sim_a_subset(143:358))
o3Octavg_control = avg(o3_sim_c_subset(143:358))

o3Novavg_Obs = avg(o3_obsmean_subset(527:742))
o3Novavg_baseline = avg(o3_sim_a_subset(527:742))
o3Novavg_control = avg(o3_sim_b_subset(527:742))

header = (/"PM25obs PM25sim PM25APEC PM25Oct PM10obs PM10sim PM10APEC PM10Oct coobs cosim coAPEC coOct no2obs no2sim no2APEC no2Oct so2obs so2sim so2APEC so2Oct o3obs o3sim o3APEC o3Oct"/)

var_matrix_pm25@_FillValue = -999 
var_matrix_pm10@_FillValue = -999 
var_matrix_co@_FillValue   = -999 
var_matrix_no2@_FillValue  = -999 
var_matrix_so2@_FillValue  = -999 
var_matrix_o3@_FillValue   = -999 

hlist = [/header/]
alist = [/var_matrix_pm25(0,:),var_matrix_pm25(1,:),var_matrix_pm25(2,:),var_matrix_pm25(3,:),var_matrix_pm10(0,:),var_matrix_pm10(1,:),var_matrix_pm10(2,:),var_matrix_pm10(3,:),var_matrix_co(0,:),var_matrix_co(1,:),var_matrix_co(2,:),var_matrix_co(3,:),var_matrix_no2(0,:),var_matrix_no2(1,:),var_matrix_no2(2,:),var_matrix_no2(3,:),var_matrix_so2(0,:),var_matrix_so2(1,:),var_matrix_so2(2,:),var_matrix_so2(3,:),var_matrix_o3(0,:),var_matrix_o3(1,:),var_matrix_o3(2,:),var_matrix_o3(3,:)/]
;alist = [/var_matrix_pm25(0,:),var_matrix_pm25(1,:),var_matrix_pm25(2,:),var_matrix_pm25(3,:)/]
print("alist created...now writing")
fname = "12stmean_zeroemis_ts.txt"
write_table(fname, "w", hlist, "%s") 
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f") 


print("------------18-26 October 2014----------------------")
print("PM 2.5 Observed average     = "+pm25Octavg_Obs)
print("PM 2.5 baseline sim average = "+pm25Octavg_baseline)
print("PM 2.5 control sim average  = "+pm25Octavg_control)
print("Absolute improvement = "+(pm25Octavg_baseline - pm25Octavg_control))
print("Percentage improvement = "+(((pm25Octavg_baseline - pm25Octavg_control)*100.0)/pm25Octavg_baseline))

print("PM 10 Observed average     = "+pm10Octavg_Obs)
print("PM 10 baseline sim average = "+pm10Octavg_baseline)
print("PM 10 control sim average  = "+pm10Octavg_control)
print("Absolute improvement = "+(pm10Octavg_baseline - pm10Octavg_control))
print("Percentage improvement = "+(((pm10Octavg_baseline - pm10Octavg_control)*100.0)/pm10Octavg_baseline))

print("CO Observed average     = "+coOctavg_Obs)
print("CO baseline sim average = "+coOctavg_baseline)
print("CO control sim average  = "+coOctavg_control)
print("Absolute improvement = "+(coOctavg_baseline - coOctavg_control))
print("Percentage improvement = "+(((coOctavg_baseline - coOctavg_control)*100.0)/coOctavg_baseline))

print("NO2 Observed average     = "+no2Octavg_Obs)
print("NO2 baseline sim average = "+no2Octavg_baseline)
print("NO2 control sim average  = "+no2Octavg_control)
print("Absolute improvement = "+(no2Octavg_baseline - no2Octavg_control))
print("Percentage improvement = "+(((no2Octavg_baseline - no2Octavg_control)*100.0)/no2Octavg_baseline))

print("SO2 Observed average     = "+so2Octavg_Obs)
print("SO2 baseline sim average = "+so2Octavg_baseline)
print("SO2 control sim average  = "+so2Octavg_control)
print("Absolute improvement = "+(so2Octavg_baseline - so2Octavg_control))
print("Percentage improvement = "+(((so2Octavg_baseline - so2Octavg_control)*100.0)/so2Octavg_baseline))

print("O3 Observed average     = "+o3Octavg_Obs)
print("O3 baseline sim average = "+o3Octavg_baseline)
print("O3 control sim average  = "+o3Octavg_control)
print("Absolute improvement = "+(o3Octavg_baseline - o3Octavg_control))
print("Percentage improvement = "+(((o3Octavg_baseline - o3Octavg_control)*100.0)/o3Octavg_baseline))


print("------------3-11 November 2014----------------------")
print("PM 2.5 Observed average     = "+pm25Novavg_Obs)
print("PM 2.5 baseline sim average = "+pm25Novavg_baseline)
print("PM 2.5 control sim average  = "+pm25Novavg_control)
print("Absolute improvement = "+(pm25Novavg_baseline - pm25Novavg_control))
print("Percentage improvement = "+(((pm25Novavg_baseline - pm25Novavg_control)*100.0)/pm25Novavg_baseline))

print("PM 10 Observed average     = "+pm10Novavg_Obs)
print("PM 10 baseline sim average = "+pm10Novavg_baseline)
print("PM 10 control sim average  = "+pm10Novavg_control)
print("Absolute improvement = "+(pm10Novavg_baseline - pm10Novavg_control))
print("Percentage improvement = "+(((pm10Novavg_baseline - pm10Novavg_control)*100.0)/pm10Novavg_baseline))

print("CO Observed average     = "+coNovavg_Obs)
print("CO baseline sim average = "+coNovavg_baseline)
print("CO control sim average  = "+coNovavg_control)
print("Absolute improvement = "+(coNovavg_baseline - coNovavg_control))
print("Percentage improvement = "+(((coNovavg_baseline - coNovavg_control)*100.0)/coNovavg_baseline))

print("NO2 Observed average     = "+no2Novavg_Obs)
print("NO2 baseline sim average = "+no2Novavg_baseline)
print("NO2 control sim average  = "+no2Novavg_control)
print("Absolute improvement = "+(no2Novavg_baseline - no2Novavg_control))
print("Percentage improvement = "+(((no2Novavg_baseline - no2Novavg_control)*100.0)/no2Novavg_baseline))

print("SO2 Observed average     = "+so2Novavg_Obs)
print("SO2 baseline sim average = "+so2Novavg_baseline)
print("SO2 control sim average  = "+so2Novavg_control)
print("Absolute improvement = "+(so2Novavg_baseline - so2Novavg_control))
print("Percentage improvement = "+(((so2Novavg_baseline - so2Novavg_control)*100.0)/so2Novavg_baseline))

print("O3 Observed average     = "+o3Novavg_Obs)
print("O3 baseline sim average = "+o3Novavg_baseline)
print("O3 control sim average  = "+o3Novavg_control)
print("Absolute improvement = "+(o3Novavg_baseline - o3Novavg_control))
print("Percentage improvement = "+(((o3Novavg_baseline - o3Novavg_control)*100.0)/o3Novavg_baseline))

end
