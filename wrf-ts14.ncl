;THIS PLOTS RH FROM APEC BASELINE AND NCDC FROM 10OCT-20NOV 2014 

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;READ IN THE WRFOUT FILES 
DATADir = "/data3/tabish/APEC-baseline/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

times  = wrf_times_c(a[:]->Times,0)
times = times + 8 ; BOTH SIMULATIONS AND OBSERVATIONS IN THIS CASE ARE IN UTC SO WE NEED TO CORRECT THE TIME-SCALE
times_crop = times (0:983)

temp = a[:]->T2(0:983,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03

qv = a[:]->QVAPOR
print("read qvapor")
P  = a[:]->P                  ; perturbation
print("read perturbation pressure")
Pb = a[:]->PB                 ; base state pressure
print("read base state pressure")
P  = P + Pb                   ; total pressure
print("computed total pressure")
theta = a[:]->T               ; perturbation potential temperature (theta+t0)
print("read perturbation potential temperature")
theta = theta + 300.
print("added 300")
TK = wrf_tk (P, theta)
print("TK calculated!")
RH = wrf_rh (qv, P, TK)
print("RH calculated")
printVarSummary(RH)

RH_sim = RH(0:983,0,144,79)  ;extract RH time-series at Beijing Intl.



;READ IN THE BEIJING-INTL NCDC DATA
z1 = asciiread("/data1/tabish/nclscripts/beijingIntl-545110-metdata_10Oct-20Nov2014.txt",-1,"string")
USAF   = stringtofloat(str_get_cols(z1, 1,6))
YEAR   = stringtofloat(str_get_cols(z1, 13,16))
MONTH  = stringtofloat(str_get_cols(z1, 17,18))
DAY    = stringtofloat(str_get_cols(z1, 19,20))
HOUR   = stringtofloat(str_get_cols(z1, 21,22))
MIN    = stringtofloat(str_get_cols(z1, 23,24))
WDIR   = stringtofloat(str_get_cols(z1, 26,28))
WSPEED = stringtofloat(str_get_cols(z1, 30,32))
TEMP   = stringtofloat(str_get_cols(z1, 83,86))
DEWP   = stringtofloat(str_get_cols(z1, 88,91))
SLP    = stringtofloat(str_get_cols(z1, 93,98))
STP    = stringtofloat(str_get_cols(z1, 106,111))

TEMPC = (TEMP - 32) / 1.8  ; CONVERT FARENHEIT TO CELSIUS
DEWPC = (DEWP - 32) / 1.8  ; CONVERT FARENHEIT TO CELSIUS


RH_obs = 100*(exp((17.625*DEWPC)/(243.04+DEWPC))/exp((17.625*TEMPC)/(243.04+TEMPC))) 
RH_obs = where(RH_obs.gt.100,RH_obs@_FillValue,RH_obs)
RH_obs_crop = RH_obs(0:983)
var_matrix  = new((/2,984/),float)  
  
var_matrix(0,:) = (/RH_sim/)
var_matrix(1,:) = (/RH_obs_crop/)


;---Start the graphics
wks = gsn_open_wks("png","BEIJINGINTL_ts_10OCT-20NOV_RH") ; send graphics to PNG file
gsnPaperOrientation = "landscape"

;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Surface PM2.5 at wanshouxigong"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.6
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
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
  restick@ttmNumTicks = 8
 ; restick@ttmMajorStride= 12
 ; restick@ttmMinorStride= 1
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
  res@xyExplicitLegendLabels = (/"sim", "obs"/)         ; create explicit labels

; Change y axis string and color for each plot.

  res@tiYAxisString = "Relative Humidity"
  plot = gsn_csm_xy(wks,times_crop,var_matrix,res)



end
