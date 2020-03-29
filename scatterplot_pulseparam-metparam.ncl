;THIS SCRIPT READS IN LARGE COMBINED SIM AND OBS ARRAYS FOR D01 AND CREATES A SCATTER PLOT
begin


;READING ASCII FILES FOR PULSE-PARAMETERS AND MET-PARAMETERS
ncol = 12
pulseparam = readAsciiTable("pulse-parameters.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
ncol = 2
metparam   = readAsciiTable("windspeed_winddir_dailymean_18Oct-15Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

printVarSummary(pulseparam)
printVarSummary(metparam)

;;;;LETS CREATE ARRAYS FOR CORRELATION;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FOR PEAK VALUE VS WIND SPEED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;BEIJING PEAK VALUE VS WIND SPEED ON DAY 1;;;;
BPWS1 = new((/20,2/),float)
do i=0,9
 BPWS1(i,0) = pulseparam(i,0)
 BPWS1(i,1) = metparam(i,0)
end do
do i=10,19
 BPWS1(i,0) = pulseparam(i,0)
 BPWS1(i,1) = metparam(i+5,0)  ;skipping 5 days for which no pulse runs were conducted (28,29,30,31,1)
end do

;;;;APEC2 PEAK VALUE VS WIND SPEED ON DAY 1;;;;;
APEC2PWS1 = new((/20,2/),float)
do i=0,9
 APEC2PWS1(i,0) = pulseparam(i,1)
 APEC2PWS1(i,1) = metparam(i,0)
end do
do i=10,19
 APEC2PWS1(i,0) = pulseparam(i,1)
 APEC2PWS1(i,1) = metparam(i+5,0)
end do

;;;;APEC2 PEAK VALUE VS WIND SPEED ON DAY 2;;;;;
APEC2PWS2 = new((/20,2/),float)
do i=0,9
 APEC2PWS2(i,0) = pulseparam(i,1)
 APEC2PWS2(i,1) = metparam(i+1,0)
end do
do i=10,19
 APEC2PWS2(i,0) = pulseparam(i,1)
 APEC2PWS2(i,1) = metparam(i+6,0)
end do

;;;;APEC3 PEAK VALUE VS WIND SPEED ON DAY 1;;;;;
APEC3PWS1 = new((/20,2/),float)
do i=0,9
 APEC3PWS1(i,0) = pulseparam(i,2)
 APEC3PWS1(i,1) = metparam(i,0)
end do
do i=10,19
 APEC3PWS1(i,0) = pulseparam(i,2)
 APEC3PWS1(i,1) = metparam(i+5,0)
end do

;;;;APEC3 PEAK VALUE VS WIND SPEED ON DAY 2;;;;;
APEC3PWS2 = new((/20,2/),float)
do i=0,9
 APEC3PWS2(i,0) = pulseparam(i,2)
 APEC3PWS2(i,1) = metparam(i+1,0)
end do
do i=10,19
 APEC3PWS2(i,0) = pulseparam(i,2)
 APEC3PWS2(i,1) = metparam(i+6,0)
end do

;;;;APEC3 PEAK VALUE VS WIND SPEED ON DAY 3;;;;;
APEC3PWS3 = new((/20,2/),float)
do i=0,9
 APEC3PWS3(i,0) = pulseparam(i,2)
 APEC3PWS3(i,1) = metparam(i+2,0)
end do
do i=10,19
 APEC3PWS3(i,0) = pulseparam(i,2)
 APEC3PWS3(i,1) = metparam(i+7,0)
end do
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FOR INTEGRATED BENEFITS VS WIND DIRECTION;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;BEIJING INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 1;;;;
BPWD1 = new((/20,2/),float)
do i=0,9
 BPWD1(i,0) = pulseparam(i,9)
 BPWD1(i,1) = metparam(i,1)
end do
do i=10,19
 BPWD1(i,0) = pulseparam(i,9)
 BPWD1(i,1) = metparam(i+5,1)
end do

;DECOMPOSING BEIJING-PEAK--WINDDIRECTION-OF-DAY1 ARRAY INTO 12 LEVELS BASED ON WIND SPEED OF DAY1
BPWD1_1 = new((/20,2/),float)
BPWD1_2 = new((/20,2/),float)
BPWD1_3 = new((/20,2/),float)
BPWD1_4 = new((/20,2/),float)
BPWD1_5 = new((/20,2/),float)
BPWD1_6 = new((/20,2/),float)
BPWD1_7 = new((/20,2/),float)
BPWD1_8 = new((/20,2/),float)
BPWD1_9 = new((/20,2/),float)
BPWD1_10 = new((/20,2/),float)
BPWD1_11 = new((/20,2/),float)
BPWD1_12 = new((/20,2/),float)

BPWD1_1(:,1) = where(BPWS1(:,1).lt.0.5,BPWD1(:,1),BPWD1_1@_FillValue)
BPWD1_2(:,1) = where(BPWS1(:,1).ge.0.5.and.BPWS1(:,1).lt.1.0,BPWD1(:,1),BPWD1_2@_FillValue)
BPWD1_3(:,1) = where(BPWS1(:,1).ge.1.0.and.BPWS1(:,1).lt.1.5,BPWD1(:,1),BPWD1_3@_FillValue)
BPWD1_4(:,1) = where(BPWS1(:,1).ge.1.5.and.BPWS1(:,1).lt.2.0,BPWD1(:,1),BPWD1_4@_FillValue)
BPWD1_5(:,1) = where(BPWS1(:,1).ge.2.0.and.BPWS1(:,1).lt.2.5,BPWD1(:,1),BPWD1_5@_FillValue)
BPWD1_6(:,1) = where(BPWS1(:,1).ge.2.5.and.BPWS1(:,1).lt.3.0,BPWD1(:,1),BPWD1_6@_FillValue)
BPWD1_7(:,1) = where(BPWS1(:,1).ge.3.0.and.BPWS1(:,1).lt.3.5,BPWD1(:,1),BPWD1_7@_FillValue)
BPWD1_8(:,1) = where(BPWS1(:,1).ge.3.5.and.BPWS1(:,1).lt.4.0,BPWD1(:,1),BPWD1_8@_FillValue)
BPWD1_9(:,1) = where(BPWS1(:,1).ge.4.0.and.BPWS1(:,1).lt.4.5,BPWD1(:,1),BPWD1_9@_FillValue)
BPWD1_10(:,1) = where(BPWS1(:,1).ge.4.5.and.BPWS1(:,1).lt.5.0,BPWD1(:,1),BPWD1_10@_FillValue)
BPWD1_11(:,1) = where(BPWS1(:,1).ge.5.0.and.BPWS1(:,1).lt.5.5,BPWD1(:,1),BPWD1_11@_FillValue)
BPWD1_12(:,1) = where(BPWS1(:,1).ge.5.5.and.BPWS1(:,1).lt.6.0,BPWD1(:,1),BPWD1_12@_FillValue)


;;;;APEC2 INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 1;;;;;
APEC2PWD1 = new((/20,2/),float)
do i=0,9
 APEC2PWD1(i,0) = pulseparam(i,10)
 APEC2PWD1(i,1) = metparam(i,1)
end do
do i=10,19
 APEC2PWD1(i,0) = pulseparam(i,10)
 APEC2PWD1(i,1) = metparam(i+5,1)
end do

;;;;APEC2 INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 2;;;;;
APEC2PWD2 = new((/20,2/),float)
do i=0,9
 APEC2PWD2(i,0) = pulseparam(i,10)
 APEC2PWD2(i,1) = metparam(i+1,1)
end do
do i=10,19
 APEC2PWD2(i,0) = pulseparam(i,10)
 APEC2PWD2(i,1) = metparam(i+6,1)
end do

;DECOMPOSING APEC2 INTEGRATED BENEFIT--WINDDIRECTION-OF-DAY2 ARRAY INTO 12 LEVELS BASED ON WIND SPEED OF DAY2
APEC2PWD2_1 = new((/20,2/),float)
APEC2PWD2_2 = new((/20,2/),float)
APEC2PWD2_3 = new((/20,2/),float)
APEC2PWD2_4 = new((/20,2/),float)
APEC2PWD2_5 = new((/20,2/),float)
APEC2PWD2_6 = new((/20,2/),float)
APEC2PWD2_7 = new((/20,2/),float)
APEC2PWD2_8 = new((/20,2/),float)
APEC2PWD2_9 = new((/20,2/),float)
APEC2PWD2_10 = new((/20,2/),float)
APEC2PWD2_11 = new((/20,2/),float)
APEC2PWD2_12 = new((/20,2/),float)

APEC2PWD2_1(:,1) = where(APEC2PWS2(:,1).lt.0.5,APEC2PWD2(:,1),APEC2PWD2_1@_FillValue)
APEC2PWD2_2(:,1) = where(APEC2PWS2(:,1).ge.0.5.and.APEC2PWS2(:,1).lt.1.0,APEC2PWD2(:,1),APEC2PWD2_2@_FillValue)
APEC2PWD2_3(:,1) = where(APEC2PWS2(:,1).ge.1.0.and.APEC2PWS2(:,1).lt.1.5,APEC2PWD2(:,1),APEC2PWD2_3@_FillValue)
APEC2PWD2_4(:,1) = where(APEC2PWS2(:,1).ge.1.5.and.APEC2PWS2(:,1).lt.2.0,APEC2PWD2(:,1),APEC2PWD2_4@_FillValue)
APEC2PWD2_5(:,1) = where(APEC2PWS2(:,1).ge.2.0.and.APEC2PWS2(:,1).lt.2.5,APEC2PWD2(:,1),APEC2PWD2_5@_FillValue)
APEC2PWD2_6(:,1) = where(APEC2PWS2(:,1).ge.2.5.and.APEC2PWS2(:,1).lt.3.0,APEC2PWD2(:,1),APEC2PWD2_6@_FillValue)
APEC2PWD2_7(:,1) = where(APEC2PWS2(:,1).ge.3.0.and.APEC2PWS2(:,1).lt.3.5,APEC2PWD2(:,1),APEC2PWD2_7@_FillValue)
APEC2PWD2_8(:,1) = where(APEC2PWS2(:,1).ge.3.5.and.APEC2PWS2(:,1).lt.4.0,APEC2PWD2(:,1),APEC2PWD2_8@_FillValue)
APEC2PWD2_9(:,1) = where(APEC2PWS2(:,1).ge.4.0.and.APEC2PWS2(:,1).lt.4.5,APEC2PWD2(:,1),APEC2PWD2_9@_FillValue)
APEC2PWD2_10(:,1) = where(APEC2PWS2(:,1).ge.4.5.and.APEC2PWS2(:,1).lt.5.0,APEC2PWD2(:,1),APEC2PWD2_10@_FillValue)
APEC2PWD2_11(:,1) = where(APEC2PWS2(:,1).ge.5.0.and.APEC2PWS2(:,1).lt.5.5,APEC2PWD2(:,1),APEC2PWD2_11@_FillValue)
APEC2PWD2_12(:,1) = where(APEC2PWS2(:,1).ge.5.5.and.APEC2PWS2(:,1).lt.6.0,APEC2PWD2(:,1),APEC2PWD2_12@_FillValue)


;;;;APEC3 INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 1;;;;;
APEC3PWD1 = new((/20,2/),float)
do i=0,9
 APEC3PWD1(i,0) = pulseparam(i,11)
 APEC3PWD1(i,1) = metparam(i,1)
end do
do i=10,19
 APEC3PWD1(i,0) = pulseparam(i,11)
 APEC3PWD1(i,1) = metparam(i+5,1)
end do

;;;;APEC3 INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 2;;;;;
APEC3PWD2 = new((/20,2/),float)
do i=0,9
 APEC3PWD2(i,0) = pulseparam(i,11)
 APEC3PWD2(i,1) = metparam(i+1,1)
end do
do i=10,19
 APEC3PWD2(i,0) = pulseparam(i,11)
 APEC3PWD2(i,1) = metparam(i+6,1)
end do


;DECOMPOSING APEC3 INTEGRATED BENEFIT--WINDDIRECTION-OF-DAY2 ARRAY INTO 12 LEVELS BASED ON WIND SPEED OF DAY2
APEC3PWD2_1 = new((/20,2/),float)
APEC3PWD2_2 = new((/20,2/),float)
APEC3PWD2_3 = new((/20,2/),float)
APEC3PWD2_4 = new((/20,2/),float)
APEC3PWD2_5 = new((/20,2/),float)
APEC3PWD2_6 = new((/20,2/),float)
APEC3PWD2_7 = new((/20,2/),float)
APEC3PWD2_8 = new((/20,2/),float)
APEC3PWD2_9 = new((/20,2/),float)
APEC3PWD2_10 = new((/20,2/),float)
APEC3PWD2_11 = new((/20,2/),float)
APEC3PWD2_12 = new((/20,2/),float)

APEC3PWD2_1(:,1) = where(APEC3PWS2(:,1).lt.0.5,APEC3PWD2(:,1),APEC3PWD2_1@_FillValue)
APEC3PWD2_2(:,1) = where(APEC3PWS2(:,1).ge.0.5.and.APEC3PWS2(:,1).lt.1.0,APEC3PWD2(:,1),APEC3PWD2_2@_FillValue)
APEC3PWD2_3(:,1) = where(APEC3PWS2(:,1).ge.1.0.and.APEC3PWS2(:,1).lt.1.5,APEC3PWD2(:,1),APEC3PWD2_3@_FillValue)
APEC3PWD2_4(:,1) = where(APEC3PWS2(:,1).ge.1.5.and.APEC3PWS2(:,1).lt.2.0,APEC3PWD2(:,1),APEC3PWD2_4@_FillValue)
APEC3PWD2_5(:,1) = where(APEC3PWS2(:,1).ge.2.0.and.APEC3PWS2(:,1).lt.2.5,APEC3PWD2(:,1),APEC3PWD2_5@_FillValue)
APEC3PWD2_6(:,1) = where(APEC3PWS2(:,1).ge.2.5.and.APEC3PWS2(:,1).lt.3.0,APEC3PWD2(:,1),APEC3PWD2_6@_FillValue)
APEC3PWD2_7(:,1) = where(APEC3PWS2(:,1).ge.3.0.and.APEC3PWS2(:,1).lt.3.5,APEC3PWD2(:,1),APEC3PWD2_7@_FillValue)
APEC3PWD2_8(:,1) = where(APEC3PWS2(:,1).ge.3.5.and.APEC3PWS2(:,1).lt.4.0,APEC3PWD2(:,1),APEC3PWD2_8@_FillValue)
APEC3PWD2_9(:,1) = where(APEC3PWS2(:,1).ge.4.0.and.APEC3PWS2(:,1).lt.4.5,APEC3PWD2(:,1),APEC3PWD2_9@_FillValue)
APEC3PWD2_10(:,1) = where(APEC3PWS2(:,1).ge.4.5.and.APEC3PWS2(:,1).lt.5.0,APEC3PWD2(:,1),APEC3PWD2_10@_FillValue)
APEC3PWD2_11(:,1) = where(APEC3PWS2(:,1).ge.5.0.and.APEC3PWS2(:,1).lt.5.5,APEC3PWD2(:,1),APEC3PWD2_11@_FillValue)
APEC3PWD2_12(:,1) = where(APEC3PWS2(:,1).ge.5.5.and.APEC3PWS2(:,1).lt.6.0,APEC3PWD2(:,1),APEC3PWD2_12@_FillValue)


;;;;APEC3 INTEGRATED BENEFIT VS WIND DIRECTION ON DAY 3;;;;;
APEC3PWD3 = new((/20,2/),float)
do i=0,9
 APEC3PWD3(i,0) = pulseparam(i,11)
 APEC3PWD3(i,1) = metparam(i+2,1)
end do
do i=10,19
 APEC3PWD3(i,0) = pulseparam(i,11)
 APEC3PWD3(i,1) = metparam(i+7,1)
end do

wks   = gsn_open_wks ("pdf","scatterplots-meteffects_on_pulses")                ; send graphics to PNG file

res                   = True                     ; plot mods desired
;res@tiMainString      = "PM2.5 Scatter Plot"    ; add title
res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@xyMarkers         =  16                      ; choose type of marker  
res@xyMarkerColor     = "black"                  ; Marker color
res@xyMarkerSizeF     = 0.015                    ; Marker size (default 0.01)
res@gsnDraw  = False                             ; don't draw
res@gsnFrame = False                             ; don't advance frame
res@tmLabelAutoStride = True                     ; nice tick mark labels
  res@tiYAxisFontHeightF  = 0.018
  res@tiXAxisFontHeightF  = 0.018

  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmXTMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXTMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYRMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYRMinorOutwardLengthF = 0.0               ; draw minor ticks inward


plot = new(6,graphic)

res@trYMinF = 0.0
res@tiXAxisString = "Peak benefit from Beijing (~F33~m~F21~gm~S~-3~N~)"  ; xaxis string
res@tiYAxisString = "Avg. Wind Speed on Day1 (ms~S~-1~N~)"  ; yaxis string
plot(0)  = gsn_csm_xy (wks,BPWS1(:,0),BPWS1(:,1),res) ; create plot
r = escorc(BPWS1(:,0),BPWS1(:,1))
print(r) 
myplot1 = plot(0)

txres = True
txres@txFontHeightF = 0.02
gsn_text_ndc(myplot1,"r=-0.74",0.38,0.90,txres)



res@trYMinF = 0.0
res@tiXAxisString = "Near-Neighbourhood peak value (ug/m3)"  ; xaxis string
res@tiYAxisString = "Wind Speed on Day1 (ms~S~-1~N~)"  ; yaxis string
plot(1)  = gsn_csm_xy (wks,APEC2PWS1(:,0),APEC2PWS1(:,1),res) ; create plot

res@tiXAxisString = "Near-Neighbourhood peak value (ug/m3)"  ; xaxis string
res@tiYAxisString = "Wind Speed on Day2 (ms~S~-1~N~)"  ; yaxis string
plot(2)  = gsn_csm_xy (wks,APEC2PWS2(:,0),APEC2PWS2(:,1),res) ; create plot

res@tiXAxisString = "Far-neighbourhood peak value (ug/m3)"  ; xaxis string
res@tiYAxisString = "Wind Speed on Day1 (ms~S~-1~N~)"  ; yaxis string
plot(3)  = gsn_csm_xy (wks,APEC3PWS1(:,0),APEC3PWS1(:,1),res) ; create plot

res@tiXAxisString = "Far-neighbourhood peak value (ug/m3)"  ; xaxis string
res@tiYAxisString = "Wind Speed on Day2 (ms~S~-1~N~)"  ; yaxis string
plot(4)  = gsn_csm_xy (wks,APEC3PWS2(:,0),APEC3PWS2(:,1),res) ; create plot

res@tiXAxisString = "Far-neighbourhood peak value (ug/m3)"  ; xaxis string
res@tiYAxisString = "Wind Speed on Day3 (ms~S~-1~N~)"  ; yaxis string
plot(5)  = gsn_csm_xy (wks,APEC3PWS3(:,0),APEC3PWS3(:,1),res) ; create plot


;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelXWhiteSpacePercent = 5.0
resP@gsnPanelYWhiteSpacePercent = 5.0
;gsn_panel(wks,plot,(/2,3/),resP)             ; now draw as one plot

;frame(wks)


;NOW PLOTTING AGAINST WIND-DIRECTION
res@trYMinF = 90
res@trYMaxF = 300
res@tiXAxisString = "Integrated benefit from Beijing (~F33~m~F21~gm~S~-3~N~hr)"  ; xaxis string
res@tiYAxisString = "Avg. Wind Direction on Day1 (~S~o~N~)"  ; yaxis string
;plot(0)  = gsn_csm_xy (wks,BPWD1(:,0),BPWD1(:,1),res) ; create plot

;PLOTS COMMENTED OUT ARE EMPTY AS THERE'S NO WIND SPEED IN THAT RANGE
;res@xyMarkerColor     = "blue" 
;plt1 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_1(:,1),res) ; create plot
;res@xyMarkerColor     = "blue" 
;plt2 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_2(:,1),res) ; create plot
;res@xyMarkerColor     = "blue" 
;plt3 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_3(:,1),res) ; create plot

