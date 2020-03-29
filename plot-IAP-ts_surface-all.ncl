; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 32
data = readAsciiTable("IAP_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(:,0))

var_matrix_oc  = new((/4,696/),float) 
var_matrix_bc  = new((/4,696/),float)
var_matrix_no3 = new((/4,696/),float)
var_matrix_so4 = new((/4,696/),float)
var_matrix_nh4 = new((/4,696/),float)
var_matrix_co  = new((/4,696/),float)
var_matrix_no2 = new((/4,696/),float)
var_matrix_o3  = new((/4,696/),float)

var_matrix_oc(0,:) = (/data(:,0)/)
var_matrix_oc(1,:) = (/data(:,1)/)
var_matrix_oc(2,:) = (/data(:,2)/)
var_matrix_oc(3,:) = (/data(:,3)/)

var_matrix_bc(0,:) = (/data(:,4)/)
var_matrix_bc(1,:) = (/data(:,5)/)
var_matrix_bc(2,:) = (/data(:,6)/)
var_matrix_bc(3,:) = (/data(:,7)/)

var_matrix_no3(0,:) = (/data(:,8)/)
var_matrix_no3(1,:) = (/data(:,9)/)
var_matrix_no3(2,:) = (/data(:,10)/)
var_matrix_no3(3,:) = (/data(:,11)/)

var_matrix_so4(0,:) = (/data(:,12)/)
var_matrix_so4(1,:) = (/data(:,13)/)
var_matrix_so4(2,:) = (/data(:,14)/)
var_matrix_so4(3,:) = (/data(:,15)/)

var_matrix_nh4(0,:) = (/data(:,16)/)
var_matrix_nh4(1,:) = (/data(:,17)/)
var_matrix_nh4(2,:) = (/data(:,18)/)
var_matrix_nh4(3,:) = (/data(:,19)/)

var_matrix_co(0,:) = (/data(:,20)/)
var_matrix_co(1,:) = (/data(:,21)/)
var_matrix_co(2,:) = (/data(:,22)/)
var_matrix_co(3,:) = (/data(:,23)/)

var_matrix_no2(0,:) = (/data(:,24)/)
var_matrix_no2(1,:) = (/data(:,25)/)
var_matrix_no2(2,:) = (/data(:,26)/)
var_matrix_no2(3,:) = (/data(:,27)/)

var_matrix_o3(0,:) = (/data(:,28)/)
var_matrix_o3(1,:) = (/data(:,29)/)
var_matrix_o3(2,:) = (/data(:,30)/)
var_matrix_o3(3,:) = (/data(:,31)/)


;---Start the graphics
wks = gsn_open_wks("x11","IAP-ts") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
;res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "Surface pollutants at IAP site"          ; add title
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
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.05
  res@tmXBLabelFontHeightF = 0.05
  res@tmYLLabelFontHeightF = 0.05
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = False    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYLLabelStride      = 1
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  res@tmEqualizeXYSizes    = True
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  ;res@gsnPanelYWhiteSpacePercent = 0.0
  
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.6               ; move units down
  res@pmLegendWidthF         = 0.4                ; Change width and
  res@pmLegendHeightF        = 0.20                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"baseline","APEC-control","Oct-control","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "OC"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_oc,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "BC"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_bc,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "NH4"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)

  res@tiYAxisString = "CO"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_co,res)

  res@tiYAxisString = "NO2"
  xy7 = gsn_csm_xy(wks,timearr,var_matrix_no2,res)

  res@tiYAxisString = "O3"
  xy8 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)


  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8/),res1,res2)

 ; draw(xy1)    ; All four plots will be drawn.
 ; frame(wks)





;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
  ;resP@gsnPanelMainString = "Surface pollutants at IAP site"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  gsn_panel(wks,(/xy1,xy2,xy3,xy4,xy5,xy6,xy7,xy8/),(/8,1/),resP)               ; now draw as one plot

end
