load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"  ; Add special wrf functions

begin

a = addfile("/home/tabish/WPS_Nishadh/geo_em.d01_3km.nc","r")   ; Open a file
b = addfile("/home/tabish/WPS/geo_em.d03.nc","r")   ; Open a file
c = addfile("/home/tabish/WPS_Nishadh/geo_em.d04_1km.nc","r")   ; Open a file
z1 = asciiread("/data1/tabish/nclscripts/metstations_D01",-1,"string")
z2 = asciiread("/data1/tabish/nclscripts/surfacedata_12-31_Octmean_improved.txt",-1,"string")
LATmet    = stringtofloat(str_get_cols(z1, 36,42))
LONmet    = stringtofloat(str_get_cols(z1, 45,52))
print (LATmet +" "+LONmet)

LATpol    = stringtofloat(str_get_cols(z2, 45,50))
LONpol    = stringtofloat(str_get_cols(z2, 27,33))
print("LAT/LON for polstations")
print (LATpol +" "+LONpol)

  type = "eps"
  wks = gsn_open_wks(type,"ter_d01-d04_met-pol_stations")       ; Create a plot workstation
  setvalues NhlGetWorkspaceObjectId()
    "wsMaximumSize" : 300000000
  end setvalues
  gsn_define_colormap(wks,"OceanLakeLandSnow")

  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"
  opts@NoHeaderFooter = True
  ter_d01 = a->HGT_M(0,:,:)                      ; Read the variable to memory
  ter_d03 = b->HGT_M(0,:,:)                      ; Read the variable to memory
  ter_d04 = c->HGT_M(0,:,:)                      ; Read the variable to memory
  ter_d01@description = "" 
  ter_d01@units = "" 
  ter_d03@description = "" 
  ter_d03@units = "" 
  ter_d04@description = ""
  ter_d04@units = ""
  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
  res@cnFillMode       = "RasterFill"        ; Raster Mode
  res@lbLabelBarOn        = False           ; turn off individual cb's
  res@gsnDraw             = False           ; don't draw
  res@gsnFrame            = False           ; don't advance frame

res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
res@cnLevels    = (/ 1,5,10,50,100,150,200,250,300,400,500,700,1000,1200,1500,1800,2500,3000,4000/) 
contour_d01 = wrf_contour(a,wks,ter_d01,res)
contour_d03 = wrf_contour(b,wks,ter_d03,res)
res@cnFillMode       = "AreaFill"        ; Raster Mode switched off the d04
contour_d04 = wrf_contour(c,wks,ter_d04,res)

  pltres = True                              ; Set plot options
  mpres = True                               ; Set map options
mpres@mpDataBaseVersion = "MediumRes"
mpres@mpDataSetName = "Earth..4"

mpres@mpGeophysicalLineColor = "Black"
mpres@mpGridLineColor = "Black"
mpres@mpLimbLineColor = "Black"
mpres@mpNationalLineColor = "Black"
mpres@mpPerimLineColor = "Black"
mpres@mpUSStateLineColor = "Black"
mpres@mpOutlineBoundarySets = "AllBoundaries"
mpres@mpNationalLineThicknessF = 1.0
mpres@mpProvincialLineThicknessF = 0.5
mpres@mpGeophysicalLineThicknessF = 1.0
mpres@mpGridLineThicknessF = 0.5

pltres@PanelPlot = True      ; Indicate these plots are to be paneled.
pltres@NoHeaderFooter = True
pltres@FramePlot = False  ; do not frame plot - will do this manually later
mpres@tmXBLabelFontHeightF = 0.016
plot = new(2,graphic)                          ; create a plot array
plot(0) = wrf_map_overlays(a,wks,(/contour_d01/),pltres,mpres)  ; Plot the data over a map background

;---Retrieve the height used for the first plot and apply to second plot
  getvalues plot(0)
    "vpHeightF" : vph
  end getvalues
mpres@tmXBLabelFontHeightF = 0.022
mpres@mpOutlineBoundarySets = "NoBoundaries"
plot(1) = wrf_map_overlays(c,wks,(/contour_d04/),pltres,mpres)  ; Plot the data over a map background

setvalues plot(1)
  "vpHeightF" : vph
end setvalues


;---Attach some dummy text strings
  txres               = True
  txres@txFontHeightF = 0.017
  txres@txJust        = "TopCenter"

