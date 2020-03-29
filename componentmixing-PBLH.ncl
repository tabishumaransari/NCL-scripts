;THIS SCRIPT PLOTS OBS PBLH VS SIM MIXING HEIGHT ALONGWITH OBS AND SIM PM2.5 CONCENTRATIONS MIXED UPTO SIM AND OBS PBL LEVELS AT AOTIZHONGXIN SITE
;ONLY FOR 20TH OCT TO 2ND NOV
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

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

;MAIN PROGRAM
begin

;LET'S READ OBSERVED VALUES FOR ALL COMPONENTS FROM TEXT FILE
ncol = 32
data = readAsciiTable("IAP_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("IAP pol obs read-in successfully from text file")

oc_obs  = data(144:431,3);subsetting to match the time of PBLH analysis plot 21Oct-1Nov
bc_obs  = data(144:431,7)
no3_obs = data(144:431,11)
so4_obs = data(144:431,15)
nh4_obs = data(144:431,19)


;LET'S READ TIME-SERIES OF MODEL LEVELS CORRESPONDING TO OBS PBLH FROM TEXT FILE
ncol = 2
data2 = readAsciiTable("levsim-levobs_ts.txt", ncol, "integer", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2@_FillValue = -999
print("levobs read-in successfully")
levobs_full = data2(:,1); full 936 hours time-series 
levobs = levobs_full(215:502); curtailed time-series for 21oct-1nov


;LET'S EXTRACT VERTICAL COLUMNS (BOTTOM 10 MODEL LEVELS) FOR EACH PM1 AEROSOL COMPONENT AT IAP GRID FOR ALL TIMES
print("now extracting aerosol component vertical columns from pre-written nc file...")
a = addfile("component-column-ts_IAP.nc","r")
oc = a->oc
bc = a->bc
no3 = a->no3
so4 = a->so4
nh4 = a->nh4
;FIRST TRIMMING FOR 39 DAYS 12OCT-19NOV IN LOCAL TIME FOR CLARITY
oc_subset = oc(40:975,:)
bc_subset = bc(40:975,:)
no3_subset = no3(40:975,:)
so4_subset = so4(40:975,:)
nh4_subset = nh4(40:975,:)
;NOW TRIMMING FURTHER FOR 21OCT-1NOV
oc_sim = oc_subset(215:502,:)
bc_sim = bc_subset(215:502,:)
no3_sim = no3_subset(215:502,:)
so4_sim = so4_subset(215:502,:)
nh4_sim = nh4_subset(215:502,:)
print("All vertical columns now subsetted in time")
;DEFINING EMPTY ARRAYS 
oc_sim_mixed = new(288,float)
bc_sim_mixed = new(288,float)
no3_sim_mixed = new(288,float)
so4_sim_mixed = new(288,float)
nh4_sim_mixed = new(288,float)

;VOLUMETRIC AVERAGING ROUTINE UPTO OBS-PBLH LEVELS
print("starting volumetric averaging...")
do i =0,287
 oc_sim_mixed(i) = volumetricavg(oc_sim(i,:),levobs(i))
 bc_sim_mixed(i) = volumetricavg(bc_sim(i,:),levobs(i))
 no3_sim_mixed(i) = volumetricavg(no3_sim(i,:),levobs(i))
 so4_sim_mixed(i) = volumetricavg(so4_sim(i,:),levobs(i))
 nh4_sim_mixed(i) = volumetricavg(nh4_sim(i,:),levobs(i))
end do
print("volumetric averaging done and stored in new 1D arrays")
oc_matrix  = new((/3,dimsizes(oc_sim_mixed)/),float)
oc_matrix(0,:) = (/oc_obs/)
oc_matrix(1,:) = (/oc_sim(:,0)/)
oc_matrix(2,:) = (/oc_sim_mixed/)

bc_matrix  = new((/3,dimsizes(bc_sim_mixed)/),float)
bc_matrix(0,:) = (/bc_obs/)
bc_matrix(1,:) = (/bc_sim(:,0)/)
bc_matrix(2,:) = (/bc_sim_mixed/)

no3_matrix  = new((/3,dimsizes(no3_sim_mixed)/),float)
no3_matrix(0,:) = (/no3_obs/)
no3_matrix(1,:) = (/no3_sim(:,0)/)
no3_matrix(2,:) = (/no3_sim_mixed/)

so4_matrix  = new((/3,dimsizes(so4_sim_mixed)/),float)
so4_matrix(0,:) = (/so4_obs/)
so4_matrix(1,:) = (/so4_sim(:,0)/)
so4_matrix(2,:) = (/so4_sim_mixed/)

nh4_matrix  = new((/3,dimsizes(nh4_sim_mixed)/),float)
nh4_matrix(0,:) = (/nh4_obs/)
nh4_matrix(1,:) = (/nh4_sim(:,0)/)
nh4_matrix(2,:) = (/nh4_sim_mixed/)


;STATISTICS FOR EACH AEROSOL COMPONENT
oc_obs_avg = avg(oc_matrix(0,:))
oc_sim_avg = avg(oc_matrix(1,:))
oc_sim_mixed_avg = avg(oc_matrix(2,:))
oc_rmse = dim_rmsd(oc_matrix(1,:), oc_matrix(0,:))
oc_mixed_rmse = dim_rmsd(oc_matrix(2,:), oc_matrix(0,:))
oc_r = escorc(oc_matrix(0,:),oc_matrix(1,:))
oc_mixed_r = escorc(oc_matrix(0,:),oc_matrix(2,:))

bc_obs_avg = avg(bc_matrix(0,:))
bc_sim_avg = avg(bc_matrix(1,:))
bc_sim_mixed_avg = avg(bc_matrix(2,:))
bc_rmse = dim_rmsd(bc_matrix(1,:), bc_matrix(0,:))
bc_mixed_rmse = dim_rmsd(bc_matrix(2,:), bc_matrix(0,:))
bc_r = escorc(bc_matrix(0,:),bc_matrix(1,:))
bc_mixed_r = escorc(bc_matrix(0,:),bc_matrix(2,:))

no3_obs_avg = avg(no3_matrix(0,:))
no3_sim_avg = avg(no3_matrix(1,:))
no3_sim_mixed_avg = avg(no3_matrix(2,:))
no3_rmse = dim_rmsd(no3_matrix(1,:), no3_matrix(0,:))
no3_mixed_rmse = dim_rmsd(no3_matrix(2,:), no3_matrix(0,:))
no3_r = escorc(no3_matrix(0,:),no3_matrix(1,:))
no3_mixed_r = escorc(no3_matrix(0,:),no3_matrix(2,:))

so4_obs_avg = avg(so4_matrix(0,:))
so4_sim_avg = avg(so4_matrix(1,:))
so4_sim_mixed_avg = avg(so4_matrix(2,:))
so4_rmse = dim_rmsd(so4_matrix(1,:), so4_matrix(0,:))
so4_mixed_rmse = dim_rmsd(so4_matrix(2,:), so4_matrix(0,:))
so4_r = escorc(so4_matrix(0,:),so4_matrix(1,:))
so4_mixed_r = escorc(so4_matrix(0,:),so4_matrix(2,:))

nh4_obs_avg = avg(nh4_matrix(0,:))
nh4_sim_avg = avg(nh4_matrix(1,:))
nh4_sim_mixed_avg = avg(nh4_matrix(2,:))
nh4_rmse = dim_rmsd(nh4_matrix(1,:), nh4_matrix(0,:))
nh4_mixed_rmse = dim_rmsd(nh4_matrix(2,:), nh4_matrix(0,:))
nh4_r = escorc(nh4_matrix(0,:),nh4_matrix(1,:))
nh4_mixed_r = escorc(nh4_matrix(0,:),nh4_matrix(2,:))

print(";;;;;;;;;;;;;;;;;;;;;;;;STATISTICS FOR AEROSOL COMPONENTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;")
print("           OBS Mean     Sim mean        Mean bias         RMSE             R     ")
print("                     surface  mixed  surface  mixed  surface  mixed  surface  mixed")
print(" OC      "+oc_obs_avg+"  "+oc_sim_avg+"  "+oc_sim_mixed_avg+"  "+(oc_sim_avg-oc_obs_avg)+"  "+(oc_sim_mixed_avg-oc_obs_avg)+"  "+oc_rmse+"  "+oc_mixed_rmse+"  "+oc_r+"  "+oc_mixed_r)
print(" BC      "+bc_obs_avg+"  "+bc_sim_avg+"  "+bc_sim_mixed_avg+"  "+(bc_sim_avg-bc_obs_avg)+"  "+(bc_sim_mixed_avg-bc_obs_avg)+"  "+bc_rmse+"  "+bc_mixed_rmse+"  "+bc_r+"  "+bc_mixed_r)
print(" NO3     "+no3_obs_avg+"  "+no3_sim_avg+"  "+no3_sim_mixed_avg+"  "+(no3_sim_avg-no3_obs_avg)+"  "+(no3_sim_mixed_avg-no3_obs_avg)+"  "+no3_rmse+"  "+no3_mixed_rmse+"  "+no3_r+"  "+no3_mixed_r)
print(" SO4     "+so4_obs_avg+"  "+so4_sim_avg+"  "+so4_sim_mixed_avg+"  "+(so4_sim_avg-so4_obs_avg)+"  "+(so4_sim_mixed_avg-so4_obs_avg)+"  "+so4_rmse+"  "+so4_mixed_rmse+"  "+so4_r+"  "+so4_mixed_r)
print(" NH4     "+nh4_obs_avg+"  "+nh4_sim_avg+"  "+nh4_sim_mixed_avg+"  "+(nh4_sim_avg-nh4_obs_avg)+"  "+(nh4_sim_mixed_avg-nh4_obs_avg)+"  "+nh4_rmse+"  "+nh4_mixed_rmse+"  "+nh4_r+"  "+nh4_mixed_r)
print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;")

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
wks = gsn_open_wks("pdf","componentmixing-PBLH") ; send graphics to PNG file
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
res1@xyLineThicknesses = (/  1.0, 1.0, 1.0 /)          ; make second line thicker
res1@xyLineColors      = (/"black","red","blue"/)          ; change line color

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
 ; res1@trYMaxF= 500

  res1@pmLegendDisplayMode    = "Always"            ; turn on legend
  res1@pmLegendSide           = "Top"               ; Change location of
  res1@pmLegendParallelPosF   = .75                  ; move units right
  res1@pmLegendOrthogonalPosF = -0.45               ; move units down
  res1@pmLegendWidthF         = 0.20                ; Change width and
  res1@pmLegendHeightF        = 0.18                ; height of legend.
  res1@lgPerimOn              = False               ; turn off box around
  res1@lgLabelFontHeightF     = .035                 ; label font height
  res1@xyExplicitLegendLabels = (/"obs (surface)","sim (surface)","sim (avg upto obs BLH)"/)         ; create explicit labels
  res1@gsnDraw  = False                          ; don't draw
  res1@gsnFrame = False                          ; don't advance frame
  res1@tiYAxisString = "OC (ug/m3)"

plot1 = gsn_csm_xy(wks,timearr,oc_matrix,res1)    
  res1@tiYAxisString = "BC (ug/m3)"
  res1@pmLegendDisplayMode    = "Never"            ; turn on legend
plot2 = gsn_csm_xy(wks,timearr,bc_matrix,res1)    
  res1@tiYAxisString = "NO3 (ug/m3)"
plot3 = gsn_csm_xy(wks,timearr,no3_matrix,res1)   
  res1@tiYAxisString = "SO4 (ug/m3)"
plot4 = gsn_csm_xy(wks,timearr,so4_matrix,res1)   
  res1@tiYAxisString = "NH4 (ug/m3)"
plot5 = gsn_csm_xy(wks,timearr,nh4_matrix,res1)   


;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/plot1,plot2,plot3,plot4,plot5/),(/5,1/),resP)             ; now draw as one plot


end
