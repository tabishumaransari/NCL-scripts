;TO PLOT IAP TOWERMET VS WRF DATA WITH IMPROVED AUTOMATIC FUNCTIONS FOR WS AND WD
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

ncol = 40
data = readAsciiTable("IAPtowermet-5lev_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

var_matrix_T0  = new((/2,745/),float)
var_matrix_T1  = new((/2,745/),float)
var_matrix_T2  = new((/2,745/),float)
var_matrix_T3  = new((/2,745/),float)
var_matrix_T4  = new((/2,745/),float)

var_matrix_RH0  = new((/2,745/),float)
var_matrix_RH1  = new((/2,745/),float)
var_matrix_RH2  = new((/2,745/),float)
var_matrix_RH3  = new((/2,745/),float)
var_matrix_RH4  = new((/2,745/),float)

var_matrix_WS0  = new((/2,745/),float)
var_matrix_WS1  = new((/2,745/),float)
var_matrix_WS2  = new((/2,745/),float)
var_matrix_WS3  = new((/2,745/),float)
var_matrix_WS4  = new((/2,745/),float)

var_matrix_WD0  = new((/2,745/),float)
var_matrix_WD1  = new((/2,745/),float)
var_matrix_WD2  = new((/2,745/),float)
var_matrix_WD3  = new((/2,745/),float)
var_matrix_WD4  = new((/2,745/),float)

var_matrix_T0(0,:) = (/data(:,0)/)
var_matrix_T0(1,:) = (/data(:,1)/)
var_matrix_T1(0,:) = (/data(:,2)/)
var_matrix_T1(1,:) = (/data(:,3)/)
var_matrix_T2(0,:) = (/data(:,4)/)
var_matrix_T2(1,:) = (/data(:,5)/)
var_matrix_T3(0,:) = (/data(:,6)/)
var_matrix_T3(1,:) = (/data(:,7)/)
var_matrix_T4(0,:) = (/data(:,8)/)
var_matrix_T4(1,:) = (/data(:,9)/)

var_matrix_RH0(0,:) = (/data(:,10)/)
var_matrix_RH0(1,:) = (/data(:,11)/)
var_matrix_RH1(0,:) = (/data(:,12)/)
var_matrix_RH1(1,:) = (/data(:,13)/)
var_matrix_RH2(0,:) = (/data(:,14)/)
var_matrix_RH2(1,:) = (/data(:,15)/)
var_matrix_RH3(0,:) = (/data(:,16)/)
var_matrix_RH3(1,:) = (/data(:,17)/)
var_matrix_RH4(0,:) = (/data(:,18)/)
var_matrix_RH4(1,:) = (/data(:,19)/)

var_matrix_WS0(0,:) = (/data(:,20)/)
var_matrix_WS0(1,:) = (/data(:,21)/)
var_matrix_WS1(0,:) = (/data(:,22)/)
var_matrix_WS1(1,:) = (/data(:,23)/)
var_matrix_WS2(0,:) = (/data(:,24)/)
var_matrix_WS2(1,:) = (/data(:,25)/)
var_matrix_WS3(0,:) = (/data(:,26)/)
var_matrix_WS3(1,:) = (/data(:,27)/)
var_matrix_WS4(0,:) = (/data(:,28)/)
var_matrix_WS4(1,:) = (/data(:,29)/)

var_matrix_WD0(0,:) = (/data(:,30)/)
var_matrix_WD0(1,:) = (/data(:,31)/)
var_matrix_WD1(0,:) = (/data(:,32)/)
var_matrix_WD1(1,:) = (/data(:,33)/)
var_matrix_WD2(0,:) = (/data(:,34)/)
var_matrix_WD2(1,:) = (/data(:,35)/)
var_matrix_WD3(0,:) = (/data(:,36)/)
var_matrix_WD3(1,:) = (/data(:,37)/)
var_matrix_WD4(0,:) = (/data(:,38)/)
var_matrix_WD4(1,:) = (/data(:,39)/)


timearr = ispan (1,745,1)
timearr@units = "hours since 2014-10-12 00:00:00"

;---Start the graphics
wks = gsn_open_wks("pdf","IAP_towermet_controlrunECMWF") ; send graphics to PNG file
gsnPaperOrientation = "landscape"
;---Plotting options for time series plot
res             = True
res@gsnMaximize = False
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","black"/)          ; change line color
res@trXMaxF=max(timearr)
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.06
  res@tiYAxisFontHeightF = 0.06
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = False    ; Turn on right labels
  res@tmYRMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmXBLabelFontHeightF = 0.05   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.60               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiMainString     = "Temperature at IAP tower"          ; add title
  res@tiYAxisString = "T_lev4(degC)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_T4,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "T_lev3(degC)"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_T3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "T_lev2(degC)"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_T2,res)

  res@tiYAxisString = "T_lev1(degC)"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_T1,res)

  res@tiYAxisString = "T_lev0(degC)"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_T0,res)

  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid1 = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)
