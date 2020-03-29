;*************************************************
; bar_16.ncl
;
; Concepts illustrated:
;   - Creating a blank plot
;   - Drawing stacked bar plots
;*************************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  days = (/"21","22","23","24","25","26","27","28","29","30","31"/)

  ndays = dimsizes(days)

  AI = (/5.89, 8.49, 11.06, 13.32, 24.42, 6.23, 7.15, 10.36, 12.77, 15.73, 14.11/);RUN1 FOR ALL 11 DAYS
  AP = (/0.15, 0.09, 0.06, 0.47, 0.89, 0.02, 0.19, 0.07, 0.01, 0.04, 0.1/);RUN2
  AT = (/2.17, 3.56, 4.29, 10.31, 14.61, 2.35, 2.78, 4.67, 3.43, 4.33, 6.19/);RUN3
  AR = (/9.59, 20.06, 30.43, 29.19, 30.02, 10.18, 11.96, 25.23, 42.28, 47.42, 33.39/);RUN4
  BI = (/3.3, 16.89, 37.61, 60.64, 35.6, 3.3, 10.36, 13.13, 30.73, 44.45, 32.37/);RUN5
  BP = (/0.31, 0.68, 2.73, 7.39, 2.61, 0.18, 0.33, 1.17, 0.25, 0, 3.22/);RUN6
  BT = (/0.18, 0.92, 8.56, 20.55, 8.1, 0.62, 0.32, 0.59, 0.48, 0, 2.09/);RUN7
  BR = (/3.3, 16.56, 42.07, 51.51, 28.09, 3.01, 7.18, 14.92, 26.96, 49.11, 23.83/);RUN8
  CI = (/0.14, 0.93, 5.23, 18.38, 13.11, 1.83, 1.57, 1.03, 6.01, 24.01, 22.22/);RUN9
  CP = (/0.03, 0.31, 1.07, 4.3, 3.69, 0.89, 1.03, 0.96, 1.73, 0, 7.25/);RUN10
  CT = (/0.02, 0.06, 0.67, 2.83, 1.26, 0.17, 0.37, 0.27, 0.87, 0, 4.46/);RUN11
  CR = (/0.21, 1.72, 6.8, 19.93, 14.56, 2.27, 3.7, 2.36, 6.1, 20.84, 21.66/);RUN12


  wks = gsn_open_wks("x11","stacked-barchart")  ; send graphics to PNG file
;
; Set resources for blank plot. Be sure to set axes limits
; that represent d that will be added later via polygons.
;
  res                          = True

  res@gsnMaximize              = True    ; Maximize plot in frame
  res@gsnDraw                  = False   ; Don't draw
  res@gsnFrame                 = False   ; Don't advance frame

;  res@vpWidthF                 = 0.3     ; Make long and
;  res@vpHeightF                = 0.9     ; narrow

;---Set axes limits. Add extra space for X max.
;  res@trYMinF                  = 0.0
;  res@trYMaxF                  = (max(d2) + max(d1)+max(d3) + max(d4))*1.2  
;  res@trXMinF                  = 0
;  res@trXMaxF                  = ndays + 1


;---Put day labels on X axis
  res@tmXBMode                 = "Explicit"
  res@tmXBValues               = ispan(1,ndays,1)
  res@tmXBLabels               = days
  res@tmXBLabelJust            = "BottomCenter"

  res@gsnScale                 = True    ; Make labels on axes same size

;--Turn off X axis tickmarks
  res@tmXBMajorLengthF         = 0.
  res@tmXBMajorOutwardLengthF  = 0.  
  res@tmYLMajorLengthF         = 0.01
  res@tmYLMajorOutwardLengthF  = 0.01

  res@tmXTOn                   = False   ; Turn off top tickmarks

;---Create blank plot without Y grid lines
  plot_without_xgrid = gsn_csm_blank_plot(wks,res)

;---Create blank plot with Y grid lines
  res@tmYMajorGrid                = True    ; Turn on grid lines
  res@tmYMajorGridLineDashPattern = 2       ; Dashed lines
  res@tmYMajorGridThicknessF      = 1.0     ; default is 2 (?)
  plot_with_xgrid = gsn_csm_blank_plot(wks,res)

;---Arrays to hold the bar values and the bars themselves.
  run1 = new(ndays,graphic)
  run2 = new(ndays,graphic)
  run3 = new(ndays,graphic)
  run4 = new(ndays,graphic)
  run5 = new(ndays,graphic)
  run6 = new(ndays,graphic)
  run7 = new(ndays,graphic)
  run8 = new(ndays,graphic)
  run9 = new(ndays,graphic)
  run10 = new(ndays,graphic)
  run11 = new(ndays,graphic)
  run12 = new(ndays,graphic)

;---Set some resources for the bars.
  bres           = True
  bres@gsEdgesOn = True      ; Outline the polygons (bars)
;
; Loop through each day and attach bar to plot that
; doesn't have grid lines.

  do i=1,ndays
    bres@gsFillColor           = "red"
      
    ybar      = (/0,d1(i-1),d1(i-1),0,0/)
    xbar      = (/i-0.25,i-0.25,i+0.25,i+0.25,i-0.25/)
    dum1(i-1) = gsn_add_polygon(wks,plot_without_xgrid,xbar,ybar,bres)

    bres@gsFillColor          = "blue"
    
    ybar      = (/d1(i-1),d2(i-1)+d1(i-1),d2(i-1)+d1(i-1),d1(i-1),d1(i-1)/)
    dum2(i-1) = gsn_add_polygon(wks,plot_without_xgrid,xbar,ybar,bres)
    
    bres@gsFillColor          = "green"

    ybar      = (/d1(i-1)+d2(i-1),d3(i-1)+d2(i-1)+d1(i-1),\
                  d3(i-1)+d2(i-1)+d1(i-1),d1(i-1)+d2(i-1),\
                  d1(i-1)+d2(i-1)/)
    dum3(i-1) = gsn_add_polygon(wks,plot_without_xgrid,xbar,ybar,bres)
 
    
    bres@gsFillColor          = "orange"

    ybar      = (/d1(i-1)+d2(i-1)+d3(i-1),d4(i-1)+d3(i-1)+d2(i-1)+d1(i-1),\
                  d4(i-1)+d3(i-1)+d2(i-1)+d1(i-1),d1(i-1)+d2(i-1)+d3(i-1),\
                  d1(i-1)+d2(i-1)+d3(i-1)/)
    dum4(i-1) = gsn_add_polygon(wks,plot_without_xgrid,xbar,ybar,bres)

end do

;
; Drawing the plot will draw all the attached bars. Have to draw
; the plot twice: one with the X grid lines and one without, in
; order to make sure the X grid lines are behind the bars.
;
; Couldn't see how else to do this.
;
  draw(plot_with_xgrid)
  draw(plot_without_xgrid)
  frame(wks)
end

