; Example of using panels with WRF data

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
;
; The WRF ARW input file.  
; This needs to have a ".nc" appended, so just do it.
  a = addfile("./wrfout_d03_150s_chemdt0.nc","r")

; We generate plots, but what kind do we prefer?
  type = "eps"
; type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"pblh_panel")
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")  ; overwrite the .hluresfile color map


; Set some basic resources
  res = True
  res@NoHeaderFooter           = True            ; Switch headers and footers off

  pltres = True
  pltres@PanelPlot = True      ; Indicate these plots are to be paneled.
  mpres = True


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  plots = new ( 24, graphic )
    
    iplot = 0
    do itime = 24,47
  
       pblh = wrf_user_getvar(a,"PBLH",itime)   ; PBLH in m
  
      ; Generate contours
        pblh_res = res
        pblh_res@cnFillOn = True          
       ; pblh_res@ContourParameters = (/ 240., 300., 5. /)
        pblh_res@lbLabelBarOn = False       ; Turn off individual label bars so we can
        pblh_contour = wrf_contour(a,wks,pblh,pblh_res)
         
      ; Overlay contours on a map
        ;pltres@cnConstFLabelFontHeightF = 0.0012
        pltres@NoTitles = True
         pltres@CommonTitle = False
       ; pltres@PlotTitle =  times(itime)
      plots(iplot) = wrf_map_overlays(a,wks,pblh_contour,pltres,mpres)
      delete(pblh_contour)
      iplot = iplot + 1
  
   end do
  
  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = pblh@description + "  (" + pblh@units + ")"
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
gsn_panel(wks,(/plots/),(/6,4/),pnlres)

frame(wks)

end