;********************************************
; add black circles over met and pol stations
;********************************************
  polyres               = True          ; poly marker mods desired
  polyres@gsMarkerIndex = 4            ; choose circle as polymarker
  polyres@gsMarkerSizeF = 6           ; select size to avoid streaking
  polyres@gsMarkerColor = (/"black"/)   ; choose color
  polyres@gsMarkerThicknessF  = 1.0
  tabish31=gsn_add_polymarker(wks,plot(0),LONmet,LATmet,polyres)  ; draw polymarkers
  tabish41=gsn_add_polymarker(wks,plot(0),LONpol,LATpol,polyres)  ; draw polymarkers

  pmres1 = True
  pmres1@gsMarkerColor = "cornflowerblue"
  pmres1@gsMarkerIndex = 16
  pmres1@gsMarkerSizeF = 0.004

  pmres2 = True
  pmres2@gsMarkerColor = "tomato"
  pmres2@gsMarkerIndex = 16
  pmres2@gsMarkerSizeF = 0.004

;STARTING TO MARK MET AND POL STATIONS 
tabish3 = gsn_add_polymarker(wks,plot(0),LONmet,LATmet,pmres1)
tabish4 = gsn_add_polymarker(wks,plot(0),LONpol,LATpol,pmres2)



; DRAW DOMAIN 2 AND 3 BOUNDARIES OVER DOMAIN 1
  gres2                 = True
;  gres2@gsFillColor     = "deepskyblue"
;  gres2@gsFillOpacityF  = 0.7
  gres2@gsLineThicknessF = 3.0
  lat2 = (/35.04059,  45.21748, 44.41343, 34.32753, 35.04059/)
  lon2 = (/109.437, 109.3554, 124.9451,  123.0779, 109.437/)
  tabish1 = gsn_add_polyline(wks,plot(0),lon2,lat2,gres2)


  gres3                 = True
;  gres3@gsFillColor     = "pink"
;  gres3@gsFillOpacityF  = 0.7
  gres3@gsLineThicknessF = 3.0
  lat3 = (/36.05806,  42.79478, 42.4514, 35.7411, 36.05806/)
  lon3 = (/113.3356, 113.6442, 120.2533,  119.3942, 113.3356/)
  tabish2 = gsn_add_polyline(wks,plot(0),lon3,lat3,gres3)



;pmres1@gsMarkerSizeF = 0.003
;pmres2@gsMarkerSizeF = 0.003
;tabish5 = gsn_add_polymarker(wks,plot(1),LONmet,LATmet,pmres1)
;tabish6 = gsn_add_polymarker(wks,plot(1),LONpol,LATpol,pmres2)


;********************************************
; add black circles over met and pol stations for D04
;********************************************
  polyres@gsMarkerSizeF = 8           ; select size to avoid streaking
  polyres@gsMarkerThicknessF  = 1.0
  tabish71=gsn_add_polymarker(wks,plot(1),LONmet,LATmet,polyres)  ; draw polymarkers
  tabish81=gsn_add_polymarker(wks,plot(1),LONpol,LATpol,polyres)  ; draw polymarkers




pmres1@gsMarkerSizeF = 0.006
pmres2@gsMarkerSizeF = 0.006
tabish7 = gsn_add_polymarker(wks,plot(1),LONmet,LATmet,pmres1)
tabish8 = gsn_add_polymarker(wks,plot(1),LONpol,LATpol,pmres2)
pmres2@gsMarkerColor = "Black"
tabish9 = gsn_add_polymarker(wks,plot(1),116.37,39.97,pmres2)

china_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp"
lnres                  = True
lnres@gsLineColor      = "black"
lnres@gsLineThicknessF = 1
;china_id1 = gsn_add_shapefile_polylines(wks,plot(0),china_shp_name,lnres)
;china_id3 = gsn_add_shapefile_polylines(wks,plot(1),china_shp_name,lnres)
china_id4 = gsn_add_shapefile_polylines(wks,plot(1),china_shp_name,lnres)

;************************************************
; create panel
;************************************************
  resP                     = True                ; modify the panel plot
;  resP@gsnPanelMainString  = "Model domain: topography, meteorological and pollutant stations"
  resP@gsnPanelLabelBar    = True               ; This gives an error!!!
  resP@lbLabelFontHeightF  = 0.010               ; make labels smaller
;  resP@gsnPanelRowSpec     = True                   ; tell panel what order to plot
;  resP@gsnPanelCenter      = False
  resP@gsnPanelBottom = 0.07
  resP@gsnFrame = False
  resP@gsnPanelDebug = True   
  resP@gsnPanelXF          = (/0.06,0.58/)
  gsn_panel(wks,(/plot/),(/1,2/),resP)               ; now draw as one plot


; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.010
  gsn_text_ndc(wks,"Topography height (m)",0.51,0.373,txres)
  frame(wks)
end

