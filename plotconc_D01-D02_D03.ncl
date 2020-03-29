load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin
; Make a list of all files we are interested in
  DATADir = "/data1/tabish/APEC-baseline/"
  FILES_d01 = systemfunc (" ls -1 " + DATADir + "wrfout_d01_2014-10* ")
  FILES_d02 = systemfunc (" ls -1 " + "/data3/tabish/APEC-baseline/wrfout_d02_2014-10* ")
  FILES_d03 = systemfunc (" ls -1 " + "/data3/tabish/APEC-baseline/wrfout_d03_2014-10* ")
  numFILES = dimsizes(FILES_d01)

; We generate plots, but what kind do we prefer?
  type = "png"
  wks = gsn_open_wks(type,"PM25conc_d01-d02-d03_12-31_Octmean");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  gsn_define_colormap(wks,"WhiteBlue")

; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 avg conc for 12-31 Oct 2014"

  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
s=1
a = addfile(FILES_d01(0)+".nc","r"); THIS IS JUST FOR INITIALIZATION OF PM25 ARRAY, IT WILL BE SUBSTRACTED FROM THE SUM IN THE END
b = addfile(FILES_d02(0)+".nc","r"); THIS IS JUST FOR INITIALIZATION OF PM25 ARRAY, IT WILL BE SUBSTRACTED FROM THE SUM IN THE END
c = addfile(FILES_d03(0)+".nc","r"); THIS IS JUST FOR INITIALIZATION OF PM25 ARRAY, IT WILL BE SUBSTRACTED FROM THE SUM IN THE END
pm25init_a =  a->PM2_5_DRY(15,0,:,:)
pm25init_b =  b->PM2_5_DRY(15,0,:,:)
pm25init_c =  c->PM2_5_DRY(15,0,:,:)
pm25sum_a =  pm25init_a
pm25sum_b =  pm25init_b
pm25sum_c =  pm25init_c
times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
ntimes = dimsizes(times)
do it = 16,ntimes-1,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum_a = pm25sum_a + a->PM2_5_DRY(it,0,:,:)
    pm25sum_b = pm25sum_b + b->PM2_5_DRY(it,0,:,:)
    pm25sum_c = pm25sum_c + c->PM2_5_DRY(it,0,:,:)
end do ; END OF TIME LOOP

do ifil = 1,numFILES-2             ; FILE LOOP
  a = addfile(FILES_d01(ifil)+".nc","r")   ; Open the next file
  b = addfile(FILES_d02(ifil)+".nc","r")   ; Open the next file
  c = addfile(FILES_d03(ifil)+".nc","r")   ; Open the next file
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)
  do it = 0,ntimes-1,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum_a = pm25sum_a + a->PM2_5_DRY(it,0,:,:)
    pm25sum_b = pm25sum_b + b->PM2_5_DRY(it,0,:,:)
    pm25sum_c = pm25sum_c + c->PM2_5_DRY(it,0,:,:)
  end do ; END OF TIME LOOP
end do

a = addfile(FILES_d01(numFILES-1)+".nc","r")   ; Open the next file
b = addfile(FILES_d02(numFILES-1)+".nc","r")   ; Open the next file
c = addfile(FILES_d03(numFILES-1)+".nc","r")   ; Open the next file
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)
  do it = 0,16,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum_a = pm25sum_a + a->PM2_5_DRY(it,0,:,:)
    pm25sum_b = pm25sum_b + b->PM2_5_DRY(it,0,:,:)
    pm25sum_c = pm25sum_c + c->PM2_5_DRY(it,0,:,:)
  end do ; END OF TIME LOOP

pm25_a_avg= pm25sum_a/s
pm25_b_avg= pm25sum_b/s
pm25_c_avg= pm25sum_c/s
pm25_a_avgzoom = pm25_a_avg(46:73,80:100)
pm25_b_avgzoom = pm25_b_avg(13:93,38:96)
;pm25_avgzoom@description = "PM2.5 conc in ug m^-3"

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
       opts@cnLevels = (/40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,240/) ; set levels 
      ;opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
    opts@cnFillMode = "RasterFill"  
    opts@NoHeaderFooter           = True            ; Switch headers and footers off
    opts@lbLabelBarOn = False
    contour_pm25_a = wrf_contour(a,wks,pm25_a_avgzoom,opts)
    contour_pm25_b = wrf_contour(a,wks,pm25_b_avgzoom,opts)
    contour_pm25_c = wrf_contour(a,wks,pm25_c_avg,opts)
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
  plots = new ( 3, graphic )
 
      ; Overlay contours on a map
        ;pltres@NoTitles = True
        pltres@CommonTitle = True
        pltres_a = pltres
        pltres_b = pltres
        pltres_c = pltres
        pltres_a@PlotTitle = "D01 - 27km"
        pltres_b@PlotTitle = "D02 - 9km"
        pltres_c@PlotTitle = "D03 - 3km"
        plots(0) = wrf_map_overlays(a,wks,contour_pm25_a,pltres_a,mpres)
        plots(1) = wrf_map_overlays(b,wks,contour_pm25_b,pltres_b,mpres)
        plots(2) = wrf_map_overlays(c,wks,contour_pm25_c,pltres_c,mpres)
     
  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "PM2.5 mean conc for 12-31 Oct 2014"
  ;  pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
   ; pnlres@lbBoxMinorExtentF          = 0.3

    gsn_panel(wks,(/plots/),(/1,3/),pnlres)

end

