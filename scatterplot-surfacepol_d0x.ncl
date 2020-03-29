;THIS SCRIPT READS IN LARGE COMBINED SIM AND OBS ARRAYS FOR D01 AND CREATES A SCATTER PLOT
begin

obsarray = asciiread("corr-array-obs_d04",-1,"string")
simarray = asciiread("corr-array-sim_d04",-1,"string")

pm25sim = stringtofloat(str_get_cols(simarray, 0,8))
pm10sim = stringtofloat(str_get_cols(simarray, 10,18))
cosim = stringtofloat(str_get_cols(simarray, 20,28))
no2sim = stringtofloat(str_get_cols(simarray, 30,38))
so2sim = stringtofloat(str_get_cols(simarray, 40,48))
o3sim = stringtofloat(str_get_cols(simarray, 50,58))

pm25obs = stringtofloat(str_get_cols(obsarray, 0,8))
pm10obs = stringtofloat(str_get_cols(obsarray, 10,18))
coobs = stringtofloat(str_get_cols(obsarray, 20,28))
no2obs = stringtofloat(str_get_cols(obsarray, 30,38))
so2obs = stringtofloat(str_get_cols(obsarray, 40,48))
o3obs = stringtofloat(str_get_cols(obsarray, 50,58))

pm25sim = where(pm25sim.gt.500,pm25sim@FillValue,pm25sim)
pm25obs = where(pm25obs.gt.500,pm25obs@FillValue,pm25obs)
pm25obs = where(pm25obs.eq.-999,pm25obs@FillValue,pm25obs)
pm25obs = where(pm25obs.lt.0,pm25obs@FillValue,pm25obs)

pm10sim = where(pm10sim.gt.600,pm10sim@FillValue,pm10sim)
pm10obs = where(pm10obs.gt.600,pm10obs@FillValue,pm10obs)
pm10obs = where(pm10obs.eq.-999,pm10obs@FillValue,pm10obs)
pm10obs = where(pm10obs.lt.0,pm10obs@FillValue,pm10obs)

cosim = where(cosim.gt.4,cosim@FillValue,cosim)
coobs = where(coobs.gt.4,coobs@FillValue,coobs)
coobs = where(coobs.eq.-999,coobs@FillValue,coobs)
coobs = where(coobs.lt.0,coobs@FillValue,coobs)

no2sim = where(no2sim.gt.150,no2sim@FillValue,no2sim)
no2obs = where(no2obs.gt.150,no2obs@FillValue,no2obs)
no2obs = where(no2obs.eq.-999,no2obs@FillValue,no2obs)
no2obs = where(no2obs.lt.0,no2obs@FillValue,no2obs)

so2sim = where(so2sim.gt.50,so2sim@FillValue,so2sim)
so2obs = where(so2obs.gt.50,so2obs@FillValue,so2obs)
so2obs = where(so2obs.eq.-999,so2obs@FillValue,so2obs)
so2obs = where(so2obs.lt.0,so2obs@FillValue,so2obs)

o3sim = where(o3sim.gt.70,o3sim@FillValue,o3sim)
o3obs = where(o3obs.gt.70,o3obs@FillValue,o3obs)
o3obs = where(o3obs.eq.-999,o3obs@FillValue,o3obs)
o3obs = where(o3obs.lt.0,o3obs@FillValue,o3obs)

rc_pm25   = decimalPlaces(regline (pm25obs,pm25sim),2,True)
rc_pm10   = decimalPlaces(regline (pm10obs,pm10sim),2,True)
rc_co     = decimalPlaces(regline (coobs,cosim),2,True)
rc_no2    = decimalPlaces(regline (no2obs,no2sim),2,True)
rc_so2    = decimalPlaces(regline (so2obs,so2sim),2,True)
rc_o3     = decimalPlaces(regline (o3obs,o3sim),2,True)

r_pm25   = decimalPlaces(escorc (pm25obs,pm25sim),2,True)
r_pm10   = decimalPlaces(escorc (pm10obs,pm10sim),2,True)
r_co     = decimalPlaces(escorc (coobs,cosim),2,True)
r_no2    = decimalPlaces(escorc (no2obs,no2sim),2,True)
r_so2    = decimalPlaces(escorc (so2obs,so2sim),2,True)
r_o3     = decimalPlaces(escorc (o3obs,o3sim),2,True)

pm25_rmse = decimalPlaces(dim_rmsd(pm25obs, pm25sim),2,True)
pm10_rmse = decimalPlaces(dim_rmsd(pm10obs, pm10sim),2,True)
co_rmse   = decimalPlaces(dim_rmsd(coobs, cosim),2,True)
so2_rmse  = decimalPlaces(dim_rmsd(so2obs, so2sim),2,True)
no2_rmse  = decimalPlaces(dim_rmsd(no2obs, no2sim),2,True)
o3_rmse   = decimalPlaces(dim_rmsd(o3obs, o3sim),2,True)


