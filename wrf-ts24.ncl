;SIMILAR TO WRF-TS23.NCL, FOR OCT10-16, WITH MISSING VALUES IMPOSED ON SIMULATED ARRAYS 

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

delete(lines_station)
delete(time)

return([/co, so2, no2, o3, PM25, PM10/])

end   ; end function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("polmean") ; function name
function polmean(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12)
begin ; begin function
c = 0.0
s =0.0
polavg = new (dimsizes(p1),typeof(p1),p1@_FillValue)
do t=0,1007

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;FUNCTION TO MATCH MISSING VALUES IN SIMULATED ARRAYS AS IN OBSERVED ARRAYS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

undef("matchmisval") ; function name
function matchmisval(sim,obs)
begin ; begin function
sim = where(obs.eq.obs@_FillValue,obs@_FillValue,sim)
return(sim)
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

DATADir = "/data3/tabish/YSU-nudged-0.5BTHso2-0.7Bnox/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)

pm25_sim_Aotizhongxin    = a[:]->PM2_5_DRY(:,0,145,79)
pm10_sim_Aotizhongxin    = a[:]->PM10(:,0,145,79)
co_sim_Aotizhongxin      = a[:]->co(:,0,145,79)
no2_sim_Aotizhongxin     = a[:]->no2(:,0,145,79)
so2_sim_Aotizhongxin     = a[:]->so2(:,0,145,79)
o3_sim_Aotizhongxin      = a[:]->o3(:,0,145,79)
pblh_sim_Aotizhongxin    = a[:]->PBLH(:,145,79)

pm25_sim_Wanshouxigong    = a[:]->PM2_5_DRY(:,0,141,79)
pm10_sim_Wanshouxigong    = a[:]->PM10(:,0,141,79)
co_sim_Wanshouxigong      = a[:]->co(:,0,141,79)
no2_sim_Wanshouxigong     = a[:]->no2(:,0,141,79)
so2_sim_Wanshouxigong     = a[:]->so2(:,0,141,79)
o3_sim_Wanshouxigong      = a[:]->o3(:,0,141,79)
pblh_sim_Wanshouxigong    = a[:]->PBLH(:,141,79)

pm25_sim_Dongsi    = a[:]->PM2_5_DRY(:,0,144,80)
pm10_sim_Dongsi    = a[:]->PM10(:,0,144,80)
co_sim_Dongsi      = a[:]->co(:,0,144,80)
no2_sim_Dongsi     = a[:]->no2(:,0,144,80)
so2_sim_Dongsi     = a[:]->so2(:,0,144,80)
o3_sim_Dongsi      = a[:]->o3(:,0,144,80)
pblh_sim_Dongsi    = a[:]->PBLH(:,144,80)

pm25_sim_Dingling    = a[:]->PM2_5_DRY(:,0,155,72)
pm10_sim_Dingling    = a[:]->PM10(:,0,155,72)
co_sim_Dingling      = a[:]->co(:,0,155,72)
no2_sim_Dingling     = a[:]->no2(:,0,155,72)
so2_sim_Dingling     = a[:]->so2(:,0,155,72)
o3_sim_Dingling      = a[:]->o3(:,0,155,72)
pblh_sim_Dingling    = a[:]->PBLH(:,155,72)

pm25_sim_Tiantan    = a[:]->PM2_5_DRY(:,0,141,81)
pm10_sim_Tiantan    = a[:]->PM10(:,0,141,81)
co_sim_Tiantan      = a[:]->co(:,0,141,81)
no2_sim_Tiantan     = a[:]->no2(:,0,141,81)
so2_sim_Tiantan     = a[:]->so2(:,0,141,81)
o3_sim_Tiantan      = a[:]->o3(:,0,141,81)
pblh_sim_Tiantan    = a[:]->PBLH(:,141,81)

pm25_sim_Nongzhanguan    = a[:]->PM2_5_DRY(:,0,144,81)
pm10_sim_Nongzhanguan    = a[:]->PM10(:,0,144,81)
co_sim_Nongzhanguan      = a[:]->co(:,0,144,81)
no2_sim_Nongzhanguan     = a[:]->no2(:,0,144,81)
so2_sim_Nongzhanguan     = a[:]->so2(:,0,144,81)
o3_sim_Nongzhanguan      = a[:]->o3(:,0,144,81)
pblh_sim_Nongzhanguan    = a[:]->PBLH(:,144,81)

