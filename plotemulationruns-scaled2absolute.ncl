; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


begin
;LETS READ EMULATION RUNS DATA. THESE HAVE 12 ROWS AND 264 COLUMNS
ncol = 264
data = readAsciiTable("emulation.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
printVarSummary(data)

;LETS READ RUN0 (BASELINE) DATA. THIS HAS 264 ROWS AND 1 COLUMN
ncol = 1
data0 = readAsciiTable("run0_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data0@_FillValue = -999
print("table read-in successfully")
data0 = where(data0.lt.0.0,0.0,data0)
printVarSummary(data0)

emulationvalues  = new((/12,264/),float) ;11days long runs
emulationvalues_scaled2absolute  = new((/12,264/),float) ;11days long runs
emulationvalues_dailyavg  = new((/12,11/),float) ;11days long runs
emulationvalues_scaled2absolute_dailyavg  = new((/12,11/),float) ;11days long runs
run0 = new(264,float)
emulationvalues = data
emulationvalues = emulationvalues/100.0
run0 = data0

do i = 0,11
 do j = 0,263
  emulationvalues_scaled2absolute(i,j) = emulationvalues(i,j) * run0(j)
 end do
end do


;---Start the graphics
wks = gsn_open_wks("eps","emulationbenefits_scaled2absolute") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC2 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
;res@xyMarkLineMode = "MarkLines"               ; Markers *and* lines
;res@xyMarkers      = (/4,5,6,8,4,5,6,8,4,5,6,8/)
res@xyMarkers      = (/1,1,1,1,1,1,1,1,1,1,1,1/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
;res@xyDashPatterns  = (/2,1,3,0,2,1,3,0,2,1,3,0/)                         ; Make curves all solid
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
;res@xyLineColors      = (/"red4","red3","red","orangered","navyblue","royalblue4","royalblue1","deepskyblue","forestgreen","green4","green","springgreen"/)          ; change line color
res@xyLineColors      = (/"black","black","black","black","red","red","red","red","blue","blue","blue","blue"/)          ; change line color
res@xyMarkerColors      = (/"black","black","black","black","red","red","red","red","blue","blue","blue","blue"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12
  timearr = ispan (1,264,1)
  timearr@units = "hours since 2014-10-21 00:00:00"
  time_axis_labels(timearr,res,restick)
  res@trXMaxF=max(timearr)
  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03
  res@tmYLLabelFontHeightF = 0.03
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  res@trYMaxF     =  265
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward

 res@xyLabelMode            = "Custom"           ; label a line
 res@xyExplicitLabels       = (/"I","P","T","R","I","P","T","R","I","P","T","R"/)            ; text to use
 res@xyLineLabelFontHeightF = 0.020              ; font height
 res@xyLineLabelFontColors   = (/"black","black","black","black","red","red","red","red","blue","blue","blue","blue"/)              ; label color

  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
 

  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
  plot = gsn_csm_xy(wks,timearr,emulationvalues_scaled2absolute,res)    ; Create the four plots.

  gres = True
  gres@YPosPercent = 90.    ; expressed as %, 0->100, sets position of top border of legend 
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 73      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)
  gres@ItemSpacePercent = 10.
  lineres = True
  lineres@lgLineColors = (/"black","red","blue"/) ; line colors
  lineres@lgLineThicknesses = 2.5                        ; line thicknesses
  lineres@LineLengthPercent = 6.                         ; expressed as %, 0->100, length of line
  textres = True
  textres@lgLabels = (/"Beijing","Near Neighbourhood","Far Neighbourhood"/)  ; legend labels (required)
  textres@lgLabelFontHeights = (/0.012,0.012,0.012/)
  plot = simple_legend(wks,plot,gres,lineres,textres)
  draw(plot)    ; All four plots will be drawn.
  frame(wks)


end
