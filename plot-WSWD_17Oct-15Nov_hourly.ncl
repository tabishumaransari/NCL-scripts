; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/home/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

ncol = 5
data1 = readAsciiTable("windspeed_17Oct-15Nov_hourly.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data1@_FillValue = -999
print("windspeed table read-in successfully")
print("Avg wind speed for 23 October is "+ avg(data1(120:143,1)))
print("Avg wind speed for 24 October is "+ avg(data1(144:167,1)))
print("Avg wind speed for 29 October is "+ avg(data1(264:287,1)))
print("Avg wind speed for 30 October is "+ avg(data1(288:311,1)))

ws_d02avg     = (/data1(:,0)/)
ws_d03avg     = (/data1(:,1)/)
ws_APEC2avg   = (/data1(:,2)/)
ws_Beijingavg = (/data1(:,3)/)
ws_IAP        = (/data1(:,4)/)


data2 = readAsciiTable("winddir_17Oct-15Nov_hourly.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2@_FillValue = -999 
print("wind-direction table read-in successfully")
;print(data(:,4))

wd_d02avg     = (/data2(:,0)/)
wd_d03avg     = (/data2(:,1)/)
wd_APEC2avg   = (/data2(:,2)/)
wd_Beijingavg = (/data2(:,3)/)
wd_IAP        = (/data2(:,4)/)
;wd_IAP = where(wd_IAP.lt.50,wd_IAP+50,wd_IAP)

;---Start the graphics
wks = gsn_open_wks("x11","WSWD_17Oct-15Nov_hourly_ts") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = False
;res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0/)
res@tmXTOn      = False
;res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"black","red", "blue", "magenta", "darkgreen"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12

  timearr = ispan (0,695,1)
  timearr@units = "hours since 2014-10-18 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.016
  res@tmXBLabelFontHeightF = 0.016
  res@tmYLLabelFontHeightF = 0.016
  ;res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYLLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  
  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  res@tmXBMajorLengthF     = 0.02
  res@tmXBMinorLengthF     = 0.01
  res@tmYLMajorLengthF     = 0.02
  res@tmYLMinorLengthF     = 0.01


 
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 0.15                  ; move units right
  res@pmLegendOrthogonalPosF = -0.40               ; move units down
  res@pmLegendWidthF         = 0.2                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"D02 avg","D03 avg","Near-neighbourhood avg","Beijing avg","IAP site"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
  res@tiYAxisString = "Wind Speed (ms~S~-1~N~)"
  xy1 = gsn_csm_xy(wks,timearr,(/ws_d02avg, ws_d03avg, ws_APEC2avg, ws_Beijingavg, ws_IAP/),res)    ; Create the four plots.

; Change y axis string and y-axis for wind direction plot.
  res@tiYAxisString = "Wind Direction (~S~o~N~)"
  res@tiYAxisOffsetXF = 0.007 
  res@trYMaxF     =  360
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,90,180,270,360/)
  res@tmYLLabels      = "" + res@tmYLValues
  res@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)
  res@pmLegendDisplayMode    = "Never"            ; turn on legend
  xy2 = gsn_csm_xy(wks,timearr,(/wd_d02avg, wd_d03avg, wd_APEC2avg, wd_Beijingavg, wd_IAP/),res)    ; Create the four plots.


;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
  resP@gsnPanelYWhiteSpacePercent = 0.0
  resP@gsnPanelXWhiteSpacePercent = 0.0
  gsn_panel(wks,(/xy1,xy2/),(/2,1/),resP)               ; now draw as one plot

end
