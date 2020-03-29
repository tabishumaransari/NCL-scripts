load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"  ; Add special wrf functions

begin

  a = addfile("/home/tabish/WPS/geo_em.d03.nc","r")   ; Open a file


  type = "x11"
  wks = gsn_open_wks(type,"ter_d03")       ; Create a plot workstation
  gsn_define_colormap(wks,"OceanLakeLandSnow")

  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"
  opts@NoHeaderFooter = True
  ter = a->HGT_M(0,:,:)                      ; Read the variable to memory

  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
res@cnLevelSelectionMode = "ExplicitLevels"   ; set explicit contour levels
res@cnLevels    = (/ 5,10,50,100,150,200,300,500,700,1000,1200,1500,1800/)   ; set levels
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
  txres@txFontHeightF = 0.020
  txres@txJust        = "TopCenter"


; Now you can add some information to the plot. 
; Below is an example of adding a white dot over the DC location.
  pmres12 = True
  pmres12@gsMarkerColor = "Blue"
  pmres12@gsMarkerIndex = 16
  pmres12@gsMarkerSizeF = 0.01

  pmres2 = True
  pmres2@gsMarkerColor = "Red"
  pmres2@gsMarkerIndex = 16
  pmres2@gsMarkerSizeF = 0.01

;STARTING TO MARK CITIES WHERE APEC CONTROLS WERE IMPLEMENTED  
lat=39.9042
lon=116.4074
text = "Beijing"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.5380
lon=116.6838
text = "Langfang"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38.8744
lon=115.4646
text = "Baoding"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.3434
lon=117.3616
text = "Tianjin"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.6309
lon=118.1802
text = "Tangshan"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38.3045
lon=116.8388
text = "Cangzhou"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38.0428
lon=114.5149
text = "Shijiazhuang"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.7389
lon=115.6702
text = "Hengshui"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.4341
lon=116.3575
text = "Dezhou"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.3820
lon=117.9707
text = "Binzhou"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.4340
lon=118.6746
text = "Dongying"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.0708
lon=114.5047
text = "Xingtai"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.6257
lon=114.5390
text = "Handan"
gsn_polymarker(wks,plot,lon,lat,pmres12)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.4570
lon=115.9855
text = "Liaocheng"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.6512
lon=117.1201
text = "Jinan"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.8135
lon=118.0550
text = "Zibo"
gsn_polymarker(wks,plot,lon,lat,pmres2)
text_id = gsn_add_text(wks,plot,text,lon,lat,txres)

draw(plot)
frame(wks)
end

