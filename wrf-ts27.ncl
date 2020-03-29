;STATION TIME-SERIES FOR COMPONENT-CORRECTED PM2.5 FOR OCT12_0000HRS-NOV19_0000HRS BJT WITH NEW OBSERVATIONAL DATA

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

pm25_sim =new(984,float)  
pm10_sim =new(984,float)  
pmcoarse_sim =new(984,float)  
co_sim =new(984,float)  
no2_sim =new(984,float)  
so2_sim =new(984,float)  
o3_sim =new(984,float)  

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
;times  = wrf_times_c(a[:]->Times,0)
;print(times)
;times = times + 8
;times_crop = times(40:975)

timearr = ispan (1,936,1)
timearr@units = "hours since 2014-10-12 00:00:00"



pm25_sim    = a[:]->PM2_5_DRY(:,0,J,I)
bc_sim    = a[:]->bc_a01(:,0,J,I) + a[:]->bc_a02(:,0,J,I) +a[:]->bc_a03(:,0,J,I) +a[:]->bc_a04(:,0,J,I) +a[:]->bc_a05(:,0,J,I) +a[:]->bc_a06(:,0,J,I)
no3_sim   = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) +a[:]->no3_a03(:,0,J,I) +a[:]->no3_a04(:,0,J,I) +a[:]->no3_a05(:,0,J,I) +a[:]->no3_a06(:,0,J,I)
so4_sim   = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) +a[:]->so4_a03(:,0,J,I) +a[:]->so4_a04(:,0,J,I) +a[:]->so4_a05(:,0,J,I) +a[:]->so4_a06(:,0,J,I)
p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)
d = ((p+pb)/(287.058*t2))

do i = 0, 936
 no3_sim(i) = no3_sim(i) * d(i)
 bc_sim(i)  = bc_sim(i) * d(i)
 so4_sim(i) = so4_sim(i) * d(i)
end do

pblh        = a[:]->PBLH(:,J,I)

pm25_sim_crop = pm25_sim(40:975)
bc_sim_crop   = bc_sim(40:975)
no3_sim_crop  = no3_sim(40:975)
so4_sim_crop  = so4_sim(40:975)
pblh_crop     = pblh(40:975)

pm25_bc       = pm25_sim_crop - (0.5 * bc_sim_crop)
pm25_no3      = pm25_sim_crop - (0.5 * no3_sim_crop)
pm25_bc_no3   = pm25_sim_crop - 0.5 * (bc_sim_crop + no3_sim_crop)
pm25_corr   = (2.0 * so4_sim_crop) +  pm25_sim_crop - 0.6 * (bc_sim_crop + no3_sim_crop)

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
  
  co_obs    = co(48:983) ;273:392 for 21-25Oct runs
  so2_obs   = so2(48:983)
  no2_obs   = no2(48:983)
  o3_obs    = o3(48:983)
  PM10_obs  = PM10(48:983)
  PM25_obs  = PM25(48:983)
  PMcoarse_obs = PM10_obs - PM25_obs
  datetime     = str_get_field(lines_full,10,delim1)
  timefull     = tofloat(str_get_field(lines_full,11,delim))
  datetime_obs = timefull(48:983)
  print(datetime_obs)
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
printVarSummary(PM25_obs)

  var_matrix_pm25        = new((/2,936/),float) ;120 for 21-25oct 
  var_matrix_pm25_bc     = new((/2,936/),float) ;120 for 21-25oct 
  var_matrix_pm25_no3    = new((/2,936/),float) ;120 for 21-25oct 
  var_matrix_pm25_bc_no3 = new((/2,936/),float) ;120 for 21-25oct 
  var_matrix_pm25_bc_no3_so4 = new((/2,936/),float) ;120 for 21-25oct 
  var_matrix_pm25_corr = new((/2,936/),float)  

var_matrix_pm25(0,:)        = (/pm25_sim_crop/)
var_matrix_pm25(1,:)        = (/PM25_obs/)
var_matrix_pm25_corr(0,:)   = (/pm25_corr/)
var_matrix_pm25_corr(1,:)   = (/PM25_obs/)

;---Start the graphics
wks = gsn_open_wks("png",stationname+"_ts_controlrun_pm25corr") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at "+stationname          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 4
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
res@tiYAxisFontHeightF = 0.0005
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N/%Y"
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
  res@tmYRLabelFontHeightF = 0.02   ; Increase font height
  res@tmXBLabelFontHeightF = 0.02   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  res@gsnYRefLine = 25.0 

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .80                  ; move units right
  res@pmLegendOrthogonalPosF = -0.75               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_pm25_corr,res)    ; Create the four plots.

;  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
;  res@tiYAxisString = "Corrected"
;  xy2 = gsn_csm_xy(wks,timearr,var_matrix_pm25_corr,res)    ; They won't be drawn yet.


  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)


end
