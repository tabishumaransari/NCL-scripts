; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_zeroemis_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(527,:))

var_matrix_pm25  = new((/3,240/),float) ;120 for 21-25oct
var_matrix_pm10  = new((/3,240/),float)
var_matrix_co    = new((/3,240/),float)
var_matrix_no2   = new((/3,240/),float)
var_matrix_so2   = new((/3,240/),float)
var_matrix_o3    = new((/3,240/),float)

var_matrix_pm25(0,:) = (/data(144:383,0)/)
var_matrix_pm25(1,:) = (/data(144:383,1)/)
var_matrix_pm25(2,:) = (/data(144:383,3)/)
;var_matrix_pm25(3,:) = (/data(144:383,3)/)

var_matrix_pm10(0,:) = (/data(144:383,4)/)
var_matrix_pm10(1,:) = (/data(144:383,5)/)
var_matrix_pm10(2,:) = (/data(144:383,7)/)
;var_matrix_pm10(3,:) = (/data(144:383,7)/)

var_matrix_co(0,:) = (/data(144:383,8)/)
var_matrix_co(1,:) = (/data(144:383,9)/)
var_matrix_co(2,:) = (/data(144:383,11)/)
;var_matrix_co(3,:) = (/data(:,11)/)

var_matrix_no2(0,:) = (/data(144:383,12)/)
var_matrix_no2(1,:) = (/data(144:383,13)/)
var_matrix_no2(2,:) = (/data(144:383,15)/)
;var_matrix_no2(3,:) = (/data(:,15)/)

var_matrix_so2(0,:) = (/data(144:383,16)/)
var_matrix_so2(1,:) = (/data(144:383,17)/)
var_matrix_so2(2,:) = (/data(144:383,19)/)
;var_matrix_so2(3,:) = (/data(:,19)/)

var_matrix_o3(0,:) = (/data(144:383,20)/)
var_matrix_o3(1,:) = (/data(144:383,21)/)
var_matrix_o3(2,:) = (/data(144:383,23)/)
;var_matrix_o3(3,:) = (/data(:,23)/)


;---Start the graphics
wks = gsn_open_wks("x11","Beijing-12st-mean-pol-ts_zeroemiscontrols") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"black","red","blue"/)          ; change line color
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

  timearr = ispan (1,240,1)
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
  res@pmLegendParallelPosF   = .85                  ; move units right
  res@pmLegendOrthogonalPosF = -0.45               ; move units down
  res@pmLegendWidthF         = 0.4                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .04                 ; label font height
  res@xyExplicitLegendLabels = (/"observed","baseline","zeroemis"/)         ; create explicit labels
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
                                                                                                                                                              
  res@tiYAxisString = "SO2 (ppbv)"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_so2,res)

  res@tiYAxisString = "O3 (ppbv)"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)

;  res1                     = True
;  res2                     = True
;  res1@gsnMaximize         = True
;  res2@gsnAttachPlotsXAxis = True

;  xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6/),res1,res2)

;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)


;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
;  resP@gsnPanelMainString = "12 Beijing sites mean time-series"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  resP@gsnPanelXWhiteSpacePercent = 0.0
  gsn_panel(wks,(/xy1,xy2,xy3,xy4,xy5,xy6/),(/6,1/),resP)               ; now draw as one plot



end
