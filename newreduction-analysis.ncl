; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25obs      = data(:,0)
pm25baseline = data(:,1)
pm25novcontrols = data(:,2)
pm25octcontrols = data(:,3)

baseline_array = new(480,float)
pcbenefit_array = new(480,float)
c=0

do i = 96, 335 ;OCT LOOP
 baseline = pm25baseline(i)
 controls = pm25octcontrols(i)
 benefit = baseline - controls
 if(benefit.lt.0) then 
  benefit =0.0
 end if
 pcbenefit = (benefit/baseline)*100.0
 print("baseline="+baseline+" %age benefit="+pcbenefit)
 baseline_array(c) = baseline
 pcbenefit_array(c) = pcbenefit
 c = c + 1
end do

do i = 527, 766 ;NOV LOOP
 baseline = pm25baseline(i)
 controls = pm25novcontrols(i)
 benefit = baseline - controls
 if(benefit.lt.0) then
  benefit =0.0
 end if
 pcbenefit = (benefit/baseline)*100.0
 print("baseline="+baseline+" %age benefit="+pcbenefit)
 baseline_array(c) = baseline
 pcbenefit_array(c) = pcbenefit
 c = c + 1
end do

wks   = gsn_open_wks ("pdf","scatterplot_baseline-vs-pcbenefit")                ; send graphics to PNG file

res                   = True                     ; plot mods desired
res@tiMainString      = "16-25 Oct and 3-12 Nov"           ; add title
res@xyMarkLineModes   = "Markers"                ; choose which have markers
res@xyMarkers         =  16                      ; choose type of marker
res@xyMarkerColor     = "black"                    ; Marker color
res@xyMarkerSizeF     = 0.005                     ; Marker size (default 0.01)
res@gsnDraw  = False                          ; don't draw
res@gsnFrame = False                          ; don't advance frame
res@tmLabelAutoStride = True                     ; nice tick mark labels
;res@tmXBMajorOutwardLengthF  =0.0
;res@tmXBMinorOutwardLengthF  =0.0
;res@tmYLMajorOutwardLengthF  =0.0
;res@tmYLMinorOutwardLengthF  =0.0
res@gsnDraw  = False                             ; don't draw
res@gsnFrame = False                             ; don't advance frame

res@tiXAxisString = "baseline concentration"  ; xaxis string
res@tiYAxisString = "%age benefit"  ; yaxis string

plot = new(3,graphic)
plot(0)  = gsn_csm_xy (wks,baseline_array,pcbenefit_array,res) ; create plot
res@tiMainString      = "23-25 Oct"           ; add title
plot(1)  = gsn_csm_xy (wks,baseline_array(168:239),pcbenefit_array(168:239),res) ; create plot
res@tiMainString      = "10-12 Nov"           ; add title
plot(2)  = gsn_csm_xy (wks,baseline_array(408:479),pcbenefit_array(408:479),res) ; create plot


gsn_panel(wks,plot,(/1,3/),False)             ; now draw as one plot



end
