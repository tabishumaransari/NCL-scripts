load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
;load "./WRFUserARW.ncl"

begin
  a = addfile("./wrfout_d01_31lev_50hPa_YSU.nc","r");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We generate plots, but what kind do we prefer?
  type = "png"
; type = "x11"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"PM25conc_d01");;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")

; Set some basic resources
  res = True
 ;res@MainTitle                   = "SO2 in ppbv"

  pltres = True
  mpres = True

;---Using the color map to define colors for contours or vectors
;  res@cnFillPalette = "hotres"
;  res@vcLevelPalette = "hotres"

  res@cnFillOn          = True               ; Create a color fill plot

; What times and how many time steps are in the data set?
  times = wrf_user_getvar(a,"times",-1)  ; get all times in the file
  ntimes = dimsizes(times)         ; number of times in the file
print (ntimes)
ozone1=a->PM2_5_DRY(24,0,:,:);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  do it = 25,ntimes-1,1             ; TIME LOOP
    print("Working on time: " + times(it) )
    res@TimeLabel = times(it)   ; Set Valid time to use on plots
    ozone1=ozone1+a->PM2_5_DRY(it,0,:,:);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  end do        ; END OF TIME LOOP

OZONE=ozone1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ozone_avg= OZONE/(ntimes-24);
ozone_avg@description = "PM2.5 conc in ug m^-3";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Plotting options for ozone                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = False  ; Turn off map outlines
  mpres@mpFillOn    = False  ; Turn off map fill
  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
      opts = res                         
     ; opts@ContourParameters = (/5, 40, 2.5/)
     ; opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
       opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
       opts@cnLevels = (/5,10,15,30,50,75,100,125,150,200,260/) ; set levels 


      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_ozone = wrf_contour(a,wks,ozone_avg,opts)
      delete(opts)
  

    ; MAKE PLOTS                                       
      plot = wrf_map_overlays(a,wks,(/contour_ozone/),pltres,mpres)

  india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm0.shp";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lnres                  = True
  lnres@gsLineColor      = "black"
  lnres@gsLineThicknessF = 1   
  india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)
  draw(plot)       ; This will draw the map and the shapefile outlines.
  frame(wks)       ; Advance the frame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end

