; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"



begin

runarr =  new((/10,121/),float)

baseline16_19oct = (/32.00759,24.19994,20.9362,21.71133,22.78286,25.85089,32.44185,46.67327,42.73829,32.14121,31.78448,28.61281,26.19137,24.18993,25.26915,22.21895,22.88428,34.13464,56.19189,67.48733,72.38248,72.61597,70.59707,67.05762,72.12019,74.88326,70.6694,62.74235,64.37339,62.18375,65.71722,77.95816,89.4866,74.36617,69.70287,62.21678,60.18409,62.82483,70.75704,71.16004,71.60061,75.13824,106.2193,120.6332,125.9973,116.6313,99.83915,93.37234,80.95728,64.71229,47.79351,44.99038,49.90242,46.24151,49.65244,60.75753,63.47007,50.89976,48.8245,45.25706,44.70105,49.28584,49.57876,52.35965,68.14626,100.7725,151.6848,192.9966,208.5779,206.6857,208.1173,208.4497,208.2128,209.5609,214.8757,224.7645,235.2724,248.8098,270.8735,306.1167,338.7347,330.8009,343.6196,329.0531,311.242,288.3299,260.6159,240.9542,225.0057,225.3695,253.1091,276.0706,282.6566,298.001,305.8905,295.0351,291.1388/)

reduced16_19oct = (/32.00759,17.81378,12.57681,12.53629,13.36429,14.19274,15.57879,18.05782,16.18486,13.4553,13.30443,13.07866,12.52681,12.68837,13.54639,12.16552,13.37258,19.83027,31.31593,33.9345,35.42338,35.50502,33.6735,31.74964,33.06827,34.22807,32.57651,29.11802,29.33897,28.23522,29.13975,31.66796,32.74765,27.91921,24.90542,21.81872,19.63043,19.61846,21.27389,20.66895,20.43828,19.85656,28.70823,35.08036,37.36826,34.8018,31.77305,31.84968,30.41198,22.87387,13.19529,11.92973,12.88535,11.48143,12.01378,14.78074,14.83541,12.54497,11.58343,10.86678,10.73905,11.65342,11.37387,11.98871,15.77735,23.38205,33.1534,43.74878,46.59176,47.58117,49.74437,51.91127,53.84656,54.79591,58.25526,64.78997,70.13396,74.37481,83.37775,98.53152,111.1458,120.3162,133.3619,149.1654,160.5211,160.5962,153.0093,147.5163,140.1372,135.8916,141.819,147.8156,151.4886,157.7762,162.1299,163.505,163.4258/)

baseline17_20oct = (/33.06827,41.64334,41.98088,38.45119,41.16293,40.47554,44.2432,54.70812,64.42064,53.04683,49.65067,45.45958,45.04303,49.89116,57.94753,57.60892,58.10423,59.96194,90.60858,106.0346,112.7717,83.08779,66.12318,64.00654,59.69289,55.32924,42.28325,39.74801,43.29892,40.3995,44.28575,56.43459,59.36513,48.05526,45.99681,42.68841,42.41993,47.02956,46.65493,49.67258,64.6381,94.74618,142.407,182.1721,196.1001,169.2962,161.3599,162.3429,168.2712,181.567,190.5616,202.4464,212.5413,223.5442,242.1854,273.1956,302.6914,292.2431,302.5456,294.0044,281.8647,262.5787,238.8976,222.6486,208.6958,208.554,234.6996,257.5703,264.8186,254.2679,257.2713,250.5196,249.0275,253.7024,249.0103,243.5331,241.2928,246.0481,263.5752,286.8553,272.8797,239.2798,202.3938,192.4084,172.5513,104.2559,70.17863,59.6915,41.4811,40.03437,44.57646,51.5045,52.33972,36.39636,30.36481,26.58134,19.32106/)

reduced17_20oct = (/33.06827,34.22807,32.57651,29.11802,29.33897,28.23522,29.13975,31.66796,32.74765,27.91924,24.90707,21.81848,19.63112,19.61896,21.27396,20.66933,20.43857,19.85699,28.70828,35.08018,37.37266,34.7855,31.77605,31.86039,30.40583,22.87487,13.25334,12.07266,13.05476,11.68774,12.2721,14.9361,15.07217,12.73754,11.71814,10.97167,10.83851,11.77096,11.50255,12.13561,15.92996,23.49978,33.29716,43.83952,46.70232,47.67125,49.80956,52.01625,53.98521,55.04385,58.64211,65.45708,70.77368,74.90931,83.69452,98.76855,111.4011,120.3339,133.5669,149.6545,161.5806,162.5252,155.1954,149.3013,141.6929,137.3183,143.2161,149.3652,153.1857,159.1058,163.411,163.9952,163.5496,160.8214,156.0069,150.0875,147.2016,147.1617,150.5866,155.3153,146.1039,128.3926,114.6562,109.236,99.99606,61.53877,36.21718,29.30344,17.94458,13.99612,14.0487,13.6488,12.41911,10.77576,9.972484,8.619081,7.510822/)

