load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
begin

a1 = addfile("/data3/tabish/vert-MEIC-emis/pulse-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2 = addfile("/data3/tabish/vert-MEIC-emis/pulse-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_0-3normal4-11Beijing.nc","r")
b  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d01_2014-10-17_010000.nc","r"); importing just for map projection information
pm25_baseline = a1->E_ECI(:,2,:,:)
pm25_pulse    = a2->E_ECI(:,2,:,:)
pm25diff = pm25_baseline - pm25_pulse
printVarSummary(pm25diff)

wks = gsn_open_wks("x11","emiss_d03_baseline-pulse")
gsn_define_colormap(wks,"BlAqGrYeOrReVi200")

; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 diff in ug/m3"
  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
;  res@cnLevelSelectionMode = "ManualLevels"
;  res@cnMinLevelValF = 0.
;  res@cnMaxLevelValF = 20.
;  res@cnLevelSpacingF = 1.
  
  do it = 0,11,1             ; TIME LOOP
    pm25 = pm25diff(it,:,:)
    pm25@description = "PM2.5 diff in ug/m3"
    mpres             = True   ; Set map options
    opts = res                         
    opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map

    contour_pm25 = wrf_contour(b,wks,pm25,opts)
    delete(opts)
  
   ; MAKE PLOTS                                       
   plot = wrf_map_overlays(b,wks,(/contour_pm25/),pltres,mpres)
 end do        ; END OF TIME LOOP


;  india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  lnres                  = True
;  lnres@gsLineColor      = "black"
;  lnres@gsLineThicknessF = 1   
;  india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)
;  draw(plot)       ; This will draw the map and the shapefile outlines.
;  frame(wks)       ; Advance the frame

end

