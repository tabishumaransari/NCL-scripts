begin
  a = new(39, float)
  b = new(39, float)
  a = (/6.69,13.53,43.50,43.88,36.34,96.50,156.98,238.84,193.83,36.65,73.88,126.44,226.60,300.88,56.56,27.92,61.36,107.64,156.22,151.96,47.12,8.0,32.03,127.19,69.26,15.52,56.27,87.34,71.44,85.08,34.40,7.62,23.81,35.44,97.53,72.53,24.26,60.97,225.55/)
  b = (/5.22,10.55,33.94,34.23,28.35,75.27,122.44,186.30,151.19,28.58,57.62,98.62,176.74,234.69,44.12,21.78,47.86,83.96,121.85,118.53,36.76,6.24,24.87,103.91,57.15,11.72,43.28,69.16,57.11,69.91,29.68,5.71,18.57,27.64,76.08,56.57,18.92,47.56,175.93/)

  wks = gsn_open_wks("x11","histogram")          
  ;gsn_define_colormap(wks,"temp1")           

  res                                = True
  res@gsnDraw                  = False
  res@gsnFrame                 = False  
  res@tmXBLabelStride                = 1  
  res@tmYLLabelStride                = 1     ;
  res@tmYLMode        = "Explicit"	
  res@tmYLValues      = (/0,1,2,3,4,5,6,7,8,9,10,11,12/)
  res@tmYLLabels      = "" + res@tmYLValues
  res@tmXBLabelFontHeightF = 0.015
  res@tmYLLabelFontHeightF = 0.015
  res@tmYLFormat = "f" 
  res@trYMaxF     =  12		; set maximum Y-axis value
  res@tmYROn = False
  res@tiYAxisString = "No. of days"
  res@tiXAxisString = "24hr avg PM2.5 concentration"
  res@tiYAxisFontHeightF = 0.015
  res@tiXAxisFontHeightF = 0.015
  res@gsnHistogramClassIntervals = (/0,25,50,75,100,125,150,175,200,225,250,300,325/)
  res@gsnHistogramBarColors = (/"blue","blue","blue","orange","orange","orange","red","red","red","red","red","red"/)
  plot1=gsn_histogram(wks,a,res)         ; create histogram with 20 bins
  plot2=gsn_histogram(wks,b,res)         ; create histogram with 20 bins
  gsn_panel(wks,(/plot1,plot2/),(/1,2/),False)


end

