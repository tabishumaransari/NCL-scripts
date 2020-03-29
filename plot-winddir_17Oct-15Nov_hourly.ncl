; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/home/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 5
data = readAsciiTable("winddir_17Oct-15Nov_hourly.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(:,4))

wd_d02avg     = (/data(:,0)/)
wd_d03avg     = (/data(:,1)/)
wd_APEC2avg   = (/data(:,2)/)
wd_Beijingavg = (/data(:,3)/)
wd_IAP        = (/data(:,4)/)
;wd_IAP = where(wd_IAP.lt.50,wd_IAP+50,wd_IAP)

;---Start the graphics
wks = gsn_open_wks("x11","winddir_17Oct-15Nov_hourly_ts") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
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
  restick@ttmFormat = "%D"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 48
  restick@ttmMinorStride= 24

  timearr = ispan (1,696,1)
  timearr@units = "hours since 2014-10-18 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
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
  
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 0.1                  ; move units right
  res@pmLegendOrthogonalPosF = -0.50               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"D02avg","D03avg","APEC2avg","Beijingavg","IAP"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "Wind Direction (deg)"
  res@trYMaxF     =  360
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,90,180,270,360/)
  res@tmYLLabels      = "" + res@tmYLValues
  res@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)
  xy1 = gsn_csm_xy(wks,timearr,(/wd_d02avg, wd_d03avg, wd_APEC2avg, wd_Beijingavg, wd_IAP/),res)    ; Create the four plots.

  draw(xy1)
frame(wks)

end
