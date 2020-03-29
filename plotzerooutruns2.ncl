; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


begin

ncol = 12
data = readAsciiTable("zero-out_runs_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
var_matrix_pm25  = new((/12,264/),float) ;11days long runs
var_matrix_pm25dailyavg  = new((/12,11/),float) ;11days long runs
var_matrix_pm25dailyavgpc  = new((/12,11/),float) ;11days long runs
print(dimsizes(data))
print(dimsizes(var_matrix_pm25))
day = 21
do i= 0,11
 var_matrix_pm25(i,:) = data(:,i)
 do j = 0,240,24
  dailybenefit = avg(var_matrix_pm25(i,j:j+23))
  dailybenefit  = decimalPlaces(dailybenefit ,2,True)
  print("Daily benefits for run "+(i+1)+" on "+day+"="+dailybenefit)
  var_matrix_pm25dailyavg(i,j/24)=dailybenefit
  day = day+1
 end do 
day =21
end do

print(sum(var_matrix_pm25dailyavg(:,0)))
print(sum(var_matrix_pm25dailyavg(:,1)))
print(sum(var_matrix_pm25dailyavg(:,2)))
print(sum(var_matrix_pm25dailyavg(:,3)))
print(sum(var_matrix_pm25dailyavg(:,4)))
print(sum(var_matrix_pm25dailyavg(:,5)))
print(sum(var_matrix_pm25dailyavg(:,6)))
print(sum(var_matrix_pm25dailyavg(:,7)))
print(sum(var_matrix_pm25dailyavg(:,8)))
print(sum(var_matrix_pm25dailyavg(:,9)))
print(sum(var_matrix_pm25dailyavg(:,10)))


do i = 0,11
 do j=0,10
  var_matrix_pm25dailyavgpc(i,j) = var_matrix_pm25dailyavg(i,j)/sum(var_matrix_pm25dailyavg(:,j))
  var_matrix_pm25dailyavgpc(i,j) = 100.0 * var_matrix_pm25dailyavgpc(i,j)
  var_matrix_pm25dailyavgpc(i,j) = decimalPlaces(var_matrix_pm25dailyavgpc(i,j) ,2,True)
 end do
end do

print(var_matrix_pm25dailyavgpc)

;---Start the graphics
wks = gsn_open_wks("pdf","zerooutruns-benefit") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "portrait"
res@vpKeepAspect= True
;res@tiMainString     = "12 APEC2 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.8
;res@xyMarkLineMode = "Lines"
;res@xyMarkLineMode = "Markers"
;res@xyMarkLineMode = "MarkLines"               ; Markers *and* lines
;res@xyMarkers      = (/4,5,6,8,4,5,6,8,4,5,6,8/)
res@xyMarkers      = (/1,1,1,1,1,1,1,1,1,1,1,1/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"

res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmXBMinorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMinorOutwardLengthF = 0.0               ; draw tickmarks inward

res@tmXBMajorLengthF = 0.03
res@tmXBMinorLengthF = 0.015

res@tmYLMajorLengthF = 0.03
res@tmYLMinorLengthF = 0.015

;res@xyDashPatterns  = (/2,1,3,0,2,1,3,0,2,1,3,0/)                         ; Make curves all solid
;res@xyDashPatterns  = (/0,2,3,1,0,2,3,1,0,2,3,1/)                         ; Make curves all solid
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
;res@xyLineThicknesses = (/  2.0, 0.5, 1.0, 1.5, 2.0, 0.5, 1.0, 1.5,2.0, 0.5, 1.0, 1.5/)          ; make second line thicker
;res@xyLineColors      = (/"red4","red3","red","orangered","navyblue","royalblue4","royalblue1","deepskyblue","forestgreen","green4","green","springgreen"/)          ; change line color
res@xyLineColors      = (/"red","red","red","red","green4","green4","green4","green4","blue","blue","blue","blue"/)          ; change line color
;res@xyLineOpacities  = (/1.0,0.4,0.6,0.8,1.0,0.4,0.6,0.8,1.0,0.4,0.6,0.8/)
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
  timearr = ispan (0,263,1)
  timearr@units = "hours since 2014-10-21 00:00:00"
  time_axis_labels(timearr,res,restick)
  res@trXMaxF=max(timearr)
  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.04
  res@tmYLLabelFontHeightF = 0.04
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
  res@trYMaxF     =  105
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward

 res@xyLabelMode            = "Custom"           ; label a line
 res@xyExplicitLabels       = (/"I","P","T","R","I","P","T","R","I","P","T","R"/)            ; text to use
 res@xyLineLabelFontHeightF = 0.020              ; font height
; res@xyLineLabelFontColors   = (/"red","red","red","red","green4","green4","green4","green4","blue","blue","blue","blue"/)              ; label color
 res@xyLineLabelFontColors   = (/"black","black","black","black","black","black","black","black","black","black","black","black"/)              ; label color






;  res@pmLegendDisplayMode    = "Always"            ; turn on legend
;  res@pmLegendSide           = "Top"               ; Change location of
;  res@pmLegendParallelPosF   = .85                  ; move units right
;  res@pmLegendOrthogonalPosF = 0              ; move units down
;  res@pmLegendWidthF         = 0.3                ; Change width and
;  res@pmLegendHeightF        = 0.8                ; height of legend.
;  res@lgAutoManage           = False
;  res@lgPerimOn              = False               ; turn off box around
;  res@lgLabelFontHeightF     = .04                 ; label font height
;  res@xyExplicitLegendLabels = (/"obs","baseline","pulse18","pulse19","pulse20","pulse21","pulse22","pulse23","pulse24","pulse25","pulse26","pulse27"/)         ; create explicit labels
;   res@xyExplicitLegendLabels = (/"Beijing","Near Neighbourhood","Far Neighbourhood"/)         ; create explicit labels



  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
 

  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
  plot = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)    ; Create the four plots.

  gres = True
  gres@YPosPercent = 90.    ; expressed as %, 0->100, sets position of top border of legend 
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 5      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)
  gres@ItemSpacePercent = 10.
  lineres = True
  lineres@lgLineColors = (/"red","green4","blue"/) ; line colors
  lineres@lgLineThicknesses = 2.5                        ; line thicknesses
  lineres@LineLengthPercent = 6                         ; expressed as %, 0->100, length of line
  textres = True
  textres@lgLabels = (/"Beijing","Near Neighbourhood","Far Neighbourhood"/)  ; legend labels (required)
  textres@lgLabelFontHeights = (/0.012,0.012,0.012/)
  plot = simple_legend(wks,plot,gres,lineres,textres)

  gres@XPosPercent = 50
  lineres2 = True
  lineres2@lgLineColors = (/"black","black","black","black"/) ; line colors
;  lineres2@lgDashIndexes = (/0,2,3,1/)             ; line patterns  
;  lineres2@lgLineThicknesses = 2.5
  lineres2@LineLengthPercent = 0                         ; expressed as %, 0->100, length of line
  textres2 = True
  textres2@lgLabels = (/"I: Industry","P: Power","T: Transport","R: Residential"/) 
  textres2@lgLabelFontHeights = (/0.012,0.012,0.012,0.012/)
  plot = simple_legend(wks,plot,gres,lineres2,textres2)

  draw(plot)    ; All four plots will be drawn.
  frame(wks)


end
