;SAME AS APECDISTRICTS.NCL BUT WILL CROPPED MAP AND BIGGER FONTS
begin
  wks  = gsn_open_wks("eps","pulse-districts") ; send graphics to PNG file

  res                     = True

  res@gsnDraw             = False       ; don't draw yet
  res@gsnFrame            = False       ; don't advance frame yet
  res@gsnMaximize         = True       ; maximize plot in frame
  res@gsnPaperOrientation = "landscape"
  res@vpKeepAspect        = True  
  res@mpProjection        = "LambertConformal"    ; choose projection
  res@mpLambertParallel1F = 20          ; first parallel
  res@mpLambertParallel2F = 50          ; second parallel
  res@mpLambertMeridianF  = 110         ; meridian

  res@mpLimitMode         = "Corners"   ; corner method of zoom
; D03 corners...
;  res@mpLeftCornerLatF  = 35.7
;  res@mpLeftCornerLonF  = 113.3356
;  res@mpRightCornerLatF = 41
;  res@mpRightCornerLonF = 120
; D02 corners...
  res@mpLeftCornerLatF  = 35
  res@mpLeftCornerLonF  = 109.35
  res@mpRightCornerLatF = 44.41
  res@mpRightCornerLonF = 124.94

  res@pmTickMarkDisplayMode = "Always"  ; turn on tickmarks
  res@tmXBMajorOutwardLengthF = 0.0
  res@tmXTMajorOutwardLengthF = 0.0
  res@tmYLMajorOutwardLengthF = 0.0
  res@tmYRMajorOutwardLengthF = 0.0


 ; res@tiMainString          = "APEC controls"
  res@tiMainFontHeightF  = 0.025
  res@tiYAxisFontHeightF = 0.01
  res@tiXAxisFontHeightF = 0.01
  res@tmXBLabelFontHeightF = 0.01
  plot = gsn_csm_map(wks,res)   ; Create map, but don't draw it yet.

;*************************************************
; Section to add polygons to map.
;*************************************************
  f = addfile("/home/tabish/Shapefiles/China/CHN_adm2.shp", "r")   ; Open shapefile
  
;
; Read data off shapefile
;
  segments = f->segments
  geometry = f->geometry
  segsDims = dimsizes(segments)
  geomDims = dimsizes(geometry)
;
; Read global attributes  
;
  geom_segIndex = f@geom_segIndex
  geom_numSegs  = f@geom_numSegs
  segs_xyzIndex = f@segs_xyzIndex
  segs_numPnts  = f@segs_numPnts

  lines       = new(segsDims(0),graphic)   ; Array to hold polygons
  numFeatures = geomDims(0)

  name =  f->NAME_2
  lon   = f->x
  lat   = f->y

  plres             = True       ; resources for polylines
  plres@gsEdgesOn   = True       ; draw border around polygons
  plres@gsEdgeThicknessF = 1.0  
  plres@gsEdgeDashPattern = 1  
  plres@gsEdgeColor = "black"    
;  plres@gsFillColor      = "Navy"
;  plres@gsFillOpacityF    = 0.5
  
  segNum = 0
  do i=0, numFeatures-1 
; color assignment (probably a better way to do this?)
   if (name(i).eq."Beijing") then
     plres@gsFillColor = "tomato"
     else if (name(i).eq."Langfang").or.(name(i).eq."Baoding").or.(name(i).eq."Shijiazhuang").or.(name(i).eq."Xingtai").or.(name(i).eq."Handan").or.(name(i).eq."Tangshan").or.(name(i).eq."Tianjin").or.(name(i).eq."Cangzhou").or.(name(i).eq."Hengshui").or.(name(i).eq."Dezhou").or.(name(i).eq."Binzhou").or.(name(i).eq."Dongying").or.(name(i).eq."Liaocheng").or.(name(i).eq."Jinan").or.(name(i).eq."Zibo")then
       plres@gsFillColor = "limegreen"
     else         
        plres@gsFillColor = "dodgerblue"
     end if
   end if

   startSegment = geometry(i, geom_segIndex)
   numSegments  = geometry(i, geom_numSegs)
   do seg=startSegment, startSegment+numSegments-1
     startPT = segments(seg, segs_xyzIndex)
     endPT = startPT + segments(seg, segs_numPnts) - 1
     lines(segNum) = gsn_add_polygon(wks, plot, lon(startPT:endPT), lat(startPT:endPT), plres)
     segNum = segNum + 1
   end do
   plres@gsFillColor      = "Grey" 
  end do

print("done making polygons")

delete(lat)
delete(lon)

;---Attach some dummy text strings
  txres               = True
  txres@txFontHeightF = 0.020
  txres@txJust        = "CenterCenter"

;STARTING TO MARK CITIES WHERE APEC CONTROLS WERE IMPLEMENTED
lat=40.15
lon=116.4074
text = "Beijing"
text_id1 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38
lon=116.2
text = "Near Neighbourhood"
text_id8 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=41
lon=112.2
text = "Far Neighbourhood"
text_id8 = gsn_add_text(wks,plot,text,lon,lat,txres)

;ADD DISTRICT BOUNDARIES WITH THICKER BLACK LINES
india_shp_name    = "/home/tabish/Shapefiles/China/CHN_adm1.shp"
lnres                  = True
lnres@gsLineColor      = "black"
lnres@gsLineThicknessF = 2.0
india_id = gsn_add_shapefile_polylines(wks,plot,india_shp_name,lnres)

; Maximize output in frame. This will draw everything and advance
; the frame.
;
  maximize_output(wks,False)





end