print(dimsizes(amid1))
;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Wind Speed at IAP tower"          ; add title
  res@tiYAxisString = "WS_lev4(m/s)"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_WS4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "WS_lev3(m/s)"
  xy7 = gsn_csm_xy(wks,timearr,var_matrix_WS3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "WS_lev2(m/s)"
  xy8 = gsn_csm_xy(wks,timearr,var_matrix_WS2,res)

  res@tiYAxisString = "WS_lev1(m/s)"
  xy9 = gsn_csm_xy(wks,timearr,var_matrix_WS1,res)

  res@tiYAxisString = "WS_lev0(m/s)"
  xy10 = gsn_csm_xy(wks,timearr,var_matrix_WS0,res)

 amid2 = gsn_attach_plots(xy6,(/xy7,xy8,xy9,xy10/),res1,res2)
;draw(xy1)
;frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Relative Humidity at IAP tower"          ; add title
  res@tiYAxisString = "RH_lev4(%)"
  xy11 = gsn_csm_xy(wks,timearr,var_matrix_RH4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "RH_lev3(%)"
  xy12 = gsn_csm_xy(wks,timearr,var_matrix_RH3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "RH_lev2(%)"
  xy13 = gsn_csm_xy(wks,timearr,var_matrix_RH2,res)

  res@tiYAxisString = "RH_lev1(%)"
  xy14 = gsn_csm_xy(wks,timearr,var_matrix_RH1,res)

  res@tiYAxisString = "RH_lev0(%)"
  xy15 = gsn_csm_xy(wks,timearr,var_matrix_RH0,res)

 amid3 = gsn_attach_plots(xy11,(/xy12,xy13,xy14,xy15/),res1,res2)
;draw(xy1)
;frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  res@xyMarkers      = (/4,4/)  
;  res@xyDashPatterns  = (/2,2/)                         ; Make curves all dashed
  res@tiMainString     = "Wind Direction at IAP tower"          ; add title
  
  res@trYMaxF     =  360
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,90,180,270,360/)
  res@tmYLLabels      = "" + res@tmYLValues
  res@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)

  res@tiYAxisString = "WD_lev4(deg)"
  xy16 = gsn_csm_xy(wks,timearr,var_matrix_WD4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "WD_lev3(deg)"
  xy17 = gsn_csm_xy(wks,timearr,var_matrix_WD3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "WD_lev2(deg)"
  xy18 = gsn_csm_xy(wks,timearr,var_matrix_WD2,res)

  res@tiYAxisString = "WD_lev1(deg)"
  xy19 = gsn_csm_xy(wks,timearr,var_matrix_WD1,res)

  res@tiYAxisString = "WD_lev0(deg)"
  xy20 = gsn_csm_xy(wks,timearr,var_matrix_WD0,res)

 amid4 = gsn_attach_plots(xy16,(/xy17,xy18,xy19,xy20/),res1,res2)
;draw(xy1)
;frame(wks)

;************************************************
; create panel
;************************************************
gsn_panel(wks,(/xy1,xy11,xy6,xy16/),(/2,2/),False)             ; now draw as one plot


end
