;TIME-SERIES OF NH3 SENSITIVITY RUN WITH CONTROL RUN AND OBS AT IAP DURING 21OCT-25OCT

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
;load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
print("Initializing arrays...")
;INITIALIZING OBS ARRAYS TO HOLD VALUES FROM 20OCT 1600HRS UTC TO 25OCT 1600HRS UTC 
so4 = new(120,float)
no3 = new(120,float)
nh4 = new(120,float)
pm25 = new(120,float)

;INITIALIZING SIM ARRAYS FOR CONTROL-RUN AND NH3-SENSITIVITY RUNS WITH PROPER LENGTH 
so4_sim_subset_cr = new(120,float)
no3_sim_subset_cr = new(120,float)
nh4_sim_subset_cr = new(120,float)
pm25_sim_subset_cr = new(120,float)

so4_sim_subset_nr = new(120,float)
no3_sim_subset_nr = new(120,float)
nh4_sim_subset_nr = new(120,float)
pm25_sim_subset_nr = new(120,float)

print("reading wrf directories...")
DATADir1 = "/mnt/rasher/control-run-so4-ECMWF/"
;DATADir2 = "/mnt/rasher/NH3-sensitivity_run/"
DATADir2 = "/mnt/rasher/nh3sens/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "subset_d03_2014-* ")
a = addfiles(FILES1,"r")
b = addfiles(FILES2,"r")
print("all wrf files loaded.")
I=79
J=144

so4_sim_cr   = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) +a[:]->so4_a03(:,0,J,I) +a[:]->so4_a04(:,0,J,I) + 0.6 * a[:]->so4_a05(:,0,J,I)  
no3_sim_cr   = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) +a[:]->no3_a03(:,0,J,I) +a[:]->no3_a04(:,0,J,I) + 0.6 * a[:]->no3_a05(:,0,J,I)   
nh4_sim_cr   = a[:]->nh4_a01(:,0,J,I) + a[:]->nh4_a02(:,0,J,I) +a[:]->nh4_a03(:,0,J,I) +a[:]->nh4_a04(:,0,J,I) + 0.6 * a[:]->nh4_a05(:,0,J,I)   
pm25_sim_cr = a[:]->PM2_5_DRY(:,0,145,79)

so4_sim_nr   = b[:]->so4_a01(:,0,J,I) + b[:]->so4_a02(:,0,J,I) +b[:]->so4_a03(:,0,J,I) +b[:]->so4_a04(:,0,J,I) + 0.6 * b[:]->so4_a05(:,0,J,I) 
no3_sim_nr   = b[:]->no3_a01(:,0,J,I) + b[:]->no3_a02(:,0,J,I) +b[:]->no3_a03(:,0,J,I) +b[:]->no3_a04(:,0,J,I) + 0.6 * b[:]->no3_a05(:,0,J,I) 
nh4_sim_nr   = b[:]->nh4_a01(:,0,J,I) + b[:]->nh4_a02(:,0,J,I) +b[:]->nh4_a03(:,0,J,I) +b[:]->nh4_a04(:,0,J,I) + 0.6 * b[:]->nh4_a05(:,0,J,I) 
pm25_sim_nr = b[:]->PM2_5_DRY(:,0,145,79)

timearr = ispan (1,120,1)
timearr@units = "hours since 2014-10-21 00:00:00"


so4_sim_cr_subset = so4_sim_cr(255:374)
no3_sim_cr_subset = no3_sim_cr(255:374)
nh4_sim_cr_subset = nh4_sim_cr(255:374)
pm25_sim_cr_subset = pm25_sim_cr(255:374)
so4_sim_nr_subset = so4_sim_nr(15:134)
no3_sim_nr_subset = no3_sim_nr(15:134)
nh4_sim_nr_subset = nh4_sim_nr(15:134)
pm25_sim_nr_subset = pm25_sim_nr(15:134)

p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)

d = ((p+pb)/(287.058*t2))
d_subset = d(255:374)
print("computed the density array")
print("Multiplying corresponding elements of pollutant arrays and density array in a loop")
do i = 0, 119
 so4_sim_cr_subset(i) = so4_sim_cr_subset(i) * d_subset(i)
 no3_sim_cr_subset(i) = no3_sim_cr_subset(i) * d_subset(i)
 nh4_sim_cr_subset(i) = nh4_sim_cr_subset(i) * d_subset(i)

 so4_sim_nr_subset(i) = so4_sim_nr_subset(i) * d_subset(i)
 no3_sim_nr_subset(i) = no3_sim_nr_subset(i) * d_subset(i)
 nh4_sim_nr_subset(i) = nh4_sim_nr_subset(i) * d_subset(i)
