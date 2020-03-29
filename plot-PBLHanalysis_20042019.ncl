;THIS SCRIPT PLOTS OBS PBLH VS SIM MIXING HEIGHT ALONGWITH OBS AND SIM PM2.5 CONCENTRATIONS MIXED UPTO SIM AND OBS PBL LEVELS AT AOTIZHONGXIN SITE
;ONLY FOR 20TH OCT TO 2ND NOV
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

ncol = 6
data = readAsciiTable("boundarylayer-mixing_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")


PBLH_matrix  = new((/2,dimsizes(data(:,0))/),float)
PBLH_matrix(0,:) = (/data(:,1)/)
PBLH_matrix(1,:) = (/data(:,0)/)

PM_matrix  = new((/4,dimsizes(data(:,0))/),float)
PM_matrix(0,:) = (/data(:,4)/)
PM_matrix(1,:) = (/data(:,5)/)
PM_matrix(2,:) = (/data(:,3)/)
PM_matrix(3,:) = (/data(:,2)/)

;l = dimsizes(pblh_obs_curtailed)
obsavg            = avg(data(:,0))
blhavg            = avg(data(:,1))
pm25simavg        = avg(data(:,3))
pm25sim_levsimavg = avg(data(:,4))
pm25sim_levobsavg = avg(data(:,5))
pm25obsavg        = avg(data(:,2))


;CALCULATING RMSE FOR EACH CASE
pm25sim_rmse    = dim_rmsd(data(:,3),data(:,2))
pm25levsim_rmse = dim_rmsd(data(:,4),data(:,2))
pm25levobs_rmse = dim_rmsd(data(:,5),data(:,2))


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



;---Start the graphics
wks = gsn_open_wks("pdf","PBLHanalysis_curtailed_sh-eh_20042019") ; send graphics to PNG file
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
  res@tmYLLabelFontHeightF = 0.035   ; Increase font height
  res@tmXBLabelFontHeightF = 0.035   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYLLabelJust        = "CenterRight"   ; right-justify labels
  res@trYMaxF= 2000

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
  res1@tmYLLabelFontHeightF = 0.035   ; Increase font height
  res1@tmXBLabelFontHeightF = 0.035   ; Increase font height
  res1@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res1@tmYLLabelJust        = "CenterRight"   ; right-justify labels
  res1@trYMaxF= 500

  res1@pmLegendDisplayMode    = "Always"            ; turn on legend
  res1@pmLegendSide           = "Top"               ; Change location of
  res1@pmLegendParallelPosF   = .59                  ; move units right
  res1@pmLegendOrthogonalPosF = -0.44               ; move units down
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