print(rc_pm25)
print(r_pm25)
print(pm25_rmse)
print(rc_pm10)
print(r_pm10)
print(pm10_rmse)
print(rc_co)
print(r_co)
print(co_rmse)
print(rc_no2)
print(r_no2)
print(no2_rmse)
print(rc_so2)
print(r_so2)
print(so2_rmse)
print(rc_o3)
print(r_o3)
print(o3_rmse)

;x     = ispan(0,dimsizes(pm25sim)-1,1)*1.
data_pm25      = new ( (/2,dimsizes(pm25sim)/), typeof(pm25sim))
data_pm10      = new ( (/2,dimsizes(pm10sim)/), typeof(pm10sim))
data_co        = new ( (/2,dimsizes(cosim)/), typeof(cosim))
data_so2       = new ( (/2,dimsizes(so2sim)/), typeof(so2sim))
data_no2       = new ( (/2,dimsizes(no2sim)/), typeof(no2sim))
data_o3        = new ( (/2,dimsizes(o3sim)/), typeof(o3sim))
data_pm25(0,:) = pm25sim
data_pm25(1,:) = rc_pm25*(pm25obs-rc_pm25@xave) + rc_pm25@yave
data_pm10(0,:) = pm10sim
data_pm10(1,:) = rc_pm10*(pm10obs-rc_pm10@xave) + rc_pm10@yave
data_co(0,:) = cosim
data_co(1,:) = rc_co*(coobs-rc_co@xave) + rc_co@yave
data_so2(0,:) = so2sim
data_so2(1,:) = rc_so2*(so2obs-rc_so2@xave) + rc_so2@yave
data_no2(0,:) = no2sim
data_no2(1,:) = rc_no2*(no2obs-rc_no2@xave) + rc_no2@yave
data_o3(0,:) = o3sim
data_o3(1,:) = rc_o3*(o3obs-rc_o3@xave) + rc_o3@yave

wks   = gsn_open_wks ("x11","scatterplots_D04")                ; send graphics to PNG file

res                     = True                   ; plot mods desired
res@gsnMaximize         = True                   ; maximize plot in frame
res@xyMarkLineModes     = (/"Markers","Lines"/)  ; choose which have markers
res@xyMarkers           = 16                     ; choose type of marker
res@xyMarkerColor       = "red"                  ; Marker color
res@xyMarkerSizeF       = 0.0001                  ; Marker size (default 0.01)
res@xyDashPatterns      = 1                      ; solid line
res@xyLineThicknesses   = (/1,2/)                ; set second line to 2




;res                   = True                     ; plot mods desired
res@tiMainString      = "PM2.5"    ; add title
;res@xyMarkLineModes   = "Markers"                ; choose which have markers
;res@xyMarkers         =  16                      ; choose type of marker
;res@xyMarkerColor     = "black"                  ; Marker color
;res@xyMarkerSizeF     = 0.01                    ; Marker size (default 0.01)
res@gsnDraw  = False                             ; don't draw
res@gsnFrame = False                             ; don't advance frame
res@tmLabelAutoStride = True                     ; nice tick mark labels
res@tiXAxisString = "obs"  ; xaxis string
res@tiYAxisString = "sim"  ; yaxis string

res@trXMinF = 0
res@trXMaxF = 500
res@trYMinF = 0
res@trYMaxF = 500
plot = new(6,graphic)
plot(0)  = gsn_csm_xy (wks,pm25obs,data_pm25,res) ; create plot

res@tiMainString      = "PM10"    ; add title
res@trXMinF = 0
res@trXMaxF = 600
res@trYMinF = 0
res@trYMaxF = 600
plot(1)  = gsn_csm_xy (wks,pm10obs,data_pm10,res) ; create plot

res@tiMainString      = "CO"    ; add title
res@trXMinF = 0
res@trXMaxF = 4
res@trYMinF = 0
res@trYMaxF = 4
plot(2)  = gsn_csm_xy (wks,coobs,data_co,res) ; create plot

res@tiMainString      = "NO2"    ; add title
res@trXMinF = 0
res@trXMaxF = 150
res@trYMinF = 0
res@trYMaxF = 150
plot(3)  = gsn_csm_xy (wks,no2obs,data_no2,res) ; create plot

res@tiMainString      = "SO2"    ; add title
res@trXMinF = 0
res@trXMaxF = 50
res@trYMinF = 0
res@trYMaxF = 50
plot(4)  = gsn_csm_xy (wks,so2obs,data_so2,res) ; create plot

res@tiMainString      = "O3"    ; add title
res@trXMinF = 0
res@trXMaxF = 70
res@trYMinF = 0
res@trYMaxF = 70
plot(5)  = gsn_csm_xy (wks,o3obs,data_o3,res) ; create plot

gsn_panel(wks,plot,(/2,3/),False)             ; now draw as one plot
end
