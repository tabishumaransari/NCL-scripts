; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin
;---Get some data to plot
  a = addfile("./wrfout_d03_150s_chemdt30m.nc","r")
  b = addfile("./wrfout_d03_31lev_100hPa_YSU.nc","r")
  c = addfile("./wrfout_d03_31lev_100hPa_MYJ.nc","r")
  d = addfile("./wrfout_d03_31lev_50hPa_YSU.nc","r")
  e = addfile("./wrfout_d03_31lev_50hPa_MYJ.nc","r")
  var_array1=a->o3(:,0,144,79)
  var_array2=b->o3(:,0,144,79)
  var_array3=c->o3(:,0,144,79)
  var_array4=d->o3(:,0,144,79)
  var_array5=e->o3(:,0,144,79)
  var_matrix  = new((/5,dimsizes(var_array1)/),float)  
  var_matrix(0,:) = var_array1
  var_matrix(1,:) = var_array2
  var_matrix(2,:) = var_array3
  var_matrix(3,:) = var_array4
  var_matrix(4,:) = var_array5

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

;---Start the graphics
  wks = gsn_open_wks("png","Ozone_timeseries3") ; send graphics to PNG file

;---Plotting options for time series plot
  res             = True

  res@gsnMaximize = True
  res@vpWidthF    = 0.8
  res@vpHeightF   = 0.3

  res@tmXTOn      = False
  res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPattern  = 0                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0,   3.0,   3.0,   3.0,   3.0/)          ; make second line thicker
 res@xyLineColors      = (/"black","brown","green","blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  restick@ttmFormat = "%N/%D %H:%M"

  time_axis_labels(times,res,restick)

  ;res@tiMainString       = filename
  res@tiYAxisString      = "Ozone in (" + var_array1@units + ")"
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.02

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .2                  ; move units right
  res@pmLegendOrthogonalPosF = -0.5               ; move units down
  res@pmLegendWidthF         = 0.15                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"51lev-100hPa-MYJ","31lev-100hPa-YSU","31lev-100hPa-MYJ","31lev-50hPa-YSU","31lev-50hPa-MYJ"/)         ; create explicit labels

  plot = gsn_csm_xy(wks,times,var_matrix,res)
end

