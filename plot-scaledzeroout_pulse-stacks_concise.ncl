; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


begin

ncol = 12
data = readAsciiTable("zero-out_runs_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
var_matrix_pm25  = new((/12,264/),float) ;11days long runs
var_matrix_pm25dailyavg  = new((/12,11/),float) ;11days long runs
var_matrix_pm25dailyavgpc  = new((/12,11/),float) ;11days long runs
print(dimsizes(data))
print(dimsizes(var_matrix_pm25))
day = 21
do i= 0,11
 var_matrix_pm25(i,:) = data(:,i)
 do j = 0,240,24
  dailybenefit = avg(var_matrix_pm25(i,j:j+23))
  dailybenefit  = decimalPlaces(dailybenefit ,2,True)
  print("Daily benefits for run "+(i+1)+" on "+day+"="+dailybenefit)
  var_matrix_pm25dailyavg(i,j/24)=dailybenefit
  day = day+1
 end do
day =21
end do

print(sum(var_matrix_pm25dailyavg(:,0)))
print(sum(var_matrix_pm25dailyavg(:,1)))
print(sum(var_matrix_pm25dailyavg(:,2)))
print(sum(var_matrix_pm25dailyavg(:,3)))
print(sum(var_matrix_pm25dailyavg(:,4)))
print(sum(var_matrix_pm25dailyavg(:,5)))
print(sum(var_matrix_pm25dailyavg(:,6)))
print(sum(var_matrix_pm25dailyavg(:,7)))
print(sum(var_matrix_pm25dailyavg(:,8)))
print(sum(var_matrix_pm25dailyavg(:,9)))
print(sum(var_matrix_pm25dailyavg(:,10)))


do i = 0,11
 do j=0,10
  var_matrix_pm25dailyavgpc(i,j) = var_matrix_pm25dailyavg(i,j)/sum(var_matrix_pm25dailyavg(:,j))
  var_matrix_pm25dailyavgpc(i,j) = 100.0 * var_matrix_pm25dailyavgpc(i,j)
  var_matrix_pm25dailyavgpc(i,j) = decimalPlaces(var_matrix_pm25dailyavgpc(i,j) ,2,True)
 end do
end do

;SCALE DOWN PM2.5 BENEFITS TO MATCH PULSE-REDUCTIONS SIMILAR TO APEC CONTROLS
;;;;BEIJING;;;;
 Beijing_ind  = 0.50*var_matrix_pm25(0,:)
 Beijing_pow  = 0.50*var_matrix_pm25(1,:)
 Beijing_tran = 0.40*var_matrix_pm25(2,:)
 Beijing_res  = 0.40*var_matrix_pm25(3,:)
;;stacking
 Beijing_pow  = Beijing_pow + Beijing_ind
 Beijing_tran = Beijing_tran + Beijing_pow
 Beijing_res  = Beijing_res + Beijing_tran

;;;;;APEC2;;;
 APEC2_ind  = 0.35*var_matrix_pm25(4,:)
 APEC2_pow  = 0.35*var_matrix_pm25(5,:)
 APEC2_tran = 0.30*var_matrix_pm25(6,:)
 APEC2_res  = 0.30*var_matrix_pm25(7,:)
;;stacking
 APEC2_pow  = APEC2_pow + APEC2_ind
 APEC2_tran = APEC2_tran + APEC2_pow
 APEC2_res  = APEC2_res + APEC2_tran

;;;;APEC3;;;;
 APEC3_ind = 0.35*var_matrix_pm25(8,:)
 APEC3_pow = 0.35*var_matrix_pm25(9,:)
 APEC3_tran = 0.30*var_matrix_pm25(10,:)
 APEC3_res = 0.30*var_matrix_pm25(11,:)
;;stacking
 APEC3_pow  = APEC3_pow + APEC3_ind
 APEC3_tran = APEC3_tran + APEC3_pow
 APEC3_res  = APEC3_res + APEC3_tran


; Beijing_zeroout_stack =  var_matrix_pm25(0,:) + var_matrix_pm25(1,:) +var_matrix_pm25(2,:) +var_matrix_pm25(3,:)
; APEC2_zeroout_stack   =  var_matrix_pm25(4,:) + var_matrix_pm25(5,:) +var_matrix_pm25(6,:) +var_matrix_pm25(7,:)
; APEC3_zeroout_stack   =  var_matrix_pm25(8,:) + var_matrix_pm25(9,:) +var_matrix_pm25(10,:) +var_matrix_pm25(11,:)
; Total_zeroout_stack   = Beijing_zeroout_stack + APEC2_zeroout_stack + APEC3_zeroout_stack


;;;;;;;;;;;;;;;;;;;;;;PULSE-STACKS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ncol = 20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;READING FILES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;READING ASCII FILES FOR OCTOBER (BEIJING, APEC2 AND APEC3)
pm25_Beijing_Oct = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Oct = readAsciiTable("pm25_pulseruns_APEC2_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Oct = readAsciiTable("pm25_pulseruns_APEC3_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

;;;;;;;;;;;;;;;;;;;DECLARATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DEFINING OCTOBER MATRIX FOR ALL REGIONS
pm25_Beijing_pulse_matrix = new((/10,336/),float)
pm25_APEC2_pulse_matrix   = new((/10,336/),float)
pm25_APEC3_pulse_matrix   = new((/10,336/),float)

Beijing_matrix = new((/15,168/),float)
APEC2_matrix = new((/15,168/),float)
APEC3_matrix = new((/15,168/),float)

;;;;;;INITIALIZE THE ABOVE 2D ARRAYS WITH ZEROES;;;;;;;
do i = 0,9
 do j = 0, 335
  pm25_Beijing_pulse_matrix(i,j) = 0.0
  pm25_APEC2_pulse_matrix(i,j)   = 0.0
  pm25_APEC3_pulse_matrix(i,j)   = 0.0
 end do
end do

do i = 0,14
 do j = 0, 167
  Beijing_matrix(i,j) = 0.0
  APEC2_matrix(i,j) = 0.0
  APEC3_matrix(i,j) = 0.0
 end do
end do


;;;;;;;;;;;;STORING VALUES FOR BEIJING OCTOBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_Oct18B = pm25_Beijing_Oct(:,0)
pm25_Beijing_Oct18P = pm25_Beijing_Oct(:,1)
pm25_Beijing_Oct19B = pm25_Beijing_Oct(:,2)
pm25_Beijing_Oct19P = pm25_Beijing_Oct(:,3)
pm25_Beijing_Oct20B = pm25_Beijing_Oct(:,4)
pm25_Beijing_Oct20P = pm25_Beijing_Oct(:,5)
pm25_Beijing_Oct21B = pm25_Beijing_Oct(:,6)
pm25_Beijing_Oct21P = pm25_Beijing_Oct(:,7)
pm25_Beijing_Oct22B = pm25_Beijing_Oct(:,8)
pm25_Beijing_Oct22P = pm25_Beijing_Oct(:,9)
pm25_Beijing_Oct23B = pm25_Beijing_Oct(:,10)
pm25_Beijing_Oct23P = pm25_Beijing_Oct(:,11)
pm25_Beijing_Oct24B = pm25_Beijing_Oct(:,12)
pm25_Beijing_Oct24P = pm25_Beijing_Oct(:,13)
pm25_Beijing_Oct25B = pm25_Beijing_Oct(:,14)
pm25_Beijing_Oct25P = pm25_Beijing_Oct(:,15)
pm25_Beijing_Oct26B = pm25_Beijing_Oct(:,16)
pm25_Beijing_Oct26P = pm25_Beijing_Oct(:,17)
pm25_Beijing_Oct27B = pm25_Beijing_Oct(:,18)
pm25_Beijing_Oct27P = pm25_Beijing_Oct(:,19)

Beijing_Oct18pulse = pm25_Beijing_Oct18B - pm25_Beijing_Oct18P
Beijing_Oct19pulse = pm25_Beijing_Oct19B - pm25_Beijing_Oct19P
Beijing_Oct20pulse = pm25_Beijing_Oct20B - pm25_Beijing_Oct20P
Beijing_Oct21pulse = pm25_Beijing_Oct21B - pm25_Beijing_Oct21P
Beijing_Oct22pulse = pm25_Beijing_Oct22B - pm25_Beijing_Oct22P
Beijing_Oct23pulse = pm25_Beijing_Oct23B - pm25_Beijing_Oct23P
Beijing_Oct24pulse = pm25_Beijing_Oct24B - pm25_Beijing_Oct24P
Beijing_Oct25pulse = pm25_Beijing_Oct25B - pm25_Beijing_Oct25P
Beijing_Oct26pulse = pm25_Beijing_Oct26B - pm25_Beijing_Oct26P
Beijing_Oct27pulse = pm25_Beijing_Oct27B - pm25_Beijing_Oct27P

pm25_Beijing_pulse_matrix(0,0:119) = Beijing_Oct18pulse
pm25_Beijing_pulse_matrix(1,24:143) = Beijing_Oct19pulse
pm25_Beijing_pulse_matrix(2,48:167) = Beijing_Oct20pulse
pm25_Beijing_pulse_matrix(3,72:191) = Beijing_Oct21pulse
pm25_Beijing_pulse_matrix(4,96:215) = Beijing_Oct22pulse
pm25_Beijing_pulse_matrix(5,120:239) = Beijing_Oct23pulse
pm25_Beijing_pulse_matrix(6,144:263) = Beijing_Oct24pulse
pm25_Beijing_pulse_matrix(7,168:287) = Beijing_Oct25pulse
pm25_Beijing_pulse_matrix(8,192:311) = Beijing_Oct26pulse
pm25_Beijing_pulse_matrix(9,216:335) = Beijing_Oct27pulse
pm25_Beijing_pulse_matrix = where(pm25_Beijing_pulse_matrix.lt.0,0.0,pm25_Beijing_pulse_matrix)

;PREPARING CUMULATIVE TIME-SERIES OF BEIJING PULSES
pm25_Beijing_pulse_matrix(1,:) = pm25_Beijing_pulse_matrix(0,:) + pm25_Beijing_pulse_matrix(1,:)
pm25_Beijing_pulse_matrix(2,:) = pm25_Beijing_pulse_matrix(1,:) + pm25_Beijing_pulse_matrix(2,:)
pm25_Beijing_pulse_matrix(3,:) = pm25_Beijing_pulse_matrix(2,:) + pm25_Beijing_pulse_matrix(3,:)
pm25_Beijing_pulse_matrix(4,:) = pm25_Beijing_pulse_matrix(3,:) + pm25_Beijing_pulse_matrix(4,:)
pm25_Beijing_pulse_matrix(5,:) = pm25_Beijing_pulse_matrix(4,:) + pm25_Beijing_pulse_matrix(5,:)
pm25_Beijing_pulse_matrix(6,:) = pm25_Beijing_pulse_matrix(5,:) + pm25_Beijing_pulse_matrix(6,:)
pm25_Beijing_pulse_matrix(7,:) = pm25_Beijing_pulse_matrix(6,:) + pm25_Beijing_pulse_matrix(7,:)
pm25_Beijing_pulse_matrix(8,:) = pm25_Beijing_pulse_matrix(7,:) + pm25_Beijing_pulse_matrix(8,:)
pm25_Beijing_pulse_matrix(9,:) = pm25_Beijing_pulse_matrix(8,:) + pm25_Beijing_pulse_matrix(9,:)

Beijing_matrix(0:9,:) = pm25_Beijing_pulse_matrix(:,72:239);subsettting to match 21-31Oct length of zeroout stacks
;Beijing_matrix(10,:)  = left empty to denote the x-axis. Useful for filling color below curves
Beijing_matrix(11,:)  = Beijing_ind(0:167)
Beijing_matrix(12,:)  = Beijing_pow(0:167)
Beijing_matrix(13,:)  = Beijing_tran(0:167)
Beijing_matrix(14,:)  = Beijing_res(0:167)

printVarSummary(Beijing_matrix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;APEC2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_APEC2_Oct18B = pm25_APEC2_Oct(:,0)
pm25_APEC2_Oct18P = pm25_APEC2_Oct(:,1)
pm25_APEC2_Oct19B = pm25_APEC2_Oct(:,2)
pm25_APEC2_Oct19P = pm25_APEC2_Oct(:,3)
pm25_APEC2_Oct20B = pm25_APEC2_Oct(:,4)
pm25_APEC2_Oct20P = pm25_APEC2_Oct(:,5)
pm25_APEC2_Oct21B = pm25_APEC2_Oct(:,6)
pm25_APEC2_Oct21P = pm25_APEC2_Oct(:,7)
pm25_APEC2_Oct22B = pm25_APEC2_Oct(:,8)
pm25_APEC2_Oct22P = pm25_APEC2_Oct(:,9)
pm25_APEC2_Oct23B = pm25_APEC2_Oct(:,10)
pm25_APEC2_Oct23P = pm25_APEC2_Oct(:,11)
pm25_APEC2_Oct24B = pm25_APEC2_Oct(:,12)
pm25_APEC2_Oct24P = pm25_APEC2_Oct(:,13)
pm25_APEC2_Oct25B = pm25_APEC2_Oct(:,14)
pm25_APEC2_Oct25P = pm25_APEC2_Oct(:,15)
pm25_APEC2_Oct26B = pm25_APEC2_Oct(:,16)
pm25_APEC2_Oct26P = pm25_APEC2_Oct(:,17)
pm25_APEC2_Oct27B = pm25_APEC2_Oct(:,18)
pm25_APEC2_Oct27P = pm25_APEC2_Oct(:,19)

APEC2_Oct18pulse = pm25_APEC2_Oct18B - pm25_APEC2_Oct18P
APEC2_Oct19pulse = pm25_APEC2_Oct19B - pm25_APEC2_Oct19P
APEC2_Oct20pulse = pm25_APEC2_Oct20B - pm25_APEC2_Oct20P
APEC2_Oct21pulse = pm25_APEC2_Oct21B - pm25_APEC2_Oct21P
APEC2_Oct22pulse = pm25_APEC2_Oct22B - pm25_APEC2_Oct22P
APEC2_Oct23pulse = pm25_APEC2_Oct23B - pm25_APEC2_Oct23P
APEC2_Oct24pulse = pm25_APEC2_Oct24B - pm25_APEC2_Oct24P
APEC2_Oct25pulse = pm25_APEC2_Oct25B - pm25_APEC2_Oct25P
APEC2_Oct26pulse = pm25_APEC2_Oct26B - pm25_APEC2_Oct26P
APEC2_Oct27pulse = pm25_APEC2_Oct27B - pm25_APEC2_Oct27P

pm25_APEC2_pulse_matrix(0,0:119) = APEC2_Oct18pulse
pm25_APEC2_pulse_matrix(1,24:143) = APEC2_Oct19pulse
pm25_APEC2_pulse_matrix(2,48:167) = APEC2_Oct20pulse
pm25_APEC2_pulse_matrix(3,72:191) = APEC2_Oct21pulse
pm25_APEC2_pulse_matrix(4,96:215) = APEC2_Oct22pulse
pm25_APEC2_pulse_matrix(5,120:239) = APEC2_Oct23pulse
pm25_APEC2_pulse_matrix(6,144:263) = APEC2_Oct24pulse
pm25_APEC2_pulse_matrix(7,168:287) = APEC2_Oct25pulse
pm25_APEC2_pulse_matrix(8,192:311) = APEC2_Oct26pulse
pm25_APEC2_pulse_matrix(9,216:335) = APEC2_Oct27pulse
pm25_APEC2_pulse_matrix = where(pm25_APEC2_pulse_matrix.lt.0,0.0,pm25_APEC2_pulse_matrix)

;PREPARING CUMULATIVE TIME-SERIES OF APEC2 PULSES
pm25_APEC2_pulse_matrix(1,:) = pm25_APEC2_pulse_matrix(0,:) + pm25_APEC2_pulse_matrix(1,:)
pm25_APEC2_pulse_matrix(2,:) = pm25_APEC2_pulse_matrix(1,:) + pm25_APEC2_pulse_matrix(2,:)
pm25_APEC2_pulse_matrix(3,:) = pm25_APEC2_pulse_matrix(2,:) + pm25_APEC2_pulse_matrix(3,:)
pm25_APEC2_pulse_matrix(4,:) = pm25_APEC2_pulse_matrix(3,:) + pm25_APEC2_pulse_matrix(4,:)
pm25_APEC2_pulse_matrix(5,:) = pm25_APEC2_pulse_matrix(4,:) + pm25_APEC2_pulse_matrix(5,:)
pm25_APEC2_pulse_matrix(6,:) = pm25_APEC2_pulse_matrix(5,:) + pm25_APEC2_pulse_matrix(6,:)
pm25_APEC2_pulse_matrix(7,:) = pm25_APEC2_pulse_matrix(6,:) + pm25_APEC2_pulse_matrix(7,:)
pm25_APEC2_pulse_matrix(8,:) = pm25_APEC2_pulse_matrix(7,:) + pm25_APEC2_pulse_matrix(8,:)
pm25_APEC2_pulse_matrix(9,:) = pm25_APEC2_pulse_matrix(8,:) + pm25_APEC2_pulse_matrix(9,:)

APEC2_matrix(0:9,:) = pm25_APEC2_pulse_matrix(:,72:239);subsettting to match 21-31Oct length of zeroout stacks
;APEC2_matrix(10,:)  = left empty to denote the x-axis. Useful for filling color below curves
APEC2_matrix(11,:)  = APEC2_ind(0:167)
APEC2_matrix(12,:)  = APEC2_pow(0:167)
APEC2_matrix(13,:)  = APEC2_tran(0:167)
APEC2_matrix(14,:)  = APEC2_res(0:167)

printVarSummary(APEC2_matrix)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;APEC3;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_APEC3_Oct18B = pm25_APEC3_Oct(:,0)
pm25_APEC3_Oct18P = pm25_APEC3_Oct(:,1)
pm25_APEC3_Oct19B = pm25_APEC3_Oct(:,2)
pm25_APEC3_Oct19P = pm25_APEC3_Oct(:,3)
pm25_APEC3_Oct20B = pm25_APEC3_Oct(:,4)
pm25_APEC3_Oct20P = pm25_APEC3_Oct(:,5)
pm25_APEC3_Oct21B = pm25_APEC3_Oct(:,6)
pm25_APEC3_Oct21P = pm25_APEC3_Oct(:,7)
pm25_APEC3_Oct22B = pm25_APEC3_Oct(:,8)
pm25_APEC3_Oct22P = pm25_APEC3_Oct(:,9)
pm25_APEC3_Oct23B = pm25_APEC3_Oct(:,10)
pm25_APEC3_Oct23P = pm25_APEC3_Oct(:,11)
pm25_APEC3_Oct24B = pm25_APEC3_Oct(:,12)
pm25_APEC3_Oct24P = pm25_APEC3_Oct(:,13)
pm25_APEC3_Oct25B = pm25_APEC3_Oct(:,14)
pm25_APEC3_Oct25P = pm25_APEC3_Oct(:,15)
pm25_APEC3_Oct26B = pm25_APEC3_Oct(:,16)
pm25_APEC3_Oct26P = pm25_APEC3_Oct(:,17)
pm25_APEC3_Oct27B = pm25_APEC3_Oct(:,18)
pm25_APEC3_Oct27P = pm25_APEC3_Oct(:,19)

APEC3_Oct18pulse = pm25_APEC3_Oct18B - pm25_APEC3_Oct18P
APEC3_Oct19pulse = pm25_APEC3_Oct19B - pm25_APEC3_Oct19P
APEC3_Oct20pulse = pm25_APEC3_Oct20B - pm25_APEC3_Oct20P
APEC3_Oct21pulse = pm25_APEC3_Oct21B - pm25_APEC3_Oct21P
APEC3_Oct22pulse = pm25_APEC3_Oct22B - pm25_APEC3_Oct22P
APEC3_Oct23pulse = pm25_APEC3_Oct23B - pm25_APEC3_Oct23P
APEC3_Oct24pulse = pm25_APEC3_Oct24B - pm25_APEC3_Oct24P
APEC3_Oct25pulse = pm25_APEC3_Oct25B - pm25_APEC3_Oct25P
APEC3_Oct26pulse = pm25_APEC3_Oct26B - pm25_APEC3_Oct26P
APEC3_Oct27pulse = pm25_APEC3_Oct27B - pm25_APEC3_Oct27P

pm25_APEC3_pulse_matrix(0,0:119) = APEC3_Oct18pulse
pm25_APEC3_pulse_matrix(1,24:143) = APEC3_Oct19pulse
pm25_APEC3_pulse_matrix(2,48:167) = APEC3_Oct20pulse
pm25_APEC3_pulse_matrix(3,72:191) = APEC3_Oct21pulse
pm25_APEC3_pulse_matrix(4,96:215) = APEC3_Oct22pulse
pm25_APEC3_pulse_matrix(5,120:239) = APEC3_Oct23pulse
pm25_APEC3_pulse_matrix(6,144:263) = APEC3_Oct24pulse
pm25_APEC3_pulse_matrix(7,168:287) = APEC3_Oct25pulse
pm25_APEC3_pulse_matrix(8,192:311) = APEC3_Oct26pulse
pm25_APEC3_pulse_matrix(9,216:335) = APEC3_Oct27pulse
pm25_APEC3_pulse_matrix = where(pm25_APEC3_pulse_matrix.lt.0,0.0,pm25_APEC3_pulse_matrix)

;PREPARING CUMULATIVE TIME-SERIES OF APEC3 PULSES
pm25_APEC3_pulse_matrix(1,:) = pm25_APEC3_pulse_matrix(0,:) + pm25_APEC3_pulse_matrix(1,:)
pm25_APEC3_pulse_matrix(2,:) = pm25_APEC3_pulse_matrix(1,:) + pm25_APEC3_pulse_matrix(2,:)
pm25_APEC3_pulse_matrix(3,:) = pm25_APEC3_pulse_matrix(2,:) + pm25_APEC3_pulse_matrix(3,:)
pm25_APEC3_pulse_matrix(4,:) = pm25_APEC3_pulse_matrix(3,:) + pm25_APEC3_pulse_matrix(4,:)
pm25_APEC3_pulse_matrix(5,:) = pm25_APEC3_pulse_matrix(4,:) + pm25_APEC3_pulse_matrix(5,:)
pm25_APEC3_pulse_matrix(6,:) = pm25_APEC3_pulse_matrix(5,:) + pm25_APEC3_pulse_matrix(6,:)
pm25_APEC3_pulse_matrix(7,:) = pm25_APEC3_pulse_matrix(6,:) + pm25_APEC3_pulse_matrix(7,:)
pm25_APEC3_pulse_matrix(8,:) = pm25_APEC3_pulse_matrix(7,:) + pm25_APEC3_pulse_matrix(8,:)
pm25_APEC3_pulse_matrix(9,:) = pm25_APEC3_pulse_matrix(8,:) + pm25_APEC3_pulse_matrix(9,:)

APEC3_matrix(0:9,:) = pm25_APEC3_pulse_matrix(:,72:239);subsettting to match 21-31Oct length of zeroout stacks
;APEC3_matrix(10,:)  = left empty to denote the x-axis. Useful for filling color below curves
APEC3_matrix(11,:)  = APEC3_ind(0:167)
APEC3_matrix(12,:)  = APEC3_pow(0:167)
APEC3_matrix(13,:)  = APEC3_tran(0:167)
APEC3_matrix(14,:)  = APEC3_res(0:167)

printVarSummary(APEC3_matrix)


;---Start the graphics
wks = gsn_open_wks("pdf","zeroout-scaled-stack_VS_pulse-stack_concise") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "Portrait"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC2 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.8
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/2,0,2,0,2,0/)                         ; Make curves all solid
;res@xyLineThicknesses = (/  1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","blue","limegreen","limegreen","red","red"/)          ; change line color
;res@gsnXYFillColors = (/"seagreen","turquoise","blue","orange","green","yellow","red","dodgerblue","violet","black","black","black","black","black"/)
;res@gsnXYFillOpacities = (/1,1,1,1,1,1,1,1,1,0,0.2,0.2,0.2,0.2/) 
;res@gsnXYFillOpacities = (/1,1,1,1,1,1,1,1,1,0,0,0,0,0/) 
;res@gsnXYFillPatterns = (/0,0,0,0,0,0,0,0,0,0,2,3,4,5/) 
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
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12
  timearr = ispan (0,167,1)
  timearr@units = "hours since 2014-10-21 00:00:00"
  time_axis_labels(timearr,res,restick)
  res@trXMaxF=max(timearr)
  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
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
;  res@trYMaxF     =  100
  ;res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  ;res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  res@tiYAxisString = "PM~B~2.5~N~ contributions (~F33~m~F21~gm~S~-3~N~)"

;;;legend;;
  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .20                  ; move units right
  res@pmLegendOrthogonalPosF = -0.40               ; move units down
  res@pmLegendWidthF         = 0.25                ; Change width and
  res@pmLegendHeightF        = 0.25                ; height of legend.
  res@lgAutoManage           = False
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .025                 ; label font height
  res@xyExplicitLegendLabels = (/"Far neighbourhood pulse","Far neighbourhood continuous","Near neighbourhood pulse","Near neighbourhood continuous","Beijing pulse","Beijing continuous"/)         ; create explicit labels
;;;;;;;;;;;;;;

res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmXBMinorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMinorOutwardLengthF = 0.0               ; draw tickmarks inward

res@tmXBMajorLengthF = 0.03
res@tmXBMinorLengthF = 0.015

res@tmYLMajorLengthF = 0.03
res@tmYLMinorLengthF = 0.015


 APEC3_pulse = APEC3_matrix(9,:)
 APEC3_zo    = APEC3_matrix(14,:)
 APEC2_pulse = APEC2_matrix(9,:)
 APEC2_zo    = APEC2_matrix(14,:)
 Beijing_pulse = Beijing_matrix(9,:)
 Beijing_zo    = Beijing_matrix(14,:)

 APEC2_pulse = APEC2_pulse + APEC3_pulse
 Beijing_pulse = Beijing_pulse + APEC2_pulse

 APEC2_zo = APEC2_zo + APEC3_zo
 Beijing_zo = Beijing_zo + APEC2_zo



 plot = gsn_csm_xy(wks,timearr,(/APEC3_pulse,APEC3_zo,APEC2_pulse,APEC2_zo,Beijing_pulse,Beijing_zo/),res) 



end