res@xyMarkerColor     = "dodgerblue" 
plt4 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_4(:,1),res) ; create plot
res@xyMarkerColor     = "limegreen" 
plt5 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_5(:,1),res) ; create plot
res@xyMarkerColor     = "orange" 
plt6 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_6(:,1),res) ; create plot
res@xyMarkerColor     = "orangered" 
plt7 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_7(:,1),res) ; create plot
res@xyMarkerColor     = "red" 
plt8 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_8(:,1),res) ; create plot
res@xyMarkerColor     = "red" 
plt9 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_9(:,1),res) ; create plot
res@xyMarkerColor     = "red" 
plt10 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_10(:,1),res) ; create plot
res@xyMarkerColor     = "deeppink" 
plt11 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1_11(:,1),res) ; create plot
;UPDATING RESOURCES FOR BLACK CIRCLES AS BORDERS
res@xyMarkers         =  4                      ; choose type of marker
res@xyMarkerColor     = "black"                  ; Marker color
res@xyMarkerSizeF     = 0.017                    ; Marker size (default 0.01)
res@xyMarkerThicknessF  = 2.0
plt12 = gsn_csm_xy (wks,BPWD1(:,0),BPWD1(:,1),res) ; create plot


plot(0)=plt12
overlay(plot(0),plt4)
overlay(plot(0),plt5)
overlay(plot(0),plt6)
overlay(plot(0),plt7)
overlay(plot(0),plt8)
overlay(plot(0),plt9)
overlay(plot(0),plt10)
overlay(plot(0),plt11)
myplot2 = plot(0)