runarr(0,0:96)   = baseline16_19oct
runarr(1,0:96)   = reduced16_19oct
runarr(2,24:120)  = baseline17_20oct
runarr(3,24:120)  = reduced17_20oct


;ADDING CIRCLES AT INFLEXION POINTS
circlearr =  new(121,float)
circlearr(0) = 32.00759
circlearr(24) = 33.06827
;circlearr(48) = 44.74567
;circlearr(72) = 154.1803
;circlearr(96) = 193.0457


;---Start the graphics
wks = gsn_open_wks("x11","4dayguess") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
;res@gsnPaperOrientation = "portrait"
;res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0, 1.0, 1.0/); make lines thicker
res@xyLineColors      = (/"blue","red","blue","red"/)          ; change line color
;res@gsnXRefLine = (/ 73 /)
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
; restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12

  timearr = ispan (0,120,1)
  timearr@units = "hours since 2014-10-16 00:00:00"
  time_axis_labels(timearr,res,restick)
res@trXMaxF=max(timearr)
;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.025
  res@tmXBLabelFontHeightF = 0.025
  res@tmYLLabelFontHeightF = 0.025
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
  
  res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmXBMajorLengthF = 0.03  
  res@tmXBMinorLengthF = 0.02  

 
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorLengthF = 0.03
  res@tmYLMinorLengthF = 0.02

  res@trYMaxF     =  350
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,50,100,150,200,250,300,350/)
 res@tmYLLabels      = "" + res@tmYLValues
;  res@tmYLLabels      = (/"","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",""/)
  res@tmYLMinorValues = (/25,75,125,175,225,275,325/)


;  res@pmLegendDisplayMode    = "Never"            ; turn on legend
;  res@pmLegendSide           = "Top"               ; Change location of
;  res@pmLegendParallelPosF   = 0.15                  ; move units right
;  res@pmLegendOrthogonalPosF = -0.45               ; move units down
;  res@pmLegendWidthF         = 0.25                ; Change width and
;  res@pmLegendHeightF        = 0.15                ; height of legend.
;  res@lgAutoManage           = False
;  res@lgPerimOn              = False               ; turn off box around
;  res@lgLabelFontHeightF     = .04                 ; label font height
;  res@xyExplicitLegendLabels = (/"reduced","baseline"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
; Change y axis string and color for each plot.
  res@tiYAxisString = "PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)"
  
; res@tmXMajorGrid          = True               ; Add white grid lines
; res@tmXMajorGridLineColor = "white"
; res@tmYMajorGrid          = True
; res@tmYMajorGridLineColor = "white"

res@gsnYRefLineColor = (/"green","green"/)
res@gsnYRefLine = (/ 75,150 /)

txres               = True
txres@txFontHeightF = 0.010
gsn_text_ndc(wks,"PM~B~2.5~N~=75 ~F33~m~F21~gm~S~-3~N~; AQI=100",0.20,0.405,txres)
gsn_text_ndc(wks,"PM~B~2.5~N~=150 ~F33~m~F21~gm~S~-3~N~; AQI=200",0.20,0.50,txres)



xy1 = gsn_csm_xy(wks,timearr,runarr,res)    ; Create the four plots.


res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@xyMonoMarker = True
res@xyMarker         =  4                      ; choose type of marker  
res@xyMarkerColor     = "black"                    ; Marker color
res@xyMarkerSizeF     = 0.02                     ; Marker size (default 0.01)

xy2 = gsn_csm_xy(wks,timearr,circlearr,res)
overlay(xy1,xy2)


; fill_xy_plot_area(wks,xy1)
;SIMPLE LEGEND
  gres = True
  gres@XPosPercent = 5
  lineres2 = True
  lineres2@lgLineColors = (/"red","blue"/) ; line colors
  lineres2@lgDashIndexes = (/0,0/)             ; line patterns
  lineres2@lgLineThicknesses = 2.5
  lineres2@LineLengthPercent = 8                         ; expressed as %, 0->100, length of line
  textres2 = True
  textres2@lgLabels = (/"reduced emissions","baseline emissions"/)
  textres2@lgLabelFontHeights = (/0.012,0.012/)
  xy1 = simple_legend(wks,xy1,gres,lineres2,textres2)



;---Fill the plot area in gray
; fill_xy_plot_area(wks,xy1)
 draw(xy1)
 frame(wks)

print(runarr(1,24))
print(runarr(3,48))

end


