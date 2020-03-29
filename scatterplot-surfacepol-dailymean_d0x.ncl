;THIS SCRIPT READS IN LARGE COMBINED SIM AND OBS ARRAYS FOR D01 AND CREATES A SCATTER PLOT
begin

obsarray = asciiread("corr-array-obs_Aoti",-1,"string")
simarray = asciiread("corr-array-sim_Aoti",-1,"string")

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

meanarraysize = dimsizes(pm25sim)/24
pm25simmean = new(meanarraysize, float)
pm25obsmean = new(meanarraysize, float)
pm10simmean = new(meanarraysize, float)
pm10obsmean = new(meanarraysize, float)
cosimmean = new(meanarraysize, float)
coobsmean = new(meanarraysize, float)
so2simmean = new(meanarraysize, float)
so2obsmean = new(meanarraysize, float)
no2simmean = new(meanarraysize, float)
no2obsmean = new(meanarraysize, float)
o3simmean = new(meanarraysize, float)
o3obsmean = new(meanarraysize, float)
count = 1

c1=0.0
c2=0.0
c3=0.0
c4=0.0
c5=0.0
c6=0.0

j=0
pm25simsum = 0.0
pm25obssum = 0.0
pm10simsum = 0.0
pm10obssum = 0.0
cosimsum = 0.0
coobssum = 0.0
so2simsum = 0.0
so2obssum = 0.0
no2simsum = 0.0
no2obssum = 0.0
o3simsum = 0.0
o3obssum = 0.0

do i =0, dimsizes(pm25sim)-1
 if(.not.ismissing(pm25obs(i))) then
   pm25simsum  = pm25simsum + pm25sim(i)
   pm25obssum  = pm25obssum + pm25obs(i)
   c1 = c1 + 1.0
 end if

 if(.not.ismissing(pm10obs(i))) then
   pm10simsum  = pm10simsum + pm10sim(i)
   pm10obssum  = pm10obssum + pm10obs(i)
   c2 = c2 +1.0
 end if

 if(.not.ismissing(coobs(i))) then
   cosimsum  = cosimsum + cosim(i)
   coobssum  = coobssum + coobs(i)
   c3 = c3 +1.0
 end if

 if(.not.ismissing(so2obs(i))) then
   so2simsum  = so2simsum + so2sim(i)
   so2obssum  = so2obssum + so2obs(i)
   c4 = c4 +1.0
 end if
 
 if(.not.ismissing(no2obs(i))) then 
   no2simsum  = no2simsum + no2sim(i)
   no2obssum  = no2obssum + no2obs(i)
   c5 = c5 +1.0
 end if

 if(.not.ismissing(o3obs(i))) then
   o3simsum  = o3simsum + o3sim(i)
   o3obssum  = o3obssum + o3obs(i)
   c6 = c6 +1.0
 end if

;print(count+" "+pm25obssum)
 if(count.eq.24) then
 
  if(c1.eq.0)then 
   pm25simmean(j) = pm25simmean@_FillValue
   pm25obsmean(j) = pm25obsmean@_FillValue
  else
   pm25simmean(j) = pm25simsum/c1
   pm25obsmean(j) = pm25obssum/c1  
  end if
 
  if(c2.eq.0)then
   pm10simmean(j) = pm10simmean@_FillValue
   pm10obsmean(j) = pm10obsmean@_FillValue
  else
   pm10simmean(j) = pm10simsum/c2
   pm10obsmean(j) = pm10obssum/c2
  end if
 
  if(c3.eq.0)then
   cosimmean(j) = cosimmean@_FillValue
   coobsmean(j) = coobsmean@_FillValue
  else
   cosimmean(j) = cosimsum/c3
   coobsmean(j) = coobssum/c3
  end if
 
  if(c4.eq.0)then
   so2simmean(j) = so2simmean@_FillValue
   so2obsmean(j) = so2obsmean@_FillValue
  else
   so2simmean(j) = so2simsum/c4
   so2obsmean(j) = so2obssum/c4
  end if
  
  if(c5.eq.0)then
   no2simmean(j) = no2simmean@_FillValue
   no2obsmean(j) = no2obsmean@_FillValue
  else
   no2simmean(j) = no2simsum/c5
   no2obsmean(j) = no2obssum/c5
  end if

  if(c6.eq.0)then
   o3simmean(j) = o3simmean@_FillValue
   o3obsmean(j) = o3obsmean@_FillValue
  else
   o3simmean(j) = o3simsum/c6
   o3obsmean(j) = o3obssum/c6
  end if

  j = j + 1
  count = 0
  c1=0.0
  c2=0.0
  c3=0.0
  c4=0.0
  c5=0.0
  c6=0.0
  pm25simsum = 0.0
  pm25obssum = 0.0
  pm10simsum = 0.0
  pm10obssum = 0.0
  cosimsum = 0.0
  coobssum = 0.0
  so2simsum = 0.0
  so2obssum = 0.0
  no2simsum = 0.0
  no2obssum = 0.0
  o3simsum = 0.0
  o3obssum = 0.0
 end if
 count = count + 1

