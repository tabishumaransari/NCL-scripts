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

var_matrix_pm25  = new((/2,120/),float) ;120 for 21-25oct
var_matrix_pm10  = new((/2,936/),float)
var_matrix_co    = new((/2,936/),float)
var_matrix_no2   = new((/2,936/),float)
var_matrix_so2   = new((/2,936/),float)
var_matrix_o3    = new((/2,936/),float)

var_matrix_pm25(0,:) = (/data(96:215,0)/)
var_matrix_pm25(1,:) = (/data(96:215,1)/)
;var_matrix_pm25(2,:) = (/data(:,2)/)
;var_matrix_pm25(3,:) = (/data(:,3)/)

var_matrix_pm10(0,:) = (/data(:,4)/)
var_matrix_pm10(1,:) = (/data(:,5)/)
;var_matrix_pm10(2,:) = (/data(:,6)/)
;var_matrix_pm10(3,:) = (/data(:,7)/)

var_matrix_co(0,:) = (/data(:,8)/)
var_matrix_co(1,:) = (/data(:,9)/)
;var_matrix_co(2,:) = (/data(:,10)/)
;var_matrix_co(3,:) = (/data(:,11)/)

var_matrix_no2(0,:) = (/data(:,12)/)
var_matrix_no2(1,:) = (/data(:,13)/)
;var_matrix_no2(2,:) = (/data(:,14)/)
;var_matrix_no2(3,:) = (/data(:,15)/)

var_matrix_so2(0,:) = (/data(:,16)/)
var_matrix_so2(1,:) = (/data(:,17)/)
;var_matrix_so2(2,:) = (/data(:,18)/)
;var_matrix_so2(3,:) = (/data(:,19)/)

var_matrix_o3(0,:) = (/data(:,20)/)
var_matrix_o3(1,:) = (/data(:,21)/)
;var_matrix_o3(2,:) = (/data(:,22)/)
;var_matrix_o3(3,:) = (/data(:,23)/)


printVarSummary(var_matrix_pm25)
print(avg(var_matrix_pm25(1,0:23)))
print(avg(var_matrix_pm25(1,24:47)))
print(avg(var_matrix_pm25(1,48:71)))
print(avg(var_matrix_pm25(1,72:95)))
print(avg(var_matrix_pm25(1,96:119)))

print(max(var_matrix_pm25(1,:)))

;---Start the graphics
wks = gsn_open_wks("x11","Beijing-12st-mean-ts_pm25_16-20Oct") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
;res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.8
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"black","blue"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12

  timearr = ispan (0,119,1)
  timearr@units = "hours since 2014-10-16 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
;PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.035
  res@tmYLLabelFontHeightF = 0.035
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
  
  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  res@tmXBMajorLengthF = 0.03              
  res@tmXBMinorLengthF = 0.015              
  res@tmYLMajorLengthF = 0.03              
  res@tmYLMinorLengthF = 0.015             

  res@trYMaxF     =  350
  res@trYMinF     =  0
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,50,100,150,200,250,300,350/)
  res@tmYLLabels      = "" + res@tmYLValues
  res@tmYLMinorValues = (/25,75,125,175,225,275,325/)



;res@gsnXRefLine = (/ 528, 768 /) 
  
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .12                  ; move units right
  res@pmLegendOrthogonalPosF = -0.2               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.12                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .04                 ; label font height
  res@xyExplicitLegendLabels = (/"obs","model"/)         ; create explicit labels
;  res@gsnDraw  = False                          ; don't draw
;  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)    ; Create the four plots.

;  draw(xy1)    ; All four plots will be drawn.
; frame(wks)



end
