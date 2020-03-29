load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;REMOVE THE OUTLIERS
undef("remoutlier")
function remoutlier(var)
begin
 n = dimsizes(var)
 do i=1,n-2
  prev = var(i-1)
  now  = var(i)
  next = var(i+1)
  miss = var@_FillValue
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.gt.2*prev).and.(now.gt.2*next)) then
    var(i) = miss
  end if
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.lt.2*prev).and.(now.lt.2*next)) then
    var(i) = miss
  end if
 end do
 return(var)
end



begin

DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=144
pblh_sim   = a[:]->PBLH(:,J,I)
pblh_sim_subset = pblh_sim(40:975)
pm25 = a[:]->PM2_5_DRY(:,0:13,J,I)
printVarSummary(pm25)
pm25_subset = pm25(40:975,:)


; ROUTINE TO CHECK MAXIMUM DROP IN POLLUTANT CONCENTRATIONS
drop = 0.0
blh_arr = (/26.8,90.31,177.60,288.88,429.22,608.47,829.12,1116.82,1457.69,1809.77,2174.12,2711.91,3418.99,4130.57/)
blh = new(936, float)
lev = new(936, float)
yesno = new(936, float)

do t=0,935

 do h=0,12

  drop_current = pm25_subset(t,h) - pm25_subset(t,h+1)
;  print("drop_current="+drop_current+" drop="+drop)  
  if(drop_current.gt.drop) then 
   drop = drop_current
   blh(t) = blh_arr(h)
;   lev(t) = h
  end if

 end do
 drop =0.0 
end do
;print(pblh_sim_subset+"	"+blh)


  filename = "/data1/tabish/nclscripts/totalLIDAR_PBLH_hourly_under3km_newalgo_936.txt"
;  filename1 = "/data1/tabish/nclscripts/dustLIDAR_PBLH_hourly_under3km_newalgo.txt"
;  filename2 = "/data1/tabish/nclscripts/sphereLIDAR_PBLH_hourly_under3km_newalgo.txt"
  lines = asciiread(filename,-1,"string")
;  lines1 = asciiread(filename1,-1,"string")
;  lines2 = asciiread(filename2,-1,"string")

  delim = " " ; delimiter
  datetime         = str_get_field(lines,1,delim)
  pblh_obs	   =   tofloat(str_get_field(lines,2,delim))
;  pblh_dust	   =   tofloat(str_get_field(lines1,2,delim))
;  pblh_sphere	   =   tofloat( str_get_field(lines2,2,delim))
  ;pblh_dust = remoutlier(pblh_dust)
  ;pblh_sphere = remoutlier(pblh_sphere)
;  pblh_dust = runave (pblh_dust, 3, 0)
;  pblh_sphere = runave (pblh_sphere, 3, 0)
;  pblh_sphere(935) = pblh_sphere(934)



;CALCULATE MATCHING MODEL LEVEL TO OBSERVED DUST PBLH
do i = 0,935
 diffmin =5000.0
 do j = 0,13
  if(.not.ismissing(pblh_obs(i))) then
  diff = pblh_obs(i) - blh_arr(j)
  print(pblh_obs(i)+"	"+blh_arr(j))
  diff = abs(diff)
  if(diff.lt.diffmin) then 
   diffmin = diff
   lev(i) = j
  end if
  end if
 end do
end do





yesno = where(pblh_obs.gt.blh, 1, 0)   
;yesno_IAP = yesno(72:767)
;lev_IAP   = lev(72:767)
;pblh_dust_IAP = pblh_dust(72:767)

pblh_obs_subset = pblh_obs(215:334)
blh_subset = blh(215:334)
yesno_subset = yesno(215:334)
lev_subset = lev(215:334)

;print(yesno+"	"+lev)
alist = [/yesno_subset, lev_subset/]
;write_table("yesno-lev_obsPBLH_21-25Oct.txt", "w", alist, "%ld%16.2f")




  print("obs pblh="+pblh_obs_subset+"	sim mixing height="+blh_subset+" yesno="+yesno_subset+" lev="+lev_subset)
;print(yesno+"	"+lev)
;print(dimsizes(pblh_sphere))





  var_matrix  = new((/2,dimsizes(pblh_obs_subset)/),float)
  var_matrix(0,:) = (/pblh_obs_subset/)
  var_matrix(1,:) = (/blh_subset/)
;  var_matrix(2,:) = (/pblh_sim_subset/)
;  var_matrix(3,:) = (/blh/)
  
obsavg   = avg(pblh_obs)
;sphereavg = avg(pblh_sphere)
;simavg    = avg(pblh_sim_subset)
blhavg    = avg(blh)



print("LIDAR PBLH mean        = "+obsavg)
;print("Sphere LIDAR avg PBLH = "+sphereavg)
;print("Simulated avg PBLH    = "+simavg)
print("Sim mixing height mean = "+blhavg)
 
;  timearr = ispan (1,936,1)
  timearr = ispan (1,120,1)
;  timearr@units = "hours since 2014-10-12 00:00:00"
  timearr@units = "hours since 2014-10-20 23:00:00"

;---Start the graphics
wks = gsn_open_wks("x11","PBLHanalysis") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@trXMaxF=max(timearr)
res@tiMainString     = "Boundary Layer Height (m)"          ; add title
res@gsnMaximize = True
;res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0 /)          ; make second line thicker
res@xyLineColors      = (/"red","blue"/)          ; change line color
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
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 12
  restick@ttmMinorStride= 1
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.05
  res@tiYAxisFontHeightF = 0.05
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = False   ; Turn off left tickmarks
  res@tmYROn               = True    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
 res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = 0               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .03                 ; label font height
  res@xyExplicitLegendLabels = (/"LIDAR PBLH","sim mixing height"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

;printVarSummary(times_subset)
; Change y axis string and color for each plot.
  res@tiYAxisString = "PBLH (m)"
  plot = gsn_csm_xy(wks,timearr,var_matrix,res)    ; Create the four plots.

  draw(plot)
  frame(wks)
end
