;THIS SCRIPT PLOTS OBS PBLH VS SIM MIXING HEIGHT ALONGWITH OBS AND SIM PM2.5 CONCENTRATIONS MIXED UPTO SIM AND OBS PBL LEVELS AT AOTIZHONGXIN SITE
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;REMOVE THE OUTLIERS
undef("remoutlier")
function remoutlier(var)
begin
 n = dimsizes(var)
 do i=1,n-2
  prev = var(i-1)
  now  = var(i)
  next = var(i+1)
  miss = var@_FillValue
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.gt.2*prev).and.(now.gt.2*next)) then
    var(i) = miss
  end if
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.lt.2*prev).and.(now.lt.2*next)) then
    var(i) = miss
  end if
 end do
 return(var)
end



begin

DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=145
pblh_sim   = a[:]->PBLH(:,J,I)
pblh_sim_subset = pblh_sim(40:975)
pm25 = a[:]->PM2_5_DRY(:,0:15,J,I); FETCH THE FIRST 14 MODEL LEVELS TO CALCULATE CONCENTRATION DROP LATER
pm25_subset = pm25(40:975,:); SUBSET TO MATCH THE HOURS OF AOTIZHONGXIN OBSERVATIONS


; ROUTINE TO CHECK MAXIMUM DROP IN POLLUTANT CONCENTRATIONS
drop = 0.0
blh_arr = (/26.8,90.31,177.60,288.88,429.22,608.47,829.12,1116.82,1457.69,1809.77,2174.12,2711.91,3418.99,4130.57/)
blh = new(936, float)
levsim = new(936, integer)
levobs = new(936, integer)
;yesno = new(936, float)

do t=0,935

 do h=0,12

  drop_current = pm25_subset(t,h) - pm25_subset(t,h+1)
;  print("drop_current="+drop_current+" drop="+drop)  
  if(drop_current.gt.drop) then 
   drop = drop_current
   blh(t) = blh_arr(h)
   levsim(t) = h
  end if

 end do
 drop =0.0 
end do

  filename = "/data1/tabish/nclscripts/totalLIDAR_PBLH_hourly_under3km_newalgo_936.txt"
  lines1 = asciiread(filename,-1,"string")
  delim = " " ; delimiter
  datetime         = str_get_field(lines1,1,delim)
  pblh_obs	   =   tofloat(str_get_field(lines1,2,delim))
  pblh_obs = runave (pblh_obs, 3, 0) 

;CALCULATE MATCHING MODEL LEVEL TO OBSERVED DUST PBLH
do i = 0,935
 diffmin =5000.0
 do j = 0,13
  if(.not.ismissing(pblh_obs(i))) then
  diff = pblh_obs(i) - blh_arr(j)
  print(pblh_obs(i)+"	"+blh_arr(j))
  diff = abs(diff)
  if(diff.lt.diffmin) then 
   diffmin = diff
   levobs(i) = j
  end if
  end if
 end do
end do
levobs(0)=levobs(1)
levobs(dimsizes(levobs)-1)=levobs(dimsizes(levobs)-2)
print(levobs)
pm25sim = pm25_subset(:,0)
pm25sim_levsim = new(936, float) 
pm25sim_levobs = new(936, float) 
printVarSummary(pm25_subset)

do i =0,935
 print("i="+i+" levsim="+levobs(i))
 pm25sim_levsim(i) = avg(pm25_subset(i,0:levsim(i)))
 pm25sim_levobs(i) = avg(pm25_subset(i,0:levobs(i))) 
end do
print("The OBS-PBL-MIXED and SIM-PBL-MIXED PM2.5 arrays have been created")


print("Obs PBLH="+pblh_obs+",lev="+levobs+",Sim PBLH="+blh+",lev="+levsim)
;alist = [/yesno_subset, lev_subset/]
;write_table("yesno-lev_obsPBLH_21-25Oct.txt", "w", alist, "%ld%16.2f")

  PBLH_matrix  = new((/2,dimsizes(pblh_obs)/),float)
  PBLH_matrix(0,:) = (/pblh_obs/)
  PBLH_matrix(1,:) = (/blh/)
 

;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filename = "/data1/tabish/surface_data/Beijing_AQ_data_APEC2014_dingling.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_Aotizhongxin = str_match(lines, "Aotizhongxin")
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
   lines_full(fill) = ",Aotizhongxin,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,1011A,missing missing missing"
   fill = fill +1
