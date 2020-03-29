; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"



begin

runarr =  new((/10,121/),float)
runarr1 =  new((/10,121/),float)
runarr2 =  new((/10,121/),float)
runarr3 =  new((/10,121/),float)
runarr4 =  new((/10,121/),float)

baseline16_18oct = (/32.00759,24.19994,20.9362,21.71133,22.78286,25.85089,32.44185,46.67327,42.73829,32.14121,31.78448,28.61281,26.19137,24.18993,25.26915,22.21895,22.88428,34.13464,56.19189,67.48733,72.38248,72.61597,70.59707,67.05762,72.12019,74.88326,70.6694,62.74235,64.37339,62.18375,65.71722,77.95816,89.4866,74.36617,69.70287,62.21678,60.18409,62.82483,70.75704,71.16004,71.60061,75.13824,106.2193,120.6332,125.9973,116.6313,99.83915,93.37234,80.95728,64.71229,47.79351,44.99038,49.90242,46.24151,49.65244,60.75753,63.47007,50.89976,48.8245,45.25706,44.70105,49.28584,49.57876,52.35965,68.14626,100.7725,151.6848,192.9966,208.5779,206.6857,208.1173,208.4497,208.2128/)

reduced16_18oct = (/32.00759,20.48813,15.99068,16.22196,17.06771,19.13692,22.11868,28.6451,27.11345,21.44821,21.17629,20.34071,19.03393,18.10786,19.70895,18.05216,19.53868,29.05073,46.53703,56.00461,60.14778,60.27596,59.84254,58.84402,62.04233,62.79783,59.73714,53.87443,55.44258,53.64318,55.24683,62.61871,69.76255,59.13931,54.21677,48.03516,44.77344,44.9765,48.9413,48.06258,49.01476,51.59499,74.17684,83.63405,86.45905,81.75862,71.59354,66.41853,56.71596,47.0919,39.33834,37.81095,40.9926,39.01955,40.2732,45.69174,46.6985,39.98317,37.68694,35.13724,34.17136,35.93293,35.42912,37.00233,48.73458,71.15357,105.8474,136.4409,148.1623,143.2068,145.5047,149.6691,153.4936/)

baseline17_19oct = (/62.04233,67.0877,65.13975,59.11436,61.89287,60.17641,63.8862,76.36295,87.99689,73.41444,69.047,61.77826,59.81861,62.47287,70.31379,70.71188,71.39248,74.95162,106.0554,120.4198,125.7894,102.6646,84.30929,80.94698,71.79061,61.09113,46.76978,44.22768,49.38245,46.09092,49.6952,60.81192,63.56475,51.01376,48.94279,45.36746,44.79479,49.39979,49.63295,52.2137,67.41571,99.28021,149.2655,190.2713,205.4058,188.4766,183.3527,184.2377,186.0734,193.936,201.7497,213.0016,223.8339,237.4921,259.806,295.0562,328.2961,321.2881,335.0941,324.2287,309.8448,289.5957,262.1752,242.0374,227.0306,226.9335,255.5439,278.0194,285.3672,285.0844,285.1205,275.412,273.5621/)

reduced17_19oct = (/62.04233,59.44376,55.71338,50.12014,51.14412,49.27678,50.73338,55.97625,57.9326,49.5273,44.80384,38.99538,34.90975,33.2933,34.80153,35.01748,35.9505,35.79253,46.68133,52.36807,53.53865,57.71597,52.67725,50.01725,44.74567,32.54535,19.86778,18.53318,21.50917,19.15135,18.79149,20.64824,20.00105,16.74539,15.19476,14.05754,13.71564,14.59418,13.89645,15.54256,22.34595,35.57222,51.58525,68.29061,70.91355,76.66936,83.41994,88.3315,88.83642,86.96134,91.21469,99.35192,106.2944,113.1639,128.3089,148.571,163.3883,167.7302,178.1897,188.0806,195.3857,193.7044,181.9588,171.1286,161.0762,155.3071,161.612,170.1877,173.9541,189.1055,197.2403,195.1543,193.5552/)