end do

print("All sim arrays prepared now")

;;;;;;;;;;;;;;OBSERVATIONS AT IAP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   filename = "/home/tabish/APEC_data/IAPdata-pollutant.csv"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_useful = str_match(lines, ":00"); SEARCH FOR 00HRS OBSERVATIONS
  str = "," + lines_useful@_FillValue + ","
  lines_useful = str_sub_str(lines_useful,",,",str); REPLACE BLANK SPACES WITH MISSING VALUES

  delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
  delim = "," ; delimiter
  print(lines_useful)
  datetime         = str_get_field(lines_useful,2,delim)
;  time         = tofloat(str_get_field(lines_Aotizhongxin,11,delim))
;  print ("Time="+datetime)

print(dimsizes(lines_useful))

; READ IN AEROSOL SPECIES AT GROUND SITE
  so4_full         = tofloat(str_get_field(lines_useful,4,delim))
  so4              = so4_full(144:263)
  no3_full         = tofloat(str_get_field(lines_useful,5,delim))
  no3              = no3_full(144:263)
  nh4_full         = tofloat(str_get_field(lines_useful,6,delim))
  nh4              = nh4_full(144:263)
delete(lines)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;OBSERVATIONS AT AOTIZHONGXIN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filename = "/home/tabish/APEC_data/Beijing_AQ_data_APEC2014_dingling.csv"
lines_full = new(1008,string)

;---Read in file as 1d array of strings so we can parse each line
lines = asciiread(filename,-1,"string")
stationname = "Aotizhongxin"
print(stationname)
  lines_station = str_match(lines, stationname)
  delim = ", :" ; multiple delimiters to separate day from date to find missing times
  delim1 = "," ; multiple delimiters to separate day from date to find missing times
  time         = tofloat(str_get_field(lines_station,11,delim))
;print(time)

fill =0
do i = 0, dimsizes(lines_station)-2
 print("i="+i + " fill="+fill)
 n=(time(i+1)-time(i))
 if((n.eq.1).or.(n.eq.-23))then
  lines_full(fill) = lines_station(i)
  fill = fill + 1
  print("fill="+fill)
 else
  lines_full(fill) = lines_station(i)
  fill=fill+1
  print("fill="+fill)
  do j=1,n-1
   lines_full(fill) = ","+stationname+",9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,9.96921e+36,1011A,missing missing missing"
   fill = fill +1
;  print("fill="+fill)
  end do
 end if
end do

lines_full(1007) = lines_station(dimsizes(lines_station)-1)
print(lines_full)
;  stationname  = str_get_field(lines_full,1,delim)
  PM25       = tofloat(str_get_field(lines_full,7,delim))
  PM25       = where(PM25.eq.0 .or. PM25.eq.9.96921e+36, PM25@_FillValue, PM25)
pm25 = PM25(256:375) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

;REMOVE THE OUTLIERS
undef("remoutlier")
function remoutlier(var)
begin
 n = dimsizes(var)
 do i=1,n-2
  prev = var(i-1)
  now  = var(i)
  next = var(i+1)
  miss = var@_FillValue
  if ((.not.ismissing(prev)).and.(.not.ismissing(now)).and.(.not.ismissing(next)).and.(now.gt.2*prev).and.(now>2*next)) then
    var(i) = miss
  end if
 end do
 return(var)
end


so4 = remoutlier(so4)
no3 = remoutlier(no3)
nh4 = remoutlier(nh4)
pm25 = remoutlier(pm25)
print("All obs arrays prepared now")

var_matrix_no3  = new((/3,120/),float)  
var_matrix_nh4  = new((/3,120/),float)  
var_matrix_so4  = new((/3,120/),float)  
var_matrix_pm25  = new((/3,120/),float)  
 
var_matrix_no3(0,:) = (/no3_sim_cr_subset/)
var_matrix_no3(1,:) = (/no3_sim_nr_subset/)
var_matrix_no3(2,:) = no3


var_matrix_nh4(0,:) = (/nh4_sim_cr_subset/)
var_matrix_nh4(1,:) = (/nh4_sim_nr_subset/)
var_matrix_nh4(2,:) = nh4

var_matrix_so4(0,:) = (/so4_sim_cr_subset/)
var_matrix_so4(1,:) = (/so4_sim_nr_subset/)
var_matrix_so4(2,:) = so4

