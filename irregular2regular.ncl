;
;LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10
; -11.5746   48.3209    0.0001    0.0009

  ncol  = 10
  fname = "/media/tabish/DataDisk/LEC_desktopbackup_23092019/nclscripts/mapeire_trimmed.txt"
  data  = readAsciiTable(fname, ncol, "float", 1)
  printVarSummary(data)
  dimd  = dimsizes(data)
  nrow  = dimd(0)
  
  LON = data(:,0)      ; [*]
  LAT = data(:,1)
  CO  = data(:,2)
  NOX = data(:,3)
  SO2 = data(:,4)
  NMVOC = data(:,5)
  NH3 = data(:,6)
  BC  = data(:,7)
  PM25= data(:,8)
  PM10= data(:,9)
  delete(data)

  CO@long_name = "Carbon Monoxide"
  CO@units     = ""
  printMinMax(CO,True)  
  
  wks = gsn_open_wks("x11","TABISH")       ; send graphics to PNG file

  res                             = True
  res@gsnMaximize                 = True
  res@gsnFrame                    = False   ; Want to draw markers later.

; Variable dependent
res@cnLevelSelectionMode        = "ManualLevels"
res@cnMinLevelValF              = 0
res@cnMaxLevelValF              = 1000
res@cnLevelSpacingF             = 50

  res@cnFillOn                    = True
;;res@cnFillPalette               = 
;;res@cnLinesOn                   = True
;;res@cnLineLabelsOn              = True

;;res@lbOrientation               = "vertical"
;;res@lbBoxLinesOn                = False

;---Zoom in on map area of interest
  spacey                          = 0.05
  spacex                          = 0.05
  res@mpMinLatF                   = min(LAT)-spacey
  res@mpMinLonF                   = min(LON)-spacex
  res@mpMaxLatF                   = max(LAT)+spacey
  res@mpMaxLonF                   = max(LON)+spacex

  res@sfXArray                    = LON
  res@sfYArray                    = LAT

  res@pmTickMarkDisplayMode       = "Always"   ; nicer map tickmarks

;---Create the plot; it won't get drawn because gsnFrame was set to False.
;;res@tiMainString = ""
  plot = gsn_csm_contour_map(wks,CO,res)

;---Draw markers on the plot in the lat/lon locations.
;  mkres               = True
;  mkres@gsMarkerIndex = 16     ; Filled circle
;  mkres@gsMarkerSizeF = 0.005  ; Marker size
;  gsn_polymarker(wks,plot,LON,LAT,mkres)
  frame(wks)   ; Now advance the frame.