baseline18_20oct = (/44.74567,37.78347,26.19323,24.57684,28.69679,26.89429,30.91692,42.42986,46.39262,35.39667,33.3079,30.95452,31.54148,36.80636,36.14164,39.93649,50.52914,70.38171,105.9308,141.9993,151.9835,141.9401,141.7494,142.1817,141.4416,146.0466,153.8812,166.1694,177.6476,191.4236,216.546,255.564,293.4672,295.2888,312.5921,310.2327,303.2297,285.348,257.9276,238.9883,224.3985,221.7371,249.9528,272.4524,279.0484,278.1935,284.9971,275.8074,271.9665,269.8775,262.8879,255.4464,252.2995,256.1179,275.2093,301.4378,292.2424,256.1828,211.6676,200.4528,179.6756,107.7423,73.29311,61.93339,42.95693,41.51678,45.91369,52.95705,53.18269,39.64871,35.77304,33.06663,25.81687/)

reduced18_20oct = (/44.74567,32.54535,19.86778,18.53318,21.50917,19.15135,18.79149,20.64824,20.00105,16.74491,15.19466,14.05766,13.71587,14.59409,13.89599,15.54317,22.3432,35.56816,51.5763,68.27845,70.90572,76.66364,83.42654,88.30505,88.87265,86.85101,91.18859,99.15421,106.1231,113.0472,128.2796,148.5811,163.5553,168.3036,179.1188,188.8397,196.5072,194.6168,181.8698,170.7771,160.702,154.8837,160.9347,169.1088,173.3215,188.8071,197.0748,194.6351,192.4726,185.5386,176.8613,169.0368,164.4213,166.089,172.3157,187.8089,182.834,154.9819,130.0703,122.4868,111.3952,68.35735,39.9783,32.91017,19.8964,15.63323,15.5973,15.18261,13.44689,14.10047,15.79627,15.18728,14.54516/)

fullbaseline = (/24.19994,20.9362,21.71133,22.78286,25.85089,32.44185,46.67327,42.73829,32.14121,31.78448,28.61281,26.19137,24.18993,25.26915,22.21895,22.88428,34.13464,56.19189,67.48733,72.38248,72.61597,70.59707,67.05762,72.12019,74.88326,70.6694,62.74235,64.37339,62.18375,65.71722,77.95816,89.4866,74.36617,69.70287,62.21678,60.18409,62.82483,70.75704,71.16004,71.60061,75.13824,106.2193,120.6332,125.9973,116.6313,99.83915,93.37234,80.95728,64.71229,47.79351,44.99038,49.90242,46.24151,49.65244,60.75753,63.47007,50.89976,48.8245,45.25706,44.70105,49.28584,49.57876,52.35965,68.14626,100.7725,151.6848,192.9966,208.5779,206.6857,208.1173,208.4497,208.2128,209.5609,214.8757,224.7645,235.2724,248.8098,270.8735,306.1167,338.7347,330.8009,343.6196,329.0531,311.242,288.3299,260.6159,240.9542,225.0057,225.3695,253.1091,276.0706,282.6566,298.001,305.8905,295.0351,291.1388,283.628,271.4805,264.4235,259.4895,262.5587,280.7025,310.3388,299.9319,263.0949,215.9418,203.6828,181.7167,108.1687,73.90604,62.34404,43.23148,41.99731,46.74193,53.98,53.71708,46.24252,43.80432,38.74782,29.18607/)


runarr(0,0:72)   = baseline16_18oct
runarr(1,0:72)   = reduced16_18oct
runarr(2,24:96)  = baseline17_19oct
runarr(3,24:96)  = reduced17_19oct
runarr(4,48:120) = baseline18_20oct
runarr(5,48:120) = reduced18_20oct

runarr1(0,0:72)   = baseline16_18oct
runarr1(1,0:72)   = reduced16_18oct

runarr2(0,0:24)   = reduced16_18oct(0:24)
runarr2(1,24:96)  = baseline17_19oct
runarr2(2,24:96)  = reduced17_19oct

runarr3(0,0:24)   = reduced16_18oct(0:24)
runarr3(1,24:48)  = reduced17_19oct(0:24)
runarr3(2,48:120) = baseline18_20oct
runarr3(3,48:120) = reduced18_20oct

