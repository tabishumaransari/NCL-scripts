;THIS SCRIPT PLOTS OBS PBLH VS SIM MIXING HEIGHT ALONGWITH OBS AND SIM PM2.5 CONCENTRATIONS MIXED UPTO SIM AND OBS PBL LEVELS AT AOTIZHONGXIN SITE
;ONLY FOR 20TH OCT TO 2ND NOV
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

;VOLUMETRIC AVERAGING UPTO SPECIFIED VERTICAL MODEL LEVEL
;IT TAKES VERTICAL COLUMN OF POLLUTANT AND PBLH MODEL LEVEL AND RETURNS THE AVERAGED POLLUTANT VALUE UPTO THAT LEVEL
undef("volumetricavg")
function volumetricavg(col, lev)
begin
;Integrated height of model levels
H = (/26.28,90.32,177.60,288.88,429.22,608.47,829.12,1116.82,1457.69,1809.77,2174.11,2711.91,3418.99,4130.57,4845.72,5560.91/)
;Thickness of each model level
T = (/26.28,64.04,87.28,111.28,140.34,179.25,220.65,287.70,340.87,352.08,364.34,537.80,707.08,711.58,715.15,715.19/)
s = 0.0
do i = 0,lev
 s = s + col(i)*T(i)
end do
volavg = s/H(lev)
return(volavg)
end


begin

DATADir = "/mnt/rasher/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=145
pblh_sim   = a[:]->PBLH(:,J,I)
pblh_sim_subset = pblh_sim(40:975) ; 39 days array starting 12Oct
pm25 = a[:]->PM2_5_DRY(:,0:15,J,I); FETCH THE FIRST 14 MODEL LEVELS TO CALCULATE CONCENTRATION DROP LATER
pm25_subset = pm25(40:975,:); SUBSET TO MATCH THE HOURS OF AOTIZHONGXIN OBSERVATIONS


; ROUTINE TO CHECK MAXIMUM DROP IN POLLUTANT CONCENTRATIONS
drop = 0.0
blh_arr = (/26.8,90.31,177.60,288.88,429.22,608.47,829.12,1116.82,1457.69,1809.77,2174.12,2711.91,3418.99,4130.57/)
blh = new(936, float)
levsim = new(936, integer)
levobs = new(936, integer)
;yesno = new(936, float)

do t=0,935

 do h=0,9

  drop_current = pm25_subset(t,h) - pm25_subset(t,h+1)
;  drop_current = pm25_subset(t,h)^(1.0/3.0) - pm25_subset(t,h+1)^(1.0/3.0)
;  print("drop_current="+drop_current+" drop="+drop)  
  if(drop_current.gt.drop) then 
   drop = drop_current
   blh(t) = blh_arr(h)
   levsim(t) = h
  end if

 end do
 drop =0.0 
end do

  filename = "/home/tabish/nclscripts/totalLIDAR_PBLH_hourly_under-eh_newalgo05102018_936.txt"
  lines1 = asciiread(filename,-1,"string")
  delim = " " ; delimiter
  datetime         = str_get_field(lines1,1,delim)
  pblh_obs	   =   tofloat(str_get_field(lines1,2,delim))
  pblh_obs = runave (pblh_obs, 3, 0) 

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
   levobs(i) = j
  end if
  end if
 end do
end do

levobs(0)=levobs(1)
levobs(dimsizes(levobs)-1)=levobs(dimsizes(levobs)-2)
print(levobs)


;;;;;;;;;;;;WRITING OUT LEVOBS AND LEVSIM ARRAYS IN ASCII FILE FOR SUBSEQUENT USE;;;;;;;;;;;;;
header = (/"Levsim Levobs"/)
hlist = [/header/]
alist = [/levsim(:),levobs(:)/]
print("alist created...now writing")
fname = "levsim-levobs_ts.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%0.2i %0.2i")
print("levsim-levobs_ts.txt...now written")


pm25sim = pm25_subset(:,0)
pm25sim_levsim = new(936, float) 
pm25sim_levobs = new(936, float) 
printVarSummary(pm25_subset)


;SIMPLE AVERAGING ROUTINE UPTO SIM AND OBS-PBLH LEVELS
;do i =0,935
; print("i="+i+" levsim="+levobs(i))
; pm25sim_levsim(i) = avg(pm25_subset(i,0:levsim(i)))
; pm25sim_levobs(i) = avg(pm25_subset(i,0:levobs(i))) 
;end do


;VOLUMETRIC AVERAGING ROUTINE UPTO SIM AND OBS-PBLH LEVELS
do i =0,935
 print("i="+i+" levsim="+levobs(i))
 pm25sim_levsim(i) = volumetricavg(pm25_subset(i,:),levsim(i))
 pm25sim_levobs(i) = volumetricavg(pm25_subset(i,:),levobs(i))