;RESETTING RESOURCES BACK FOR COLORED DOTS
res@xyMarkers         =  16
res@xyMarkerSizeF     = 0.015                    ; Marker size (default 0.01)

res@tiXAxisString = "Near-Neighbourhood Int. benefit (~F33~m~F21~gm~S~-3~N~hr)"  ; xaxis string
res@tiYAxisString = "Wind Direction on Day1 (~S~o~N~)"  ; yaxis string
plot(1)  = gsn_csm_xy (wks,APEC2PWD1(:,0),APEC2PWD1(:,1),res) ; create plot

res@tiXAxisString = "Integrated benefit from Near-Neighbourhood (~F33~m~F21~gm~S~-3~N~hr)"  ; xaxis string

res@tiYAxisString = "Avg. Wind Direction on Day2 (~S~o~N~)"  ; yaxis string
;plot(2)  = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2(:,1),res) ; create plot

res@xyMarkerColor     = "dodgerblue"
plt4 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_4(:,1),res) ; create plot
res@xyMarkerColor     = "limegreen"
plt5 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_5(:,1),res) ; create plot
res@xyMarkerColor     = "orange"
plt6 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_6(:,1),res) ; create plot
res@xyMarkerColor     = "orangered"
plt7 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_7(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt8 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_8(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt9 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_9(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt10 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_10(:,1),res) ; create plot
res@xyMarkerColor     = "deeppink"
plt11 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2_11(:,1),res) ; create plot
;UPDATING RESOURCES FOR BLACK CIRCLES AS BORDERS
res@xyMarkers         =  4                      ; choose type of marker
res@xyMarkerColor     = "black"                  ; Marker color
res@xyMarkerSizeF     = 0.017                    ; Marker size (default 0.01)
res@xyMarkerThicknessF  = 2.0
plt12 = gsn_csm_xy (wks,APEC2PWD2(:,0),APEC2PWD2(:,1),res) ; create plot

plot(2)=plt12
overlay(plot(2),plt4)
overlay(plot(2),plt5)
overlay(plot(2),plt6)
overlay(plot(2),plt7)
overlay(plot(2),plt8)
overlay(plot(2),plt9)
overlay(plot(2),plt10)
overlay(plot(2),plt11)
myplot3 = plot(2)

;RESETTING RESOURCES BACK FOR COLORED DOTS
res@xyMarkers         =  16
res@xyMarkerSizeF     = 0.015                    ; Marker size (default 0.01)

res@tiXAxisString = "Far-neighbourhood Int. benefit (~F33~m~F21~g\,m~S~-3~N~hr)"  ; xaxis string
res@tiYAxisString = "Wind Direction on Day1 (~S~o~N~)"  ; yaxis string
plot(3)  = gsn_csm_xy (wks,APEC3PWD1(:,0),APEC3PWD1(:,1),res) ; create plot

res@tiXAxisString = "Integrated benefit from Far-Neighbourhood (~F33~m~F21~gm~S~-3~N~hr)"  ; xaxis string
res@tiYAxisString = "Avg. Wind Direction on Day2 (~S~o~N~)"  ; yaxis string
;plot(4)  = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2(:,1),res) ; create plot
print("tabish")
res@xyMarkerColor     = "dodgerblue"
plt4 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_4(:,1),res) ; create plot
res@xyMarkerColor     = "limegreen"
plt5 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_5(:,1),res) ; create plot
res@xyMarkerColor     = "orange"
plt6 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_6(:,1),res) ; create plot
res@xyMarkerColor     = "orangered"
plt7 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_7(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt8 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_8(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt9 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_9(:,1),res) ; create plot
res@xyMarkerColor     = "red"
plt10 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_10(:,1),res) ; create plot
res@xyMarkerColor     = "deeppink"
print("Tabish")
plt11 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2_11(:,1),res) ; create plot
;UPDATING RESOURCES FOR BLACK CIRCLES AS BORDERS
res@xyMarkers         =  4                      ; choose type of marker
res@xyMarkerColor     = "black"                  ; Marker color
res@xyMarkerSizeF     = 0.017                    ; Marker size (default 0.01)
res@xyMarkerThicknessF  = 2.0
plt12 = gsn_csm_xy (wks,APEC3PWD2(:,0),APEC3PWD2(:,1),res) ; create plot

