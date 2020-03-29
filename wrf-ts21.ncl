;TIME-SERIES FOR IAP DATA FOR OCT21-25

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

pm25_sim =new(120,float)  
pm10_sim =new(120,float)  
pmcoarse_sim =new(120,float)  
co_sim =new(120,float)  
no2_sim =new(120,float)  
so2_sim =new(120,float)  
o3_sim =new(120,float)  
pm25_obs =new(120,float)  
pm10_obs =new(120,float)  
pmcoarse_obs =new(120,float)  
co_obs =new(120,float)  
no2_obs =new(120,float)  
so2_obs =new(120,float)  
o3_obs =new(120,float)  

DATADir = "/data3/tabish/YSU-nudged-0.5so20.7nox/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
times  = wrf_times_c(a[:]->Times,0)
;print(times)
;times_crop = times(16:135)
I=79
J=144
so4_sim   = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) +a[:]->so4_a03(:,0,J,I) +a[:]->so4_a04(:,0,J,I) +a[:]->so4_a05(:,0,J,I) +a[:]->so4_a06(:,0,J,I) +a[:]->so4_a07(:,0,J,I) +a[:]->so4_a08(:,0,J,I) 
no3_sim   = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) +a[:]->no3_a03(:,0,J,I) +a[:]->no3_a04(:,0,J,I) +a[:]->no3_a05(:,0,J,I) +a[:]->no3_a06(:,0,J,I) +a[:]->no3_a07(:,0,J,I) +a[:]->no3_a08(:,0,J,I) 
nh4_sim   = a[:]->nh4_a01(:,0,J,I) + a[:]->nh4_a02(:,0,J,I) +a[:]->nh4_a03(:,0,J,I) +a[:]->nh4_a04(:,0,J,I) +a[:]->nh4_a05(:,0,J,I) +a[:]->nh4_a06(:,0,J,I) +a[:]->nh4_a07(:,0,J,I) +a[:]->nh4_a08(:,0,J,I) 
co_sim    = a[:]->co(:,0,J,I)
no2_sim   = a[:]->no2(:,0,J,I)
so2_sim   = a[:]->so2(:,0,J,I)
o3_sim    = a[:]->o3(:,0,J,I)

co_sim  = 1000* co_sim
no2_sim  = 1000* no2_sim
so2_sim  = 1000* so2_sim
o3_sim   = 1000* o3_sim
pblh = a[:]->PBLH(:,J,I)
times = times + 8




;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   filename = "/data1/tabish/surface_data/IAPdata-pollutant.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_useful = str_match(lines, ":00")
  lines_useful = str_sub_str(lines_useful,",,",",lines_useful@_FillValue,")

  delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
  delim = "," ; multiple delimiters to separate day from date to find missing times
  print(lines_useful)
  datetime         = str_get_field(lines_useful,2,delim)
;  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;  print ("Time="+datetime)



; READ IN AEROSOL SPECIES AT GROUND SITE
  org         = tofloat(str_get_field(lines_useful,3,delim))
  so4         = tofloat(str_get_field(lines_useful,4,delim))
  no3         = tofloat(str_get_field(lines_useful,5,delim))
  nh4         = tofloat(str_get_field(lines_useful,6,delim))
  chl         = tofloat(str_get_field(lines_useful,7,delim))
  bc          = tofloat(str_get_field(lines_useful,8,delim))
; READ IN GASEOUS SPECIES AT GROUND SITE
  co         = tofloat(str_get_field(lines_useful,15,delim))
  co         = co*1000
  no         = tofloat(str_get_field(lines_useful,16,delim))
  no2        = tofloat(str_get_field(lines_useful,17,delim))
  o3         = tofloat(str_get_field(lines_useful,19,delim))
  so2        = tofloat(str_get_field(lines_useful,20,delim))
  so2	     = so2*10
; READ IN AEROSOL SPECIES AT 260M
  org_260    = tofloat(str_get_field(lines_useful,21,delim))
  so4_260    = tofloat(str_get_field(lines_useful,22,delim))
  no3_260    = tofloat(str_get_field(lines_useful,23,delim))
  nh4_260    = tofloat(str_get_field(lines_useful,24,delim))
  chl_260    = tofloat(str_get_field(lines_useful,25,delim))
 
  co_subset    = co(153:272)
  so2_subset   = so2(153:272)
  no2_subset   = no2(153:272)
  o3_subset    = o3(153:272)
  so4_subset   = so4(153:272)
  no3_subset   = no3(153:272)
  nh4_subset   = nh4(153:272)

