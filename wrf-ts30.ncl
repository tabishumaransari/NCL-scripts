;STATION TIME-SERIES FOR ALL POLLUTANTS FOR OCT12_0000HRS-NOV07_1500HRS BJT WITH NEW OBSERVATIONAL DATA for FNL vs ECMWF

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;pm25_sim =new(984,float)  
;pm10_sim =new(984,float)  
;pmcoarse_sim =new(984,float)  
;co_sim =new(984,float)  
;no2_sim =new(984,float)  
;so2_sim =new(984,float)  
;o3_sim =new(984,float)  

datetime_obs = new(936,float)
pm25_obs =new(936,float)  
pm10_obs =new(936,float)  
pmcoarse_obs =new(936,float)  
co_obs =new(936,float)  
no2_obs =new(936,float)  
so2_obs =new(936,float)  
o3_obs =new(936,float)  

DATADir = "/data3/tabish/control-run/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
pm25_sim    = a[:]->PM2_5_DRY(:,0,J,I)
pm10_sim    = a[:]->PM10(:,0,J,I)
co_sim      = a[:]->co(:,0,J,I)
no2_sim     = a[:]->no2(:,0,J,I)
so2_sim     = a[:]->so2(:,0,J,I)
o3_sim      = a[:]->o3(:,0,J,I)
pmcoarse_sim = pm10_sim - pm25_sim
co_sim      = 1000* co_sim
no2_sim     = 1000* no2_sim
so2_sim     = 1000* so2_sim
o3_sim      = 1000* o3_sim
pblh        = a[:]->PBLH(:,J,I)

pm25_sim_crop = pm25_sim(40:975)
pm10_sim_crop = pm10_sim(40:975)
pmcoarse_sim_crop = pmcoarse_sim(40:975)
co_sim_crop   = co_sim(40:975)
no2_sim_crop  = no2_sim(40:975)
so2_sim_crop  = so2_sim(40:975)
o3_sim_crop   = o3_sim(40:975)
pblh_crop     = pblh(40:975)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DATADir2 = "/data2/tabish/control-run-so4-ECMWF/"
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
b = addfiles(FILES2,"r")
pm25_sim_b    = b[:]->PM2_5_DRY(:,0,J,I)
pm10_sim_b    = b[:]->PM10(:,0,J,I)
co_sim_b      = b[:]->co(:,0,J,I)
no2_sim_b     = b[:]->no2(:,0,J,I)
so2_sim_b     = b[:]->so2(:,0,J,I)
o3_sim_b      = b[:]->o3(:,0,J,I)
pmcoarse_sim_b = pm10_sim_b - pm25_sim_b
co_sim_b      = 1000* co_sim_b
no2_sim_b     = 1000* no2_sim_b
so2_sim_b     = 1000* so2_sim_b
o3_sim_b      = 1000* o3_sim_b
pblh_b        = b[:]->PBLH(:,J,I)

pm25_sim_b_crop = pm25_sim_b(40:975)
pm10_sim_b_crop = pm10_sim_b(40:975)
pmcoarse_sim_b_crop = pmcoarse_sim_b(40:975)
co_sim_b_crop   = co_sim_b(40:975)
no2_sim_b_crop  = no2_sim_b(40:975)
so2_sim_b_crop  = so2_sim_b(40:975)
o3_sim_b_crop   = o3_sim_b(40:975)
pblh_b_crop     = pblh_b(40:975)



timearr = ispan (1,936,1)
timearr@units = "hours since 2014-10-12 00:00:00"







;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   filename = "/data1/tabish/surface_data/Beijing_AQ_data_APEC2014_dingling.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_Aotizhongxin = str_match(lines, stationname)
  delim = ", :" ; multiple delimiters to separate day from date to find missing times
  delim1 = "," ; multiple delimiters to separate day from date to find missing times
  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;print(time)
lines_full = new(1008,string)
fill =0
do i = 0, dimsizes(lines_Aotizhongxin)-2
 print("i="+i + " fill="+fill)
 n=(time(i+1)-time(i))
 if((n.eq.1).or.(n.eq.-23))then
  lines_full(fill) = lines_Aotizhongxin(i)
  fill = fill + 1
  print("fill="+fill)
 else
  lines_full(fill) = lines_Aotizhongxin(i)
  fill=fill+1
  print("fill="+fill)
  do j=1,n-1
   lines_full(fill) = ","+stationname+",9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,1011A,missing missing missing"
   fill = fill +1