print("Tabish")
plot(4)=plt12
overlay(plot(4),plt4)
overlay(plot(4),plt5)
overlay(plot(4),plt6)
overlay(plot(4),plt7)
overlay(plot(4),plt8)
overlay(plot(4),plt9)
overlay(plot(4),plt10)
overlay(plot(4),plt11)
myplot4 = plot(4)

res@tiXAxisString = "Far-neighbourhood Int. benefit (~F33~m~F21~gm~S~-3~N~hr)"  ; xaxis string
res@tiYAxisString = "Wind Direction on Day3 (~S~o~N~)"  ; yaxis string
plot(5)  = gsn_csm_xy (wks,APEC3PWD3(:,0),APEC3PWD3(:,1),res) ; create plot

;ADD GREY SHADING FOR SOUTHERN WIND-DIRECTION
  xmin = 0
  xmax = 1000
  ymin = 135
  ymax = 225
  xpg  = (/xmin,xmax,xmax,xmin,xmin/)
  ypg  = (/ymin,ymin,ymax,ymax,ymin/)

 pgres = True
 pgres@gsFillColor    = "black"
 pgres@gsFillOpacityF = 0.1
 dum1 = gsn_add_polygon   (wks, myplot1, xpg, ypg, pgres)
 dum2 = gsn_add_polygon   (wks, myplot2, xpg, ypg, pgres)
 dum3 = gsn_add_polygon   (wks, myplot3, xpg, ypg, pgres)
 dum4 = gsn_add_polygon   (wks, myplot4, xpg, ypg, pgres)

