; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
;LETS READ RUN0 (BASELINE) DATA. THIS HAS 264 ROWS AND 1 COLUMN
ncol = 1
data = readAsciiTable("run0_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
printVarSummary(data)

baseline_hourly = new(264,float)
baseline_hourly = data(:,0)

baseline_daily = new(264,float)
;CALCULATE DAILY MEAN VALUES
c=0
do i =0,263,24
 print("i="+i)
 baseline_daily(i:i+23) = avg(baseline_hourly(i:i+23))
end do

baseline_array= new((/2,264/),float)
baseline_array(0,:) = baseline_hourly
baseline_array(1,:) = baseline_daily



;---Start the graphics
wks = gsn_open_wks("x11","baseline_hourly-daily_ts") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "portrait"
res@vpKeepAspect=False
res@vpWidthF    = 2
res@vpHeightF   = 0.8
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@tmXBMajorOutwardLengthF = 0.0
res@tmXBMinorOutwardLengthF = 0.0
res@tmYLMajorOutwardLengthF = 0.0
res@tmYLMinorOutwardLengthF = 0.0
res@xyMarkLineMode =  "Lines" 
res@xyDashPatterns  = (/0,2/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"black","black"/)          ; change line color
res@gsnYRefLineColor = (/"green","blue"/) 
res@gsnYRefLine = (/ 75,150 /) 

txres               = True
txres@txFontHeightF = 0.010
gsn_text_ndc(wks,"PM~B~2.5~N~=75 ~F33~m~F21~gm~S~-3~N~; AQI=100",0.38,0.412,txres)
gsn_text_ndc(wks,"PM~B~2.5~N~=150 ~F33~m~F21~gm~S~-3~N~; AQI=200",0.38,0.465,txres)




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
  res@tmXBMajorLengthF     = 0.025
  res@tmXBMinorLengthF     = 0.0125
  res@tmYLMajorLengthF     = 0.025
  res@tmYLMinorLengthF     = 0.0125

  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
 ; res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

;LEGENDS
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .1                  ; move units right
  res@pmLegendOrthogonalPosF = -0.4                ; move units down
  res@pmLegendWidthF         = 0.15                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .03                 ; label font height
  res@xyExplicitLegendLabels = (/"Hourly","Daily mean"/)         ; create explicit labels




  plot1 = gsn_csm_xy(wks,timearr,baseline_array,res)



end