end do


print("The OBS-PBL-MIXED and SIM-PBL-MIXED PM2.5 arrays have been created")

pm25sim_curtailed = pm25sim(215:502)
pm25sim_levsim_curtailed = pm25sim_levsim(215:502)
pm25sim_levobs_curtailed = pm25sim_levobs(215:502)

print("Obs PBLH="+pblh_obs+",lev="+levobs+",Sim PBLH="+blh+",lev="+levsim)
;alist = [/yesno_subset, lev_subset/]
;write_table("yesno-lev_obsPBLH_21-25Oct.txt", "w", alist, "%ld%16.2f")

  PBLH_matrix  = new((/2,dimsizes(pm25sim_curtailed)/),float)
  pblh_obs_curtailed = pblh_obs(215:502)
  blh_curtailed = blh(215:502)
  pblh_obs_curtailed = runave (pblh_obs_curtailed, 3, 0)
  blh_curtailed = runave (blh_curtailed, 3, 0)


  PBLH_matrix(1,:) = (/pblh_obs_curtailed/)
  PBLH_matrix(0,:) = (/blh_curtailed/)
 

;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filename = "/home/tabish/APEC_data/Beijing_AQ_data_APEC2014_dingling.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_Aotizhongxin = str_match(lines, "Aotizhongxin")
  delim = ", :" ; multiple delimiters to separate day from date to find missing times
  delim1 = "," ; multiple delimiters to separate day from date to find missing times
  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;print(time)
lines_full = new(1008,string)
fill =0
do i = 0, dimsizes(lines_Aotizhongxin)-2
 print("i="+i + " fill="+fill)
 n=(time(i+1)-time(i))
 if((n.eq.1).or.(n.eq.-23))then
  lines_full(fill) = lines_Aotizhongxin(i)
  fill = fill + 1
  print("fill="+fill)
 else
  lines_full(fill) = lines_Aotizhongxin(i)
  fill=fill+1
  print("fill="+fill)
  do j=1,n-1
   lines_full(fill) = ",Aotizhongxin,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,9.96921e+36 ,1011A,missing missing missing"
   fill = fill +1