pm25_sim_Guanyuan    = a[:]->PM2_5_DRY(:,0,143,78)
pm10_sim_Guanyuan    = a[:]->PM10(:,0,143,78)
co_sim_Guanyuan      = a[:]->co(:,0,143,78)
no2_sim_Guanyuan     = a[:]->no2(:,0,143,78)
so2_sim_Guanyuan     = a[:]->so2(:,0,143,78)
o3_sim_Guanyuan      = a[:]->o3(:,0,143,78)
pblh_sim_Guanyuan    = a[:]->PBLH(:,143,78)

pm25_sim_Haidianwanliu    = a[:]->PM2_5_DRY(:,0,145,77)
pm10_sim_Haidianwanliu   = a[:]->PM10(:,0,145,77)
co_sim_Haidianwanliu      = a[:]->co(:,0,145,77)
no2_sim_Haidianwanliu     = a[:]->no2(:,0,145,77)
so2_sim_Haidianwanliu     = a[:]->so2(:,0,145,77)
o3_sim_Haidianwanliu      = a[:]->o3(:,0,145,77)
pblh_sim_Haidianwanliu    = a[:]->PBLH(:,145,77)

pm25_sim_Shunyixincheng    = a[:]->PM2_5_DRY(:,0,151,88)
pm10_sim_Shunyixincheng    = a[:]->PM10(:,0,151,88)
co_sim_Shunyixincheng      = a[:]->co(:,0,151,88)
no2_sim_Shunyixincheng     = a[:]->no2(:,0,151,88)
so2_sim_Shunyixincheng     = a[:]->so2(:,0,151,88)
o3_sim_Shunyixincheng      = a[:]->o3(:,0,151,88)
pblh_sim_Shunyixincheng    = a[:]->PBLH(:,151,88)

pm25_sim_Huairouzhen    = a[:]->PM2_5_DRY(:,0,160,85)
pm10_sim_Huairouzhen    = a[:]->PM10(:,0,160,85)
co_sim_Huairouzhen      = a[:]->co(:,0,160,85)
no2_sim_Huairouzhen     = a[:]->no2(:,0,160,85)
so2_sim_Huairouzhen     = a[:]->so2(:,0,160,85)
o3_sim_Huairouzhen      = a[:]->o3(:,0,160,85)
pblh_sim_Huairouzhen    = a[:]->PBLH(:,160,85)

pm25_sim_Changpingzheng    = a[:]->PM2_5_DRY(:,0,152,74)
pm10_sim_Changpingzheng    = a[:]->PM10(:,0,152,74)
co_sim_Changpingzheng      = a[:]->co(:,0,152,74)
no2_sim_Changpingzheng     = a[:]->no2(:,0,152,74)
so2_sim_Changpingzheng     = a[:]->so2(:,0,152,74)
o3_sim_Changpingzheng      = a[:]->o3(:,0,152,74)
pblh_sim_Changpingzheng    = a[:]->PBLH(:,152,74)

pm25_sim_Gucheng    = a[:]->PM2_5_DRY(:,0,142,75)
pm10_sim_Gucheng    = a[:]->PM10(:,0,142,75)
co_sim_Gucheng      = a[:]->co(:,0,142,75)
no2_sim_Gucheng     = a[:]->no2(:,0,142,75)
so2_sim_Gucheng     = a[:]->so2(:,0,142,75)
o3_sim_Gucheng      = a[:]->o3(:,0,142,75)
pblh_sim_Gucheng    = a[:]->PBLH(:,142,75)

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

