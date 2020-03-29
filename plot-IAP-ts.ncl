; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 32
data = readAsciiTable("IAP_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table-surface read-in successfully")
;print(data(:,0))

ncol = 16
data2 = readAsciiTable("IAP260m_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2@_FillValue = -999
print("table-260m read-in successfully")

;SINCE BC-260 ISN'T INCLUDED IN THE TEXT FILE IT HAS TO BE READ IN FROM WRF FILES
;DATADir1 = "/mnt/rasher/control-run-so4-ECMWF/"
;FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
;a = addfiles(FILES1,"r")
;print("all wrf files loaded.")
;I=79
;J=144
;bc_sim_260    = a[:]->bc_a01(:,3,J,I) + a[:]->bc_a02(:,3,J,I) +a[:]->bc_a03(:,3,J,I) +a[:]->bc_a04(:,3,J,I) + 0.6 * a[:]->bc_a05(:,3,J,I)
;bc_sim_260_subset = bc_sim_260(112:807)
;bc_sim_260_subset  = 1.15 * bc_sim_260_subset ;UNIT CORRECTION FROM ug/kg TO ug/m3

;LET'S WRITE THIS ARRAY INTO A TEXT FILE FOR SUBSEQUENT USE
;asciiwrite ("bc_sim260subset_ts.txt" , sprintf("%9.4f", bc_sim_260_subset ))

ncol = 1
data3 = readAsciiTable("bc_sim260subset_ts.txt", ncol, "float", 0); NO HEADER
data3@_FillValue = -999
print("bc-sim-260m array read-in successfully")
printVarSummary(data3)


var_matrix_oc  = new((/2,696/),float) 
var_matrix_bc  = new((/2,696/),float)
var_matrix_no3 = new((/2,696/),float)
var_matrix_so4 = new((/2,696/),float)
var_matrix_nh4 = new((/2,696/),float)


var_matrix_oc_260  = new((/2,696/),float)
var_matrix_bc_260  = new((/2,696/),float)
var_matrix_no3_260 = new((/2,696/),float)
var_matrix_so4_260 = new((/2,696/),float)
var_matrix_nh4_260 = new((/2,696/),float)


var_matrix_oc(0,:) = (/data(:,0)/)
var_matrix_oc(1,:) = (/data(:,3)/)

var_matrix_bc(0,:) = (/data(:,4)/)
var_matrix_bc(1,:) = (/data(:,7)/)

var_matrix_no3(0,:) = (/data(:,8)/)
var_matrix_no3(1,:) = (/data(:,11)/)

var_matrix_so4(0,:) = (/data(:,12)/)
var_matrix_so4(1,:) = (/data(:,15)/)

var_matrix_nh4(0,:) = (/data(:,16)/)
var_matrix_nh4(1,:) = (/data(:,19)/)


var_matrix_oc_260(0,:) = (/data2(:,0)/)
var_matrix_oc_260(1,:) = (/data2(:,3)/)

var_matrix_bc_260(0,:) = data3
;var_matrix_bc_260(1,:) = 

var_matrix_no3_260(0,:) = (/data2(:,4)/)
var_matrix_no3_260(1,:) = (/data2(:,7)/)

var_matrix_so4_260(0,:) = (/data2(:,8)/)
var_matrix_so4_260(1,:) = (/data2(:,11)/)

var_matrix_nh4_260(0,:) = (/data2(:,12)/)
var_matrix_nh4_260(1,:) = (/data2(:,15)/)



;---Start the graphics
wks = gsn_open_wks("pdf","IAP-pol-ts_surface-260m_panel") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
;res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "Surface pollutants at IAP site"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"red","black"/)          ; change line color
;res@gsnXRefLine = (/ 457 /)

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
 timearr = ispan (1,696,1)
 timearr@units = "hours since 2014-10-15 00:00:00"
 time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.03
  res@tmYLLabelFontHeightF = 0.04
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
  
