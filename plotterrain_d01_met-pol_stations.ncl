load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"  ; Add special wrf functions

begin

a = addfile("/home/tabish/WPS_Nishadh/geo_em.d01.nc","r")   ; Open a file
z1 = asciiread("/data1/tabish/nclscripts/metstations_D01",-1,"string")
z2 = asciiread("/data1/tabish/nclscripts/surfacedata_12-31_Octmean_improved.txt",-1,"string")
LATmet    = stringtofloat(str_get_cols(z1, 36,42))
LONmet    = stringtofloat(str_get_cols(z1, 45,52))
print (LATmet +" "+LONmet)

LATpol    = stringtofloat(str_get_cols(z2, 45,50))
LONpol    = stringtofloat(str_get_cols(z2, 27,33))
print("LAT/LON for polstations")
print (LATpol +" "+LONpol)

  type = "png"
  wks = gsn_open_wks(type,"ter_d01_met-pol_stations")       ; Create a plot workstation
  setvalues NhlGetWorkspaceObjectId()
    "wsMaximumSize" : 300000000
  end setvalues
  gsn_define_colormap(wks,"OceanLakeLandSnow")

  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"
  opts@NoHeaderFooter = True
  ter = a->HGT_M(0,:,:)                      ; Read the variable to memory

  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
;res@cnLevels    = (/ 1,5,10,50,100,150,200,300,500,700,1000,1200,1500,1800/)   ; set levels
res@cnLevels    = (/ 1,5,10,50,100,150,200,250,300,400,500,700,1000,1200,1500,1800,2500,3000,4000/)   ; set levels
;res@cnLevels    = (/1, 10,50,100,150,300,500,1000,1500,2000,2500,3000,4000,4500,5000/)   ; set levels
mpres = True
mpres@mpDataBaseVersion = "MediumRes"
mpres@mpDataSetName = "Earth..4"

mpres@mpGeophysicalLineColor = "Black"
mpres@mpGridLineColor = "Black"
mpres@mpLimbLineColor = "Black"
mpres@mpNationalLineColor = "Black"
mpres@mpPerimLineColor = "Black"
mpres@mpUSStateLineColor = "Black"
mpres@mpOutlineBoundarySets = "StateBoundaries" 
mpres@mpNationalLineThicknessF = 1.5
mpres@mpProvincialLineThicknessF = 1.5
mpres@mpGeophysicalLineThicknessF = 1.5  
contour = wrf_contour(a,wks,ter,res)

  pltres = True                              ; Set plot options
  mpres = True                               ; Set map options
pltres@NoHeaderFooter = True
pltres@FramePlot = False  ; do not frame plot - will do this manually later
plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)  ; Plot the data over a map background

;---Attach some dummy text strings
  txres               = True
  txres@txFontHeightF = 0.017
  txres@txJust        = "TopCenter"

  gres2                 = True
  gres2@gsFillColor     = "black"
  gres2@gsFillOpacityF  = 0.7
  lat2 = (/35.04059,  45.21748, 44.41343, 34.32753, 35.04059/)
  lon2 = (/109.437, 109.3554, 124.9451,  123.0779, 109.437/)
  ;dum2 = gsn_add_polygon(wks,plot,lon2,lat2,gres2)
  gsn_polygon(wks,plot,lon2,lat2,gres2)


  gres3                 = True
  gres3@gsFillColor     = "grey60"
  gres3@gsFillOpacityF  = 0.7
  lat3 = (/36.05806,  42.79478, 42.4514, 35.7411, 36.05806/)
  lon3 = (/113.3356, 113.6442, 120.2533,  119.3942, 113.3356/)
  ;dum3 = gsn_add_polygon(wks,plot,lon3,lat3,gres3)
  gsn_polygon(wks,plot,lon3,lat3,gres3)

; Now you can add some information to the plot. 
; Below is an example of adding a white dot over the DC location.
  pmres1 = True
  pmres1@gsMarkerColor = "Blue"
  pmres1@gsMarkerIndex = 16
  pmres1@gsMarkerSizeF = 0.005

  pmres2 = True
  pmres2@gsMarkerColor = "Red"
  pmres2@gsMarkerIndex = 16
  pmres2@gsMarkerSizeF = 0.005

;STARTING TO MARK MET AND POL STATIONS 
gsn_polymarker(wks,plot,LONmet,LATmet,pmres1)
gsn_polymarker(wks,plot,LONpol,LATpol,pmres2)

china_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp"
lnres                  = True
lnres@gsLineColor      = "black"
lnres@gsLineThicknessF = 1
china_id = gsn_add_shapefile_polylines(wks,plot,china_shp_name,lnres)
draw(plot)       ; This will draw the map and the shapefile outlines.
frame(wks)       ; Advance the frame


end