;   print("fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_Aotizhongxin(dimsizes(lines_Aotizhongxin)-1)
print(lines_full)
;  stationname  = str_get_field(lines_full,1,delim)

  co         = tofloat(str_get_field(lines_full,2,delim))
  so2        = tofloat(str_get_field(lines_full,8,delim))
  no2        = tofloat(str_get_field(lines_full,3,delim))
  o3         = tofloat(str_get_field(lines_full,4,delim))
  PM10         = tofloat(str_get_field(lines_full,6,delim))
  PM25         = tofloat(str_get_field(lines_full,7,delim))
  
  co         = where(co.eq.0 .or. co.eq.9.96921e+36, co@_FillValue, co)
  co 	     = 1000*co
  so2        = where(so2.eq.0 .or. so2.eq.9.96921e+36, so2@_FillValue, so2)
  no2        = where(no2.eq.0 .or. no2.eq.9.96921e+36, no2@_FillValue, no2)
  o3         = where(o3.eq.0 .or. o3.eq.9.96921e+36, o3@_FillValue, o3)
  PM10       = where(PM10.eq.0 .or. PM10.eq.9.96921e+36, PM10@_FillValue, PM10)
  PM25       = where(PM25.eq.0 .or. PM25.eq.9.96921e+36, PM25@_FillValue, PM25)
  

;SINCE 16TH OCT 0000HRS IS MISSING FROM SIMULATED ARRAYS WE OMIT THAT FROM OBS ARRAYS TOO
;  co_obs    = co(48:983) ;273:392 for 21-25Oct runs
;  so2_obs   = so2(48:983)
;  no2_obs   = no2(48:983)
;  o3_obs    = o3(48:983)
;  PM10_obs  = PM10(48:983)
;  PM25_obs  = PM25(48:983)
printVarSummary(co)
printVarSummary(co_obs)
co_obs(0:95) = co(48:143) 
co_obs(96:935) = co(145:984) 

so2_obs(0:95) = so2(48:143) 
so2_obs(96:935) = so2(145:984)

no2_obs(0:95) = no2(48:143) 
no2_obs(96:935) = no2(145:984)

o3_obs(0:95) = o3(48:143) 
o3_obs(96:935) = o3(145:984)

pm10_obs(0:95) = PM10(48:143) 
pm10_obs(96:935) = PM10(145:984)

pm25_obs(0:95) = PM25(48:143) 
pm25_obs(96:935) = PM25(145:984)

  PMcoarse_obs = pm10_obs - pm25_obs
  datetime     = str_get_field(lines_full,10,delim1)
  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime_obs = timefull(48:983)
  datetime_obs(0:95)   = timefull(48:143)
  datetime_obs(96:935) = timefull(145:984)
  print(datetime_obs)
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
printVarSummary(pm25_obs)

  var_matrix_pm25  = new((/3,936/),float) ;120 for 21-25oct 
  var_matrix_pm10  = new((/3,936/),float)  
  var_matrix_pmcoarse  = new((/3,936/),float)  
  var_matrix_co  = new((/3,936/),float)  
  var_matrix_no2  = new((/3,936/),float)  
  var_matrix_so2  = new((/3,936/),float)  
  var_matrix_o3  = new((/3,936/),float)  
  var_matrix_pblh = new((/2,936/),float)  

printVarSummary(pm25_sim_b_crop)  
var_matrix_pm25(0,:) = (/pm25_sim_crop/)
var_matrix_pm25(1,:) = (/pm25_sim_b_crop/)
var_matrix_pm25(2,:) = pm25_obs

var_matrix_pm10(0,:) = (/pm10_sim_crop/)
var_matrix_pm10(1,:) = (/pm10_sim_b_crop/)
var_matrix_pm10(2,:) = pm10_obs

var_matrix_pmcoarse(0,:) = (/pmcoarse_sim_crop/)
var_matrix_pmcoarse(1,:) = (/pmcoarse_sim_b_crop/)
var_matrix_pmcoarse(2,:) = PMcoarse_obs

var_matrix_co(0,:) = (/co_sim_crop/)
var_matrix_co(1,:) = (/co_sim_b_crop/)
var_matrix_co(2,:) = co_obs

var_matrix_no2(0,:) = (/no2_sim_crop/)
var_matrix_no2(1,:) = (/no2_sim_b_crop/)
var_matrix_no2(2,:) = no2_obs

var_matrix_so2(0,:) = (/so2_sim_crop/)
var_matrix_so2(1,:) = (/so2_sim_b_crop/)
var_matrix_so2(2,:) = so2_obs

var_matrix_o3(0,:) = (/o3_sim_crop/)
var_matrix_o3(1,:) = (/o3_sim_b_crop/)
var_matrix_o3(2,:) = o3_obs

var_matrix_pblh(0,:) = (/pblh_crop/)
var_matrix_pblh(1,:) = (/pblh_b_crop/)

;---Start the graphics
wks = gsn_open_wks("x11",stationname+"_ts_controlrun_FNL-ECMWFso4") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at "+stationname          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  2.0, 2.0, 2.0/)          ; make second line thicker
res@xyLineColors      = (/"blue", "black", "red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
  restick@ttmNumTicks = 20
;  restick@ttmMajorStride= 12
;  restick@ttmMinorStride= 1
  time_axis_labels(timearr,res,restick)

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
  res@xyExplicitLegendLabels = (/"FNL", "ECMWF", "obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
  res@tiYAxisString = "PM10"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_pm10,res)    ; They won't be drawn yet.

  res@tiYAxisString = "PM coarse"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_pmcoarse,res)

  res@tiYAxisString = "CO"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_co,res)

  res@tiYAxisString = "NO2"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_no2,res)

  res@tiYAxisString = "SO2"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_so2,res)

  res@tiYAxisString = "O3"
  xy7 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy8 = gsn_csm_xy(wks,timearr,var_matrix_pblh,res)

  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)


end
