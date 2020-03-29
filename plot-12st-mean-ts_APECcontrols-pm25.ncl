; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")
print(data(527,:))

var_matrix_pm25  = new((/3,240/),float) ;120 for 21-25oct
var_matrix_pm10  = new((/3,240/),float)
var_matrix_co    = new((/3,240/),float)
var_matrix_no2   = new((/3,240/),float)
var_matrix_so2   = new((/3,240/),float)
var_matrix_o3    = new((/3,240/),float)

var_matrix_pm25(0,:) = (/data(528:767,0)/)
var_matrix_pm25(1,:) = (/data(528:767,1)/)
var_matrix_pm25(2,:) = (/data(528:767,2)/)
;var_matrix_pm25(3,:) = (/data(528:767,3)/)

var_matrix_pm10(0,:) = (/data(528:767,4)/)
var_matrix_pm10(1,:) = (/data(528:767,5)/)
var_matrix_pm10(2,:) = (/data(528:767,6)/)
;var_matrix_pm10(3,:) = (/data(528:767,7)/)

var_matrix_co(0,:) = (/data(528:767,8)/)
var_matrix_co(1,:) = (/data(528:767,9)/)
var_matrix_co(2,:) = (/data(528:767,10)/)
;var_matrix_co(3,:) = (/data(:,11)/)

var_matrix_no2(0,:) = (/data(528:767,12)/)
var_matrix_no2(1,:) = (/data(528:767,13)/)
var_matrix_no2(2,:) = (/data(528:767,14)/)
;var_matrix_no2(3,:) = (/data(:,15)/)

var_matrix_so2(0,:) = (/data(528:767,16)/)
var_matrix_so2(1,:) = (/data(528:767,17)/)
var_matrix_so2(2,:) = (/data(528:767,18)/)
;var_matrix_so2(3,:) = (/data(:,19)/)

var_matrix_o3(0,:) = (/data(528:767,20)/)
var_matrix_o3(1,:) = (/data(528:767,21)/)
var_matrix_o3(2,:) = (/data(528:767,22)/)
;var_matrix_o3(3,:) = (/data(:,23)/)

pm25avg_obs = avg(var_matrix_pm25(0,:))
pm25avg_baseline = avg(var_matrix_pm25(1,:))
pm25avg_control = avg(var_matrix_pm25(2,:))
pm25pcbenefit  = ((pm25avg_baseline - pm25avg_control)/pm25avg_baseline)*100.0

pm10avg_obs = avg(var_matrix_pm10(0,:))
pm10avg_baseline = avg(var_matrix_pm10(1,:))
pm10avg_control = avg(var_matrix_pm10(2,:))
pm10pcbenefit  = ((pm10avg_baseline - pm10avg_control)/pm10avg_baseline)*100.0

coavg_obs = avg(var_matrix_co(0,:))
coavg_baseline = avg(var_matrix_co(1,:))
coavg_control = avg(var_matrix_co(2,:))
copcbenefit  = ((coavg_baseline - coavg_control)/coavg_baseline)*100.0

no2avg_obs = avg(var_matrix_no2(0,:))
no2avg_baseline = avg(var_matrix_no2(1,:))
no2avg_control = avg(var_matrix_no2(2,:))
no2pcbenefit  = ((no2avg_baseline - no2avg_control)/no2avg_baseline)*100.0

o3avg_obs = avg(var_matrix_o3(0,:))
o3avg_baseline = avg(var_matrix_o3(1,:))
o3avg_control = avg(var_matrix_o3(2,:))
o3pcbenefit  = ((o3avg_baseline - o3avg_control)/o3avg_baseline)*100.0

;;;;;;;;;PERCENTAGE BENEFIT OVER 10 DAYS;;;;;;;;;
print("%age benefit over 10 day period: 3nov--12nov")
print("PM2.5 obs avg="+pm25avg_obs+" PM2.5 baseline avg="+pm25avg_baseline+" controls-avg="+pm25avg_control+" %age benefit="+pm25pcbenefit)

;---Start the graphics
wks = gsn_open_wks("eps","Beijing-12st-mean-pol-ts_APECcontrols-pm25") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
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
  timearr@units = "hours since 2014-11-03 00:00:00"
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
  res@xyExplicitLegendLabels = (/"observed","baseline","APEC-controls"/)         ; create explicit labels
;  res@gsnDraw  = False                          ; don't draw
;  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5 (ug/m3)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)    ; Create the four plots.


end
