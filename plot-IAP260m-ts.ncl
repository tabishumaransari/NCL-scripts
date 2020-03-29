; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 16
data = readAsciiTable("IAP260m_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(:,0))

var_matrix_oc  = new((/4,696/),float) 
var_matrix_no3 = new((/4,696/),float)
var_matrix_so4 = new((/4,696/),float)
var_matrix_nh4 = new((/4,696/),float)

var_matrix_oc(0,:) = (/data(:,0)/)
var_matrix_oc(1,:) = (/data(:,1)/)
var_matrix_oc(2,:) = (/data(:,2)/)
var_matrix_oc(3,:) = (/data(:,3)/)

var_matrix_no3(0,:) = (/data(:,4)/)
var_matrix_no3(1,:) = (/data(:,5)/)
var_matrix_no3(2,:) = (/data(:,6)/)
var_matrix_no3(3,:) = (/data(:,7)/)

var_matrix_so4(0,:) = (/data(:,8)/)
var_matrix_so4(1,:) = (/data(:,9)/)
var_matrix_so4(2,:) = (/data(:,10)/)
var_matrix_so4(3,:) = (/data(:,11)/)

var_matrix_nh4(0,:) = (/data(:,12)/)
var_matrix_nh4(1,:) = (/data(:,13)/)
var_matrix_nh4(2,:) = (/data(:,14)/)
var_matrix_nh4(3,:) = (/data(:,15)/)

;---Start the graphics
wks = gsn_open_wks("x11","IAP260m-ts") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
;res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "Pollutants at 260m at IAP site"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","black", "black", "red"/)          ; change line color
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
 timearr@units = "hours since 2014-10-15 00:00:00"
 time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.05
  res@tiYAxisFontHeightF = 0.05
  res@tmXBLabelFontHeightF = 0.05
;  res@tmYLLabelFontHeightF = 0.05
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
  
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  ;res@gsnPanelYWhiteSpacePercent = 0.0

  res@gsnPanelTop = 0.0 ;default = 1.0
  res@gsnPanelBottom =0.0 ;default = 0.0
  res@gsnPanelLeft =0.0;default = 0.0
  res@gsnPanelRight=0.0 ;default = 1.0 
  res@gsnBoxMargin = 0.0
  
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = 0               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.3                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .03                 ; label font height
  res@xyExplicitLegendLabels = (/"baseline","APEC-control","Oct-control","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "OC"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_oc,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots


  res@tiYAxisString = "NO3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "NH4"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)

  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4/),res1,res2)

;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)





;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
  resP@gsnPanelMainString = "Pollutants at 260m at IAP site"     ; set main title
  gsn_panel(wks,(/xy1,xy2,xy3,xy4/),(/4,1/),resP)               ; now draw as one plot

end
