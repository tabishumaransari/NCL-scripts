;THIS SCRIPT READS IN STATION DATA FROM YUANLIN AND WRF DATA AND CREATES A SCATTER PLOT
begin

obsarray = asciiread("/data1/tabish/surface_data/yuanlin_data/110000246.txt",-1,"string")

pm25obs_array = stringtofloat(str_get_cols(obsarray, 0,6))
pm10obs_array = stringtofloat(str_get_cols(obsarray, 8,14))
so2obs_array = stringtofloat(str_get_cols(obsarray, 16,22))
no2obs_array = stringtofloat(str_get_cols(obsarray, 24,30))
coobs_array = stringtofloat(str_get_cols(obsarray, 32,38))
o3obs_array = stringtofloat(str_get_cols(obsarray, 40,46))


print(pm25obs_array+" "+pm10obs_array+" "+so2obs_array+" "+no2obs_array+" "+coobs_array+" "+o3obs_array)
;NOW ENTIRE OBS ARRAYS HAVE BEEN LOADED. LETS CROP IN THE USEFUL DATA 12OCT000 BJT - 31OCT 2300 BJT, EXCLUDING 16OCT 0800 BJT
pm25obs = new(480,float)
pm10obs = new(480,float)
so2obs = new(480,float)
no2obs = new(480,float)
coobs = new(480,float)
o3obs = new(480,float)

pm25obs(0:103)   = pm25obs_array(6816:6919)
pm25obs(104:479) = pm25obs_array(6921:7296)

pm10obs(0:103)   = pm10obs_array(6816:6919)
pm10obs(104:479) = pm10obs_array(6921:7296)

so2obs(0:103)   = so2obs_array(6816:6919)
so2obs(104:479) = so2obs_array(6921:7296)

no2obs(0:103)   = no2obs_array(6816:6919)
no2obs(104:479) = no2obs_array(6921:7296)

coobs(0:103)   = coobs_array(6816:6919)
coobs(104:479) = coobs_array(6921:7296)

o3obs(0:103)   = o3obs_array(6816:6919)
o3obs(104:479) = o3obs_array(6921:7296)


DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=145
pm25sim_array    = a[:]->PM2_5_DRY(:,0,J,I)
pm10sim_array    = a[:]->PM10(:,0,J,I)
cosim_array      = a[:]->co(:,0,J,I)
no2sim_array     = a[:]->no2(:,0,J,I)
so2sim_array     = a[:]->so2(:,0,J,I)
o3sim_array      = a[:]->o3(:,0,J,I)

pm25sim = pm25sim_array(40:519)
pm10sim = pm10sim_array(40:519)
cosim   = cosim_array(40:519)
no2sim  = no2sim_array(40:519)
so2sim  = so2sim_array(40:519)
o3sim   = o3sim_array(40:519)

pm25obs = where(pm25obs.eq.0,pm25obs@_FillValue,pm25obs)
pm10obs = where(pm10obs.eq.0,pm10obs@_FillValue,pm10obs)
coobs   = where(coobs.lt.0.0,coobs@_FillValue,coobs/1.1642)
no2obs  = where(no2obs.eq.0,no2obs@_FillValue,no2obs/1.9125)
so2obs  = where(so2obs.eq.0,so2obs@_FillValue,so2obs/2.6609)
o3obs   = where(o3obs.eq.0,o3obs@_FillValue,o3obs/1.9957)

no2sim = 1000*no2sim
so2sim = 1000*so2sim
o3sim  = 1000*o3sim

;no2obs = 1000*no2obs
;so2obs = 1000*so2obs
;o3obs  = 1000*o3obs
print(no2obs+" "+no2sim)

if (any(isnan_ieee(pm25obs))) then
    if(.not.isatt(pm25obs,"_FillValue")) then
      pm25obs@_FillValue = default_fillvalue(typeof(pm25obs))
    end if
    replace_ieeenan (pm25obs, pm25obs@_FillValue, 0)
end if


if (any(isnan_ieee(pm10obs))) then
    if(.not.isatt(pm10obs,"_FillValue")) then
      pm10obs@_FillValue = default_fillvalue(typeof(pm10obs))
    end if
    replace_ieeenan (pm10obs, pm10obs@_FillValue, 0)
