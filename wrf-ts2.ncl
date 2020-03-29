; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin
;---Get some data to plot
  a = addfile("/data3/tabish/newruns-9Feb2017/wrfout_d03_2014-10-11_000000_initial.nc","r")
  b = addfile("/data3/tabish/newruns-9Feb2017/wrfout_d03_2014-10-11_010000_restart.nc","r")
;  c = addfile("./wrfout_d03_150s_chemdt30m.nc","r")
  var_array1=a->U(1:23,0,144,79)
  var_array2=b->U(0:22,0,144,79)
 ; var_array3=c->PM2_5_DRY(:,0,144,79)
  var_matrix  = new((/2,dimsizes(var_array1)/),float)  
  var_matrix(0,:) = var_array1
  var_matrix(1,:) = var_array2
 ;var_matrix(2,:) = var_array3

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
  times  = wrf_times_c(a->Times,0)
  ntimes = dimsizes(times)
  times_crop = times(0:22)
;---Start the graphics
  wks = gsn_open_wks("x11","wrf_timeseries2") ; send graphics to PNG file

;---Plotting options for time series plot
  res             = True

  res@gsnMaximize = True
  res@vpWidthF    = 0.8
  res@vpHeightF   = 0.3

  res@tmXTOn      = False
  res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPattern  = 0                         ; Make curves all solid
res@xyLineThicknesses = (/  2.0,   2.0/)          ; make second line thicker
 res@xyLineColors      = (/"blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  restick@ttmFormat = "%N/%D %H:%M"

  time_axis_labels(times_crop,res,restick)

  ;res@tiMainString       = filename
  res@tiYAxisString      = "O3 conc (" + var_array1@units + ")"
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.02

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .2                  ; move units right
  res@pmLegendOrthogonalPosF = -0.4               ; move units down
  res@pmLegendWidthF         = 0.15                ; Change width and
  res@pmLegendHeightF        = 0.1                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"51lev,chemdt=0","31lev,chemdt=10m"/)         ; create explicit labels

  plot = gsn_csm_xy(wks,times_crop,var_matrix,res)
end