co_subset(103) = co_subset@_FillValue
so2_subset(103) = so2_subset@_FillValue
nh4_subset(103) = nh4_subset@_FillValue
o3_subset(103) = o3_subset@_FillValue
;REMOVE THE OUTLIERS
;undef("remoutlier")
;procedure remoutlier(var)
;begin
; n = dimsizes(var)
; do i=1,n-2
;  prev = var(i-1)
;  now  = var(i)
;  next = var(i+1)
;  miss = var@_FillValue

;  if ((prev.ne.miss).and.(now.ne.miss).and.(next.ne.miss)) then
;   print (prev + now + next)
;   if ((now.gt.5*prev).and.(now>5*next)) then
;    var(i) = miss
;   end if
  ;else print(prev+now+next)
;  end if  
; end do
;end


; remoutlier(co_subset)
; remoutlier(so2_subset)
; remoutlier(no2_subset)
; remoutlier(o3_subset)
; remoutlier(so4_subset)
; remoutlier(no3_subset)
; remoutlier(nh4_subset)


;print ("co="+co_subset +" so2="+so2_subset)

;  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

  var_matrix_no3  = new((/2,120/),float)  
  var_matrix_nh4  = new((/2,120/),float)  
  var_matrix_so4  = new((/2,120/),float)  
  var_matrix_co   = new((/2,120/),float)  
  var_matrix_no2  = new((/2,120/),float)  
  var_matrix_so2  = new((/2,120/),float)  
  var_matrix_o3   = new((/2,120/),float)  
  
var_matrix_no3(0,:) = (/no3_sim/)
var_matrix_no3(1,:) = no3_subset
var_matrix_nh4(0,:) = (/nh4_sim/)
var_matrix_nh4(1,:) = nh4_subset
var_matrix_so4(0,:) = (/so4_sim/)
var_matrix_so4(1,:) = so4_subset
var_matrix_co(0,:)  = (/co_sim/)
var_matrix_co(1,:)  = co_subset
var_matrix_no2(0,:) = (/no2_sim/)
var_matrix_no2(1,:) = no2_subset
var_matrix_so2(0,:) = (/so2_sim/)
var_matrix_so2(1,:) = so2_subset
var_matrix_o3(0,:)  = (/o3_sim/)
var_matrix_o3(1,:)  = o3_subset


;---Start the graphics
wks = gsn_open_wks("png","IAP_ts_21-25Oct_YSUnudged_0.7nox0.5so2") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at IAP ground site"          ; add title
res@gsnMaximize = True
res@vpKeepAspect=False
res@vpWidthF    = 3
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  3.0, 3.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
  restick@ttmFormat = "%D_%H"
  ;restick@ttmFormat = "%D"
;  restick@ttmNumTicks = 5
  restick@ttmMajorStride= 12
  restick@ttmMinorStride= 1
  time_axis_labels(times,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.05
  res@tiYAxisFontHeightF = 0.05

  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = False   ; Turn off left tickmarks
  res@tmYROn               = True    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels


  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.75               ; move units down
  res@pmLegendWidthF         = 0.5                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "CO"
  xy1 = gsn_csm_xy(wks,times,var_matrix_co,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
  res@tiYAxisString = "NO2"
  xy2 = gsn_csm_xy(wks,times,var_matrix_no2,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy3 = gsn_csm_xy(wks,times,var_matrix_no3,res)

  res@tiYAxisString = "SO2"
  xy4 = gsn_csm_xy(wks,times,var_matrix_so2,res)

  res@tiYAxisString = "SO4"
  xy5 = gsn_csm_xy(wks,times,var_matrix_so4,res)

  res@tiYAxisString = "NH4"
  xy6 = gsn_csm_xy(wks,times,var_matrix_nh4,res)

  res@tiYAxisString = "O3"
  xy7 = gsn_csm_xy(wks,times,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy8 = gsn_csm_xy(wks,times,pblh,res)

  res1                     = True
  res2                     = True
  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)


end
