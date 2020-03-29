begin

 seq     = (/1,2,3,4,5,6,7,8,9,10,11,12/)                                     ;
 corr_a  = (/0.875,0.875,0.854167,0.854167,0.958333,0.916667,0.875,0.895833,0.916667,0.770833,0.875,0.875/)
 corr_b  = (/0.625,0.875,0.791667,0.791667,0.895833,0.875,0.6875,0.75,0.708333,0.666667,0.625,0.8125/)
 corr_c  = (/0.770833,0.875,0.75,0.9375,0.979167,1,0.729167,0.8125,0.8125,0.729167,0.833333,0.833333/)
 corr_d  = (/0.875,0.854167,0.875,0.833333,0.791667,0.875,0.75,0.8125,0.8125,0.729167,0.770833,0.854167/)

;************************************************
; plotting parameters
;************************************************
 wks   = gsn_open_wks ("pdf","agataplot")                ; send graphics to PNG file

 res                   = True                     ; plot mods desired
 res@tiMainString      = "CORRECT avg per group per event"           ; add title
 res@xyMarkLineModes   = "Markers"                ; choose which have markers
 res@xyMarkers         =  2                      ; choose type of marker  
 res@xyMarkerColor     = "red"                    ; Marker color
 res@xyMarkerSizeF     = 0.01                     ; Marker size (default 0.01)
res@trYMaxF = 1.0
res@trYMinF = 0.6
res@trXMinF = 1
res@trXMaxF = 12
;res@tmYLMode        = "Explicit"
;res@tmYLValues      = (/1,2,3,4,5,6,7,8,9,10,11,12/)
 res@tmLabelAutoStride = True                     ; nice tick mark labels

  res@gsnDraw          = False
  res@gsnFrame         = False
 plot1  = gsn_csm_xy (wks,seq,corr_a,res) ; create plot
; res@xyMarkerColor     = "green" 
 res@xyMarkers         =  4                      ; choose type of marker  
 plot2  = gsn_csm_xy (wks,seq,corr_b,res) ; create plot
; res@xyMarkerColor     = "blue" 
 res@xyMarkers         =  6                      ; choose type of marker  
 plot3  = gsn_csm_xy (wks,seq,corr_c,res) ; create plot
; res@xyMarkerColor     = "black" 
 res@xyMarkers         =  8                      ; choose type of marker  
 plot4  = gsn_csm_xy (wks,seq,corr_d,res) ; create plot

 overlay(plot1,plot2)
 overlay(plot1,plot3)
 overlay(plot1,plot4)



  draw(plot1)
  frame(wks)


end