;  res@pmLegendDisplayMode    = "Always"            ; turn on legend
;  res@pmLegendSide           = "Top"               ; Change location of
;  res@pmLegendParallelPosF   = .85                  ; move units right
;  res@pmLegendOrthogonalPosF = -0.5               ; move units down
;  res@pmLegendWidthF         = 0.4                ; Change width and
;  res@pmLegendHeightF        = 0.15                ; height of legend.
;  res@lgPerimOn              = False               ; turn off box around
;  res@lgLabelFontHeightF     = .05                 ; label font height
;  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "OC (ug/m3)"
  res@trYMaxF = 200
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_oc,res)    ; Create the four plots.

;  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "BC (ug/m3)"
  res@trYMaxF = 35
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_bc,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3 (ug/m3)"
  res@trYMaxF = 180
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4 (ug/m3)"
  res@trYMaxF = 70
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "NH4 (ug/m3)"
  res@trYMaxF = 70
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .53                  ; move units right
  res@pmLegendOrthogonalPosF = -0.4               ; move units down
  res@pmLegendWidthF         = 0.4                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels

  res@tiYAxisString = "OC (ug/m3)"
  res@trYMaxF = 200
  xy11 = gsn_csm_xy(wks,timearr,var_matrix_oc_260,res)    ; Create the four plots.

res@pmLegendDisplayMode    = "Never" 
  res@tiYAxisString = "BC (ug/m3)"
  res@trYMaxF = 35
  xy12 = gsn_csm_xy(wks,timearr,var_matrix_bc_260,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3 (ug/m3)"
  res@trYMaxF = 180
  xy13 = gsn_csm_xy(wks,timearr,var_matrix_no3_260,res)

  res@tiYAxisString = "SO4 (ug/m3)"
  res@trYMaxF = 70
  xy14 = gsn_csm_xy(wks,timearr,var_matrix_so4_260,res)

  res@tiYAxisString = "NH4 (ug/m3)"
  res@trYMaxF = 70
  xy15 = gsn_csm_xy(wks,timearr,var_matrix_nh4_260,res)


txres = True
txres@txFontHeightF = 0.01
gsn_text_ndc(xy1,"APEC Controls",0.423,0.8,txres)


  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)
;  amid = gsn_attach_plots(xy11,(/xy12,xy13,xy14,xy15/),res1,res2)

 ; draw(xy1)    ; All four plots will be drawn.
 ; frame(wks)

  xmin = 457
  xmax = 695
  ymin = 0
  ymax = 200
  xpg  = (/xmin,xmax,xmax,xmin,xmin/)
  ypg  = (/ymin,ymin,ymax,ymax,ymin/)

 pgres = True
 pgres@gsFillColor    = "black"
 pgres@gsFillOpacityF = 0.1
 dum1 = gsn_add_polygon   (wks, xy1, xpg, ypg, pgres)
 dum11 = gsn_add_polygon   (wks, xy11, xpg, ypg, pgres)

 ymax = 35
 dum2 = gsn_add_polygon   (wks, xy2, xpg, ypg, pgres)
 dum12 = gsn_add_polygon   (wks, xy12, xpg, ypg, pgres)

 ymax = 180
 dum3 = gsn_add_polygon   (wks, xy3, xpg, ypg, pgres)
 dum13 = gsn_add_polygon   (wks, xy13, xpg, ypg, pgres)

 ymax = 70
 dum4 = gsn_add_polygon   (wks, xy4, xpg, ypg, pgres)
 dum14 = gsn_add_polygon   (wks, xy14, xpg, ypg, pgres)

 ymax = 70
 dum5 = gsn_add_polygon   (wks, xy5, xpg, ypg, pgres)
 dum15 = gsn_add_polygon   (wks, xy15, xpg, ypg, pgres)

;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
  ;resP@gsnPanelMainString = "Surface pollutants at IAP site"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  gsn_panel(wks,(/xy1,xy11,xy2,xy12,xy3,xy13,xy4,xy14,xy5,xy15/),(/5,2/),resP)               ; now draw as one plot
 ; gsn_panel(wks,(/xy1,xy11/),(/1,2/),resP)               ; now draw as one plot

end
