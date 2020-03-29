; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"



begin

emisarr0 = (/100,100,100,100, 100,100,100,100, 100,100,100,100/)
emisarr1 = (/ 40,100,100,40, 100,100,100,100, 100,100,100,100/)
emisarr2 = (/20,20,20,20, 100,100,100,100, 100,100,100,100/)
emisarr3 = (/40,40,40,40, 40,100,100,40, 100,100,100,100/)
emisarr4 = (/40,40,40,40, 40,40,40,40, 100,100,100,100/)
emisarr5 = (/40,40,40,40, 40,40,40,40, 40,40,40,40/)
emisarr6 = (/30,30,30,30, 30,30,30,30, 30,30,30,30/)
emisarr7 = (/20,20,20,20, 20,20,20,20, 20,20,20,20/)
emistimearr = ispan(1,12,1)


;---Start the graphics
wks = gsn_open_wks("eps","MPCpolicy") ; send graphics to PNG file


; frame(wks)
; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6/),res1,res2)

res3 = True
res3@vpXF                 = 0.1       ; x location

res3@gsnXYBarChart = True            ; Create bar plot
res3@trYMaxF     =  100
res3@trYMinF     =  0

res3@tmXTOn        = False
res3@tmXBOn        = False
res3@tmYROn        = False

;DRAW TICKMARKS INWARDS
res3@tmXBMajorOutwardLengthF=0.0
res3@tmXBMinorOutwardLengthF=0.0
res3@tmYLMajorOutwardLengthF=0.0
res3@tmYLMinorOutwardLengthF=0.0


res3@tmXBMajorLengthF = 0.0
res3@tmXBMinorLengthF = 0.0
res3@tmXBMinorThicknessF = 0.0
res3@tmYLMajorLengthF = 0.008
res3@tmYLMinorLengthF = 0.004

res3@tmYLMode        = "Explicit"
res3@tmYLValues      = (/0,20,40,60,80,100/)
;res3@tmYLLabels      = "" + res@tmYLValues
res3@tmYLLabels      = (/"0","20","40","60","80","100"/)
res3@tmYLMinorValues = (/10,30,50,70,90/)

res3@tmXBMode = "Explicit"
res3@tmXBValues = (/1,2,3,4,5,6,7,8,9,10,11,12/)
res3@tmXBLabels = (/"I","T","P","R","I","T","P","R","I","T","P","R"/)
;res3@tmXBMinorValues = (/-0.5,12.5,24.5,36.5,48.5,60.5/)
res3@tmXBMajorLengthF=0.0
res3@tmXBMinorLengthF=0.0

res3@gsnXYBarChartColors = (/"tomato","tomato","tomato","tomato","limegreen","limegreen","limegreen","limegreen","dodgerblue","dodgerblue","dodgerblue","dodgerblue"/)            ; choose colors
res3@xyLineColors = (/"black"/) 
res3@vpWidthF    = 0.5
res3@vpHeightF   = 0.075
res3@gsnMaximize = False

res3@tmXBLabelFontHeightF = 0.008
res3@tmYLLabelFontHeightF = 0.006
res3@tiYAxisFontHeightF = 0.006
res3@tiYAxisString = "Emissions (%)"
res3@gsnDraw  = False                          ; don't draw
res3@gsnFrame = False                          ; don't advance frame

emisplot0 = gsn_csm_xy (wks,emistimearr,emisarr0,res3)
emisplot1 = gsn_csm_xy (wks,emistimearr,emisarr1,res3)
emisplot2 = gsn_csm_xy (wks,emistimearr,emisarr2,res3)
emisplot3 = gsn_csm_xy (wks,emistimearr,emisarr3,res3)
emisplot4 = gsn_csm_xy (wks,emistimearr,emisarr4,res3)
emisplot5 = gsn_csm_xy (wks,emistimearr,emisarr5,res3)
emisplot6 = gsn_csm_xy (wks,emistimearr,emisarr6,res3)
emisplot7 = gsn_csm_xy (wks,emistimearr,emisarr7,res3)

; emisplot0 will be the base plot.
  res1                     = True
  res2                     = True
  res1@gsnMaximize         = False
  res1@wkWidthF            = 0.3
  res2@gsnAttachPlotsXAxis = True
  amid = gsn_attach_plots(emisplot0,(/emisplot1,emisplot2,emisplot3,emisplot4,emisplot5,emisplot6,emisplot7/),res1,res2)

;************************************************
; create panel just to fill white space
;************************************************
  resP                    = True                   ; modify the panel plot
  resP@gsnFrame           = False                  ; don't advance frame
  resP@gsnPanelLabelBar   = False                   ; add common colorbar
;  resP@gsnPanelMainString = "Using gsnMaximize"    ; add common title
  resP@gsnMaximize        = True                   ; use full page
  resP@gsnPanelLeft     = 0.2                   ; save space at bottom
  gsn_panel(wks,emisplot0,(/1,1/),resP)                 ; now draw as one plot

;drawNDCGrid(wks)

txres               = True
txres@txFontHeightF = 0.012


gsn_text_ndc(wks,"Case 0: <75",0.088,0.885,txres)
gsn_text_ndc(wks,"Case 1: 75-100",0.097,0.78,txres)
gsn_text_ndc(wks,"Case 2: 101-125",0.1,0.67,txres)
gsn_text_ndc(wks,"Case 3: 125-150",0.1,0.56,txres)
gsn_text_ndc(wks,"Case 4: 151-175",0.1,0.45,txres)
gsn_text_ndc(wks,"Case 5: 176-200",0.1,0.35,txres)
gsn_text_ndc(wks,"Case 6: 201-220",0.1,0.24,txres)
gsn_text_ndc(wks,"Case 7: >225",0.088,0.13,txres)


txres@txFontHeightF = 0.012
gsn_text_ndc(wks,"24h avg PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)",0.1,0.98,txres)
gsn_text_ndc(wks,"Beijing",0.38,0.96,txres)
gsn_text_ndc(wks,"Near neighbourhood",0.63,0.96,txres)
gsn_text_ndc(wks,"Far neighbourhood",0.87,0.96,txres)

xpos=0.285
do i = 0,2
gsn_text_ndc(wks,"I",xpos,0.05,txres)
xpos = xpos + 0.0617
gsn_text_ndc(wks,"P",xpos,0.05,txres)
xpos = xpos + 0.0617
gsn_text_ndc(wks,"T",xpos,0.05,txres)
xpos = xpos + 0.0617
gsn_text_ndc(wks,"R",xpos,0.05,txres)
xpos = xpos + 0.0617
end do


frame(wks)



end


