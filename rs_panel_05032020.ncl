load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin

ncol  = 11 ; COLUMNS CORRESPOND TO THE 11 DAYS HERE
data1 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run12.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run13.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run14.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data4 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run15.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data5 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run16.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data6 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run17.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data7 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run18.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data8 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run19.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data9 = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run20.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
print("all data read-in successfully")
printVarSummary(data1)

;TRANSFORMING 14400X1 STRUCTURE TO 120X120 STRUCTURE FOR CONTOUR PLOT
c=0
a1 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a2 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a3 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a4 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a5 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a6 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a7 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a8 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a9 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT

do i=0,119
 do j=0,119
    a1(i,j) = data1(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a2(i,j) = data2(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a3(i,j) = data3(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a4(i,j) = data4(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a5(i,j) = data5(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a6(i,j) = data6(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a7(i,j) = data7(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a8(i,j) = data8(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    a9(i,j) = data9(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
    c = c+1
 end do
end do

;ATTACHING 0-120% COORDINATE ARRAYS
  x    = ispan(0,119,1)
  y    = ispan(0,119,1)

  a1!0 = "y"
  a1!1 = "x"
  a1&x = x
  a1&y = y

  a2!0 = "y"
  a2!1 = "x"
  a2&x = x
  a2&y = y

  a3!0 = "y"
  a3!1 = "x"
  a3&x = x
  a3&y = y

  a4!0 = "y"
  a4!1 = "x"
  a4&x = x
  a4&y = y

  a5!0 = "y"
  a5!1 = "x"
  a5&x = x
  a5&y = y

  a6!0 = "y"
  a6!1 = "x"
  a6&x = x
  a6&y = y

  a7!0 = "y"
  a7!1 = "x"
  a7&x = x
  a7&y = y

  a8!0 = "y"
  a8!1 = "x"
  a8&x = x
  a8&y = y

  a9!0 = "y"
  a9!1 = "x"
  a9&x = x
  a9&y = y


;SMOOTHING THE DATA
do i = 1,100
  a1 = smth9_Wrap(a1,0.5,0.5,False)
  a2 = smth9_Wrap(a2,0.5,0.5,False)
  a3 = smth9_Wrap(a3,0.5,0.5,False)
  a4 = smth9_Wrap(a4,0.5,0.5,False)
  a5 = smth9_Wrap(a5,0.5,0.5,False)
  a6 = smth9_Wrap(a6,0.5,0.5,False)
  a7 = smth9_Wrap(a7,0.5,0.5,False)
  a8 = smth9_Wrap(a8,0.5,0.5,False)
  a9 = smth9_Wrap(a9,0.5,0.5,False)
end do


printMinMax(a7,True)
printMinMax(a8,True)
printMinMax(a9,True)

 wks = gsn_open_wks("pdf","RS_panel_05032020") ; Send graphics to PNG file

;;PRINTING OUT THE 0% AND 50% REDUCTIONS FOR 24TH

;print("Full reduction for all 3 regions, for 24th: "+a1(0,0))
;print("Half reduction for all 3 regions, for 24th: "+a1(49,49))
;print("Full reduction for all Industry, for 24th: "+a2(0,0))
;print("Full reduction for Near+Far Industry, for 24th: "+a2(0,99))
;print("Half reduction for all Beijing emissions, for 24th: "+a3(49,49))



; Set up resources.
  res                     = True
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame  
  res@gsnMaximize         = False
  res@cnFillOn            = True        ; Turn on contour fill
  ;res@cnFillPalette       = "BlGrYeOrReVi200"      ; Set color map
  res@cnFillPalette       = "BlAqGrYeOrReVi200"      ; Set color map
  ;res@cnFillPalette       = "MPL_Reds"      ; Set color map
  res@tiYAxisFontHeightF  = 0.025 
  res@tiXAxisFontHeightF  = 0.025 
  res@pmTitleZone	  = 3
  ;res@cnFillMode          = "RasterFill"
  res@cnLinesOn           = False
  res@lbOrientation        = "vertical"
  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmXTMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXTMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYRMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYRMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@cnLevelSelectionMode     = "ExplicitLevels"
  res@cnLevels    = (/ 75,100,125,150,175,200,225,250,275,300,325,350/)   ; set levels  
  res@lbLabelBarOn = False
  res@cnLineLabelsOn       = False    ; turns off contour line labels
  res@cnInfoLabelOn        = False    ; turns off contour info label

  res@tiXAxisString       = "Power (all 3 regions)"
  res@tiYAxisString       = "Transport (all 3 regions)"
  res@tiYAxisJust = "BottomCenter"
  res@tiYAxisOffsetXF = 0.015
  plot1  = gsn_csm_contour(wks,a1,res)  ; Create filled contours

  res@tiXAxisString       = "Transport (all 3 regions)" 
  res@tiYAxisString       = "Residential (all 3 regions)"
  plot2  = gsn_csm_contour(wks,a2,res)  ; Create filled contours

  res@tiXAxisString       = "Residential (all 3 regions)" 
  res@tiYAxisString       = "Industry (all 3 regions)"
  plot3  = gsn_csm_contour(wks,a3,res)  ; Create filled contours



  res@tiXAxisString       = "Beijing (all 4 sectors)"
  res@tiYAxisString       = "Near Neighbourhood (all 4 sectors)"
  plot4  = gsn_csm_contour(wks,a4,res)  ; Create filled contours

  res@tiXAxisString       = "Near Neighbourhood (all 4 sectors)"
  res@tiYAxisString       = "Far Neighbourhood (all 4 sectors)"
  plot5  = gsn_csm_contour(wks,a5,res)  ; Create filled contours

  res@tiXAxisString       = "Near Neighbourhood Industry"
  res@tiYAxisString       = "Near Neighbourhood Residential"
  plot6  = gsn_csm_contour(wks,a6,res)  ; Create filled contours



  res@tiXAxisString       = "Industry (all 3 regions)"
  res@tiYAxisString       = "Pow+Tran+Res (all 3 regions)"
  plot7  = gsn_csm_contour(wks,a7,res)  ; Create filled contours

  res@tiXAxisString       = "Ind+Res (all 3 regions)"
  res@tiYAxisString       = "Pow+Tran (all 3 regions)"
  plot8  = gsn_csm_contour(wks,a8,res)  ; Create filled contours

  res@tiXAxisString       = "Beijing + Near Neighbourhood (all 4 sectors)"
  res@tiYAxisString       = "Far Neighbourhood (all 4 sectors)"
  plot9  = gsn_csm_contour(wks,a9,res)  ; Create filled contours

;---Draw text and markers at data locations
  txres               = True
  mkres               = True
  txres@txFontHeightF = 0.025
  txres@txJust        = "TopCenter"  ; text will be drawn under the marker
  mkres@gsMarkerIndex = 16 ; filled circle
  mkres@gsMarkerSizeF = 0.002


;ROUNDING OFF THE PM2.5 VALUES FOR CLEAN PRINTING
a1  = round(a1,0)
a2  = round(a2,0)
a3  = round(a3,0)
a4  = round(a4,0)
a5  = round(a5,0)
a6  = round(a6,0)
a7  = round(a7,0)
a8  = round(a8,0)
a9  = round(a9,0)

dumpoly1  = new(25,graphic)
dumpoly2  = new(25,graphic)
dumpoly3  = new(25,graphic)
dumpoly4  = new(25,graphic)
dumpoly5  = new(25,graphic)
dumpoly6  = new(25,graphic)
dumpoly7  = new(25,graphic)
dumpoly8  = new(25,graphic)
dumpoly9  = new(25,graphic)
dumtext1 = new(25,graphic)
dumtext2 = new(25,graphic)
dumtext3 = new(25,graphic)
dumtext4 = new(25,graphic)
dumtext5 = new(25,graphic)
dumtext6 = new(25,graphic)
dumtext7 = new(25,graphic)
dumtext8 = new(25,graphic)
dumtext9 = new(25,graphic)

c=0; counter variable for dummy variables

do j=0,100,20
  do i=0,100,20
    if((i.gt.0).and.(j.gt.0)) then  
       print(i+","+j)
        dumpoly1(c) = gsn_add_polymarker(wks,plot1,y(i-1),x(j-1),mkres)
        dumpoly2(c) = gsn_add_polymarker(wks,plot2,y(i-1),x(j-1),mkres)
        dumpoly3(c) = gsn_add_polymarker(wks,plot3,y(i-1),x(j-1),mkres)
        dumpoly4(c) = gsn_add_polymarker(wks,plot4,y(i-1),x(j-1),mkres)
        dumpoly5(c) = gsn_add_polymarker(wks,plot5,y(i-1),x(j-1),mkres)
        dumpoly6(c) = gsn_add_polymarker(wks,plot6,y(i-1),x(j-1),mkres)
        dumpoly7(c) = gsn_add_polymarker(wks,plot7,y(i-1),x(j-1),mkres)
        dumpoly8(c) = gsn_add_polymarker(wks,plot8,y(i-1),x(j-1),mkres)
        dumpoly9(c) = gsn_add_polymarker(wks,plot9,y(i-1),x(j-1),mkres)
        
        dumtext1(c) = gsn_add_text(wks,plot1,"  ~C~"+a1(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext2(c) = gsn_add_text(wks,plot2,"  ~C~"+a2(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext3(c) = gsn_add_text(wks,plot3,"  ~C~"+a3(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext4(c) = gsn_add_text(wks,plot4,"  ~C~"+a4(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext5(c) = gsn_add_text(wks,plot5,"  ~C~"+a5(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext6(c) = gsn_add_text(wks,plot6,"  ~C~"+a6(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext7(c) = gsn_add_text(wks,plot7,"  ~C~"+a7(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext8(c) = gsn_add_text(wks,plot8,"  ~C~"+a8(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext9(c) = gsn_add_text(wks,plot9,"  ~C~"+a9(j-1,i-1),y(i-1),x(j-1),txres)
        c = c+1
    end if
  end do
end do


;draw(plot2)

; frame(wks)

;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelXWhiteSpacePercent = 5.0
resP@gsnPanelYWhiteSpacePercent = 5.0
resP@gsnPanelLabelBar           = True    ; Turn on common labelbar
resP@pmLabelBarOrthogonalPosF = - 0.02
resP@gsnFrame = False
resP@gsnPanelFigureStrings= (/"a","b","c","d","e","f","g","h","i"/) ; add strings to panel
resP@amJust   = "TopLeft"
gsn_panel(wks,(/plot1,plot2,plot3,plot4,plot5,plot6,plot7,plot8,plot9/),(/3,3/),resP)             ; now draw as one plot
; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.012
  gsn_text_ndc(wks,"PM~B~2.5~N~ in ~F33~m~F21~gm~S~-3~N~",0.5,0.08,txres)

  frame(wks)
end

