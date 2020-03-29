;THIS PLOTS RH FOR 21OCT-25OCT 2014 FOR NUDGED VS NON-NUDGED RUNS

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;READ IN THE WRFOUT FILES 
FILES_YSU           = systemfunc (" ls -1 /data3/tabish/YSU-nonnudged/wrfout_d03_2014-* ")
FILES_YSUNUDGED     = systemfunc (" ls -1 /data3/tabish/YSU-nudged/wrfout_d03_2014-* ")
FILES_QNSENUDGED    = systemfunc (" ls -1 /data3/tabish/QNSE-nudged/wrfout_d03_2014-* ")
FILES_QNSENONNUDGED = systemfunc (" ls -1 /data3/tabish/QNSE-nonnudged/wrfout_d03_2014-* ")

a = addfiles(FILES_YSU,"r")
b = addfiles(FILES_YSUNUDGED,"r")
c = addfiles(FILES_QNSENUDGED,"r")
d = addfiles(FILES_QNSENONNUDGED,"r")


times  = wrf_times_c(b[:]->Times,0)
temp_a = a[:]->T2(1:119,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
temp_b = b[:]->T2(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
temp_c = c[:]->T2(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
temp_d = d[:]->T2(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03

pblh_a = a[:]->PBLH(1:119,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
pblh_b = b[:]->PBLH(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
pblh_c = c[:]->PBLH(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
pblh_d = d[:]->PBLH(0:118,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03


temp_a = temp_a - 273.15
temp_b = temp_b - 273.15
temp_c = temp_c - 273.15
temp_d = temp_d - 273.15
times = times + 8 ; BOTH SIMULATIONS AND OBSERVATIONS IN THIS CASE ARE IN UTC SO WE NEED TO CORRECT THE TIME-SCALE
times_crop = times(0:118)
;print(dimsizes(temp))


qv_a = a[:]->QVAPOR
qv_b = b[:]->QVAPOR
qv_c = c[:]->QVAPOR
qv_d = d[:]->QVAPOR
print("read qvapor")
P_a  = a[:]->P                  ; perturbation
P_b  = b[:]->P                  ; perturbation
P_c  = c[:]->P                  ; perturbation
P_d  = d[:]->P                  ; perturbation
print("read perturbation pressure")
Pb_a = a[:]->PB                 ; base state pressure
Pb_b = b[:]->PB                 ; base state pressure
Pb_c = c[:]->PB                 ; base state pressure
Pb_d = d[:]->PB                 ; base state pressure
print("read base state pressure")
P_a  = P_a + Pb_a                   ; total pressure
P_b  = P_b + Pb_b                   ; total pressure
P_c  = P_c + Pb_c                   ; total pressure
P_d  = P_d + Pb_d                   ; total pressure
print("computed total pressure")
theta_a = a[:]->T               ; perturbation potential temperature (theta+t0)
theta_b = b[:]->T               ; perturbation potential temperature (theta+t0)
theta_c = c[:]->T               ; perturbation potential temperature (theta+t0)
theta_d = d[:]->T               ; perturbation potential temperature (theta+t0)
print("read perturbation potential temperature")
theta_a = theta_a + 300.
theta_b = theta_b + 300.
theta_c = theta_c + 300.
theta_d = theta_d + 300.
print("added 300")
TK_a = wrf_tk (P_a, theta_a)
TK_b = wrf_tk (P_b, theta_b)
TK_c = wrf_tk (P_c, theta_c)
TK_d = wrf_tk (P_d, theta_d)
print("TK calculated!")
RH_a = wrf_rh (qv_a, P_a, TK_a)
RH_b = wrf_rh (qv_b, P_b, TK_b)
RH_c = wrf_rh (qv_c, P_c, TK_c)
RH_d = wrf_rh (qv_d, P_d, TK_d)
print("RH calculated")
;printVarSummary(RH)

RH_ts_a = RH_a(1:119,0,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
RH_ts_b = RH_b(0:118,0,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
RH_ts_c = RH_c(0:118,0,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03
RH_ts_d = RH_d(0:118,0,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03



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
temp_obs = TEMPC(265:383)

DEWPC = (DEWP - 32) / 1.8  ; CONVERT FARENHEIT TO CELSIUS
RH_obs = 100*(exp((17.625*DEWPC)/(243.04+DEWPC))/exp((17.625*TEMPC)/(243.04+TEMPC)))
;RH_obs = where(RH_obs.gt.100,RH_obs@_FillValue,RH_obs)
RH_obs_crop = RH_obs(265:383)

var_matrix  = new((/5,119/),float)  
var_matrix(0,:) = (/RH_ts_a/)
var_matrix(1,:) = (/RH_ts_b/)
var_matrix(2,:) = (/RH_ts_c/)
var_matrix(3,:) = (/RH_ts_d/)
var_matrix(4,:) = (/RH_obs_crop/)


pblh_matrix  = new((/4,119/),float) 

pblh_matrix(0,:) = (/pblh_a/)
pblh_matrix(1,:) = (/pblh_b/)
pblh_matrix(2,:) = (/pblh_c/)
pblh_matrix(3,:) = (/pblh_d/)


;---Start the graphics
wks = gsn_open_wks("png","BEIJINGINTL_ts_21-25OCT_RH") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"

;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Surface PM2.5 at wanshouxigong"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/2.0, 2.0, 2.0, 2.0, 2.0/)          ; make second line thicker
res@xyLineColors      = (/"black","blue", "darkgreen", "brown", "red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
 restick@ttmFormat = "%D_%H"
;  restick@ttmFormat = "%D"
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
  res@xyExplicitLegendLabels = (/"YSU-nonnudged", "YSU-nudged", "QNSE-nudged", "QNSE-nonnudged", "obs"/)         ; create explicit labels

; Change y axis string and color for each plot.

;  res@tiYAxisString = "Temperature in degree Celsius"
  res@tiYAxisString = "Relative Humidity"

  plot = gsn_csm_xy(wks,times_crop,var_matrix,res)



end
