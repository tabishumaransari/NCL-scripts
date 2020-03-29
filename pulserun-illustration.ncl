; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"


;----------------------------------------------------------------------
; This procedure takes an existing plot, retrieves the viewport 
; coordinates, and fills that area in the desired color. This
; procedure can be used on *any* plot object.
;----------------------------------------------------------------------
undef("fill_xy_plot_area")
procedure fill_xy_plot_area(wks,plot)
begin
  getvalues plot
    "trXMinF"   : xmin
    "trYMinF"   : ymin
    "trXMaxF"   : xmax
    "trYMaxF"   : ymax
  end getvalues

  xbox = (/xmin,xmax,xmax,xmin,xmin/)
  ybox = (/ymin,ymin,ymax,ymax,ymin/)

  gnres = True
  gnres@gsFillColor     = "Gray70"
  gnres@tfPolyDrawOrder = "PreDraw"
  plot@$unique_string("box")$ = gsn_add_polygon(wks,plot,xbox,ybox,gnres)
end


;;;MAIN PROGRAM;;;
begin

runarr =  new((/40,696/),float)
;;;:::OCT PULSES;;;;;
runarr(0,0:23) = 1
runarr(1,24:119) = 1

runarr(2,24:47) = 2
runarr(3,48:143) = 2

runarr(4,48:71) = 3
runarr(5,72:167) = 3

runarr(6,72:95) = 4
runarr(7,96:191) = 4

runarr(8,96:119) = 5
runarr(9,120:215) = 5

runarr(10,120:143) = 6
runarr(11,144:239) = 6

runarr(12,144:167) = 7
runarr(13,168:263) = 7

runarr(14,168:191) = 8
runarr(15,192:287) = 8

runarr(16,192:215) = 9
runarr(17,216:311) = 9

runarr(18,216:239) = 10
runarr(19,240:335) = 10

;;;;;NOV PULSES;;;;;;;;
runarr(20,360:383) = 11
runarr(21,384:503-24) = 11

runarr(22,384:407) = 12
runarr(23,408:527-24) = 12

runarr(24,408:431) = 13
runarr(25,432:551-24) = 13

runarr(26,432:455) = 14
runarr(27,456:575-24) = 14

runarr(28,456:479) = 15
runarr(29,480:599-24) = 15

runarr(30,480:503) = 16
runarr(31,504:623-24) = 16

runarr(32,504:527) = 17
runarr(33,528:647-24) = 17

runarr(34,528:551) = 18
runarr(35,552:671-24) = 18

runarr(36,552:575) = 19
runarr(37,576:695-24) = 19

runarr(38,576:599) = 20
runarr(39,600:719-24) = 20


;---Start the graphics
wks = gsn_open_wks("eps","pulserun-illustration") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
;res@gsnPaperOrientation = "portrait"
;res@vpKeepAspect=False
;res@tiMainString     = "12 Beijing sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0,2.0/); make lines thicker
res@xyLineColors      = (/"red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue","red","blue"/)          ; change line color
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
  restick@ttmFormat = "%D"
;   restick@ttmNumTicks = 20
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12

  timearr = ispan (0,695,1)
  timearr@units = "hours since 2014-10-18 00:00:00"
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
  res@tmXBMajorLengthF = 0.02  
  res@tmXBMinorLengthF = 0.0  

 
  res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  res@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  res@tmYLMajorLengthF = 0.02

  res@trYMaxF     =  21
  res@tmYLMode        = "Explicit"
  res@tmYLValues      = (/0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21/)
; res@tmYLLabels      = "" + res@tmYLValues
  res@tmYLLabels      = (/"","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",""/)
;  res@tmYLMinorValues = (/0,30,60,90,120,150,180,210,240,270,300,330,360/)


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
  res@tiYAxisString = "Run No."
  
 res@tmXMajorGrid          = True               ; Add white grid lines
 res@tmXMajorGridLineColor = "white"
; res@tmYMajorGrid          = True
; res@tmYMajorGridLineColor = "white"

xy1 = gsn_csm_xy(wks,timearr,runarr,res)    ; Create the four plots.

 fill_xy_plot_area(wks,xy1)
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