end if

if (any(isnan_ieee(coobs))) then
    if(.not.isatt(coobs,"_FillValue")) then
      coobs@_FillValue = default_fillvalue(typeof(coobs))
    end if
    replace_ieeenan (coobs, coobs@_FillValue, 0)
end if

if (any(isnan_ieee(no2obs))) then
    if(.not.isatt(no2obs,"_FillValue")) then
      no2obs@_FillValue = default_fillvalue(typeof(no2obs))
    end if
    replace_ieeenan (no2obs, no2obs@_FillValue, 0)
end if

if (any(isnan_ieee(so2obs))) then
    if(.not.isatt(so2obs,"_FillValue")) then
      so2obs@_FillValue = default_fillvalue(typeof(so2obs))
    end if
    replace_ieeenan (so2obs, so2obs@_FillValue, 0)
end if

if (any(isnan_ieee(o3obs))) then
    if(.not.isatt(o3obs,"_FillValue")) then
      o3obs@_FillValue = default_fillvalue(typeof(o3obs))
    end if
    replace_ieeenan (o3obs, o3obs@_FillValue, 0)
end if

;lat_array       = todouble(str_get_field(polstations,2," ")) ;extract 2nd column of the first file for LON
;lon_array       = todouble(str_get_field(polstations,3," ")) ;extract 3rd column of the first file for LAT
;print("PM2.5 OBS="+pm25obs_array+" PM2.5 SIM= "+pm25sim_array)
rc_pm25   = regline (pm25obs,pm25sim)
rc_pm10   = regline (pm10obs,pm10sim)
rc_co     = regline (coobs,cosim)
rc_no2    = regline (no2obs,no2sim)
rc_so2    = regline (so2obs,so2sim)
rc_o3     = regline (o3obs,o3sim)
pm25_rmse = decimalPlaces(dim_rmsd(pm25obs, pm25sim),2,True)
pm25_r = decimalPlaces(escorc(pm25obs, pm25sim),2,True)
pm10_rmse = decimalPlaces(dim_rmsd(pm10obs, pm10sim),2,True)
pm10_r = decimalPlaces(escorc(pm10obs, pm10sim),2,True)
co_rmse   = decimalPlaces(dim_rmsd(coobs, cosim),2,True)
co_r   = decimalPlaces(escorc(coobs, cosim),2,True)
so2_rmse  = decimalPlaces(dim_rmsd(so2obs, so2sim),2,True)
so2_r  = decimalPlaces(escorc(so2obs, so2sim),2,True)
no2_rmse  = decimalPlaces(dim_rmsd(no2obs, no2sim),2,True)
no2_r  = decimalPlaces(escorc(no2obs, no2sim),2,True)
o3_rmse   = decimalPlaces(dim_rmsd(o3obs, o3sim),2,True)
o3_r   = decimalPlaces(escorc(o3obs, o3sim),2,True)


rc_pm25  = decimalPlaces(rc_pm25 ,2,True)  
rc_pm10  = decimalPlaces(rc_pm10 ,2,True)  
rc_co  = decimalPlaces(rc_co ,2,True)  
rc_so2  = decimalPlaces(rc_so2 ,2,True)  
rc_no2  = decimalPlaces(rc_no2 ,2,True)  
rc_o3  = decimalPlaces(rc_o3 ,2,True)  

print(rc_pm25)
print(pm25_r)
print(pm25_rmse)
print(rc_pm10)
print(pm10_r)
print(pm10_rmse)
print(rc_co)
print(co_r)
print(co_rmse)
print(rc_no2)
print(no2_r)
print(no2_rmse)
print(rc_so2)
print(so2_r)
print(so2_rmse)
print(rc_o3)
print(o3_r)
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

wks   = gsn_open_wks ("png","scatterplots_Aoti")                ; send graphics to PNG file

res                     = True                   ; plot mods desired
res@gsnMaximize         = True                   ; maximize plot in frame
res@xyMarkLineModes     = (/"Markers","Lines"/)  ; choose which have markers
res@xyMarkers           = 16                     ; choose type of marker 
res@xyMarkerColor       = "red"                  ; Marker color
res@xyMarkerSizeF       = 0.005                  ; Marker size (default 0.01)
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
