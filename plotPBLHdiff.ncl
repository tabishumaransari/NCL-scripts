load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
begin

DATADir1 = "/rasher/tabish/pulse-runs/baseline/"
DATADir2 = "/rasher/tabish/pulse-runs/BeijingOct18new/"
FILES1   = systemfunc (" ls -1 " + DATADir1 + "metsubset_d03_2014-* ")
FILES2   = systemfunc (" ls -1 " + DATADir2 + "metsubset_d03_2014-* ")
a1 = addfiles(FILES1,"r")
a2 = addfiles(FILES2,"r")
b  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-10-17_010000.nc","r"); importing just for map projection information
pblh_baseline = a1[:]->PBLH(:,:,:)
pblh_pulse    = a2[:]->PBLH(:,:,:)
pblhdiff      = pblh_baseline - pblh_pulse
printVarSummary(pblhdiff)

wks = gsn_open_wks("png","PBLH_d03_baseline-pulse-diff_instantaneous")
gsn_define_colormap(wks,"BlAqGrYeOrReVi200")

; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 diff in ug/m3"
  pltres = True
  mpres = True

  mpres@mpOutlineBoundarySets       = "AllBoundaries"   ; turn on country boundaries
  mpres@mpGeophysicalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpNationalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpProvincialLineColor      = "Black"       ; color of cont. outlines
  mpres@mpGeophysicalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpNationalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpProvincialLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries

  res@cnFillOn          = True               ; Create a color fill plot
  res@cnLevelSelectionMode = "ManualLevels"
  res@NoHeaderFooter           = True            ; Switch headers and footers off
  res1 = res
  res@cnMinLevelValF = 0.
  res@cnMaxLevelValF = 1000.
  res@cnLevelSpacingF = 50.
  res1@cnMinLevelValF = -50
  res1@cnMaxLevelValF = 50.
  res1@cnLevelSpacingF = 5.

pltres@PanelPlot = True      ; Indicate these plots are to be paneled.
pltres@NoTitles = True
;pltres@CommonTitle = True
pltres_a = pltres
pltres_b = pltres
pltres_c = pltres
pltres_a@PlotTitle = "baseline"
pltres_b@PlotTitle = "pulse"
pltres_c@PlotTitle = "diff"
pnlres = True
  times = wrf_user_getvar(a1,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)

  do it = 0,ntimes-1,1             ; TIME LOOP
    time_numeric = cd_inv_string(times(it), "%Y-%N-%D_%H:00:00")  ;; will return in hours since 1800-01-01 unless specified otherwise
    offset = -8    ; hours
    time_numeric = time_numeric - offset
    time_string= cd_string( time_numeric, "%Y-%N-%D_%H:00:00" )
    print("Working on time: " + time_string )    
    baseline = pblh_baseline(it,:,:)
    pulse    = pblh_pulse(it,:,:)
    diff     = pblhdiff(it,:,:)
    baseline@description = "PBLH baseline"
    pulse@description    = "PBLH pulse"
    diff@description     = "PBLH diff in m"
    mpres             = True   ; Set map options
    res@gsnSpreadColorEnd = -3  ; End third from the last color in color map
    contour_baseline = wrf_contour(b,wks,baseline,res)
    contour_pulse    = wrf_contour(b,wks,pulse,res)
    contour_diff     = wrf_contour(b,wks,diff,res1)
   ; MAKE PLOTS                                       
    plot1 = wrf_map_overlays(b,wks,(/contour_baseline/),pltres_a,mpres)
    plot2 = wrf_map_overlays(b,wks,(/contour_pulse/),pltres_b,mpres)
    plot3 = wrf_map_overlays(b,wks,(/contour_diff/),pltres_c,mpres)
    pnlres@txString = time_string
    gsn_panel(wks,(/plot1,plot2,plot3/),(/1,3/),pnlres)
 end do        ; END OF TIME LOOP


;  india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  lnres                  = True
;  lnres@gsLineColor      = "black"
;  lnres@gsLineThicknessF = 1   
;  india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)
;  draw(plot)       ; This will draw the map and the shapefile outlines.
;  frame(wks)       ; Advance the frame

end