runarr4(0,0:24)   = reduced16_18oct(0:24)
runarr4(1,24:48)  = reduced17_19oct(0:24)
runarr4(2,48:120) = reduced18_20oct
runarr4(3,0:23)   = avg(runarr4(0,0:23))
runarr4(3,24:47)  = avg(runarr4(1,24:47))
runarr4(3,48:71)  = avg(runarr4(2,48:71))
runarr4(3,72:95)  = avg(runarr4(2,72:95))
runarr4(3,96:119) = avg(runarr4(2,96:119))

emisarr =  new(60,float)
emisarr = (/40,100,100,40, 100,100,100,100, 100,100,100,100,\\ 
            20,20,20,20, 20,20,20,20, 20,20,20,20,\\
            20,20,20,20, 20,20,20,20, 20,20,20,20,\\
            20,20,20,20, 20,20,20,20, 20,20,20,20,\\
            20,20,20,20, 20,20,20,20, 20,20,20,20/)

emistimearr = ispan(1,60,1)



;ADDING CIRCLES AT INFLEXION POINTS
circlearr =  new(121,float)
circlearr(0) = 32.00759
circlearr(24) = 62.04233
circlearr(48) = 44.74567
;circlearr(72) = 154.1803
;circlearr(96) = 193.0457

print("Hourly max is "+max(reduced18_20oct))

;---Start the graphics
wks = gsn_open_wks("x11","3dayguess_multistep") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
;res@gsnPaperOrientation = "portrait"
;res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.6
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/); make lines thicker
res@xyLineColors      = (/"blue","red","blue","red","blue","red"/)          ; change line color
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
  res@tiMainFontHeightF  = 0.035
  res@tiYAxisFontHeightF = 0.035
  res@tmXBLabelFontHeightF = 0.035
  res@tmYLLabelFontHeightF = 0.035
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
  res@tmYLValues      = (/0,50,100,150,200,250,300/)
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
txres@txFontHeightF = 0.006
gsn_text_ndc(wks,"24h avg. PM~B~2.5~N~=150 ~F33~m~F21~gm~S~-3~N~; AQI=200",0.635,0.936,txres)
gsn_text_ndc(wks,"24h avg. PM~B~2.5~N~=75 ~F33~m~F21~gm~S~-3~N~; AQI=100",0.635,0.91,txres)


xy1 = gsn_csm_xy(wks,timearr,runarr1,res)    ; Create the four plots.


res@xyLineColors      = (/"black","blue","red","blue","red","blue"/)          ; change line color
xy2 = gsn_csm_xy(wks,timearr,runarr2,res)    ; Create the four plots.

res@xyLineColors      = (/"black","black","blue","red","blue","red"/)          ; change line color
xy3 = gsn_csm_xy(wks,timearr,runarr3,res)    ; Create the four plots.

res@xyLineColors      = (/"black","black","black","black","red","blue"/)          ; change line color
res@xyDashPatterns  = (/0,0,0,2,0,0/)
xy4 = gsn_csm_xy(wks,timearr,runarr4,res)    ; Create the four plots.



res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@xyMonoMarker = True
res@xyMarker         =  4                      ; choose type of marker  
res@xyMarkerColor     = "black"                    ; Marker color
res@xyMarkerSizeF     = 0.02                     ; Marker size (default 0.01)

;xy2 = gsn_csm_xy(wks,timearr,circlearr,res)
;overlay(xy1,xy2)


;SIMPLE LEGEND
  gres = True
  gres@XPosPercent = 5
  gres@YPosPercent = 95
  gres@ItemSpacePercent = 10
  lineres2 = True
  lineres2@lgLineColors = (/"red","blue","black"/) ; line colors
  lineres2@lgDashIndexes = (/0,0,0/)             ; line patterns
  lineres2@lgLineThicknesses = 2.5
  lineres2@LineLengthPercent = 8                         ; expressed as %, 0->100, length of line
  textres2 = True
  textres2@lgLabels = (/"reduced emissions run","baseline emissions run","finalized emissions run"/)
  textres2@lgLabelFontHeights = (/0.015,0.015,0.015/)
  xy1 = simple_legend(wks,xy1,gres,lineres2,textres2)


