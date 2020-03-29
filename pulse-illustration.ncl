; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


begin

ncol = 20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;READING FILES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;READING ASCII FILES FOR OCTOBER (BEIJING, APEC2 AND APEC3)
pm25_Beijing_Oct = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Oct = readAsciiTable("pm25_pulseruns_APEC2_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Oct = readAsciiTable("pm25_pulseruns_APEC3_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

;;;;;;;;;;;;;;;;;;;DECLARATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DEFINING OCTOBER MATRIX TO HOLD 10 PULSES FROM COMBINED 3 REGIONS
pm25_Oct_matrix = new((/10,336/),float)

;;;;;;INITIALIZE THE ABOVE MATRIX WITH ZEROES;;;;;;;
do i = 0,9
 do j = 0, 335
  pm25_Oct_matrix(i,j) = 0.0
 end do
end do

;;;;;;;;;;;;PULSES FOR BEIJING OCTOBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_Beijing_Oct18 = pm25_Beijing_Oct18B - pm25_Beijing_Oct18P
pm25_Beijing_Oct19 = pm25_Beijing_Oct19B - pm25_Beijing_Oct19P
pm25_Beijing_Oct20 = pm25_Beijing_Oct20B - pm25_Beijing_Oct20P
pm25_Beijing_Oct21 = pm25_Beijing_Oct21B - pm25_Beijing_Oct21P
pm25_Beijing_Oct22 = pm25_Beijing_Oct22B - pm25_Beijing_Oct22P
pm25_Beijing_Oct23 = pm25_Beijing_Oct23B - pm25_Beijing_Oct23P
pm25_Beijing_Oct24 = pm25_Beijing_Oct24B - pm25_Beijing_Oct24P
pm25_Beijing_Oct25 = pm25_Beijing_Oct25B - pm25_Beijing_Oct25P
pm25_Beijing_Oct26 = pm25_Beijing_Oct26B - pm25_Beijing_Oct26P
pm25_Beijing_Oct27 = pm25_Beijing_Oct27B - pm25_Beijing_Oct27P

;;;;;;;;;;;;PULSES FOR APEC2 OCTOBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC2_Oct18 = pm25_APEC2_Oct18B - pm25_APEC2_Oct18P
pm25_APEC2_Oct19 = pm25_APEC2_Oct19B - pm25_APEC2_Oct19P
pm25_APEC2_Oct20 = pm25_APEC2_Oct20B - pm25_APEC2_Oct20P
pm25_APEC2_Oct21 = pm25_APEC2_Oct21B - pm25_APEC2_Oct21P
pm25_APEC2_Oct22 = pm25_APEC2_Oct22B - pm25_APEC2_Oct22P
pm25_APEC2_Oct23 = pm25_APEC2_Oct23B - pm25_APEC2_Oct23P
pm25_APEC2_Oct24 = pm25_APEC2_Oct24B - pm25_APEC2_Oct24P
pm25_APEC2_Oct25 = pm25_APEC2_Oct25B - pm25_APEC2_Oct25P
pm25_APEC2_Oct26 = pm25_APEC2_Oct26B - pm25_APEC2_Oct26P
pm25_APEC2_Oct27 = pm25_APEC2_Oct27B - pm25_APEC2_Oct27P


;;;;;;;;;;;;PULSES FOR APEC3 OCTOBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC3_Oct18 = pm25_APEC3_Oct18B - pm25_APEC3_Oct18P
pm25_APEC3_Oct19 = pm25_APEC3_Oct19B - pm25_APEC3_Oct19P
pm25_APEC3_Oct20 = pm25_APEC3_Oct20B - pm25_APEC3_Oct20P
pm25_APEC3_Oct21 = pm25_APEC3_Oct21B - pm25_APEC3_Oct21P
pm25_APEC3_Oct22 = pm25_APEC3_Oct22B - pm25_APEC3_Oct22P
pm25_APEC3_Oct23 = pm25_APEC3_Oct23B - pm25_APEC3_Oct23P
pm25_APEC3_Oct24 = pm25_APEC3_Oct24B - pm25_APEC3_Oct24P
pm25_APEC3_Oct25 = pm25_APEC3_Oct25B - pm25_APEC3_Oct25P
pm25_APEC3_Oct26 = pm25_APEC3_Oct26B - pm25_APEC3_Oct26P
pm25_APEC3_Oct27 = pm25_APEC3_Oct27B - pm25_APEC3_Oct27P

;NOW ADDING PULSES FOR ALL REGIONS FOR EACH DAY
pm25_Oct18 = pm25_Beijing_Oct18 + pm25_APEC2_Oct18 + pm25_APEC3_Oct18
pm25_Oct19 = pm25_Beijing_Oct19 + pm25_APEC2_Oct19 + pm25_APEC3_Oct19
pm25_Oct20 = pm25_Beijing_Oct20 + pm25_APEC2_Oct20 + pm25_APEC3_Oct20
pm25_Oct21 = pm25_Beijing_Oct21 + pm25_APEC2_Oct21 + pm25_APEC3_Oct21
pm25_Oct22 = pm25_Beijing_Oct22 + pm25_APEC2_Oct22 + pm25_APEC3_Oct22
pm25_Oct23 = pm25_Beijing_Oct23 + pm25_APEC2_Oct23 + pm25_APEC3_Oct23
pm25_Oct24 = pm25_Beijing_Oct24 + pm25_APEC2_Oct24 + pm25_APEC3_Oct24
pm25_Oct25 = pm25_Beijing_Oct25 + pm25_APEC2_Oct25 + pm25_APEC3_Oct25
pm25_Oct26 = pm25_Beijing_Oct26 + pm25_APEC2_Oct26 + pm25_APEC3_Oct26
pm25_Oct27 = pm25_Beijing_Oct27 + pm25_APEC2_Oct27 + pm25_APEC3_Oct27

pm25_Oct_matrix(0,0:119) = pm25_Oct18 
pm25_Oct_matrix(1,24:143) = pm25_Oct19 
pm25_Oct_matrix(2,48:167) = pm25_Oct20 
pm25_Oct_matrix(3,72:191) = pm25_Oct21 
pm25_Oct_matrix(4,96:215) = pm25_Oct22 
pm25_Oct_matrix(5,120:239) = pm25_Oct23 
pm25_Oct_matrix(6,144:263) = pm25_Oct24 
pm25_Oct_matrix(7,168:287) = pm25_Oct25 
pm25_Oct_matrix(8,192:311) = pm25_Oct26 
pm25_Oct_matrix(9,216:335) = pm25_Oct27 
pm25_Oct_matrix = where(pm25_Oct_matrix.lt.0,0,pm25_Oct_matrix)
pm25_Oct_matrix = where(ismissing(pm25_Oct_matrix),0.0,pm25_Oct_matrix)


pulsestack =  dim_sum_n(pm25_Oct_matrix,0);adding the 10 pulses together resulting into a 168 elements 1d array
pulse_stack = pulsestack(72:239)

;CREATING COMPOSITE PULSES
pm25_Oct_matrix(1,:) = pm25_Oct_matrix(0,:) + pm25_Oct_matrix(1,:)
pm25_Oct_matrix(2,:) = pm25_Oct_matrix(1,:) + pm25_Oct_matrix(2,:)
pm25_Oct_matrix(3,:) = pm25_Oct_matrix(2,:) + pm25_Oct_matrix(3,:)
pm25_Oct_matrix(4,:) = pm25_Oct_matrix(3,:) + pm25_Oct_matrix(4,:)
pm25_Oct_matrix(5,:) = pm25_Oct_matrix(4,:) + pm25_Oct_matrix(5,:)
pm25_Oct_matrix(6,:) = pm25_Oct_matrix(5,:) + pm25_Oct_matrix(6,:)
pm25_Oct_matrix(7,:) = pm25_Oct_matrix(6,:) + pm25_Oct_matrix(7,:)
pm25_Oct_matrix(8,:) = pm25_Oct_matrix(7,:) + pm25_Oct_matrix(8,:)
pm25_Oct_matrix(9,:) = pm25_Oct_matrix(8,:) + pm25_Oct_matrix(9,:)

pm25_matrix = pm25_Oct_matrix(:,72:239);subsettting to match 21-27thOct
printVarSummary(pm25_matrix)

pulse_composition = new((/11,168/),float)
pulse_composition(0:9,:) = pm25_matrix
pulse_composition(10,:) = pulse_stack



;---Start the graphics
wks = gsn_open_wks("pdf","pulse-illustration") ; send graphics to PNG file
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
;res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyMonoDashPattern = True     ; Solid lines for all curves
;res@xyLineThicknesses = (/  1.0, 1.0,1.0, 1.0,1.0, 1.0,1.0, 1.0,1.0, 1.0,1.0/)          ; make second line thicker
;res@xyLineColors      = (/"blue","blue","blue","blue","blue","blue","blue","blue","blue","blue","black"/)          ; change line color
res@gsnXYFillColors = (/"seagreen","turquoise","blue","orange","green","yellow","red","dodgerblue","violet"/)
res@FillIndex = (/1,2,3,4,5,6,7,8,9/) 
;res@gsnXYFillColors = (/"firebrick","peachpuff","orangered","navyblue","peru","yellow","wheat1","gray55","thistle","coral","dodgerblue","seagreen","maroon","gold","turquoise","mediumorchid"/)
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

  res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"

res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmXBMinorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMinorOutwardLengthF = 0.0               ; draw tickmarks inward

res@tmXBMajorLengthF = 0.03
res@tmXBMinorLengthF = 0.015

res@tmYLMajorLengthF = 0.03
res@tmYLMinorLengthF = 0.015





;;;legend;;
;  res@pmLegendDisplayMode    = "Always"            ; turn on legend
;  res@pmLegendSide           = "Top"               ; Change location of
;  res@pmLegendParallelPosF   = .80                  ; move units right
;  res@pmLegendOrthogonalPosF = -0.30               ; move units down
;  res@pmLegendWidthF         = 0.25                ; Change width and
;  res@pmLegendHeightF        = 0.075                ; height of legend.
;  res@lgAutoManage           = False
;  res@lgPerimOn              = False               ; turn off box around
;  res@lgLabelFontHeightF     = .025                 ; label font height
;  res@xyExplicitLegendLabels = (/"pulses","total"/)         ; create explicit labels
;;;;;;;;;;;;;;


;----------------------------------------------------------------------
; Draw some individual labelbars.
;----------------------------------------------------------------------
  labels1  = (/"19~S~th","20~S~th","21~S~st","22~S~nd","23~S~rd","24~S~th","25~S~th","26~S~th","27~S~th"/)
  colors1  = (/"seagreen","turquoise","blue","orange","green","yellow","red","dodgerblue","violet"/)
  lbres                    = True          ; labelbar only resources
  lbres@vpWidthF           = 0.10           ; labelbar width
  lbres@vpHeightF          = 0.30           ; labelbar height
  lbres@lbBoxMajorExtentF  = 0.1          ; puts space between color boxes
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.015         ; font height. default is small
  ;lbres@lbLabelJust        = "center"  ; left justify labels
  lbres@lbPerimOn          = False
;
; Each labelbar has just one label. This allows you to more
; easily control where the label goes.
;

  ;xpos = (/0.15,  0.3,   0.45,   0.6,  0.75,   0.85/)
  xpos = 0.115
  do i=0,8
     lbres@lbFillColors     = colors1(i)
     lbres@lbLabelFontColor = "black"
     gsn_labelbar_ndc(wks,1,labels1(i),xpos,0.82,lbres)
     xpos = xpos+0.085
  end do


  plot = gsn_csm_xy(wks,timearr,pulse_composition,res)    ; Create the four plots.



end
