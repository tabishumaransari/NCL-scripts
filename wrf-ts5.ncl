; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

begin
;---Get some data to plot
  a = addfile("./wrfout_d03_chemopt8_progn0.nc","r")
  b = addfile("./wrfout_d03_chemopt8_progn1.nc","r")
  c = addfile("./wrfout_d03_chemopt10.nc","r")
  d = addfile("./wrfout_d03_chemopt170_progn0.nc","r")
  e = addfile("./wrfout_d03_chemopt170_progn1.nc","r")
  var_array1=a->PM2_5_DRY(:,0,145,79); Beijing hospital location
  var_array2=b->PM2_5_DRY(:,0,145,79)
  var_array3=c->PM2_5_DRY(:,0,145,79)
  var_array4=d->PM2_5_DRY(:,0,145,79)
  var_array5=e->PM2_5_DRY(:,0,145,79)
  var_array6=(/9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,343,327,290,274,9.96921e+36,9.96921e+36,9.96921e+36,354,9.96921e+36,332,332,332,332,304,9.96921e+36,9.96921e+36,288,9.96921e+36,268,273,273,9.96921e+36,9.96921e+36,256,256,248,248,9.96921e+36,125,26,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,7,9.96921e+36,5,4,7,9.96921e+36,9,9.96921e+36/)
  var_matrix  = new((/6,dimsizes(var_array1)/),float)  
  var_matrix(0,:) = var_array1
  var_matrix(1,:) = var_array2
  var_matrix(2,:) = var_array3
  var_matrix(3,:) = var_array4
  var_matrix(4,:) = var_array5
  var_matrix(5,:) = (/var_array6/)

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
  wks = gsn_open_wks("x11","pm25-hospital_ts") ; send graphics to PNG file

;---Plotting options for time series plot
  res             = True
res@tiMainString     = "Surface PM2.5 at Beijing Hospital"          ; add title
  res@gsnMaximize = True
  res@vpWidthF    = 0.8
  res@vpHeightF   = 0.3
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0/)  
res@tmXTOn      = False
  res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,1/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0,  3.0,   3.0,   3.0,   3.0/)          ; make second line thicker
 res@xyLineColors      = (/"black","green","blue","red","orange","black"/)          ; change line color
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
  res@tiYAxisString      = "PM 2.5 in (" + var_array1@units + ")"
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.02

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .75                  ; move units right
  res@pmLegendOrthogonalPosF = -0.7               ; move units down
  res@pmLegendWidthF         = 0.15                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .02                 ; label font height
  res@xyExplicitLegendLabels = (/"chemopt=8, progn=0","chemopt=8, progn=1","chemopt=10, progn=1","chemopt=170, progn=0","chemopt=170, progn=1","Observed"/)         ; create explicit labels

  plot = gsn_csm_xy(wks,times,var_matrix,res)
end

