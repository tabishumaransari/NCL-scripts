; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"



begin

runarr =  new((/10,121/),float)

baseline16oct = (/32.00759,24.19994,20.9362,21.71133,22.78286,25.85089,32.44185,46.67327,42.73829,32.14122,31.78433,28.61287,26.19125,24.19035,25.26926,22.21921,22.88422,34.13171,56.1931,67.49469,72.36932,72.66472,70.6338,67.05882,72.10841/)

baseline17oct = (/72.10841,74.8839,70.65594,62.66552,64.40348,62.18031,65.73746,77.97129,89.44866,74.35712,69.70729,62.22569,60.19063,62.83134,70.75819,71.15752,71.6045,75.14327,106.2214,120.637,126.0149,116.5466,99.77933,93.31649,81.00475/)

reduced17oct = (/72.10841,70.66006,65.18746,57.31111,57.88401,55.61425,57.05764,64.22214,71.18878,60.05819,54.86063,48.49109,45.15405,45.36899,49.43773,48.5298,49.25399,51.76809,74.35163,83.85419,86.64964,81.86628,71.7396,66.56216,56.85788/)

baseline18oct = (/56.85788,50.32138,43.30426,41.71498,45.77413,43.95137,48.23651,60.06218,63.03976,50.8837,48.80918,45.23679,44.76456,49.3707,49.44716,51.64685,63.84123,89.47288,134.366,174.949,190.0317,187.8655,190.3155,188.7791,185.6251/)

reduced18oct = (/56.85788,47.18135,39.4161,37.99343,41.25615,39.27178,40.55224,45.95242,46.93581,40.17462,37.84479,35.24555,34.27007,36.04494,35.56664,37.15271,48.9599,71.46018,106.3561,137.1811,148.9949,143.7738,146.0354,150.2393,154.1803/)

baseline19oct = (/154.1803,165.0595,174.751,187.5052,200.3835,217.642,245.6118,284.9707,320.357,315.563,331.0822,322.0552,309.5115,289.734,261.4136,241.5331,226.9471,225.9904,254.2627,277.1489,283.8091,298.3261,305.0107,294.774,290.8834/)

reduced19oct = (/154.1803,157.5466,166.0318,178.474,190.1701,205.2968,226.9382,250.6433,267.9491,271.9457,279.7278,274.9782,266.6089,250.6223,226.2529,206.0982,191.0389,182.1213,186.7304,195.9062,198.0014,200.7115,201.5113,197.2387,193.0457/)

baseline20oct = (/193.0457,196.3688,191.0322,187.0351,184.8369,188.9293,201.6039,218.8911,206.4955,176.7802,158.3143,150.5436,136.9828,89.49197,60.96462,52.71678,38.50439,38.05505,43.65395,49.64122,51.37128,44.35649,42.17271,36.8721,28.72487/)

reduced20oct = (/193.0457,187.5365,178.7015,173.9517,170.2303,170.6869,174.7871,182.2622,176.5888,155.9809,142.966,136.2171,123.5673,80.88507,52.92342,45.82283,32.40429,30.93116,30.73574,30.2009,33.68331,30.57177,29.85358,29.18068,24.04789/)

fullbaseline = (/24.19994,20.9362,21.71133,22.78286,25.85089,32.44185,46.67327,42.73829,32.14121,31.78448,28.61281,26.19137,24.18993,25.26915,22.21895,22.88428,34.13464,56.19189,67.48733,72.38248,72.61597,70.59707,67.05762,72.12019,74.88326,70.6694,62.74235,64.37339,62.18375,65.71722,77.95816,89.4866,74.36617,69.70287,62.21678,60.18409,62.82483,70.75704,71.16004,71.60061,75.13824,106.2193,120.6332,125.9973,116.6313,99.83915,93.37234,80.95728,64.71229,47.79351,44.99038,49.90242,46.24151,49.65244,60.75753,63.47007,50.89976,48.8245,45.25706,44.70105,49.28584,49.57876,52.35965,68.14626,100.7725,151.6848,192.9966,208.5779,206.6857,208.1173,208.4497,208.2128,209.5609,214.8757,224.7645,235.2724,248.8098,270.8735,306.1167,338.7347,330.8009,343.6196,329.0531,311.242,288.3299,260.6159,240.9542,225.0057,225.3695,253.1091,276.0706,282.6566,298.001,305.8905,295.0351,291.1388,283.628,271.4805,264.4235,259.4895,262.5587,280.7025,310.3388,299.9319,263.0949,215.9418,203.6828,181.7167,108.1687,73.90604,62.34404,43.23148,41.99731,46.74193,53.98,53.71708,46.24252,43.80432,38.74782,29.18607/)


runarr(0,0:24) = baseline16oct
runarr(1,24:48) = baseline17oct
runarr(2,24:48) = reduced17oct
runarr(3,48:72) = baseline18oct
runarr(4,48:72) = reduced18oct
runarr(5,72:96) = baseline19oct
runarr(6,72:96) = reduced19oct
runarr(7,96:120) = baseline20oct
runarr(8,96:120) = reduced20oct
;runarr(9,1:120) = fullbaseline

;ADDING CIRCLES AT INFLEXION POINTS
circlearr =  new(121,float)
circlearr(24) = 72.10841
circlearr(48) = 56.85788
circlearr(72) = 154.1803
circlearr(96) = 193.0457


;---Start the graphics
wks = gsn_open_wks("pdf","1dayguess") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
;res@gsnPaperOrientation = "portrait"
;res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,2/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/); make lines thicker
res@xyLineColors      = (/"blue","blue","red","blue","red","blue","red","blue","red","blue"/)          ; change line color
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
gsn_text_ndc(wks,"PM~B~2.5~N~=75 ~F33~m~F21~gm~S~-3~N~; AQI=100",0.72,0.405,txres)
gsn_text_ndc(wks,"PM~B~2.5~N~=150 ~F33~m~F21~gm~S~-3~N~; AQI=200",0.72,0.50,txres)



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


end


