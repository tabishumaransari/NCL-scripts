load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;----------------------------------------------------------------------
; Procedure to attach colored markers to an NCL map, given 1D
; data, and lat/lon arrays, a set of levels, and a color map.
;----------------------------------------------------------------------
procedure add_obs_markers_to_map(wks,plot,levels,colormap,data_1d,lat_1d,lon_1d)
local mkres, nlevels, colors, nlevels, n, ii
begin

;---Set resources for the markers
  mkres = True
  mkres@gsMarkerIndex = 16
;
; Based on the levels we had for the contour plot and the colormap used, 
; get an array of colors that span the colormap. This uses the same
; algorithm that the contour used, so the colors will be identical.
;
  nlevels = dimsizes(levels)
  colors = span_color_rgba(colormap,nlevels+1)   ; Need one more color than number of levels

;
; Loop through each level, gather all the data values in the given level
; range, and add colored markers to the existing map.
;
  do n=0,nlevels

;---These "if" statements are how color contours are handled in NCL.
    if(n.eq.0) then
      ii := ind(data_1d.lt.levels(n))
    else if(n.eq.nlevels) then
      ii := ind(data_1d.ge.levels(n-1))
    else
      ii := ind(data_1d.ge.levels(n-1).and.data_1d.lt.levels(n))
    end if
    end if
    if(any(ismissing(ii))) then
      continue
    end if

;---Add the markers
    mkres@gsMarkerColor = colors(n,:)    ; colors is an N x 4 array
    plot@$unique_string("markers")$ = gsn_add_polymarker(wks,plot,lon_1d(ii),lat_1d(ii),mkres)
  end do
end

;----------------------------------------------------------------------
; Main code
;----------------------------------------------------------------------

begin

;---Open WRF output file and read data
  
  DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-10* ")
numFILES = dimsizes(FILES)

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

pm25_avg= pm25sum/s
;pm25_avg@description = "NO2 conc in ppbv"

  lat2d = wrf_user_getvar(a,"XLAT",it)   ; latitude/longitude
  lon2d = wrf_user_getvar(a,"XLONG",it)

  pm25_avg@lat2d = lat2d    ; for plotting
  pm25_avg@lon2d = lon2d

;---Will use this for contours and filled markers
  colormap = "BlAqGrYeOrReVi200"
  levels   = ispan(0,150,15)
;  levels   = (/0,10,20,30,40,50,60,70,80,90,100,125,150,175,200,225,250/) * 0.01

  wks = gsn_open_wks("x11","wrf_obs_d03_12-31octmean_pm25")

;---Common resources shared by both contour plot and marker plot
  res                        = True
  res@gsnMaximize            = False
  res@gsnLeftString          = ""
  res@gsnRightString         = ""

  res@mpDataBaseVersion      = "MediumRes"
 ; res@mpFillOn               = False
 ; res@mpMinLatF              = min(pm25_avg@lat2d)
 ; res@mpMaxLatF              = max(pm25_avg@lat2d)
 ; res@mpMinLonF              = min(pm25_avg@lon2d)
 ; res@mpMaxLonF              = max(pm25_avg@lon2d)
 ; res@pmTickMarkDisplayMode  = "Always"      ; better map tickmarks

 res@mpLimitMode       = "Corners"            ; choose range of map
 res@mpLeftCornerLatF  = 36.05806
 res@mpLeftCornerLonF  = 113.3356
 res@mpRightCornerLatF = 42.4514
 res@mpRightCornerLonF = 120.2583
 res@mpProjection         = "LambertConformal"
 res@mpLambertParallel1F = 20
 res@mpLambertParallel2F = 50
 res@mpLambertMeridianF  = 110

;---Resources for filled contour plot
  cnres                      = res
  cnres@cnFillOn             = True
  cnres@cnLevelSelectionMode = "ExplicitLevels"
  cnres@cnLevels             = levels
  cnres@cnFillPalette        = colormap
  cnres@cnLinesOn            = False
  cnres@cnLineLabelsOn       = False