print(runarr(1,24))
print(runarr(3,48))

  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4/),res1,res2)
;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)

res3 = True
res3@gsnXYBarChart = True            ; Create bar plot
res3@trYMaxF     =  100
res3@trYMinF     =  0

res3@tmXTOn        = False
res3@tmYROn        = False

;DRAW TICKMARKS INWARDS
res3@tmXBMajorOutwardLengthF=0.0
res3@tmXBMinorOutwardLengthF=0.0
res3@tmYLMajorOutwardLengthF=0.0
res3@tmYLMinorOutwardLengthF=0.0


res3@tmXBMajorLengthF=0.0
res3@tmXBMinorLengthF=0.04
res3@tmXBMinorThicknessF=2.0
res3@tmYLMajorLengthF=0.03
res3@tmYLMinorLengthF=0.02

res3@tmYLMode        = "Explicit"
res3@tmYLValues      = (/0,10,20,30,40,50,60,70,80,90,100/)
;res3@tmYLLabels      = "" + res@tmYLValues
res3@tmYLLabels      = (/"0","10","20","30","40","50","60","70","80","90","100"/)
;res3@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)

res3@tmXBMode = "Explicit"
res3@tmXBValues = (/6,18,30,42,54/)
res3@tmXBLabels = (/"Day 1","Day 2","Day 3","Day 4","Day 5"/)
res3@tmXBMinorValues = (/-0.5,12.5,24.5,36.5,48.5,60.5/)

res3@gsnXYBarChartColors = (/"tomato","tomato","tomato","tomato","limegreen","limegreen","limegreen","limegreen","dodgerblue","dodgerblue","dodgerblue","dodgerblue"/)            ; choose colors
res3@xyLineColors = (/"white"/) 
res3@vpWidthF    = 2
res3@vpHeightF   = 0.6
res3@gsnMaximize = True

res3@tmXBLabelFontHeightF = 0.035
res3@tmYLLabelFontHeightF = 0.035
res3@tiYAxisFontHeightF = 0.035
res3@tiYAxisString = "Emissions Strength (%)"

res3@gsnDraw  = False                          ; don't draw
res3@gsnFrame = False                          ; don't advance frame

emisplot = gsn_csm_xy (wks,emistimearr,emisarr,res3)

;----------------------------------------------------------------------
; Draw some individual labelbars.
;----------------------------------------------------------------------
  labels1  = (/"Beijing sources","Near neigh. sources","Far neigh. sources"/)
  colors1  = (/"tomato","limegreen","dodgerblue"/)
  lbres                    = True          ; labelbar only resources
  lbres@vpWidthF           = 0.07           ; labelbar width
  lbres@vpHeightF          = 0.07          ; labelbar height
  lbres@lbBoxMajorExtentF  = 0.2          ; puts space between color boxes
  lbres@lbMonoFillPattern  = True          ; Solid fill pattern
  lbres@lbLabelFontHeightF = 0.007         ; font height. default is small
  ;lbres@lbLabelJust        = "center"  ; left justify labels
  lbres@lbPerimOn          = False
;
; Each labelbar has just one label. This allows you to more
; easily control where the label goes.
;
;txres = True
  txres@txFontHeightF = 0.015
  ;gsn_text_ndc(wks,"wind speed range (ms~S~-1~N~):",0.16,0.5,txres)
  ;xpos = (/0.15,  0.3,   0.45,   0.6,  0.75,   0.85/)
  xpos = 0.31
  do i=0,2
     lbres@lbFillColors     = colors1(i)
     lbres@lbLabelFontColor = colors1(i)
     gsn_labelbar_ndc(wks,1,labels1(i),xpos,0.38,lbres)
     xpos = xpos+0.14
  end do





;---Retrieve the height used for the first plot and apply to second plot
  getvalues xy1(0)
    "vpWidthF"  : vpw
  end getvalues

 getvalues xy2
    "vpHeightF"  : vph
 end getvalues

setvalues (emisplot)
  "vpWidthF" : vpw
  "vpHeightF": vph
end setvalues



;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/xy1,emisplot/),(/2,1/),resP)             ; now draw as one plot






end


