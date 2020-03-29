;THIS IS AN UPDATE ON WRF-TS7.NCL THAT IT TRANSFORMS WRF TIMES TO CHINA LOCAL TIME

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

pm25_sim =new(840,float)  
pm10_sim =new(840,float)  
pmcoarse_sim =new(840,float)  
co_sim =new(840,float)  
no2_sim =new(840,float)  
so2_sim =new(840,float)  
o3_sim =new(840,float)  
pm25_obs =new(840,float)  
pm10_obs =new(840,float)  
pmcoarse_obs =new(840,float)  
co_obs =new(840,float)  
no2_obs =new(840,float)  
so2_obs =new(840,float)  
o3_obs =new(840,float)  

DATADir = "/data3/tabish/APEC-baseline/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-1* ")
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)
times_crop = times(16:855)
pm25   = a[:]->PM2_5_DRY(:,0,141,79)
pm10   = a[:]->PM10(:,0,141,79)
co   = a[:]->co(:,0,141,79)
no2   = a[:]->no2(:,0,141,79)
so2   = a[:]->so2(:,0,141,79)
o3   = a[:]->o3(:,0,141,79)
pm25_sim = pm25(16:855)
pm10_sim = pm10(16:855)
pmcoarse_sim = pm10_sim - pm25_sim
co_sim = co(16:855)
no2_sim =1000* no2(16:855)
so2_sim = 1000* so2(16:855)
o3_sim = 1000* o3(16:855)
pblh = a[:]->PBLH(:,141,79)
pblh_sim = pblh(16:855)
times_crop = times_crop +8
;print(times_crop)

;TRANSFORM WRF TIMES INTO CHINA LOCAL TIME
; time_numeric = cd_inv_string(times_crop, "%Y-%N-%D_%H:00:00")  ;; will return in hours since 1800-01-01 unless specified otherwise
; offset = -8    ; hours
; time_numeric = time_numeric - offset
; times_crop_new= cd_string( time_numeric, "%Y-%N-%D_%H:00:00" )
 

;print(times_crop_new)





;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

diri = "/data1/tabish/surface_data/12Oct2014-15Nov2014_filled/"
fname = systemfunc("ls -1 " + diri + "20141*")

 do i =0, 839               ;LOOP OVER EACH FILE (TIME)
  print("file number="+ i+ " filename= "+ fname(i))
  lines = asciiread(fname(i),-1,"string")
  lines = where(lines.eq.0, -999, lines) ;CLEANSING...
  pm25_obs(i) = tofloat(str_get_field(lines(0),4," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  pm10_obs(i) = tofloat(str_get_field(lines(0),5," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  co_obs(i) = tofloat(str_get_field(lines(0),6," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  no2_obs(i) = tofloat(str_get_field(lines(0),7," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  so2_obs(i) = tofloat(str_get_field(lines(0),8," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  o3_obs(i) = tofloat(str_get_field(lines(0),9," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  delete(lines)
 end do                     ;END FILE LOOP
pm25_obs = where(pm25_obs.eq.0, -999, pm25_obs) ;CLEANSING...
pm10_obs = where(pm10_obs.eq.0, -999, pm10_obs) ;CLEANSING...
co_obs = where(co_obs.eq.0, -999, co_obs) ;CLEANSING...
no2_obs = where(no2_obs.eq.0, -999, no2_obs) ;CLEANSING...
so2_obs = where(so2_obs.eq.0, -999, so2_obs) ;CLEANSING...
o3_obs = where(o3_obs.eq.0, -999, o3_obs) ;CLEANSING...
pm25_obs@_FillValue = -999
pm10_obs@_FillValue = -999
co_obs@_FillValue = -999
no2_obs@_FillValue = -999
so2_obs@_FillValue = -999
o3_obs@_FillValue = -999
pmcoarse_obs = pm10_obs - pm25_obs
  ;var_matrix  = new((/2,dimsizes(pm25_sim)/),float)  
  var_matrix_pm25  = new((/2,840/),float)  
  var_matrix_pm10  = new((/2,840/),float)  
  var_matrix_pmcoarse  = new((/2,840/),float)  
  var_matrix_co  = new((/2,840/),float)  
  var_matrix_no2  = new((/2,840/),float)  
  var_matrix_so2  = new((/2,840/),float)  
  var_matrix_o3  = new((/2,840/),float)  
  
var_matrix_pm25(0,:) = (/pm25_sim/)
var_matrix_pm25(1,:) = pm25_obs
var_matrix_pm10(0,:) = (/pm10_sim/)
var_matrix_pm10(1,:) = pm10_obs
var_matrix_pmcoarse(0,:) = (/pmcoarse_sim/)
var_matrix_pmcoarse(1,:) = pmcoarse_obs
var_matrix_co(0,:) = (/co_sim/)
var_matrix_co(1,:) = co_obs
var_matrix_no2(0,:) = (/no2_sim/)
var_matrix_no2(1,:) = no2_obs
var_matrix_so2(0,:) = (/so2_sim/)
var_matrix_so2(1,:) = so2_obs
var_matrix_o3(0,:) = (/o3_sim/)
var_matrix_o3(1,:) = o3_obs


;---Start the graphics
wks = gsn_open_wks("png","panel-wanshouxigong_ts") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface PM2.5 at wanshouxigong"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 5
res@vpHeightF   = 0.6
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  ;restick@ttmFormat = "%D/%N_%H:00"
  restick@ttmFormat = "%D"
  restick@ttmNumTicks = 17
  time_axis_labels(times_crop,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.1
  res@tiYAxisFontHeightF = 0.05

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .75                  ; move units right
  res@pmLegendOrthogonalPosF = -0.76               ; move units down
  res@pmLegendWidthF         = 1                ; Change width and
  res@pmLegendHeightF        = 0.2                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .1                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

  plot = new(8,graphic)
  plot(0) = gsn_csm_xy(wks,times_crop,var_matrix_pm25,res)
  res@tiMainString     = "Surface PM10 at wanshouxigong"        ; add title
  plot(1) = gsn_csm_xy(wks,times_crop,var_matrix_pm10,res)
  res@tiMainString     = "Surface PM coarse at wanshouxigong"   ; add title
  plot(2) = gsn_csm_xy(wks,times_crop,var_matrix_pmcoarse,res)
  res@tiMainString     = "Surface CO at wanshouxigong"          ; add title
  plot(3) = gsn_csm_xy(wks,times_crop,var_matrix_co,res)
  res@tiMainString     = "Surface NO2 at wanshouxigong"         ; add title
  plot(4) = gsn_csm_xy(wks,times_crop,var_matrix_no2,res)
  res@tiMainString     = "Surface SO2 at wanshouxigong"         ; add title
  plot(5) = gsn_csm_xy(wks,times_crop,var_matrix_so2,res)
  res@tiMainString     = "Surface O3 at wanshouxigong"          ; add title
  plot(6) = gsn_csm_xy(wks,times_crop,var_matrix_o3,res)
  res@tiMainString     = "PBLH at wanshouxigong"          ; add title
  plot(7) = gsn_csm_xy(wks,times_crop,pblh_sim,res)

gsn_panel(wks,plot,(/8,1/),False)             ; now draw as one plot

end
