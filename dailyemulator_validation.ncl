begin
;reading validation outputs 60x11
ncol = 11
validation_output = readAsciiTable("/home/tabish/Emulation/dailyemulator-validation1.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
validation_output@_FillValue = -999
printVarSummary(validation_output)

;reading validation outputs 11x60
ncol = 60
simulation_output = readAsciiTable("/home/tabish/Emulation/run1-60_dailymean.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
simulation_output@_FillValue = -999
printVarSummary(simulation_output)

simulation_output_T = transpose(simulation_output)
printVarSummary(simulation_output_T)

print(validation_output(1,:)+"	"+simulation_output_T(1,:))

r = escorc(ndtooned(simulation_output_T),ndtooned(validation_output))   ; ccr is a scalar
print(r)

wks   = gsn_open_wks ("pdf","emulator-validation")                ; send graphics to PNG file

res                   = True                     ; plot mods desired
;res@tiMainString      = "PM2.5 Scatter Plot"           ; add title
;res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmXBMinorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmXTMajorOutwardLengthF = 0.0               ; draw minor ticks inward
res@tmXTMinorOutwardLengthF = 0.0               ; draw minor ticks inward
res@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYLMinorOutwardLengthF = 0.0               ; draw tickmarks inward
res@tmYRMajorOutwardLengthF = 0.0               ; draw minor ticks inward
res@tmYRMinorOutwardLengthF = 0.0               ; draw minor ticks inward


res@xyMarkLineMode    = "Markers"                ; choose to use markers
res@xyMarker         =  4                      ; choose type of marker
res@xyMarkerColor     = "black"                    ; Marker color
res@xyMarkerSizeF     = 0.01                     ; Marker size (default 0.01)
;res@gsnDraw  = False                          ; don't draw
;res@gsnFrame = False                          ; don't advance frame
;res@tmLabelAutoStride = True                     ; nice tick mark labels

res@tiXAxisFontHeightF = 0.02
res@tiYAxisFontHeightF = 0.02

res@tiXAxisString = "simulated daily mean PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)"  ; xaxis string
res@tiYAxisString = "emulated daily mean PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)"  ; yaxis string

plot  = gsn_csm_xy (wks,ndtooned(simulation_output_T),ndtooned(validation_output),res) ; create plot







end
