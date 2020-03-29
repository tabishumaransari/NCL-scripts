; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

ncol = 8
data = readAsciiTable("IAPtowermet_modlev3_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
;print(data(:,0))

var_matrix_T3   = new((/2,745/),float) ;120 for 21-25oct
var_matrix_RH3  = new((/2,745/),float)
var_matrix_WS3   = new((/2,745/),float)
var_matrix_WD3   = new((/2,745/),float)

var_matrix_T3(0,:) = (/data(:,0)/)
var_matrix_T3(1,:) = (/data(:,1)/)

var_matrix_RH3(0,:) = (/data(:,2)/)
var_matrix_RH3(1,:) = (/data(:,3)/)

var_matrix_WS3(0,:) = (/data(:,4)/)
var_matrix_WS3(1,:) = (/data(:,5)/)

var_matrix_WD3(0,:) = (/data(:,6)/)
var_matrix_WD3(1,:) = (/data(:,7)/)

timearr = ispan (1,745,1)
timearr@units = "hours since 2014-10-12 00:00:00"

;---Start the graphics
wks = gsn_open_wks("pdf","IAP_towermet-modlev3") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"red","black"/)          ; change line color
res@trXMaxF=max(timearr)
;res@gsnXRefLine = (/ 529 /) 
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
;  restick@ttmFormat = "%D"
  restick@ttmFormat = "%D/%N"
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 48
  restick@ttmMinorStride= 24
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
; res@tiYAxisString      = "PM 2.5 in ug/m^3"
;  res@tiMainFontHeightF  = 0.035
  res@tiYAxisFontHeightF = 0.035
  
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmXBLabelFontHeightF = 0.03   ; Increase font height
  res@tmYLLabelFontHeightF = 0.03   ; Increase font height
  ;res@tmYRLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.3               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.10                ; height of legend.
  
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .035                 ; label font height
  
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
;  res@tiMainString     = "Temperature at IAP tower"          ; add title
  res@tiYAxisString = "T (degC)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_T3,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  res@tiYAxisString = "RH (%)"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_RH3,res)    ; They won't be drawn yet.
  res@tiYAxisString = "WS (m/s)"
  res@trYMaxF     =  18	
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_WS3,res)    ; They won't be drawn yet.
;  res@xyMarkers      = (/4,4/)
;  res@xyDashPatterns  = (/2,2/)                         ; Make curves all dashed
  res@tiYAxisString = "WD (deg)"
  res@trYMaxF     =  360	
  res@tmYLMode        = "Explicit"	
  res@tmYLValues      = (/0,90,180,270,360/)
  res@tmYLLabels      = "" + res@tmYLValues 
  res@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)

  xy4 = gsn_csm_xy(wks,timearr,var_matrix_WD3,res)    ; They won't be drawn yet.



txres = True
txres@txFontHeightF = 0.015
gsn_text_ndc(xy1,"APEC",0.85,0.91,txres) ; . = draw arrow pointing 




  xmin = 529
  xmax = 745
  ymin = 0
  ymax = 360
  xpg  = (/xmin,xmax,xmax,xmin,xmin/)
  ypg  = (/ymin,ymin,ymax,ymax,ymin/)

 pgres = True
 pgres@gsFillColor    = "black"
 pgres@gsFillOpacityF = 0.1
 dum1 = gsn_add_polygon   (wks, xy1, xpg, ypg, pgres)

 dum2 = gsn_add_polygon   (wks, xy2, xpg, ypg, pgres)

 dum3 = gsn_add_polygon   (wks, xy3, xpg, ypg, pgres)

 dum4 = gsn_add_polygon   (wks, xy4, xpg, ypg, pgres)


;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0 
gsn_panel(wks,(/xy1,xy2,xy3,xy4/),(/4,1/),resP)             ; now draw as one plot


end

