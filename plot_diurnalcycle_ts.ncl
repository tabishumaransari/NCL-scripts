begin

resi = (/0.43,0.43,0.43,0.43,0.43,0.91,1.8,1.8,0.91,0.91,0.72,1.08,1.08,0.91,0.72,0.72,0.91,1.8,1.8,1.8,1.8,1.3,0.43,0.43/)
indu = (/0.62,0.17,0.17,0.17,0.17,0.17,0.17,0.70,1.08,1.63,1.63,1.63,1.63,1.63,1.63,1.63,1.63,1.58,1.51,0.89,0.89,0.89,0.89,0.89/)
pow = (/0.78,0.72,0.69,0.68,0.7,0.76,0.85,0.97,1.04,1.1,1.15,1.17,1.19,1.19,1.2,1.2,1.19,1.17,1.15,1.14,1.12,1.06,0.95,0.84/)
tran = (/0.41,0.32,0.33,0.36,0.37,0.38,0.7,1.35,1.44,1.41,1.43,1.3,1.2,1.41,1.44,1.49,1.42,1.38,1.34,1.18,1.09,1,0.74,0.52/)
agri = (/0.49,0.46,0.46,0.43,0.45,0.54,0.78,0.87,1.12,1.35,1.6,1.81,2.04,1.89,1.83,1.6,1.39,1.14,0.83,0.73,0.64,0.56,0.49,0.49/)

print(avg(resi))
print(avg(indu))
print(avg(pow))
print(avg(tran))
print(avg(agri))
print(dimsizes(resi))


  x   = ispan(0,23,1)                     ; define diurnal cycle
  wks  = gsn_open_wks("x11","diurnalcycle")                 ; send graphics to PNG file
  res                 = True                         ; make plot mods
 res@vpHeightF   = 0.25
 res@xyDashPattern  = 0                         ; Make curves all solid
 res@trXMaxF=max(x)
 res@xyLineColors = (/"brown","red","black","blue","green"/) 
;  res@tiMainString    = "Diurnal cycle"  ; title
  res@tiXAxisString   = "Hour of Day (local time)"                        ; x-axis label
  res@tiYAxisString   = "Scaling factor"                        ; x-axis label
 
  res@tmXBMode        = "Explicit"
  res@tmXTOn          = False
  res@tmYROn          = False

res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward



  res@tmXBValues      = (/0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23/)
  res@tmXBLabels      = (/"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"/)
;  res@tmXBMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)
res@xyLabelMode            = "Custom"           ; label a line
res@xyExplicitLabels = (/"R","I","P","T","A"/)
 res@xyLineLabelFontHeightF = 0.01    
 
  plot = gsn_csm_xy(wks,x,(/resi,indu,pow,tran,agri/),res)                       ; plot correlation

end
