begin
ncol = 20
pm25_Beijing_Oct = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Oct = readAsciiTable("pm25_pulseruns_APEC3_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_Beijing_Nov = readAsciiTable("pm25_pulseruns_Beijing_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Nov = readAsciiTable("pm25_pulseruns_APEC3_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

pm25_Beijing_Oct_matrix = new((/10,120/),float)
pm25_Beijing_Oct_matrix_normalized = new((/10,120/),float)
pm25_APEC3_Oct_matrix = new((/10,120/),float)
pm25_APEC3_Oct_matrix_normalized = new((/10,120/),float)

pm25_Beijing_Nov_matrix = new((/10,120/),float)
pm25_Beijing_Nov_matrix_normalized = new((/10,120/),float)
pm25_APEC3_Nov_matrix = new((/10,120/),float)
pm25_APEC3_Nov_matrix_normalized = new((/10,120/),float)

pm25_Beijing_matrix = new((/20,120/),float)
pm25_Beijing_matrix_normalized = new((/20,120/),float)
pm25_APEC3_matrix = new((/20,120/),float)
pm25_APEC3_matrix_normalized = new((/20,120/),float)

pm25_Beijing_stats            = new((/30,120/),float)
pm25_Beijing_normalized_stats = new((/30,120/),float)
pm25_APEC3_stats              = new((/30,120/),float)
pm25_APEC3_normalized_stats   = new((/30,120/),float)

pm25_Beijing_mean            = new(120,float)
pm25_Beijing_min             = new(120,float)
pm25_Beijing_max             = new(120,float)
pm25_Beijing_normalized_mean = new(120,float)
pm25_Beijing_normalized_min  = new(120,float)
pm25_Beijing_normalized_max  = new(120,float)
pm25_APEC3_mean              = new(120,float)
pm25_APEC3_min               = new(120,float)
pm25_APEC3_max               = new(120,float)
pm25_APEC3_normalized_mean   = new(120,float)
pm25_APEC3_normalized_min    = new(120,float)
pm25_APEC3_normalized_max    = new(120,float)

pm25_Beijing_min = where(pm25_Beijing_min.lt.0,0,pm25_Beijing_min)
pm25_Beijing_normalized_min = where(pm25_Beijing_normalized_min.lt.0,0,pm25_Beijing_min)
pm25_APEC3_min = where(pm25_APEC3_min.lt.0,0,pm25_APEC3_min)
pm25_APEC3_normalized_min = where(pm25_APEC3_normalized_min.lt.0,0,pm25_APEC3_min)


;;;;;;;;;;;;;;;;;;;FOR OCTOBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_Oct18B = pm25_Beijing_Oct(:,0)
pm25_Beijing_Oct18P = pm25_Beijing_Oct(:,1)
pm25_Beijing_Oct19B = pm25_Beijing_Oct(:,2)
pm25_Beijing_Oct19P = pm25_Beijing_Oct(:,3)
pm25_Beijing_Oct20B = pm25_Beijing_Oct(:,4)
pm25_Beijing_Oct20P = pm25_Beijing_Oct(:,5)
pm25_Beijing_Oct21B = pm25_Beijing_Oct(:,6)
pm25_Beijing_Oct21P = pm25_Beijing_Oct(:,7)
pm25_Beijing_Oct22B = pm25_Beijing_Oct(:,8)
pm25_Beijing_Oct22P = pm25_Beijing_Oct(:,9)
pm25_Beijing_Oct23B = pm25_Beijing_Oct(:,10)
pm25_Beijing_Oct23P = pm25_Beijing_Oct(:,11)
pm25_Beijing_Oct24B = pm25_Beijing_Oct(:,12)
pm25_Beijing_Oct24P = pm25_Beijing_Oct(:,13)
pm25_Beijing_Oct25B = pm25_Beijing_Oct(:,14)
pm25_Beijing_Oct25P = pm25_Beijing_Oct(:,15)
pm25_Beijing_Oct26B = pm25_Beijing_Oct(:,16)
pm25_Beijing_Oct26P = pm25_Beijing_Oct(:,17)
pm25_Beijing_Oct27B = pm25_Beijing_Oct(:,18)
pm25_Beijing_Oct27P = pm25_Beijing_Oct(:,19)
pm25_Beijing_Oct_matrix(0,:) = pm25_Beijing_Oct18B - pm25_Beijing_Oct18P
pm25_Beijing_Oct_matrix(1,:) = pm25_Beijing_Oct19B - pm25_Beijing_Oct19P
pm25_Beijing_Oct_matrix(2,:) = pm25_Beijing_Oct20B - pm25_Beijing_Oct20P
pm25_Beijing_Oct_matrix(3,:) = pm25_Beijing_Oct21B - pm25_Beijing_Oct21P
pm25_Beijing_Oct_matrix(4,:) = pm25_Beijing_Oct22B - pm25_Beijing_Oct22P
pm25_Beijing_Oct_matrix(5,:) = pm25_Beijing_Oct23B - pm25_Beijing_Oct23P
pm25_Beijing_Oct_matrix(6,:) = pm25_Beijing_Oct24B - pm25_Beijing_Oct24P
pm25_Beijing_Oct_matrix(7,:) = pm25_Beijing_Oct25B - pm25_Beijing_Oct25P
pm25_Beijing_Oct_matrix(8,:) = pm25_Beijing_Oct26B - pm25_Beijing_Oct26P
pm25_Beijing_Oct_matrix(9,:) = pm25_Beijing_Oct27B - pm25_Beijing_Oct27P
pm25_Beijing_Oct_matrix_normalized(0,:) = 100.0*(pm25_Beijing_Oct18B - pm25_Beijing_Oct18P)/pm25_Beijing_Oct18B
pm25_Beijing_Oct_matrix_normalized(1,:) = 100.0*(pm25_Beijing_Oct19B - pm25_Beijing_Oct19P)/pm25_Beijing_Oct19B
pm25_Beijing_Oct_matrix_normalized(2,:) = 100.0*(pm25_Beijing_Oct20B - pm25_Beijing_Oct20P)/pm25_Beijing_Oct20B
pm25_Beijing_Oct_matrix_normalized(3,:) = 100.0*(pm25_Beijing_Oct21B - pm25_Beijing_Oct21P)/pm25_Beijing_Oct21B
pm25_Beijing_Oct_matrix_normalized(4,:) = 100.0*(pm25_Beijing_Oct22B - pm25_Beijing_Oct22P)/pm25_Beijing_Oct22B
pm25_Beijing_Oct_matrix_normalized(5,:) = 100.0*(pm25_Beijing_Oct23B - pm25_Beijing_Oct23P)/pm25_Beijing_Oct23B
pm25_Beijing_Oct_matrix_normalized(6,:) = 100.0*(pm25_Beijing_Oct24B - pm25_Beijing_Oct24P)/pm25_Beijing_Oct24B
pm25_Beijing_Oct_matrix_normalized(7,:) = 100.0*(pm25_Beijing_Oct25B - pm25_Beijing_Oct25P)/pm25_Beijing_Oct25B
pm25_Beijing_Oct_matrix_normalized(8,:) = 100.0*(pm25_Beijing_Oct26B - pm25_Beijing_Oct26P)/pm25_Beijing_Oct26B
pm25_Beijing_Oct_matrix_normalized(9,:) = 100.0*(pm25_Beijing_Oct27B - pm25_Beijing_Oct27P)/pm25_Beijing_Oct27B



pm25_APEC3_Oct18B = pm25_APEC3_Oct(:,0)
pm25_APEC3_Oct18P = pm25_APEC3_Oct(:,1)
pm25_APEC3_Oct19B = pm25_APEC3_Oct(:,2)
pm25_APEC3_Oct19P = pm25_APEC3_Oct(:,3)
pm25_APEC3_Oct20B = pm25_APEC3_Oct(:,4)
pm25_APEC3_Oct20P = pm25_APEC3_Oct(:,5)
pm25_APEC3_Oct21B = pm25_APEC3_Oct(:,6)
pm25_APEC3_Oct21P = pm25_APEC3_Oct(:,7)
pm25_APEC3_Oct22B = pm25_APEC3_Oct(:,8)
pm25_APEC3_Oct22P = pm25_APEC3_Oct(:,9)
pm25_APEC3_Oct23B = pm25_APEC3_Oct(:,10)
pm25_APEC3_Oct23P = pm25_APEC3_Oct(:,11)
pm25_APEC3_Oct24B = pm25_APEC3_Oct(:,12)
pm25_APEC3_Oct24P = pm25_APEC3_Oct(:,13)
pm25_APEC3_Oct25B = pm25_APEC3_Oct(:,14)
pm25_APEC3_Oct25P = pm25_APEC3_Oct(:,15)
pm25_APEC3_Oct26B = pm25_APEC3_Oct(:,16)
pm25_APEC3_Oct26P = pm25_APEC3_Oct(:,17)
pm25_APEC3_Oct27B = pm25_APEC3_Oct(:,18)
pm25_APEC3_Oct27P = pm25_APEC3_Oct(:,19)
pm25_APEC3_Oct_matrix(0,:) = pm25_APEC3_Oct18B - pm25_APEC3_Oct18P
pm25_APEC3_Oct_matrix(1,:) = pm25_APEC3_Oct19B - pm25_APEC3_Oct19P
pm25_APEC3_Oct_matrix(2,:) = pm25_APEC3_Oct20B - pm25_APEC3_Oct20P
pm25_APEC3_Oct_matrix(3,:) = pm25_APEC3_Oct21B - pm25_APEC3_Oct21P
pm25_APEC3_Oct_matrix(4,:) = pm25_APEC3_Oct22B - pm25_APEC3_Oct22P
pm25_APEC3_Oct_matrix(5,:) = pm25_APEC3_Oct23B - pm25_APEC3_Oct23P
pm25_APEC3_Oct_matrix(6,:) = pm25_APEC3_Oct24B - pm25_APEC3_Oct24P
pm25_APEC3_Oct_matrix(7,:) = pm25_APEC3_Oct25B - pm25_APEC3_Oct25P
pm25_APEC3_Oct_matrix(8,:) = pm25_APEC3_Oct26B - pm25_APEC3_Oct26P
pm25_APEC3_Oct_matrix(9,:) = pm25_APEC3_Oct27B - pm25_APEC3_Oct27P
pm25_APEC3_Oct_matrix_normalized(0,:) = 100.0*(pm25_APEC3_Oct18B - pm25_APEC3_Oct18P)/pm25_APEC3_Oct18B
pm25_APEC3_Oct_matrix_normalized(1,:) = 100.0*(pm25_APEC3_Oct19B - pm25_APEC3_Oct19P)/pm25_APEC3_Oct19B
pm25_APEC3_Oct_matrix_normalized(2,:) = 100.0*(pm25_APEC3_Oct20B - pm25_APEC3_Oct20P)/pm25_APEC3_Oct20B
pm25_APEC3_Oct_matrix_normalized(3,:) = 100.0*(pm25_APEC3_Oct21B - pm25_APEC3_Oct21P)/pm25_APEC3_Oct21B
pm25_APEC3_Oct_matrix_normalized(4,:) = 100.0*(pm25_APEC3_Oct22B - pm25_APEC3_Oct22P)/pm25_APEC3_Oct22B
pm25_APEC3_Oct_matrix_normalized(5,:) = 100.0*(pm25_APEC3_Oct23B - pm25_APEC3_Oct23P)/pm25_APEC3_Oct23B
pm25_APEC3_Oct_matrix_normalized(6,:) = 100.0*(pm25_APEC3_Oct24B - pm25_APEC3_Oct24P)/pm25_APEC3_Oct24B
pm25_APEC3_Oct_matrix_normalized(7,:) = 100.0*(pm25_APEC3_Oct25B - pm25_APEC3_Oct25P)/pm25_APEC3_Oct25B
pm25_APEC3_Oct_matrix_normalized(8,:) = 100.0*(pm25_APEC3_Oct26B - pm25_APEC3_Oct26P)/pm25_APEC3_Oct26B
pm25_APEC3_Oct_matrix_normalized(9,:) = 100.0*(pm25_APEC3_Oct27B - pm25_APEC3_Oct27P)/pm25_APEC3_Oct27B

;;;;;;;;;;;FOR NOVEMBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_Nov2B = pm25_Beijing_Nov(:,0)
pm25_Beijing_Nov2P = pm25_Beijing_Nov(:,1)
pm25_Beijing_Nov3B = pm25_Beijing_Nov(:,2)
pm25_Beijing_Nov3P = pm25_Beijing_Nov(:,3)
pm25_Beijing_Nov4B = pm25_Beijing_Nov(:,4)
pm25_Beijing_Nov4P = pm25_Beijing_Nov(:,5)
pm25_Beijing_Nov5B = pm25_Beijing_Nov(:,6)
pm25_Beijing_Nov5P = pm25_Beijing_Nov(:,7)
pm25_Beijing_Nov6B = pm25_Beijing_Nov(:,8)
pm25_Beijing_Nov6P = pm25_Beijing_Nov(:,9)
pm25_Beijing_Nov7B = pm25_Beijing_Nov(:,10)
pm25_Beijing_Nov7P = pm25_Beijing_Nov(:,11)
pm25_Beijing_Nov8B = pm25_Beijing_Nov(:,12)
pm25_Beijing_Nov8P = pm25_Beijing_Nov(:,13)
pm25_Beijing_Nov9B = pm25_Beijing_Nov(:,14)
pm25_Beijing_Nov9P = pm25_Beijing_Nov(:,15)
pm25_Beijing_Nov10B = pm25_Beijing_Nov(:,16)
pm25_Beijing_Nov10P = pm25_Beijing_Nov(:,17)
pm25_Beijing_Nov11B = pm25_Beijing_Nov(:,18)
pm25_Beijing_Nov11P = pm25_Beijing_Nov(:,19)
pm25_Beijing_Nov_matrix(0,:) = pm25_Beijing_Nov2B - pm25_Beijing_Nov2P
pm25_Beijing_Nov_matrix(1,:) = pm25_Beijing_Nov3B - pm25_Beijing_Nov3P
pm25_Beijing_Nov_matrix(2,:) = pm25_Beijing_Nov4B - pm25_Beijing_Nov4P
pm25_Beijing_Nov_matrix(3,:) = pm25_Beijing_Nov5B - pm25_Beijing_Nov5P
pm25_Beijing_Nov_matrix(4,:) = pm25_Beijing_Nov6B - pm25_Beijing_Nov6P
pm25_Beijing_Nov_matrix(5,:) = pm25_Beijing_Nov7B - pm25_Beijing_Nov7P
pm25_Beijing_Nov_matrix(6,:) = pm25_Beijing_Nov8B - pm25_Beijing_Nov8P
pm25_Beijing_Nov_matrix(7,:) = pm25_Beijing_Nov9B - pm25_Beijing_Nov9P
pm25_Beijing_Nov_matrix(8,:) = pm25_Beijing_Nov10B - pm25_Beijing_Nov10P
pm25_Beijing_Nov_matrix(9,:) = pm25_Beijing_Nov11B - pm25_Beijing_Nov11P
pm25_Beijing_Nov_matrix_normalized(0,:) = 100.0*(pm25_Beijing_Nov2B - pm25_Beijing_Nov2P)/pm25_Beijing_Nov2B
pm25_Beijing_Nov_matrix_normalized(1,:) = 100.0*(pm25_Beijing_Nov3B - pm25_Beijing_Nov3P)/pm25_Beijing_Nov3B
pm25_Beijing_Nov_matrix_normalized(2,:) = 100.0*(pm25_Beijing_Nov4B - pm25_Beijing_Nov4P)/pm25_Beijing_Nov4B
pm25_Beijing_Nov_matrix_normalized(3,:) = 100.0*(pm25_Beijing_Nov5B - pm25_Beijing_Nov5P)/pm25_Beijing_Nov5B
pm25_Beijing_Nov_matrix_normalized(4,:) = 100.0*(pm25_Beijing_Nov6B - pm25_Beijing_Nov6P)/pm25_Beijing_Nov6B
pm25_Beijing_Nov_matrix_normalized(5,:) = 100.0*(pm25_Beijing_Nov7B - pm25_Beijing_Nov7P)/pm25_Beijing_Nov7B
pm25_Beijing_Nov_matrix_normalized(6,:) = 100.0*(pm25_Beijing_Nov8B - pm25_Beijing_Nov8P)/pm25_Beijing_Nov8B
pm25_Beijing_Nov_matrix_normalized(7,:) = 100.0*(pm25_Beijing_Nov9B - pm25_Beijing_Nov9P)/pm25_Beijing_Nov9B
pm25_Beijing_Nov_matrix_normalized(8,:) = 100.0*(pm25_Beijing_Nov10B - pm25_Beijing_Nov10P)/pm25_Beijing_Nov10B
pm25_Beijing_Nov_matrix_normalized(9,:) = 100.0*(pm25_Beijing_Nov11B - pm25_Beijing_Nov11P)/pm25_Beijing_Nov11B

pm25_APEC3_Nov2B = pm25_APEC3_Nov(:,0)
pm25_APEC3_Nov2P = pm25_APEC3_Nov(:,1)
pm25_APEC3_Nov3B = pm25_APEC3_Nov(:,2)
pm25_APEC3_Nov3P = pm25_APEC3_Nov(:,3)
pm25_APEC3_Nov4B = pm25_APEC3_Nov(:,4)
pm25_APEC3_Nov4P = pm25_APEC3_Nov(:,5)
pm25_APEC3_Nov5B = pm25_APEC3_Nov(:,6)
pm25_APEC3_Nov5P = pm25_APEC3_Nov(:,7)
pm25_APEC3_Nov6B = pm25_APEC3_Nov(:,8)
pm25_APEC3_Nov6P = pm25_APEC3_Nov(:,9)
pm25_APEC3_Nov7B = pm25_APEC3_Nov(:,10)
pm25_APEC3_Nov7P = pm25_APEC3_Nov(:,11)
pm25_APEC3_Nov8B = pm25_APEC3_Nov(:,12)
pm25_APEC3_Nov8P = pm25_APEC3_Nov(:,13)
pm25_APEC3_Nov9B = pm25_APEC3_Nov(:,14)
pm25_APEC3_Nov9P = pm25_APEC3_Nov(:,15)
pm25_APEC3_Nov10B = pm25_APEC3_Nov(:,16)
pm25_APEC3_Nov10P = pm25_APEC3_Nov(:,17)
pm25_APEC3_Nov11B = pm25_APEC3_Nov(:,18)
pm25_APEC3_Nov11P = pm25_APEC3_Nov(:,19)
pm25_APEC3_Nov_matrix(0,:) = pm25_APEC3_Nov2B - pm25_APEC3_Nov2P
pm25_APEC3_Nov_matrix(1,:) = pm25_APEC3_Nov3B - pm25_APEC3_Nov3P
pm25_APEC3_Nov_matrix(2,:) = pm25_APEC3_Nov4B - pm25_APEC3_Nov4P
pm25_APEC3_Nov_matrix(3,:) = pm25_APEC3_Nov5B - pm25_APEC3_Nov5P
pm25_APEC3_Nov_matrix(4,:) = pm25_APEC3_Nov6B - pm25_APEC3_Nov6P
pm25_APEC3_Nov_matrix(5,:) = pm25_APEC3_Nov7B - pm25_APEC3_Nov7P
pm25_APEC3_Nov_matrix(6,:) = pm25_APEC3_Nov8B - pm25_APEC3_Nov8P
pm25_APEC3_Nov_matrix(7,:) = pm25_APEC3_Nov9B - pm25_APEC3_Nov9P
pm25_APEC3_Nov_matrix(8,:) = pm25_APEC3_Nov10B - pm25_APEC3_Nov10P
pm25_APEC3_Nov_matrix(9,:) = pm25_APEC3_Nov11B - pm25_APEC3_Nov11P
pm25_APEC3_Nov_matrix_normalized(0,:) = 100.0*(pm25_APEC3_Nov2B - pm25_APEC3_Nov2P)/pm25_APEC3_Nov2B
pm25_APEC3_Nov_matrix_normalized(1,:) = 100.0*(pm25_APEC3_Nov3B - pm25_APEC3_Nov3P)/pm25_APEC3_Nov3B
pm25_APEC3_Nov_matrix_normalized(2,:) = 100.0*(pm25_APEC3_Nov4B - pm25_APEC3_Nov4P)/pm25_APEC3_Nov4B
pm25_APEC3_Nov_matrix_normalized(3,:) = 100.0*(pm25_APEC3_Nov5B - pm25_APEC3_Nov5P)/pm25_APEC3_Nov5B
pm25_APEC3_Nov_matrix_normalized(4,:) = 100.0*(pm25_APEC3_Nov6B - pm25_APEC3_Nov6P)/pm25_APEC3_Nov6B
pm25_APEC3_Nov_matrix_normalized(5,:) = 100.0*(pm25_APEC3_Nov7B - pm25_APEC3_Nov7P)/pm25_APEC3_Nov7B
pm25_APEC3_Nov_matrix_normalized(6,:) = 100.0*(pm25_APEC3_Nov8B - pm25_APEC3_Nov8P)/pm25_APEC3_Nov8B
pm25_APEC3_Nov_matrix_normalized(7,:) = 100.0*(pm25_APEC3_Nov9B - pm25_APEC3_Nov9P)/pm25_APEC3_Nov9B
pm25_APEC3_Nov_matrix_normalized(8,:) = 100.0*(pm25_APEC3_Nov10B - pm25_APEC3_Nov10P)/pm25_APEC3_Nov10B
pm25_APEC3_Nov_matrix_normalized(9,:) = 100.0*(pm25_APEC3_Nov11B - pm25_APEC3_Nov11P)/pm25_APEC3_Nov11B


;NOW POPULATING THE APPENDED ARRAYS FOR OCT-NOV COMBINED
pm25_Beijing_matrix(0:9,:)   = pm25_Beijing_Oct_matrix 
pm25_Beijing_matrix(10:19,:) = pm25_Beijing_Nov_matrix 
pm25_Beijing_matrix_normalized(0:9,:)   = pm25_Beijing_Oct_matrix_normalized
pm25_Beijing_matrix_normalized(10:19,:) = pm25_Beijing_Nov_matrix_normalized
pm25_APEC3_matrix(0:9,:)   = pm25_APEC3_Oct_matrix
pm25_APEC3_matrix(10:19,:) = pm25_APEC3_Nov_matrix
pm25_APEC3_matrix_normalized(0:9,:)   = pm25_APEC3_Oct_matrix_normalized
pm25_APEC3_matrix_normalized(10:19,:) = pm25_APEC3_Nov_matrix_normalized


;CALCULATING STATS PER HOUR
opt = True
opt@PrintStat = True
do i =0,119
 pm25_Beijing_stats(:,i)            = stat_dispersion(pm25_Beijing_matrix(:,i), opt)
 pm25_Beijing_normalized_stats(:,i) = stat_dispersion(pm25_Beijing_matrix_normalized(:,i), opt)
 pm25_APEC3_stats(:,i)              = stat_dispersion(pm25_APEC3_matrix(:,i), opt)
 pm25_APEC3_normalized_stats(:,i)   = stat_dispersion(pm25_APEC3_matrix_normalized(:,i), opt)
end do

;SAVING USEFUL STATS IN RESPECTIVE ARRAYS
pm25_Beijing_mean            = pm25_Beijing_stats(0,:)
pm25_Beijing_min             = pm25_Beijing_stats(2,:)
pm25_Beijing_max             = pm25_Beijing_stats(14,:)
pm25_Beijing_normalized_mean = pm25_Beijing_normalized_stats(0,:)
pm25_Beijing_normalized_min  = pm25_Beijing_normalized_stats(2,:)
pm25_Beijing_normalized_max  = pm25_Beijing_normalized_stats(14,:)
pm25_APEC3_mean              = pm25_APEC3_stats(0,:)
pm25_APEC3_min               = pm25_APEC3_stats(2,:)
pm25_APEC3_max               = pm25_APEC3_stats(14,:)
pm25_APEC3_normalized_mean   = pm25_APEC3_normalized_stats(0,:)
pm25_APEC3_normalized_min    = pm25_APEC3_normalized_stats(2,:)
pm25_APEC3_normalized_max    = pm25_APEC3_normalized_stats(14,:)







timearr = ispan(0,119,1)

;---Start the graphics
wks = gsn_open_wks("pdf","plot13_pm25_APEC3_Oct_abs") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC3 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
s1      = (/"blue","navy","purple","magenta","deeppink","red","brown","maroon","darkseagreen","green" /)          ; change line color
res@trXMaxF=max(timearr)
res@trYMinF     =  0
res@trYMaxF     =  16
res@tiMainString       = "PM2.5 absolute benefit due to APEC3 controls in October"
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.04
  res@tmYLLabelFontHeightF = 0.04
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmXBMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
 res@xyLabelMode           = "Custom"           ; label a line
  s                         =  (/"18-22","19-23","20-24","21-25","22-26","23-27","24-28","25-29","26-30","27-31"/)            ; text to use
;  s                         =  (/"2-6","3-7","4-8","5-9","6-10","7-11","8-12","9-13","10-14","11-15"/)            ; text to use
res@xyLineLabelFontHeightF = 0.020              ; font height
 res@xyLineLabelFontColor   = "red"              ; label color
  res@tiYAxisString = "PM2.5 (ug/m3)"


res@tmXBMode = "Explicit"
res@tmXBMinorValues = ispan(0,119,1)
res@tmXBValues = (/0,24,48,72,96,120/)
res@tmXBLabels = (/"Day 1","Day 2","Day 3","Day 4","Day 5","Day 6"/)


res@gsnDraw = False
res@gsnFrame = False
plot = new(10,graphic)
tt = fspan(.5,0.9,10)    ; you will likely want to modify this
do gg = 0,9
    res@xyLineDashSegLenF = tt(gg)
    res@xyExplicitLabels = s(gg)
    res@xyLineColors = s1(0)
    plot(gg) = gsn_csm_xy(wks,timearr,pm25_APEC3_Oct_matrix(gg,:),res)
    if (gg.ge.1) then
       overlay(plot(0),plot(gg))
    end if
end do
draw(plot)
frame(wks)
end