;   print("fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_Aotizhongxin(dimsizes(lines_Aotizhongxin)-1)
  PM25     = tofloat(str_get_field(lines_full,7,delim))
  PM25     = where(PM25.eq.0 .or. PM25.eq.9.96921e+36, PM25@_FillValue, PM25)
  pm25obs = PM25(48:983)
  pm25obs_curtailed = pm25obs(215:502) 


  PM_matrix  = new((/4,dimsizes(pm25obs_curtailed)/),float)
  PM_matrix(2,:) = (/pm25sim_curtailed/)
  PM_matrix(0,:) = (/pm25sim_levsim_curtailed/)
  PM_matrix(1,:) = (/pm25sim_levobs_curtailed/)
  PM_matrix(3,:) = (/pm25obs_curtailed/)

l = dimsizes(pblh_obs_curtailed)
obsavg    = avg(pblh_obs_curtailed)
blhavg    = avg(blh_curtailed)
pm25simavg = avg(pm25sim_curtailed)
pm25sim_levsimavg = avg(pm25sim_levsim_curtailed)
pm25sim_levobsavg =avg(pm25sim_levobs_curtailed)
pm25obsavg =avg(pm25obs_curtailed)


;CALCULATING RMSE FOR EACH CASE
pm25sim_rmse    = dim_rmsd(pm25sim_curtailed,pm25obs_curtailed)
pm25levsim_rmse = dim_rmsd(pm25sim_levsim_curtailed,pm25obs_curtailed)
pm25levobs_rmse = dim_rmsd(pm25sim_levobs_curtailed,pm25obs_curtailed)


print("LIDAR PBLH mean        = "+obsavg)
print("Sim mixing height mean = "+blhavg)
print("Sim surface PM2.5 mean = "+pm25simavg)
print("Sim PM2.5 mixed upto sim PBLH mean = "+pm25sim_levsimavg)
print("Sim PM2.5 mixed upto obs PBLH mean = "+pm25sim_levobsavg)
print("Obs surface PM2.5 mean = "+pm25obsavg)
 
print("RMSE for simulated PM2.5 ="+pm25sim_rmse)
print("RMSE for simulated PM2.5 mixed up to sim mixing height ="+pm25levsim_rmse)
print("RMSE for simulated PM2.5 mixed up to obs mixing height ="+pm25levobs_rmse)


timearr = ispan (1,288,1)
timearr@units = "hours since 2014-10-21 00:00:00"


;;;;;;;;;;;;WRITING OUT ARRAYS IN ASCII FILE FOR SUBSEQUENT USE;;;;;;;;;;;;;
;header = (/"PBLHobs PBLHsim pm25obs pm25sim pm25avg2simPBLH pm25avg2obsPBLH"/)
;hlist = [/header/]
;alist = [/PBLH_matrix(1,:),PBLH_matrix(0,:),PM_matrix(3,:),PM_matrix(2,:),PM_matrix(0,:),PM_matrix(1,:)/]
;print("alist created...now writing")
;fname = "boundarylayer-mixing_ts.txt"
;write_table(fname, "w", hlist, "%s")
;write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")
;print("boundarylayer-mixing_ts.txt...now written")


;---Start the graphics
wks = gsn_open_wks("x11","PBLHanalysis_curtailed_sh-eh_20042019") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@trXMaxF=max(timearr)
;res@tiMainString     = "Boundary Layer Mixing of PM2.5"          ; add title
;res@gsnMaximize = False
;res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0 /)          ; make second line thicker
res@xyLineColors      = (/"red","black"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted
; time labels on X axis. This function only works
; if you have a time "units" recognized by the
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 12
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
  res@tiYAxisString      = "PBLH (m)"
  res@tiMainFontHeightF  = 0.035
  res@tiYAxisFontHeightF = 0.035
  res@tiXAxisFontHeightF = 0.035
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = False    ; Turn on right labels
  res@tmYLMinorOn          = True   ; Turn off minor ticks on Y axis
  ;res@tmYLLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYLLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of
  res@pmLegendParallelPosF   = 0.86                  ; move units right
  res@pmLegendOrthogonalPosF = -0.3                ; move units down
  res@pmLegendWidthF         = 0.30                ; Change width and
  res@pmLegendHeightF        = 0.10                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = 0.03                 ; label font height
  res@xyExplicitLegendLabels = (/"sim PBLH","obs PBLH"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame
  plot1 = gsn_csm_xy(wks,timearr,PBLH_matrix,res)    ; Create the four plots.
  

res1             = True
res1@trXMaxF=max(timearr)
;res1@tiMainString     = "Boundary Layer Height (m)"          ; add title
;res1@gsnMaximize = True
;res1@vpKeepAspect=True
res1@vpWidthF    = 2
res1@vpHeightF   = 0.5
res1@xyMarkLineMode = "Lines"
res1@xyMarkers      = (/0,0,0,0/)
res1@tmXTOn      = False
res1@tmYLFormat  = "f"      ; remove trailing ".0"
res1@xyDashPatterns  = (/0,0,0,0/)                         ; Make curves all solid
res1@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0 /)          ; make second line thicker
res1@xyLineColors      = (/"green","blue","red","black"/)          ; change line color
time_axis_labels(timearr,res1,restick)

  res1@tiMainFontHeightF  = 0.035
  res1@tiYAxisFontHeightF = 0.035
  res1@tmYUseLeft           = False   ; Make right axis independent of left
  res1@tmYLOn               = True   ; Turn off left tickmarks
  res1@tmYROn               = False    ; Turn on right tickmarks
  res1@tmXTOn               = False   ; Turn off top tickmarks
  res1@tmYLLabelsOn         = True   ; Turn off left labels
  res1@tmYRLabelsOn         = False    ; Turn on right labels
  res1@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  ;res1@tmYLLabelFontHeightF = 0.04   ; Increase font height
  res1@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res1@tmYLLabelJust        = "CenterRight"   ; right-justify labels
  res1@trYMaxF= 500

  res1@pmLegendDisplayMode    = "Always"            ; turn on legend
  res1@pmLegendSide           = "Top"               ; Change location of
  res1@pmLegendParallelPosF   = .65                  ; move units right
  res1@pmLegendOrthogonalPosF = -0.15               ; move units down
  res1@pmLegendWidthF         = 0.20                ; Change width and
  res1@pmLegendHeightF        = 0.18                ; height of legend.
  res1@lgPerimOn              = False               ; turn off box around
  res1@lgLabelFontHeightF     = .03                 ; label font height
  res1@xyExplicitLegendLabels = (/"model (avg upto sim PBLH)","model (avg upto obs PBLH)","model (surface)","obs (surface)"/)         ; create explicit labels
  res1@gsnDraw  = False                          ; don't draw
  res1@gsnFrame = False                          ; don't advance frame
  res1@tiYAxisString = "PM2.5 (ug/m3)"

plot2 = gsn_csm_xy(wks,timearr,PM_matrix,res1)    ; Create the four plots.

;  res3                     = True
;  res4                     = True
;  res1@gsnMaximize         = True
;  res4@gsnAttachPlotsXAxis = True
; xy1 will be the base plot.
;  amid = gsn_attach_plots(plot1,plot2,res3,res4)
;  draw(plot1)    ; All four plots will be drawn.
;  frame(wks)

;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/plot1,plot2/),(/2,1/),resP)             ; now draw as one plot


end
