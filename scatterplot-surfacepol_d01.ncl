;THIS SCRIPT READS IN LARGE COMBINED SIM AND OBS ARRAYS FOR D01 AND CREATES A SCATTER PLOT
begin

obsarray = asciiread("corr-array-obs_d01",-1,"string")
simarray = asciiread("corr-array-sim_d01",-1,"string")

pm25sim_array = stringtodouble(str_get_cols(simarray, 0,8))
pm10sim_array = stringtodouble(str_get_cols(simarray, 10,18))
cosim_array = stringtodouble(str_get_cols(simarray, 20,28))
no2sim_array = stringtodouble(str_get_cols(simarray, 30,38))
so2sim_array = stringtodouble(str_get_cols(simarray, 40,48))
o3sim_array = stringtodouble(str_get_cols(simarray, 50,58))

pm25obs_array = stringtodouble(str_get_cols(obsarray, 0,8))
pm10obs_array = stringtodouble(str_get_cols(obsarray, 10,18))
coobs_array = stringtodouble(str_get_cols(obsarray, 20,28))
no2obs_array = stringtodouble(str_get_cols(obsarray, 30,38))
so2obs_array = stringtodouble(str_get_cols(obsarray, 40,48))
o3obs_array = stringtodouble(str_get_cols(obsarray, 50,58))


pm25sim_array = where(pm25sim_array.gt.600,pm25sim_array@FillValue,pm25sim_array)
pm25obs_array = where(pm25obs_array.gt.600,pm25obs_array@FillValue,pm25obs_array)
pm25obs_array = where(pm25obs_array.eq.-999,pm25obs_array@FillValue,pm25obs_array)
pm25obs_array = where(pm25obs_array.lt.0,pm25obs_array@FillValue,pm25obs_array)

pm10sim_array = where(pm10sim_array.gt.600,pm10sim_array@FillValue,pm10sim_array)
pm10obs_array = where(pm10obs_array.gt.600,pm10obs_array@FillValue,pm10obs_array)
pm10obs_array = where(pm10obs_array.eq.-999,pm10obs_array@FillValue,pm10obs_array)
pm10obs_array = where(pm10obs_array.lt.0,pm10obs_array@FillValue,pm10obs_array)

cosim_array = where(cosim_array.gt.3.5,cosim_array@FillValue,cosim_array)
coobs_array = where(coobs_array.gt.3.5,coobs_array@FillValue,coobs_array)
coobs_array = where(coobs_array.eq.-999,coobs_array@FillValue,coobs_array)
coobs_array = where(coobs_array.lt.0,coobs_array@FillValue,coobs_array)

no2sim_array = where(no2sim_array.gt.120,no2sim_array@FillValue,no2sim_array)
no2obs_array = where(no2obs_array.gt.120,no2obs_array@FillValue,no2obs_array)
no2obs_array = where(no2obs_array.eq.-999,no2obs_array@FillValue,no2obs_array)
no2obs_array = where(no2obs_array.lt.0,no2obs_array@FillValue,no2obs_array)

so2sim_array = where(so2sim_array.gt.280,so2sim_array@FillValue,so2sim_array)
so2obs_array = where(so2obs_array.gt.280,so2obs_array@FillValue,so2obs_array)
so2obs_array = where(so2obs_array.eq.-999,so2obs_array@FillValue,so2obs_array)
so2obs_array = where(so2obs_array.lt.0,so2obs_array@FillValue,so2obs_array)

o3sim_array = where(o3sim_array.gt.100,o3sim_array@FillValue,o3sim_array)
o3obs_array = where(o3obs_array.gt.100,o3obs_array@FillValue,o3obs_array)
o3obs_array = where(o3obs_array.eq.-999,o3obs_array@FillValue,o3obs_array)
o3obs_array = where(o3obs_array.lt.0,o3obs_array@FillValue,o3obs_array)

;lat_array       = todouble(str_get_field(polstations,2," ")) ;extract 2nd column of the first file for LON
;lon_array       = todouble(str_get_field(polstations,3," ")) ;extract 3rd column of the first file for LAT
;print("PM2.5 OBS="+pm25obs_array+" PM2.5 SIM= "+pm25sim_array)
rc_pm25   = regline (pm25obs_array,pm25sim_array)
rc_pm10   = regline (pm10obs_array,pm10sim_array)
rc_co     = regline (coobs_array,cosim_array)
rc_no2    = regline (no2obs_array,no2sim_array)
rc_so2    = regline (so2obs_array,so2sim_array)
rc_o3     = regline (o3obs_array,o3sim_array)
print(rc_pm25)
print(rc_pm10)
print(rc_co)
print(rc_no2)
print(rc_so2)
print(rc_o3)

wks   = gsn_open_wks ("png","scatterplots_d01")                ; send graphics to PNG file

res                   = True                     ; plot mods desired
;res@tiMainString      = "PM2.5 Scatter Plot"           ; add title
res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@xyMarkers         =  16                      ; choose type of marker  
res@xyMarkerColor     = "black"                    ; Marker color
res@xyMarkerSizeF     = 0.001                     ; Marker size (default 0.01)
res@gsnDraw  = False                          ; don't draw
res@gsnFrame = False                          ; don't advance frame
res@tmLabelAutoStride = True                     ; nice tick mark labels
res@tiXAxisString = "PM2.5 obs"  ; xaxis string
res@tiYAxisString = "PM2.5 sim"  ; yaxis string

plot = new(6,graphic)
plot(0)  = gsn_csm_xy (wks,pm25obs_array,pm25sim_array,res) ; create plot

res@tiXAxisString = "PM10 obs"  ; xaxis string
res@tiYAxisString = "PM10 sim"  ; yaxis string
plot(1)  = gsn_csm_xy (wks,pm10obs_array,pm10sim_array,res) ; create plot

res@tiXAxisString = "CO obs"  ; xaxis string
res@tiYAxisString = "CO sim"  ; yaxis string
plot(2)  = gsn_csm_xy (wks,coobs_array,cosim_array,res) ; create plot

res@tiXAxisString = "NO2 obs"  ; xaxis string
res@tiYAxisString = "NO2 sim"  ; yaxis string
plot(3)  = gsn_csm_xy (wks,no2obs_array,no2sim_array,res) ; create plot

res@tiXAxisString = "SO2 obs"  ; xaxis string
res@tiYAxisString = "SO2 sim"  ; yaxis string
plot(4)  = gsn_csm_xy (wks,so2obs_array,so2sim_array,res) ; create plot

res@tiXAxisString = "O3 obs"  ; xaxis string
res@tiYAxisString = "O3 sim"  ; yaxis string
plot(5)  = gsn_csm_xy (wks,o3obs_array,o3sim_array,res) ; create plot

gsn_panel(wks,plot,(/2,3/),False)             ; now draw as one plot
end
