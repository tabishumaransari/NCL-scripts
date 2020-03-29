; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin

pm25_sim =new(840,float)  
pm25_obs =new(840,float)  
DATADir = "/data3/tabish/APEC-baseline/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-1* ")
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)
pm25   = a[:]->PM2_5_DRY(:,0,142,75)
pm25_sim = pm25(16:855)
printVarSummary(times)
times_crop = times(16:855)
ntimes = dimsizes(times_crop)
print(ntimes)






;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

diri = "/data1/tabish/surface_data/12Oct2014-15Nov2014_filled/"
fname = systemfunc("ls -1 " + diri + "20141*")

 do i =0, 839               ;LOOP OVER EACH FILE (TIME)
  print("file number="+ i+ " filename= "+ fname(i))
  lines = asciiread(fname(i),-1,"string")
  lines = where(lines.eq.0, -999, lines) ;CLEANSING...
  pm25_obs(i) = tofloat(str_get_field(lines(11),4," "));READING OFF THE FIRST ROW AND 4TH COLUMN
  delete(lines)
 end do                     ;END FILE LOOP
pm25_obs = where(pm25_obs.eq.0, -999, pm25_obs) ;CLEANSING...
pm25_obs@_FillValue = -999

  var_matrix  = new((/2,dimsizes(pm25_sim)/),float)  
  var_matrix(0,:) = (/pm25_sim/)
  var_matrix(1,:) = pm25_obs
;printVarSummary(times)
;printVarSummary(totaltimes)
;--------------------------------------------------
; The "Times" on the file are in the format:
;
;   2001-06-11_12:00:00
;   2001-06-11_13:00:00
;     ...
;
; Convert this to values representing 
;   "hours since 2001-06-11 12:00:00"
;--------------------------------------------------
delete(times)
delete(a)
delete(FILES)
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-1* ")  
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)
printVarSummary(times)
times_crop = times(16:855)
ntimes = dimsizes(times_crop)
print(ntimes)
;---Start the graphics
  wks = gsn_open_wks("png","pm25-gucheng_ts") ; send graphics to PNG file

;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Surface PM2.5 at Beijing Hospital"          ; add title
res@gsnMaximize = True
res@vpWidthF    = 4
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
;res@tmYLFormat  = "f"      ; remove trailing ".0"
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
  restick@ttmFormat = "%D/%N_%H:00"

  time_axis_labels(times_crop,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.02

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .75                  ; move units right
  res@pmLegendOrthogonalPosF = -0.5               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.1                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels

  plot = gsn_csm_xy(wks,times_crop,var_matrix,res)
end