;  cnres@lbLabelBarOn         = False   ; will add in panel later
  cnres@pmTitleZone          = 2       ; move title down
  cnres@gsnAddCyclic         = False
  
  cnres@mpLimitMode       = "Corners"            ; choose range of map
  cnres@mpLeftCornerLatF  = 36.05806
  cnres@mpLeftCornerLonF  = 113.3356
  cnres@mpRightCornerLatF = 42.4514
  cnres@mpRightCornerLonF = 120.2583
  cnres@mpProjection         = "LambertConformal"
  cnres@mpLambertParallel1F = 20
  cnres@mpLambertParallel2F = 50
  cnres@mpLambertMeridianF  = 110
  cnres@mpFillOn                    =  True
  cnres@mpOutlineDrawOrder          = "PostDraw"
  cnres@mpFillDrawOrder             = "PreDraw"
 ; cnres@mpOutlineBoundarySets       = "National"
  cnres@mpOutlineBoundarySets       = "Allboundaries"
  cnresmpNationalLineColor =	"Black"
  cnresmpGeophysicalLineColor =	"Black"
  cnres@mpUSStateLineDashPattern    = 2
  cnres@mpOutlineOn           = True
  cnres@mpDataBaseVersion        = "MediumRes"
  cnres@mpDataSetName            = "Earth..4"      ; U.S. counties
  cnres@mpGridAndLimbOn = True
  cnres@mpGridLineColor = "Black"
  cnres@mpFillColors = (/"transparent","transparent","gray","transparent"/)
  cnres@pmTickMarkDisplayMode = "Always"
  cnres@tiMainString = "WRF model data"
  cnres@tiDeltaF = 3.3
  cnres@tfDoNDCOverlay = True

  cnres@gsnDraw  = False                          ; don't draw
  cnres@gsnFrame = False                          ; don't advance frame
print(res)
;---Create smooth contour plot
  plot_wrf = gsn_csm_contour_map(wks,pm25_avg,cnres)

;----------------------------------------------------------------------
; Recreate similar plot, but by using filled markers drawn over a map.
;----------------------------------------------------------------------

  fname = "surfacedata_12-31_Octmean_improved.txt"
  lines = asciiread(fname,-1,"string")
  lon = tofloat(str_get_field(lines(:),2," "))
  lat = tofloat(str_get_field(lines(:),3," "))
  pm25 = tofloat(str_get_field(lines(:),4," "))

;---Create a map plot for adding markers to.
  res@gsnDraw         = False
  res@gsnFrame        = False
  res@tfPolyDrawOrder = "Draw"    ; Necessary to make sure filled markers drawn *under* map outlines
  res@tiMainString    = "'Observational' data"

  res@mpFillOn                    =  True
  res@mpOutlineDrawOrder          = "PostDraw"
  res@mpFillDrawOrder             = "PreDraw"
 ; res@mpOutlineBoundarySets       = "National"
  res@mpOutlineBoundarySets       = "Allboundaries"
  res@mpUSStateLineDashPattern    = 2
  res@mpOutlineOn           = True
  res@mpDataBaseVersion        = "MediumRes"
  res@mpDataSetName            = "Earth..4"      ; U.S. counties
 ; res@mpGridAndLimbOn = True
  res@mpFillColors = (/"transparent","transparent","gray","transparent"/)
  res@pmTickMarkDisplayMode = "Always"
  res@tiMainString = "Surface data"

  ;plot_obs = gsn_csm_map(wks,res)


;*****************************************
; add black circles over obs data
;*****************************************
  polyres               = True          ; poly marker mods desired 
  polyres@gsMarkerIndex = 4            ; choose circle as polymarker
  polyres@gsMarkerSizeF = 10           ; select size to avoid streaking
  polyres@gsMarkerColor = (/"black"/)   ; choose color
  polyres@gsMarkerThicknessF  = 2.0
tabish=gsn_add_polymarker(wks,plot_wrf,lon,lat,polyres)  ; draw polymarkers

;---Add colored markers to the map
  add_obs_markers_to_map(wks,plot_wrf,levels,colormap,pm25,lat,lon)


;---This draws the map with the filled markers
  draw(plot_wrf)
  frame(wks)

;---Panel both plots for comparison.
;  pres                    = True
;  pres@gsnMaximize        = True
;  pres@gsnPanelLabelBar   = True
;  pres@pmLabelBarWidthF   = 0.8
;  pres@lbLabelFontHeightF = 0.01 
;  gsn_panel(wks,(/plot_wrf,plot_obs/),(/1,2/),pres)





end