co_mean = polmean(co_Aotizhongxin, co_Wanshouxigong, co_Dongsi, co_Dingling, co_Tiantan, co_Nongzhanguan, co_Guanyuan, co_Haidianwanliu, co_Shunyixincheng, co_Huairouzhen, co_Changpingzheng, co_Gucheng)
so2_mean = polmean(so2_Aotizhongxin, so2_Wanshouxigong, so2_Dongsi, so2_Dingling, so2_Tiantan, so2_Nongzhanguan, so2_Guanyuan, so2_Haidianwanliu, so2_Shunyixincheng, so2_Huairouzhen, so2_Changpingzheng, so2_Gucheng)
no2_mean = polmean(no2_Aotizhongxin, no2_Wanshouxigong, no2_Dongsi, no2_Dingling, no2_Tiantan, no2_Nongzhanguan, no2_Guanyuan, no2_Haidianwanliu, no2_Shunyixincheng, no2_Huairouzhen, no2_Changpingzheng, no2_Gucheng)
o3_mean = polmean(o3_Aotizhongxin, o3_Wanshouxigong, o3_Dongsi, o3_Dingling, o3_Tiantan, o3_Nongzhanguan, o3_Guanyuan, o3_Haidianwanliu, o3_Shunyixincheng, o3_Huairouzhen, o3_Changpingzheng, o3_Gucheng)
pm25_mean = polmean(pm25_Aotizhongxin, pm25_Wanshouxigong, pm25_Dongsi, pm25_Dingling, pm25_Tiantan, pm25_Nongzhanguan, pm25_Guanyuan, pm25_Haidianwanliu, pm25_Shunyixincheng, pm25_Huairouzhen, pm25_Changpingzheng, pm25_Gucheng)
pm10_mean = polmean(pm10_Aotizhongxin, pm10_Wanshouxigong, pm10_Dongsi, pm10_Dingling, pm10_Tiantan, pm10_Nongzhanguan, pm10_Guanyuan, pm10_Haidianwanliu, pm10_Shunyixincheng, pm10_Huairouzhen, pm10_Changpingzheng, pm10_Gucheng)




  co_subset    = co_mean(7:175) ;273:392 for 21-25Oct runs
  so2_subset   = so2_mean(7:175)
  no2_subset   = no2_mean(7:175)
  o3_subset    = o3_mean(7:175)
  PM10_subset  = pm10_mean(7:175)
  PM25_subset  = pm25_mean(7:175)
  PMcoarse_subset = new(dimsizes(PM10_subset), typeof(PM10_subset), PM10_subset@_FillValue)
  
  do count =0,(dimsizes(PM10_subset)-1)
   print("PM10="+PM10_subset(count) + " PM2.5=" + PM25_subset(count))
   if(ismissing(PM10_subset(count)).or.ismissing(PM25_subset(count))) then
    PMcoarse_subset(count) = PM10_subset@_FillValue
   else
    PMcoarse_subset(count) = PM10_subset(count) - PM25_subset(count)
   end if
  end do

; timefull     = tofloat(str_get_field(lines_full,11,delim))
; datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
printVarSummary(PM25_subset)

 ; pmcoarse_obs = pm10_obs - pm25_obs
  var_matrix_pm25  = new((/2,169/),float) ;120 for 21-25oct 
  var_matrix_pm10  = new((/2,169/),float)  
  var_matrix_pmcoarse  = new((/2,169/),float)  
  var_matrix_co  = new((/2,169/),float)  
  var_matrix_no2  = new((/2,169/),float)  
  var_matrix_so2  = new((/2,169/),float)  
  var_matrix_o3  = new((/2,169/),float)  
  
var_matrix_pm25(0,:) = (/pm25_sim/)
var_matrix_pm25(1,:) = PM25_subset
var_matrix_pm10(0,:) = (/pm10_sim/)
var_matrix_pm10(1,:) = PM10_subset
var_matrix_pmcoarse(0,:) = (/pmcoarse_sim/)
var_matrix_pmcoarse(1,:) = PMcoarse_subset
var_matrix_co(0,:) = (/co_sim/)
var_matrix_co(1,:) = co_subset
var_matrix_no2(0,:) = (/no2_sim/)
var_matrix_no2(1,:) = no2_subset
var_matrix_so2(0,:) = (/so2_sim/)
var_matrix_so2(1,:) = so2_subset
var_matrix_o3(0,:) = (/o3_sim/)
var_matrix_o3(1,:) = o3_subset


;---Start the graphics
wks = gsn_open_wks("png","Beijingmean_ts_10-16Oct_YSUnudged_0.7Bnox-0.5BTHso2_test") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at Beijing stations"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  restick@ttmFormat = "%D_%H"
  ;restick@ttmFormat = "%D"
;  restick@ttmNumTicks = 5
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 1
  time_axis_labels(times,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.05
  res@tiYAxisFontHeightF = 0.05

  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = False   ; Turn off left tickmarks
  res@tmYROn               = True    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels


  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.75               ; move units down
  res@pmLegendWidthF         = 0.5                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5"
  xy1 = gsn_csm_xy(wks,times,var_matrix_pm25,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
  res@tiYAxisString = "PM10"
  xy2 = gsn_csm_xy(wks,times,var_matrix_pm10,res)    ; They won't be drawn yet.

  res@tiYAxisString = "PM coarse"
  xy3 = gsn_csm_xy(wks,times,var_matrix_pmcoarse,res)

  res@tiYAxisString = "CO"
  xy4 = gsn_csm_xy(wks,times,var_matrix_co,res)

  res@tiYAxisString = "NO2"
  xy5 = gsn_csm_xy(wks,times,var_matrix_no2,res)

  res@tiYAxisString = "SO2"
  xy6 = gsn_csm_xy(wks,times,var_matrix_so2,res)

  res@tiYAxisString = "O3"
  xy7 = gsn_csm_xy(wks,times,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy8 = gsn_csm_xy(wks,times,pblh,res)

  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)


end
