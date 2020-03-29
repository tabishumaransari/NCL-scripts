;----------------------------------------------------------------------
; time_labels_3.ncl
;
; Concepts illustrated:
;   - Drawing a time series plot
;   - Labeling the X axis with nicely-formatted time labels
;   - Converting WRF Times variable to numeric values
;   - Removing trailing zeros from tickmark labels
;   - Changing the width and height of a plot
;----------------------------------------------------------------------
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin
;---Get some data to plot
  a = addfile("./wrfout_d03_90s_chemdt0.nc","r")
  b = addfile("./wrfout_d03_150s_chemdt0.nc","r")
  c = addfile("./wrfout_d03_150s_chemdt30m.nc","r")
  var_array1=a->PM2_5_DRY(:,0,144,79)
  var_array2=b->PM2_5_DRY(:,0,144,79)
  var_array3=c->PM2_5_DRY(:,0,144,79)
  var_array1 = var_array1
  var_array2 = var_array2
  var_array3 = var_array3
  var_matrix  = new((/3,dimsizes(var_array1)/),float)  
  var_matrix(0,:) = var_array1
  var_matrix(1,:) = var_array2
  var_matrix(2,:) = var_array3

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
  wks = gsn_open_wks("x11","PM25_timeseries") ; send graphics to PNG file

;---Plotting options for time series plot
  res             = True

  res@gsnMaximize = True
  res@vpWidthF    = 0.8
  res@vpHeightF   = 0.3

  res@tmXTOn      = False
  res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPattern  = 0                         ; Make curves all solid
res@xyLineThicknesses = (/  2.0,   2.0,	2.0/)          ; make second line thicker
 res@xyLineColors      = (/"blue","red","green"/)          ; change line color
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
  res@tiYAxisString      = "PM2.5 conc (" + var_array1@units + ")"
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
  res@xyExplicitLegendLabels = (/"90s,90s","150s,150s","150s,30m"/)         ; create explicit labels

  plot = gsn_csm_xy(wks,times,var_matrix,res)
end