var_matrix_pm25(0,:) = (/pm25_sim_cr_subset/)
var_matrix_pm25(1,:) = (/pm25_sim_nr_subset/)
var_matrix_pm25(2,:) = pm25

;;;;;;;;;;;;WRITING OUT ARRAYS IN ASCII FILE FOR SUBSEQUENT USE;;;;;;;;;;;;;
header = (/"no3simbaseline no3simsens no3obs nh4simbaseline nh4simsens nh4obs so4simbaseline so4simsens so4obs pm25simbaseline pm25simsens pm25obs"/)
hlist = [/header/]
alist = [/var_matrix_no3(0,:),var_matrix_no3(1,:),var_matrix_no3(2,:),var_matrix_nh4(0,:),var_matrix_nh4(1,:),var_matrix_nh4(2,:),var_matrix_so4(0,:),var_matrix_so4(1,:),var_matrix_so4(2,:),var_matrix_pm25(0,:),var_matrix_pm25(1,:),var_matrix_pm25(2,:)/]
print("alist created...now writing")
fname = "NH3sens_ts.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")
print("NH3sens_ts.txt...now written")


;CALCULATE AVERAGES OF EACH TIME SERIES
no3_sim_cr_avg = avg(no3_sim_cr_subset)
no3_sim_nr_avg = avg(no3_sim_nr_subset)
no3_avg        = avg(no3)

nh4_sim_cr_avg = avg(nh4_sim_cr_subset)
nh4_sim_nr_avg = avg(nh4_sim_nr_subset)
nh4_avg        = avg(nh4)

so4_sim_cr_avg = avg(so4_sim_cr_subset)
so4_sim_nr_avg = avg(so4_sim_nr_subset)
so4_avg        = avg(so4)

pm25_sim_cr_avg = avg(pm25_sim_cr_subset)
pm25_sim_nr_avg = avg(pm25_sim_nr_subset)
pm25_avg        = avg(pm25)


print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO3-CONTROL      ="+no3_sim_cr_avg)
print("NO3-SENSITIVITY  ="+no3_sim_nr_avg)
print("NO3-OBS          ="+no3_avg)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NH4-CONTROL      ="+nh4_sim_cr_avg)
print("NH4-SENSITIVITY  ="+nh4_sim_nr_avg)
print("NH4-OBS          ="+nh4_avg)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO4-CONTROL      ="+so4_sim_cr_avg)
print("SO4-SENSITIVITY  ="+so4_sim_nr_avg)
print("SO4-OBS          ="+so4_avg)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("PM2.5-CONTROL    ="+pm25_sim_cr_avg)
print("PM2.5-SENSITIVITY="+pm25_sim_nr_avg)
print("PM2.5-OBS        ="+pm25_avg)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")





;---Start the graphics
wks = gsn_open_wks("x11","NH3sensitivity_ts") ; send graphics to PNG file
;gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
;res@tiMainString     = "Effect of NH3 emissions reduction"          ; add title
;res@gsnMaximize = True
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.5
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0/)  
res@tmXTOn      = False
res@tmXBLabelDeltaF      = -0.8     ; Increase space b/w ticks and labels
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/ 1.0, 1.0, 1.0  /)          ; make second line thicker
res@xyLineColors      = (/"red","blue","black"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D/%N"
;  restick@ttmNumTicks = 15
  restick@ttmMajorStride= 24
  restick@ttmMinorStride= 1
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

;res@tiMainString       = filename
;  res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.04
  res@tiYAxisFontHeightF = 0.04
  res@tmYUseLeft           = True   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = False   ; Turn off left labels
  res@tmYLLabelsOn         = True    ; Turn on right labels
  res@tmYRMinorOn          = False   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = 0.16                  ; move units right
  res@pmLegendOrthogonalPosF = -.4               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.18                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .035                 ; label font height
  res@xyExplicitLegendLabels = (/"baseline","NH3-sensitivity","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

; Change y axis string and color for each plot.
  res@tiYAxisString = "NH4"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  

  res@tiYAxisString = "NO3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "PM2.5"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_pm25,res)

;  res1                     = True
;  res2                     = True
;  res1@gsnMaximize         = True
;  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4/),res1,res2)

;  draw(xy1)    ; All four plots will be drawn.
;  frame(wks)

;************************************************
; create panel
;************************************************
resP = True
resP@gsnPanelYWhiteSpacePercent = 0.0
gsn_panel(wks,(/xy1,xy2,xy3,xy4/),(/4,1/),resP)             ; now draw as one plot



end
