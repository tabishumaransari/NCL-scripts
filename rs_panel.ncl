load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin

ncol = 11 ; COLUMNS CORRESPOND TO THE 11 DAYS HERE
data1 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run10.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run11.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data4 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run6.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data5 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run7.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data6 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
print("all data read-in successfully")
printVarSummary(data1)

;TRANSFORMING 14400X1 STRUCTURE TO 120X120 STRUCTURE FOR CONTOUR PLOT
c=0
a1 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a2 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
a3 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
;a4 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
;a5 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
;a6 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
b1 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
b2 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
b3 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
;b4 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
;b5 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
;b6 = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT

do i=0,119
 do j=0,119
  a1(i,j) = data1(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
  a2(i,j) = data2(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
  a3(i,j) = data3(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
 ; a4(i,j) = data4(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
 ; a5(i,j) = data5(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
 ; a6(i,j) = data6(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
  
  b1(i,j) = data1(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  b2(i,j) = data2(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  b3(i,j) = data3(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  ;b4(i,j) = data4(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  ;b5(i,j) = data5(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  ;b6(i,j) = data6(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
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

  b1!0 = "y"
  b1!1 = "x"
  b1&x = x
  b1&y = y

  a2!0 = "y"
  a2!1 = "x"
  a2&x = x
  a2&y = y

  b2!0 = "y"
  b2!1 = "x"
  b2&x = x
  b2&y = y
  
  a3!0 = "y"
  a3!1 = "x"
  a3&x = x
  a3&y = y

  b3!0 = "y"
  b3!1 = "x"
  b3&x = x
  b3&y = y
  
;  a4!0 = "y"
;  a4!1 = "x"
;  a4&x = x
;  a4&y = y

;  b4!0 = "y"
;  b4!1 = "x"
;  b4&x = x
;  b4&y = y
  
;  a5!0 = "y"
;  a5!1 = "x"
;  a5&x = x
;  a5&y = y

;  b5!0 = "y"
;  b5!1 = "x"
;  b5&x = x
;  b5&y = y

;  a6!0 = "y"
;  a6!1 = "x"
;  a6&x = x
;  a6&y = y

;  b6!0 = "y"
;  b6!1 = "x"
;  b6&x = x
;  b6&y = y

  wks = gsn_open_wks("x11","RS_panel_test2") ; Send graphics to PNG file

;;PRINTING OUT THE 0% AND 50% REDUCTIONS FOR 24TH

print("Full reduction for all 3 regions, for 24th: "+a1(0,0))
print("Full reduction for all 3 regions, for 30th: "+b1(0,0))

print("Half reduction for all 3 regions, for 24th: "+a1(49,49))
print("Half reduction for all 3 regions, for 30th: "+b1(49,49))

print("Full reduction for all Industry, for 24th: "+a2(0,0))
print("Full reduction for all Industry, for 30th: "+b2(0,0))

print("Full reduction for Near+Far Industry, for 24th: "+a2(0,99))
print("Full reduction for Near+far Industry, for 30th: "+b2(0,99))

print("Half reduction for all Beijing emissions, for 24th: "+a3(49,49))
print("Half reduction for all Beijing emissions, for 30th: "+b3(49,49))

; Set up resources.
  res                     = True
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame  
  res@gsnMaximize         = False
  res@cnFillOn            = True        ; Turn on contour fill
  ;res@cnFillPalette       = "BlGrYeOrReVi200"      ; Set color map
  res@cnFillPalette       = "MPL_Reds"      ; Set color map
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

  res@tiXAxisString       = "Beijing+Near (all sectors)"
  res@tiYAxisString       = "Far (all sectors)"
  res@tiYAxisJust = "BottomCenter"
  res@tiYAxisOffsetXF = 0.015
  plot1  = gsn_csm_contour(wks,a1,res)  ; Create filled contours
  plot2  = gsn_csm_contour(wks,b1,res)  ; Create filled contours

  res@tiXAxisString       = "Industry (Beijing)" 
  res@tiYAxisString       = "Industry (Near+Far)"
  plot3  = gsn_csm_contour(wks,a2,res)  ; Create filled contours
  plot4  = gsn_csm_contour(wks,b2,res)  ; Create filled contours

  res@tiXAxisString       = "Beijing (Res+Ind)" 
  res@tiYAxisString       = "Beijing (Pow+Tran)"
  plot5  = gsn_csm_contour(wks,a3,res)  ; Create filled contours
  plot6  = gsn_csm_contour(wks,b3,res)  ; Create filled contours

;  res@tiXAxisString       = "Ind+Res(Beijing+NN+FN)" 
;  res@tiYAxisString       = "Pow+Tran(Beijing+NN+FN)"
;  plot7  = gsn_csm_contour(wks,a4,res)  ; Create filled contours
;  plot8  = gsn_csm_contour(wks,b4,res)  ; Create filled contours

;  res@tiXAxisString       = "Beijing(Ind+Res+Tran)" 
;  res@tiYAxisString       = "Near Neighbourhood(Ind+Res)"
;  plot9  = gsn_csm_contour(wks,a5,res)  ; Create filled contours
;  plot10 = gsn_csm_contour(wks,b5,res)  ; Create filled contours

;  res@tiXAxisString       = "Beijing(Ind+Res)" 
;  res@tiYAxisString       = "Beijing(Pow+Tran)"
;  plot11 = gsn_csm_contour(wks,a6,res)  ; Create filled contours
;  plot12 = gsn_csm_contour(wks,b6,res)  ; Create filled contours

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
;a4  = round(a4,0)
;a5  = round(a5,0)
;a6  = round(a6,0)
b1  = round(b1,0)
b2  = round(b2,0)
b3  = round(b3,0)
;b4  = round(b4,0)
;b5  = round(b5,0)
;b6  = round(b6,0)

dumpoly1  = new(25,graphic)
dumpoly2  = new(25,graphic)
dumpoly3  = new(25,graphic)
dumpoly4  = new(25,graphic)
dumpoly5  = new(25,graphic)
dumpoly6  = new(25,graphic)
;dumpoly7  = new(25,graphic)
;dumpoly8  = new(25,graphic)
;dumpoly9  = new(25,graphic)
;dumpoly10  = new(25,graphic)
;dumpoly11  = new(25,graphic)
;dumpoly12  = new(25,graphic)
dumtext1 = new(25,graphic)
dumtext2 = new(25,graphic)
dumtext3 = new(25,graphic)
dumtext4 = new(25,graphic)
dumtext5 = new(25,graphic)
dumtext6 = new(25,graphic)
;dumtext7 = new(25,graphic)
;dumtext8 = new(25,graphic)
;dumtext9 = new(25,graphic)
;dumtext10 = new(25,graphic)
;dumtext11 = new(25,graphic)
;dumtext12 = new(25,graphic)

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
       ; dumpoly7(c) = gsn_add_polymarker(wks,plot7,y(i-1),x(j-1),mkres)
       ; dumpoly8(c) = gsn_add_polymarker(wks,plot8,y(i-1),x(j-1),mkres)
       ; dumpoly9(c) = gsn_add_polymarker(wks,plot9,y(i-1),x(j-1),mkres)
       ; dumpoly10(c) = gsn_add_polymarker(wks,plot10,y(i-1),x(j-1),mkres)
       ; dumpoly11(c) = gsn_add_polymarker(wks,plot11,y(i-1),x(j-1),mkres)
       ; dumpoly12(c) = gsn_add_polymarker(wks,plot12,y(i-1),x(j-1),mkres)
        
        dumtext1(c) = gsn_add_text(wks,plot1,"  ~C~"+a1(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext2(c) = gsn_add_text(wks,plot2,"  ~C~"+b1(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext3(c) = gsn_add_text(wks,plot3,"  ~C~"+a2(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext4(c) = gsn_add_text(wks,plot4,"  ~C~"+b2(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext5(c) = gsn_add_text(wks,plot5,"  ~C~"+a3(j-1,i-1),y(i-1),x(j-1),txres)
        dumtext6(c) = gsn_add_text(wks,plot6,"  ~C~"+b3(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext7(c) = gsn_add_text(wks,plot7,"  ~C~"+a4(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext8(c) = gsn_add_text(wks,plot8,"  ~C~"+b4(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext9(c) = gsn_add_text(wks,plot9,"  ~C~"+a5(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext10(c) = gsn_add_text(wks,plot10,"  ~C~"+b5(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext11(c) = gsn_add_text(wks,plot11,"  ~C~"+a6(j-1,i-1),y(i-1),x(j-1),txres)
       ; dumtext12(c) = gsn_add_text(wks,plot12,"  ~C~"+b6(j-1,i-1),y(i-1),x(j-1),txres)
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
resP@pmLabelBarOrthogonalPosF = 0.005
;gsn_panel(wks,(/plot1,plot3,plot5,plot7,plot9,plot11,plot2,plot4,plot6,plot8,plot10,plot12/),(/2,6/),resP)             ; now draw as one plot
resP@gsnFrame = False
gsn_panel(wks,(/plot1,plot3,plot5,plot2,plot4,plot6/),(/2,3/),resP)             ; now draw as one plot
; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.012
  gsn_text_ndc(wks,"PM~B~2.5~N~ in ~F33~m~F21~gm~S~-3~N~",0.5,0.225,txres)

  frame(wks)
end

