;SAME AS APECDISTRICTS.NCL BUT WILL CROPPED MAP AND BIGGER FONTS
begin
  wks  = gsn_open_wks("png","APECdistricts") ; send graphics to PNG file

  res                     = True

  res@gsnDraw             = False       ; don't draw yet
  res@gsnFrame            = False       ; don't advance frame yet
  res@gsnMaximize         = True        ; maximize plot in frame

  res@mpProjection        = "LambertConformal"    ; choose projection
  res@mpLambertParallel1F = 20          ; first parallel
  res@mpLambertParallel2F = 50          ; second parallel
  res@mpLambertMeridianF  = 110         ; meridian

  res@mpLimitMode         = "Corners"   ; corner method of zoom
;  res@mpLeftCornerLatF  = 36.05806
;  res@mpLeftCornerLonF  = 113.3356
;  res@mpRightCornerLatF = 42.4514
;  res@mpRightCornerLonF = 120.2583

  res@mpLeftCornerLatF  = 35.7
  res@mpLeftCornerLonF  = 113.3356
  res@mpRightCornerLatF = 41
  res@mpRightCornerLonF = 120


  res@pmTickMarkDisplayMode = "Always"  ; turn on tickmarks

 ; res@tiMainString          = "APEC controls"

  plot = gsn_csm_map(wks,res)   ; Create map, but don't draw it yet.

;*************************************************
; Section to add polygons to map.
;*************************************************
  f = addfile("/data1/tabish/Shapefiles/China/CHN_adm2.shp", "r")   ; Open shapefile
  
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
  plres@gsEdgeColor = "black"    
;  plres@gsFillColor      = "Navy"
;  plres@gsFillOpacityF    = 0.5
  
  segNum = 0
  do i=0, numFeatures-1  

     ; color assignment (probably a better way to do this?)
     if (name(i).eq."Beijing").or.(name(i).eq."Langfang").or.(name(i).eq."Baoding").or.(name(i).eq."Shijiazhuang").or.(name(i).eq."Xingtai").or.(name(i).eq."Handan") then
         plres@gsFillColor = "cornflowerblue"
     end if
     if (name(i).eq."Tangshan").or.(name(i).eq."Tianjin").or.(name(i).eq."Cangzhou").or.(name(i).eq."Hengshui").or.(name(i).eq."Dezhou").or.(name(i).eq."Binzhou").or.(name(i).eq."Dongying").or.(name(i).eq."Liaocheng").or.(name(i).eq."Jinan").or.(name(i).eq."Zibo") then
         plres@gsFillColor = "tomato"
     end if

     startSegment = geometry(i, geom_segIndex)
     numSegments  = geometry(i, geom_numSegs)
     do seg=startSegment, startSegment+numSegments-1
        startPT = segments(seg, segs_xyzIndex)
        endPT = startPT + segments(seg, segs_numPnts) - 1
        lines(segNum) = gsn_add_polygon(wks, plot, lon(startPT:endPT),  \
                                                   lat(startPT:endPT), plres)
        segNum = segNum + 1
     end do
    plres@gsFillColor      = "Grey" 
 end do

print("done making polygons")

delete(lat)
delete(lon)

;---Attach some dummy text strings
  txres               = True
  txres@txFontHeightF = 0.015
  txres@txJust        = "CenterCenter"

;STARTING TO MARK CITIES WHERE APEC CONTROLS WERE IMPLEMENTED
lat=40.15
lon=116.4074
text = "Beijing"
text_id1 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.05
lon=116.5
text = "Langfang"
text_id2 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.0
lon=115.15
text = "Baoding"
text_id3 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.3434
lon=117.3616
text = "Tianjin"
text_id4 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=39.72
lon=118.1802
text = "Tangshan"
text_id5 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38.25
lon=116.8
text = "Cangzhou"
text_id6 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=38.0428
lon=114.5149
text = "Shijiazhuang"
text_id7 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.7389
lon=115.85
text = "Hengshui"
text_id8 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.2
lon=116.5
text = "Dezhou"
text_id9 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.5
lon=117.75
text = "Binzhou"
text_id10 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.5
lon=118.56
text = "Dongying"
text_id11 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=37.2
lon=114.75
text = "Xingtai"
text_id12 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.5
lon=114.5390
text = "Handan"
text_id13 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.4570
lon=115.9855
text = "Liaocheng"
text_id14 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.6512
lon=117.1201
text = "Jinan"
text_id15 = gsn_add_text(wks,plot,text,lon,lat,txres)

lat=36.6
lon=117.96
text = "Zibo"
text_id16 = gsn_add_text(wks,plot,text,lon,lat,txres)


; Maximize output in frame. This will draw everything and advance
; the frame.
;
  maximize_output(wks,False)

end

