load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin

; Make a list of all files we are interested in
  DATADir = "/data2/tabish/control-run-so4-ECMWF/"
  DATADir2 = "/data2/tabish/control-run-so4-ECMWF_d01/"
  FILES_d01 = systemfunc (" ls -1 " + DATADir + "wrfout_d01_2014-10* ")
  FILES_d01only = systemfunc (" ls -1 " + DATADir2 + "wrfout_d01_2014-10* ")
  FILES_d02 = systemfunc (" ls -1 " + DATADir + "wrfout_d02_2014-10* ")
  FILES_d03 = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-10* ")
  numFILES = dimsizes(FILES_d01)

  a = addfiles(FILES_d01,"r")
  a1 = addfiles(FILES_d01only,"r")
  b = addfiles(FILES_d02,"r")
  c = addfiles(FILES_d03,"r")
  a0 = addfile(FILES_d01(0),"r")

  pm25_a    = a[:]->PM2_5_DRY(:,0,:,:)
  pm25_a1   = a1[:]->PM2_5_DRY(:,0,:,:)
  pm25_b    = b[:]->PM2_5_DRY(:,0,:,:)
  pm25_c    = c[:]->PM2_5_DRY(:,0,:,:)

  pm25_a_avg = dim_avg_n_Wrap(pm25_a,0)
  pm25_a1_avg = dim_avg_n_Wrap(pm25_a1,0)
  pm25_b_avg = dim_avg_n_Wrap(pm25_b,0)
  pm25_c_avg = dim_avg_n_Wrap(pm25_c,0)
print(dimsizes(pm25_a_avg))
; We generate plots, but what kind do we prefer?
  type = "png"
  wks = gsn_open_wks(type,"PM25conc_d01-d02-d03_baselinemean");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  ;gsn_define_colormap(wks,"WhiteBlue")

; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 avg conc for 12-31 Oct 2014"
res@gsnMaximize = True
res@gsnPaperOrientation = "auto"

  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot




pm25_a_avgzoom = pm25_a_avg(46:73,80:100)
pm25_a1_avgzoom = pm25_a1_avg(46:73,80:100)
pm25_b_avgzoom = pm25_b_avg(13:93,38:96)

; Plotting options for PM2.5                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = True  ; Turn off map outlines
;  mpres@mpFillOn    = False  ; Turn off map fill
;  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
 mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries  
   opts = res                         
     ;opts@ContourParameters = (/60, 240, 10/)
     ; opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
       opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
       ;opts@cnLevels = (/40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,240/) ; set levels 
       opts@cnLevels = (/0,25,50,75,100,110,120,130,140,150,160,170/) ; set levels 
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
    opts@cnFillMode = "RasterFill"  
    opts@NoHeaderFooter           = True            ; Switch headers and footers off
    opts@lbLabelBarOn = False
    contour_pm25_a = wrf_contour(a0,wks,pm25_a_avgzoom,opts)
    contour_pm25_a1 = wrf_contour(a0,wks,pm25_a1_avgzoom,opts)
    contour_pm25_b = wrf_contour(a0,wks,pm25_b_avgzoom,opts)
    contour_pm25_c = wrf_contour(a0,wks,pm25_c_avg,opts)
      delete(opts)


  mpres@mpOutlineBoundarySets       = "AllBoundaries"   ; turn on country boundaries
  mpres@mpGeophysicalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpNationalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpProvincialLineColor      = "Black"       ; color of cont. outlines
  mpres@mpGeophysicalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpNationalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpProvincialLineThicknessF = 1.5          ; thickness of outlines

  mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries 


; FOR D03 ZOOM
  mpres@mpLimitMode	            = "Corners"
  mpres@mpLeftCornerLatF            = 42.7948
  mpres@mpLeftCornerLonF            = 113.644
  mpres@mpRightCornerLatF           = 35.7411
  mpres@mpRightCornerLonF           = 119.394
  


pltres@PanelPlot = True      ; Indicate these plots are to be paneled.
  plots = new ( 4, graphic )
 
      ; Overlay contours on a map
        ;pltres@NoTitles = True
        pltres@CommonTitle = True
        pltres_a = pltres
        pltres_b = pltres
        pltres_c = pltres
        pltres_a@PlotTitle = "D01 - 27km"
        pltres_b@PlotTitle = "D02 - 9km"
        pltres_c@PlotTitle = "D03 - 3km"
        plots(0) = wrf_map_overlays(a0,wks,contour_pm25_a,pltres_a,mpres)
        plots(1) = wrf_map_overlays(a0,wks,contour_pm25_a1,pltres_a,mpres)
        plots(2) = wrf_map_overlays(a0,wks,contour_pm25_b,pltres_b,mpres)
        plots(3) = wrf_map_overlays(a0,wks,contour_pm25_c,pltres_c,mpres)
     
  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "PM2.5 mean conc for 12-31 Oct 2014"
  ;  pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
   ; pnlres@lbBoxMinorExtentF          = 0.3

    gsn_panel(wks,(/plots(0),plots(2),plots(3)/),(/1,3/),pnlres)
    gsn_panel(wks,(/plots(1),plots(0)/),(/1,2/),pnlres)

end

