;TIME-SERIES OF NH3 SENSITIVITY RUN WITH CONTROL RUN AND OBS AT IAP DURING 21OCT-25OCT

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

ncol = 12
data = readAsciiTable("NH3sens_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("NH3sens_ts.txt read-in successfully")

timearr = ispan (1,120,1)
timearr@units = "hours since 2014-10-21 00:00:00"

var_matrix_no3  = new((/3,120/),float)  
var_matrix_nh4  = new((/3,120/),float)  
var_matrix_so4  = new((/3,120/),float)  
var_matrix_pm25  = new((/3,120/),float)  
 
var_matrix_no3(0,:) = (/data(:,0)/)
var_matrix_no3(1,:) = (/data(:,1)/)
var_matrix_no3(2,:) = (/data(:,2)/)

var_matrix_nh4(0,:) = (/data(:,3)/)
var_matrix_nh4(1,:) = (/data(:,4)/)
var_matrix_nh4(2,:) = (/data(:,5)/)

var_matrix_so4(0,:) = (/data(:,6)/)
var_matrix_so4(1,:) = (/data(:,7)/)
var_matrix_so4(2,:) = (/data(:,8)/)

var_matrix_pm25(0,:) = (/data(:,9)/)
var_matrix_pm25(1,:) = (/data(:,10)/)
var_matrix_pm25(2,:) = (/data(:,11)/)


;CALCULATE AVERAGES OF EACH TIME SERIES
no3_sim_baseline_avg = avg(data(:,0))
no3_sim_nh3sens_avg  = avg(data(:,1))
no3_obs_avg          = avg(data(:,2))

nh4_sim_baseline_avg = avg(data(:,3))
nh4_sim_nh3sens_avg  = avg(data(:,4))
nh4_obs_avg         = avg(data(:,5))

so4_sim_baseline_avg = avg(data(:,6))
so4_sim_nh3sens_avg  = avg(data(:,7))
so4_obs_avg          = avg(data(:,8))

pm25_sim_baseline_avg = avg(data(:,9))
pm25_sim_nh3sens_avg  = avg(data(:,10))
pm25_obs_avg          = avg(data(:,11))


print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO3-CONTROL      ="+no3_sim_baseline_avg )
print("NO3-SENSITIVITY  ="+no3_sim_nh3sens_avg )
print("NO3-OBS          ="+no3_obs_avg )
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NH4-CONTROL      ="+nh4_sim_baseline_avg  )
print("NH4-SENSITIVITY  ="+nh4_sim_nh3sens_avg )
print("NH4-OBS          ="+nh4_obs_avg )
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO4-CONTROL      ="+so4_sim_baseline_avg )
print("SO4-SENSITIVITY  ="+so4_sim_nh3sens_avg )
print("SO4-OBS          ="+so4_obs_avg )
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("PM2.5-CONTROL    ="+pm25_sim_baseline_avg )
print("PM2.5-SENSITIVITY="+pm25_sim_nh3sens_avg  )
print("PM2.5-OBS        ="+pm25_obs_avg )
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")





;---Start the graphics
wks = gsn_open_wks("pdf","NH3sensitivity_ts") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Effect of NH3 emissions reduction"          ; add title
;res@gsnMaximize = True
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0/)  
res@tmXTOn      = False
res@tmXBLabelDeltaF      = -0.8     ; Increase space b/w ticks and labels
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0, 1.0  /)          ; make second line thicker
res@xyLineColors      = (/"red","blue","black"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 3
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.04
  res@tiYAxisFontHeightF = 0.04
  res@tmYUseLeft           = True   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYLLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = 0.16                  ; move units right
  res@pmLegendOrthogonalPosF = -.4               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .035                 ; label font height
  res@xyExplicitLegendLabels = (/"baseline","NH3-sensitivity","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "NH4 (ug/m3)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  

  res@tiYAxisString = "NO3 (ug/m3)"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4 (ug/m3)"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "PM2.5 (ug/m3)"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)

;  res1                     = True
;  res2                     = True
;  res1@gsnMaximize         = True
;  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4/),res1,res2)

;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)

;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/xy1,xy2,xy3,xy4/),(/4,1/),resP)             ; now draw as one plot



end
