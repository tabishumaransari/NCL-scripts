load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin
; Make a list of all files we are interested in
  DATADir = "/data1/tabish/APEC-baseline/"
  FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d01_2014-10* ")
  numFILES = dimsizes(FILES)

; We generate plots, but what kind do we prefer?
  type = "pdf"
  wks = gsn_open_wks(type,"PM25conc-13Oct2014_d03");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  gsn_define_colormap(wks,"BlueYellowRed")

; Set some basic resources
  res = True
 ;res@MainTitle                   = "SO2 in ppbv"

  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
  a = addfile("/data3/tabish/APEC-baseline/wrfout_d03_2014-10-12_00:00:00.nc","r")
  b = addfile("/data3/tabish/APEC-baseline/wrfout_d03_2014-10-13_00:00:00.nc","r")
  times_a = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  times_b = wrf_user_getvar(b,"times",-1)  ; get all times in the file
  ntimes_a = dimsizes(times_a)
  ntimes_b = dimsizes(times_b)

; Plotting options for PM2.5                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = True  ; Turn off map outlines
;  mpres@mpFillOn    = False  ; Turn off map fill
;  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
  mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries  
  opts = res                         
     ; opts@ContourParameters = (/0, 200, 10/)
     ; opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
      opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
      opts@cnLevels = (/5,10,15,30,50,75,100,125,150,200,250,300,400,500,700,800,1000/) ; set levels 
     ; opts@gsnSpreadColors = False  ; End third from the last color in color map
     ;  opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
  mpres@mpOutlineBoundarySets       = "AllBoundaries"   ; turn on country boundaries
  mpres@mpGeophysicalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpNationalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpProvincialLineColor      = "Black"       ; color of cont. outlines
  mpres@mpGeophysicalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpNationalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpProvincialLineThicknessF = 1.5          ; thickness of outlines

  mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries 


;FOR 12TH OCTOBER FROM 1600 HRS UTC TILL THE LAST TIME
do it = 16,ntimes_a-1,1             ; TIME LOOP
    print("Working on time: " + times_a(it) )
    pm25 =  a->PM2_5_DRY(it,0,:,:)
   ; res@MainTitle = times_a(it)
    contour_pm25 = wrf_contour(a,wks,pm25,opts)
    plot = wrf_map_overlays(a,wks,(/contour_pm25/),pltres,mpres)
end do

;FOR 13TH OCTOBER FROM 0000 HRS TO 0700 HRS UTC
do it = 0,15,1             ; TIME LOOP
    print("Working on time: " + times_b(it) )
    pm25 =  a->PM2_5_DRY(it,0,:,:)
   ; res@MainTitle = times_b(it)
    contour_pm25 = wrf_contour(a,wks,pm25,opts)
    plot = wrf_map_overlays(a,wks,(/contour_pm25/),pltres,mpres)
end do


  ;india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm0.shp"
  ;lnres                  = True
  ;lnres@gsLineColor      = "black"
  ;lnres@gsLineThicknessF = 1   
  ;india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)
  ;draw(plot)       ; This will draw the map and the shapefile outlines.
  ;frame(wks)       ; Advance the frame

end

