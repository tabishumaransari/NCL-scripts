;THIS PLOTS ONLY PBLH FOR 21-25 OCT 2014 and FROM APEC-BASELINE1 AND 3

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin


DATADir = "/data3/tabish/APEC-baseline3/"
DATADir2 = "/data3/tabish/APEC-baseline/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
b = addfiles(FILES2,"r")
times  = wrf_times_c(a[:]->Times,0)
;print(times)
times_crop = times(16:135)
print(times_crop)
pblh1 = a[:]->PBLH(:,141,79)
pblh2 = b[:]->PBLH(:,141,79)
pblh_qnse = pblh1(16:135)
pblh_ysu = pblh2(232:351)
times_crop = times_crop +8




;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
z1 = asciiread("LIDAR_PBLH_hourly_under3km_improved.txt",(/1080,2/),"float")
z2 = asciiread("dustLIDAR_PBLH_hourly_under3km_improved.txt",(/1080,2/),"float")
pblh_obs_anthro = z1(264:383,1)  ; CROP OUT THE PBLH DATA FOR THE REQUIRED PERIOD
pblh_obs_dust   = z2(264:383,1)  ; CROP OUT THE PBLH DATA FOR THE REQUIRED PERIOD
var_matrix_pblh  = new((/4,120/),float)  
  
var_matrix_pblh(0,:) = (/pblh_qnse/)
var_matrix_pblh(1,:) = (/pblh_ysu/)
var_matrix_pblh(2,:) = pblh_obs_anthro
var_matrix_pblh(3,:) = pblh_obs_dust


;---Start the graphics
wks = gsn_open_wks("png","wanshouxigong_ts_21-25Oct_QNSE-YSU-OBS_PBLH") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Surface PM2.5 at wanshouxigong"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.6
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,1,1/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0, 2.0, 2.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","black","red","darkgreen"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  restick@ttmFormat = "%D_%H"
  ;restick@ttmFormat = "%D"
;  restick@ttmNumTicks = 5
  restick@ttmMajorStride= 12
  restick@ttmMinorStride= 1
  time_axis_labels(times_crop,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.1
  res@tiYAxisFontHeightF = 0.05

  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = False   ; Turn off left tickmarks
  res@tmYROn               = True    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels


  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .85                  ; move units right
  res@pmLegendOrthogonalPosF = 0               ; move units down
  res@pmLegendWidthF         = 0.5                ; Change width and
  res@pmLegendHeightF        = 0.35                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"qnse","ysu","anthroLIDAR","dustLIDAR"/)         ; create explicit labels

; Change y axis string and color for each plot.

  res@tiYAxisString = "PBLH"
  plot = gsn_csm_xy(wks,times_crop,var_matrix_pblh,res)



end