print(count+" "+c1+" "+c2+" "+c3+" "+c4+" "+c5+" "+c6)
end do
;print(pm25obs+" "+pm25sim)
rc_pm25   = decimalPlaces(regline (pm25obsmean,pm25simmean),2,True)
rc_pm10   = decimalPlaces(regline (pm10obsmean,pm10simmean),2,True)
rc_co     = decimalPlaces(regline (coobsmean,cosimmean),2,True)
rc_no2    = decimalPlaces(regline (no2obsmean,no2simmean),2,True)
rc_so2    = decimalPlaces(regline (so2obsmean,so2simmean),2,True)
rc_o3     = decimalPlaces(regline (o3obsmean,o3simmean),2,True)

r_pm25   = decimalPlaces(escorc (pm25obsmean,pm25simmean),2,True)
r_pm10   = decimalPlaces(escorc (pm10obsmean,pm10simmean),2,True)
r_co     = decimalPlaces(escorc (coobsmean,cosimmean),2,True)
r_no2    = decimalPlaces(escorc (no2obsmean,no2simmean),2,True)
r_so2    = decimalPlaces(escorc (so2obsmean,so2simmean),2,True)
r_o3     = decimalPlaces(escorc (o3obsmean,o3simmean),2,True)

pm25_rmse = decimalPlaces(dim_rmsd(pm25obsmean, pm25simmean),2,True)
pm10_rmse = decimalPlaces(dim_rmsd(pm10obsmean, pm10simmean),2,True)
co_rmse   = decimalPlaces(dim_rmsd(coobsmean, cosimmean),2,True)
so2_rmse  = decimalPlaces(dim_rmsd(so2obsmean, so2simmean),2,True)
no2_rmse  = decimalPlaces(dim_rmsd(no2obsmean, no2simmean),2,True)
o3_rmse   = decimalPlaces(dim_rmsd(o3obsmean, o3simmean),2,True)


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
data_pm25      = new ( (/2,dimsizes(pm25simmean)/), typeof(pm25simmean))
data_pm10      = new ( (/2,dimsizes(pm10simmean)/), typeof(pm10simmean))
data_co        = new ( (/2,dimsizes(cosimmean)/), typeof(cosimmean))
data_so2       = new ( (/2,dimsizes(so2simmean)/), typeof(so2simmean))
data_no2       = new ( (/2,dimsizes(no2simmean)/), typeof(no2simmean))
data_o3        = new ( (/2,dimsizes(o3simmean)/), typeof(o3simmean))
data_pm25(0,:) = pm25simmean
data_pm25(1,:) = rc_pm25*(pm25obsmean-rc_pm25@xave) + rc_pm25@yave
data_pm10(0,:) = pm10simmean
data_pm10(1,:) = rc_pm10*(pm10obsmean-rc_pm10@xave) + rc_pm10@yave
data_co(0,:) = cosimmean
data_co(1,:) = rc_co*(coobsmean-rc_co@xave) + rc_co@yave
data_so2(0,:) = so2simmean
data_so2(1,:) = rc_so2*(so2obsmean-rc_so2@xave) + rc_so2@yave
data_no2(0,:) = no2simmean
data_no2(1,:) = rc_no2*(no2obsmean-rc_no2@xave) + rc_no2@yave
data_o3(0,:) = o3simmean
data_o3(1,:) = rc_o3*(o3obsmean-rc_o3@xave) + rc_o3@yave

wks   = gsn_open_wks ("png","scatterplotsdailymean_Aoti")                ; send graphics to PNG file

res                     = True                   ; plot mods desired
res@gsnMaximize         = True                   ; maximize plot in frame
res@xyMarkLineModes     = (/"Markers","Lines"/)  ; choose which have markers
res@xyMarkers           = 16                     ; choose type of marker
res@xyMarkerColor       = "red"                  ; Marker color
res@xyMarkerSizeF       = 0.01                  ; Marker size (default 0.01)
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
res@trXMaxF = 200
res@trYMinF = 0
res@trYMaxF = 200
plot = new(6,graphic)
plot(0)  = gsn_csm_xy (wks,pm25obsmean,data_pm25,res) ; create plot

res@tiMainString      = "PM10"    ; add title
res@trXMinF = 0
res@trXMaxF = 200
res@trYMinF = 0
res@trYMaxF = 200
plot(1)  = gsn_csm_xy (wks,pm10obsmean,data_pm10,res) ; create plot

res@tiMainString      = "CO"    ; add title
res@trXMinF = 0
res@trXMaxF = 2
res@trYMinF = 0
res@trYMaxF = 2
plot(2)  = gsn_csm_xy (wks,coobsmean,data_co,res) ; create plot

res@tiMainString      = "NO2"    ; add title
res@trXMinF = 0
res@trXMaxF = 70
res@trYMinF = 0
res@trYMaxF = 70
plot(3)  = gsn_csm_xy (wks,no2obsmean,data_no2,res) ; create plot

res@tiMainString      = "SO2"    ; add title
res@trXMinF = 0
res@trXMaxF = 40
res@trYMinF = 0
res@trYMaxF = 40
plot(4)  = gsn_csm_xy (wks,so2obsmean,data_so2,res) ; create plot

res@tiMainString      = "O3"    ; add title
res@trXMinF = 0
res@trXMaxF = 20
res@trYMinF = 0
res@trYMaxF = 20
plot(5)  = gsn_csm_xy (wks,o3obsmean,data_o3,res) ; create plot

gsn_panel(wks,plot,(/2,3/),False)             ; now draw as one plot
end