;----------------------------------------------------------------------
; Draw some individual labelbars.
;----------------------------------------------------------------------
  labels1  = (/"<2.0","2.0-2.5","2.5-3.0","3.0-3.5","3.5-5.0",">5.0"/)
  colors1  = (/"dodgerblue2","limegreen","orange","orangered","red","deeppink"/)
  lbres                    = True          ; labelbar only resources
  lbres@vpWidthF           = 0.1           ; labelbar width
  lbres@vpHeightF          = 0.1           ; labelbar height
  lbres@lbBoxMajorExtentF  = 0.15          ; puts space between color boxes
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.015         ; font height. default is small
  ;lbres@lbLabelJust        = "center"  ; left justify labels
  lbres@lbPerimOn          = False
;
; Each labelbar has just one label. This allows you to more
; easily control where the label goes.
;
;txres = True
  txres@txFontHeightF = 0.012
  gsn_text_ndc(wks,"wind speed range (ms~S~-1~N~):",0.16,0.5,txres)
  ;xpos = (/0.15,  0.3,   0.45,   0.6,  0.75,   0.85/)
  xpos = 0.26
  do i=0,5
     lbres@lbFillColors     = colors1(i)
     lbres@lbLabelFontColor = colors1(i)
     gsn_labelbar_ndc(wks,1,labels1(i),xpos,0.55,lbres)
     xpos = xpos+0.12
  end do


;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 10.0
resP@gsnPanelXWhiteSpacePercent = 10.0
;gsn_panel(wks,plot,(/2,3/),resP)             ; now draw as one plot
gsn_panel(wks,(/myplot1,myplot2,myplot3,myplot4/),(/2,2/),resP)             ; now draw as one plot







end
