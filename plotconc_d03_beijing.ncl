load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin
; Make a list of all files we are interested in
  DATADir = "/data3/tabish/APEC-baseline/"
  FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-10* ")
  numFILES = dimsizes(FILES)

; We generate plots, but what kind do we prefer?
  type = "png"
  wks = gsn_open_wks(type,"PM25conc_modeldata_d03_12-31_Octmean");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")

; Set some basic resources
  res = True
 ;res@MainTitle                   = "SO2 in ppbv"

  pltres = True
  mpres = True
  colors = (/"white","black","blue4","blue3","blue","royalblue1","cadetblue1","aquamarine","green2","green","chartreuse","greenyellow","yellow","yellow1","yellow2","orange","tomato","orangered","red","red3","orangered3","purple","purple3","purple4"/)
  ;colors = (/"white","black"/)
  gsn_define_colormap(wks,colors)
;---Using the color map to define colors for contours or vectors
;  res@cnFillPalette = "hotres"
;  res@vcLevelPalette = "hotres"

  res@cnFillOn          = True               ; Create a color fill plot
s=1
a = addfile(FILES(0)+".nc","r"); THIS IS JUST FOR INITIALIZATION OF PM25 ARRAY, IT WILL BE SUBSTRACTED FROM THE SUM IN THE END
pm25init =  a->PM2_5_DRY(15,0,:,:)
pm25sum =  pm25init
times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
ntimes = dimsizes(times)
do it = 16,ntimes-1,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum = pm25sum + a->PM2_5_DRY(it,0,:,:)
end do ; END OF TIME LOOP

do ifil = 1,numFILES-2             ; FILE LOOP
  a = addfile(FILES(ifil)+".nc","r")   ; Open the next file
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)
  do it = 0,ntimes-1,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum = pm25sum + a->PM2_5_DRY(it,0,:,:)
  end do ; END OF TIME LOOP
end do

a = addfile(FILES(numFILES-1)+".nc","r")   ; Open the next file
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)
  do it = 0,16,1             ; TIME LOOP
    s=s+1
    print("Working on time: " + times(it) )
    pm25sum = pm25sum + a->PM2_5_DRY(it,0,:,:)
  end do ; END OF TIME LOOP


;a = addfile("/data3/tabish/APEC-baseline/wrfout_d01_2014-11-01_00:00:00.nc","r");
;times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
;print("Working on time: " + times(0) )
;pm25sum = pm25sum + a->PM2_5_DRY(0,0,:,:)
;s=s+1

;a = addfile("/data3/tabish/APEC-baseline/wrfout_d01_2014-11-01_01:00:00.nc","r");
;times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
;ntimes = dimsizes(times)
;do it = 0,7,1             ; TIME LOOP
;    s=s+1
;    print("Working on time: " + times(it) )
;    pm25sum = pm25sum + a->PM2_5_DRY(it,0,:,:)
;end do ; END OF TIME LOOP

;pm25sum = pm25sum - pm25init 

pm25_avg= pm25sum/s
pm25_avg@description = "PM2.5 conc in ug m^-3"

; Plotting options for PM2.5                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = True  ; Turn off map outlines
;  mpres@mpFillOn    = False  ; Turn off map fill
;  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
 mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries  
   opts = res                         
      opts@ContourParameters = (/0, 200, 10/)
     ; opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
     ;  opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
     ;  opts@cnLevels = (/5,10,15,30,50,75,100,125,150,200,260/) ; set levels 
      opts@gsnSpreadColors = False  ; End third from the last color in color map
     ; opts@gsnSpreadColorEnd = 0  ; End third from the last color in color map
      contour_pm25 = wrf_contour(a,wks,pm25_avg,opts)
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
; FOR BEIJING ZOOM
;  mpres@mpLeftCornerLatF            = 41
;  mpres@mpLeftCornerLonF            = 115.5
;  mpres@mpRightCornerLatF           = 39
;  mpres@mpRightCornerLonF           = 117.5
  

  ; MAKE PLOTS                                       
      plot = wrf_map_overlays(a,wks,(/contour_pm25/),pltres,mpres)

  ;india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm0.shp"
  ;lnres                  = True
  ;lnres@gsLineColor      = "black"
  ;lnres@gsLineThicknessF = 1   
  ;india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)
  ;draw(plot)       ; This will draw the map and the shapefile outlines.
  ;frame(wks)       ; Advance the frame

end

