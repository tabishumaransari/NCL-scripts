load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin

ncol = 11 ; COLUMNS CORRESPOND TO THE 11 DAYS HERE
;data1 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8001.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data2 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8002.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8003.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data4 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8004.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data5 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8005.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data6 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8006.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data7 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8007.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data8 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8008.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9 = readAsciiTable("/home/tabish/Emulation/EmulPreds_responsesurface_Run8009.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/Emulation/EmulPreds_responsesurface_Run12.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

;data = (data1+data2+data3+data4+data5+data6+data7+data8+data9+data10)/10.0
data@_FillValue = -999
print("table read-in successfully")
printVarSummary(data)

;TRANSFORMING 14400X1 STRUCTURE TO 120X120 STRUCTURE FOR CONTOUR PLOT
c=0
a = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 24TH OCT
b = new((/120,120/),float);MATRIX TO HOLD VALUES FOR 30TH OCT
do i=0,119
 do j=0,119
  a(i,j) = data(c,3);THIS MATRIX STORES VALUES FOR 24TH OCT
  b(i,j) = data(c,9);THIS MATRIX STORES VALUES FOR 30TH OCT
  c = c+1
 end do
end do
printMinMax(a,False)
;ATTACHING 0-120% COORDINATE ARRAYS
  x    = ispan(0,119,1)
  y    = ispan(0,119,1)

  a!0 = "x"
  a!1 = "y"
  a&x = x
  a&y = y

  b!0 = "x"
  b!1 = "y"
  b&x = x
  b&y = y

  wks = gsn_open_wks("x11","RSpanel2_ApAt_vs_ArAi") ; Send graphics to PNG file

; Set up resources.
  res                     = True
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame  
  res@gsnMaximize         = False
  res@cnFillOn            = True        ; Turn on contour fill
  res@cnFillPalette       = "BlGrYeOrReVi200"      ; Set color map
 ; res@cnFillPalette       = "WhiteBlue"      ; Set color map
  res@tiYAxisFontHeightF  = 0.018 
  res@tiXAxisFontHeightF  = 0.018 
  res@tiYAxisString       = "Bejing (Pow+Tran)"
  res@pmTitleZone	  = 3
  res@tiXAxisString       = "Beijing (Res+Ind)"
  ;res@cnFillMode          = "RasterFill"
  res@cnLinesOn           = False
 res@lbOrientation        = "vertical"
  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  tmXTMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXTMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  res@tmYRMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYRMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  aT = transpose(a)
  bT = transpose(b)

  plot1 = gsn_csm_contour(wks,aT,res)  ; Create filled contours
  plot2 = gsn_csm_contour(wks,bT,res)  ; Create filled contours

;---Draw text and markers at data locations
  txres               = True
  mkres               = True
  txres@txFontHeightF = 0.015
  txres@txJust        = "TopCenter"  ; text will be drawn under the marker
  mkres@gsMarkerIndex = 16 ; filled circle
  mkres@gsMarkerSizeF = 0.004
;ROUNDING OFF THE PM2.5 VALUES FOR CLEAN PRINTING
a  = round(a,0)
b  = round(b,0)

dumpoly1  = new(25,graphic)
dumpoly2  = new(25,graphic)
dumtext1 = new(25,graphic)
dumtext2 = new(25,graphic)
c=0; counter variable for dummy variables
  do j=0,100,20
    do i=0,100,20
      if((i.gt.0).and.(j.gt.0)) then  
       print(i+","+j)
;       gsn_polymarker(wks,plot1,x(i-1),y(j-1),mkres)
;       gsn_text(wks,plot1,"  ~C~"+a(j-1,i-1),x(i-1),y(j-1),txres)
        dumpoly1(c) = gsn_add_polymarker(wks,plot1,x(i-1),y(j-1),mkres)
        dumtext1(c) = gsn_add_text(wks,plot1,"  ~C~"+a(j-1,i-1),x(i-1),y(j-1),txres)

        dumpoly2(c) = gsn_add_polymarker(wks,plot2,x(i-1),y(j-1),mkres)
        dumtext2(c) = gsn_add_text(wks,plot2,"  ~C~"+b(j-1,i-1),x(i-1),y(j-1),txres)
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
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/plot1,plot2/),(/1,2/),resP)             ; now draw as one plot

end