;   print("fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_Aotizhongxin(dimsizes(lines_Aotizhongxin)-1)
  PM25     = tofloat(str_get_field(lines_full,7,delim))
  PM25     = where(PM25.eq.0 .or. PM25.eq.9.96921e+36, PM25@_FillValue, PM25)
  pm25obs = PM25(48:983)
 
  PM_matrix  = new((/4,dimsizes(pblh_obs)/),float)
  PM_matrix(0,:) = (/pm25sim/)
  PM_matrix(1,:) = (/pm25sim_levsim/)
  PM_matrix(2,:) = (/pm25sim_levobs/)
  PM_matrix(3,:) = (/pm25obs/)


obsavg    = avg(pblh_obs)
blhavg    = avg(blh)
pm25simavg = avg(pm25sim)
pm25sim_levsimavg = avg(pm25sim_levsim)
pm25sim_levobsavg =avg(pm25sim_levobs)
pm25obsavg =avg(pm25obs)

print("LIDAR PBLH mean        = "+obsavg)
print("Sim mixing height mean = "+blhavg)
print("Sim surface PM2.5 mean = "+pm25simavg)
print("Sim PM2.5 mixed upto sim PBLH mean = "+pm25sim_levsimavg)
print("Sim PM2.5 mixed upto obs PBLH mean = "+pm25sim_levobsavg)
print("Obs surface PM2.5 mean = "+pm25obsavg)
 
timearr = ispan (1,936,1)
timearr@units = "hours since 2014-10-12 00:00:00"

;---Start the graphics
wks = gsn_open_wks("x11","PBLHanalysis") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@trXMaxF=max(timearr)
;res@tiMainString     = "Boundary Layer Mixing of PM2.5"          ; add title
;res@gsnMaximize = False
;res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0 /)          ; make second line thicker
res@xyLineColors      = (/"black","red"/)          ; change line color
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
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 48
  restick@ttmMinorStride= 24
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
  res@tiYAxisString      = "PBLH (m)"
  res@tiMainFontHeightF  = 0.035
  res@tiYAxisFontHeightF = 0.035
  res@tiXAxisFontHeightF = 0.035
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = False    ; Turn on right labels
  res@tmYLMinorOn          = True   ; Turn off minor ticks on Y axis
  ;res@tmYLLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYLLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 0.80                  ; move units right
  res@pmLegendOrthogonalPosF = -0.3                ; move units down
  res@pmLegendWidthF         = 0.30                ; Change width and
  res@pmLegendHeightF        = 0.10                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = 0.035                 ; label font height
  res@xyExplicitLegendLabels = (/"obs PBLH","sim mixing height"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
  plot1 = gsn_csm_xy(wks,timearr,PBLH_matrix,res)    ; Create the four plots.
  

res1             = True
res1@trXMaxF=max(timearr)
;res1@tiMainString     = "Boundary Layer Height (m)"          ; add title
;res1@gsnMaximize = True
;res1@vpKeepAspect=True
res1@vpWidthF    = 2
res1@vpHeightF   = 0.4
res1@xyMarkLineMode = "Lines"
res1@xyMarkers      = (/0,0,0,0/)
res1@tmXTOn      = False
res1@tmYLFormat  = "f"      ; remove trailing ".0"
res1@xyDashPatterns  = (/0,0,0,0/)                         ; Make curves all solid
res1@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0 /)          ; make second line thicker
res1@xyLineColors      = (/"red","green","blue","black"/)          ; change line color
time_axis_labels(timearr,res1,restick)

  res1@tiMainFontHeightF  = 0.035
  res1@tiYAxisFontHeightF = 0.035
  res1@tmYUseLeft           = False   ; Make right axis independent of left
  res1@tmYLOn               = True   ; Turn off left tickmarks
  res1@tmYROn               = False    ; Turn on right tickmarks
  res1@tmXTOn               = False   ; Turn off top tickmarks
  res1@tmYLLabelsOn         = True   ; Turn off left labels
  res1@tmYRLabelsOn         = False    ; Turn on right labels
  res1@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  ;res1@tmYLLabelFontHeightF = 0.04   ; Increase font height
  res1@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res1@tmYLLabelJust        = "CenterRight"   ; right-justify labels

  res1@pmLegendDisplayMode    = "Always"            ; turn on legend
  res1@pmLegendSide           = "Top"               ; Change location of
  res1@pmLegendParallelPosF   = .80                  ; move units right
  res1@pmLegendOrthogonalPosF = -0.48               ; move units down
  res1@pmLegendWidthF         = 0.3                ; Change width and
  res1@pmLegendHeightF        = 0.18                ; height of legend.
  res1@lgPerimOn              = False               ; turn off box around
  res1@lgLabelFontHeightF     = .03                 ; label font height
  res1@xyExplicitLegendLabels = (/"sim. surface PM2.5","sim. PM2.5 mixed upto sim PBLH","sim. PM2.5 mixed upto obs PBLH","Obs surface PM2.5"/)         ; create explicit labels
  res1@gsnDraw  = False                          ; don't draw
  res1@gsnFrame = False                          ; don't advance frame
  res1@tiYAxisString = "PM2.5 (ug/m3)"

plot2 = gsn_csm_xy(wks,timearr,PM_matrix,res1)    ; Create the four plots.

;  res3                     = True
;  res4                     = True
;  res1@gsnMaximize         = True
;  res4@gsnAttachPlotsXAxis = True
; xy1 will be the base plot.
;  amid = gsn_attach_plots(plot1,plot2,res3,res4)
;  draw(plot1)    ; All four plots will be drawn.
;  frame(wks)

;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/plot1,plot2/),(/2,1/),resP)             ; now draw as one plot


end
