;   Example script - plot terrain (using some basic WRF scripts)
;   Overwrite basic map background settings
;   November 2008

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

  a = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-11-06_01:00:00.nc","r")           ; Open a file
  b = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2_so4_allAPEC2.nc","r")
  c = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_so4_allAPEC2.nc","r")

  type = "png"

  wks = gsn_open_wks(type,"pm25i_24hemissions_d03_allAPEC2")         ; Create a plot workstation
  ; gsn_define_colormap(wks,"WhiteYellowOrangeRed")
   gsn_define_colormap(wks,"hotres")
  ;gsn_define_colormap(wks,"MPL_Reds")
; Set some basic resources
  res = True
;  res@MainTitle                   = "Emissions: NMVOC"
  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot

   
res@lbLabelBarOn = False       ; Turn off individual label bars
res@NoHeaderFooter           = True            ; Switch headers and footers off

; Plotting options                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = False  ; Turn off map outlines
  mpres@mpFillOn    = False  ; Turn off map fill
  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
      opts = res                         
     ; opts@ContourParameters = (/0, 10, 1/)
    ;  opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
     ; opts@cnLevels = (/0.005,0.075,0.01,0.02,0.05,0.10,0.15,0.25,0.50,0.75,1.0,1.25,1.50,1.75/) ; set levels 
     ; opts@cnLevels = (/0.005,0.075,0.01,0.02,0.05,0.10,0.15,0.25,0.50,0.75,1.0,1.25,1.50,1.75,2.00,2.25,2.50,2.75/) ; set levels 
     ;opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
     ; opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
     
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  plots = new ( 24, graphic )

  ; Generate contours
        emis_res = res
        emis_res@cnFillOn = True
        emis_res@lbLabelBarOn = False       ; Turn off individual label bars so we can
       emis_res@cnLevelSelectionMode = "ManualLevels"
       emis_res@ContourParameters = (/ 0, 0.02, 0.001 /)
  ; Overlay contours on a map
        ;pltres@cnConstFLabelFontHeightF = 0.0012
        pltres@NoTitles = True
         pltres@CommonTitle = False
       ; pltres@PlotTitle =  times(itime)


iplot = 0
do itime = 0,11
 emis = b->E_PM25I(itime,0,:,:)
 emis_contour = wrf_contour(a,wks,emis,emis_res)
 plots(iplot) = wrf_map_overlays(a,wks,emis_contour,pltres,mpres)
 delete(emis_contour)
 iplot = iplot + 1
end do

do itime = 0,11
 emis = c->E_PM25I(itime,0,:,:)
 emis_contour = wrf_contour(a,wks,emis,emis_res)
 plots(iplot) = wrf_map_overlays(a,wks,emis_contour,pltres,mpres)
 delete(emis_contour)
 iplot = iplot + 1
end do

  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = emis@description + "  (" + emis@units + ")"
    pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.13
    res@gsnFrame         = False
    india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp"
    lnres                  = True
    lnres@gsLineColor      = "black"
    lnres@gsLineThicknessF = 1.5

do i=0,23
 unistr = unique_string("polyl")
 plots@$unistr$ = gsn_add_shapefile_polylines(wks,plots(i),india_shp_name,lnres)
end do
gsn_panel(wks,(/plots/),(/4,6/),pnlres)

;resP                     = True                ; modify the panel plot
;resP@gsnPanelMainString = "EDGAR-HTAP and MEIC emissions for PM2.5"
;resP@gsnPanelLabelBar  = True
;gsn_panel(wks,plot_co,(/1,2/),resP)
;frame(wks)

end
