;THIS IS AN UPDATE ON WRF-TS10.NCL, IT PLOTS ONLY THE DATA FOR 21-25 OCT 2014 and FROM APEC-BASELINE2

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

pm25_sim =new(120,float)  
pm10_sim =new(120,float)  
pmcoarse_sim =new(120,float)  
co_sim =new(120,float)  
no2_sim =new(120,float)  
so2_sim =new(120,float)  
o3_sim =new(120,float)  
pm25_obs =new(120,float)  
pm10_obs =new(120,float)  
pmcoarse_obs =new(120,float)  
co_obs =new(120,float)  
no2_obs =new(120,float)  
so2_obs =new(120,float)  
o3_obs =new(120,float)  

DATADir = "/data3/tabish/APEC-baseline2/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)
print(times)
times_crop = times(16:135)
pm25   = a[:]->PM2_5_DRY(:,0,141,79)
pm10   = a[:]->PM10(:,0,141,79)
co   = a[:]->co(:,0,141,79)
no2   = a[:]->no2(:,0,141,79)
so2   = a[:]->so2(:,0,141,79)
o3   = a[:]->o3(:,0,141,79)
pm25_sim = pm25(16:135)
pm10_sim = pm10(16:135)
pmcoarse_sim = pm10_sim - pm25_sim
co_sim = co(16:135)
no2_sim =1000* no2(16:135)
so2_sim = 1000* so2(16:135)
o3_sim = 1000* o3(16:135)
pblh = a[:]->PBLH(:,141,79)
pblh_sim = pblh(16:135)
times_crop = times_crop +8




;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LOOP OVER 21ST-25TH OCT FILES
diri = "/data1/tabish/surface_data/12Oct2014-15Nov2014_filled/"
fname = systemfunc("ls -1 " + diri + "20141*")
fill =0
 do i =216, 335               ;LOOP OVER EACH FILE (TIME)
  print("file number="+ i+ " filename= "+ fname(i))
  lines = asciiread(fname(i),-1,"string")
  lines = where(lines.eq.0, -999, lines) ;CLEANSING...
  pm25_obs(fill) = tofloat(str_get_field(lines(0),4," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  pm10_obs(fill) = tofloat(str_get_field(lines(0),5," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  co_obs(fill) = tofloat(str_get_field(lines(0),6," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  no2_obs(fill) = tofloat(str_get_field(lines(0),7," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  so2_obs(fill) = tofloat(str_get_field(lines(0),8," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  o3_obs(fill) = tofloat(str_get_field(lines(0),9," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  delete(lines)
  fill = fill +1
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
z3 = asciiread("LIDAR_PBLH_hourly_under3km_improved.txt",(/1080,2/),"float")
pblh_obs = z3(264:383,1)
  ;var_matrix  = new((/2,dimsizes(pm25_sim)/),float)  
  var_matrix_pm25  = new((/2,120/),float)  
  var_matrix_pm10  = new((/2,120/),float)  
  var_matrix_pmcoarse  = new((/2,120/),float)  
  var_matrix_co  = new((/2,120/),float)  
  var_matrix_no2  = new((/2,120/),float)  
  var_matrix_so2  = new((/2,120/),float)  
  var_matrix_o3  = new((/2,120/),float)  
  var_matrix_pblh  = new((/2,120/),float)  
  
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
var_matrix_pblh(0,:) = (/pblh_sim/)
var_matrix_pblh(1,:) = pblh_obs


;---Start the graphics
wks = gsn_open_wks("x11","wanshouxigong_ts_21-25Oct_APECbaseline2") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Surface PM2.5 at wanshouxigong"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.4
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
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.45               ; move units down
  res@pmLegendWidthF         = 0.5                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "PM2.5"
  xy1 = gsn_csm_xy(wks,times_crop,var_matrix_pm25,res)    ; Create the four plots.

  res@tiYAxisString = "PM10"
  xy2 = gsn_csm_xy(wks,times_crop,var_matrix_pm10,res)    ; They won't be drawn yet.

  res@tiYAxisString = "PM coarse"
  xy3 = gsn_csm_xy(wks,times_crop,var_matrix_pmcoarse,res)

  res@tiYAxisString = "CO"
  xy4 = gsn_csm_xy(wks,times_crop,var_matrix_co,res)

  res@tiYAxisString = "NO2"
  xy5 = gsn_csm_xy(wks,times_crop,var_matrix_no2,res)

  res@tiYAxisString = "SO2"
  xy6 = gsn_csm_xy(wks,times_crop,var_matrix_so2,res)

  res@tiYAxisString = "O3"
  xy7 = gsn_csm_xy(wks,times_crop,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy8 = gsn_csm_xy(wks,times_crop,var_matrix_pblh,res)

  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)


end
