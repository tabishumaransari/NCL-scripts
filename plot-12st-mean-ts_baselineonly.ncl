; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(:,0))

var_matrix_pm25  = new((/2,936/),float) ;120 for 21-25oct
var_matrix_pm10  = new((/2,936/),float)
var_matrix_co    = new((/2,936/),float)
var_matrix_no2   = new((/2,936/),float)
var_matrix_so2   = new((/2,936/),float)
var_matrix_o3    = new((/2,936/),float)

var_matrix_pm25(0,:) = (/data(:,1)/)
var_matrix_pm25(1,:) = (/data(:,0)/)
;var_matrix_pm25(2,:) = (/data(:,2)/)
;var_matrix_pm25(3,:) = (/data(:,3)/)

var_matrix_pm10(0,:) = (/data(:,5)/)
var_matrix_pm10(1,:) = (/data(:,4)/)
;var_matrix_pm10(2,:) = (/data(:,6)/)
;var_matrix_pm10(3,:) = (/data(:,7)/)

var_matrix_co(0,:) = (/data(:,9)/)
var_matrix_co(1,:) = (/data(:,8)/)
;var_matrix_co(2,:) = (/data(:,10)/)
;var_matrix_co(3,:) = (/data(:,11)/)

var_matrix_no2(0,:) = (/data(:,13)/)
var_matrix_no2(1,:) = (/data(:,12)/)
;var_matrix_no2(2,:) = (/data(:,14)/)
;var_matrix_no2(3,:) = (/data(:,15)/)

var_matrix_so2(0,:) = (/data(:,17)/)
var_matrix_so2(1,:) = (/data(:,16)/)
;var_matrix_so2(2,:) = (/data(:,18)/)
;var_matrix_so2(3,:) = (/data(:,19)/)

var_matrix_o3(0,:) = (/data(:,21)/)
var_matrix_o3(1,:) = (/data(:,20)/)
;var_matrix_o3(2,:) = (/data(:,22)/)
;var_matrix_o3(3,:) = (/data(:,23)/)


;---Start the graphics
wks = gsn_open_wks("x11","Beijing-12st-mean-pol-ts_baselineonly") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"red","black"/)          ; change line color
;res@gsnXRefLine = (/ 529, 745 /)
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
;  restick@ttmFormat = "%D"
  restick@ttmFormat = "%D/%N"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 48
  restick@ttmMinorStride= 24

  timearr = ispan (1,936,1)
  timearr@units = "hours since 2014-10-12 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.027
  res@tmYLLabelFontHeightF = 0.027
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
  res@pmLegendParallelPosF   = .88                  ; move units right
  res@pmLegendOrthogonalPosF = -0.45               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .04                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5 (ug/m3)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  res@tiYAxisString = "PM10 (ug/m3)"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_pm10,res)    ; They won't be drawn yet.

  res@tiYAxisString = "CO (ppbv)"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_co,res)

  res@tiYAxisString = "NO2 (ppbv)"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_no2,res)
  res@trYMaxF     =  30                                                                                                                                                            
  res@tiYAxisString = "SO2 (ppbv)"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_so2,res)

res@trYMaxF     =  60

  res@tiYAxisString = "O3 (ppbv)"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)


txres = True
txres@txFontHeightF = 0.012
gsn_text_ndc(xy1,"APEC Controls",0.635,0.97,txres) ; . = draw arrow pointing



;  res1                     = True
;  res2                     = True
;  res1@gsnMaximize         = True
;  res2@gsnAttachPlotsXAxis = True

;  xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6/),res1,res2)

;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)


  xmin = 529
  xmax = 745
  ymin = 0
  ymax = 3500
  xpg  = (/xmin,xmax,xmax,xmin,xmin/)
  ypg  = (/ymin,ymin,ymax,ymax,ymin/)

 pgres = True
 pgres@gsFillColor    = "black"
 pgres@gsFillOpacityF = 0.1
 dum1 = gsn_add_polygon   (wks, xy1, xpg, ypg, pgres)

 dum2 = gsn_add_polygon   (wks, xy2, xpg, ypg, pgres)

 dum3 = gsn_add_polygon   (wks, xy3, xpg, ypg, pgres)

 dum4 = gsn_add_polygon   (wks, xy4, xpg, ypg, pgres)

 dum5 = gsn_add_polygon   (wks, xy5, xpg, ypg, pgres)
 
 dum6 = gsn_add_polygon   (wks, xy6, xpg, ypg, pgres)







;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
;  resP@gsnPanelMainString = "12 Beijing sites mean time-series"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  resP@gsnPanelXWhiteSpacePercent = 0.0
  gsn_panel(wks,(/xy1,xy2,xy3,xy4,xy5,xy6/),(/6,1/),resP)               ; now draw as one plot



end
