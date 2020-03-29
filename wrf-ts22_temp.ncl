;TIME-SERIES FOR IAP POLLUTANT DATA FOR CONTROL-RUN-SO4 AND ECMWF-CONTROL-RUN-SO4: 15OCT - 7NOV 

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

DATADir = "/data2/tabish/ECMWF-control-run-so4/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=144
so4_sim   = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) +a[:]->so4_a03(:,0,J,I) +a[:]->so4_a04(:,0,J,I) +a[:]->so4_a05(:,0,J,I) +a[:]->so4_a06(:,0,J,I)  
no3_sim   = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) +a[:]->no3_a03(:,0,J,I) +a[:]->no3_a04(:,0,J,I) +a[:]->no3_a05(:,0,J,I) +a[:]->no3_a06(:,0,J,I)  
nh4_sim   = a[:]->nh4_a01(:,0,J,I) + a[:]->nh4_a02(:,0,J,I) +a[:]->nh4_a03(:,0,J,I) +a[:]->nh4_a04(:,0,J,I) +a[:]->nh4_a05(:,0,J,I) +a[:]->nh4_a06(:,0,J,I)  
chl_sim   = a[:]->cl_a01(:,0,J,I)  + a[:]->cl_a02(:,0,J,I)  +a[:]->cl_a03(:,0,J,I)  +a[:]->cl_a04(:,0,J,I)  +a[:]->cl_a05(:,0,J,I)  +a[:]->cl_a06(:,0,J,I)   
oc_sim    = a[:]->oc_a01(:,0,J,I) + a[:]->oc_a02(:,0,J,I) +a[:]->oc_a03(:,0,J,I) +a[:]->oc_a04(:,0,J,I) +a[:]->oc_a05(:,0,J,I) +a[:]->oc_a06(:,0,J,I)  
bc_sim    = a[:]->bc_a01(:,0,J,I) + a[:]->bc_a02(:,0,J,I) +a[:]->bc_a03(:,0,J,I) +a[:]->bc_a04(:,0,J,I) +a[:]->bc_a05(:,0,J,I) +a[:]->bc_a06(:,0,J,I)  
co_sim    = a[:]->co(:,0,J,I)
no2_sim   = a[:]->no2(:,0,J,I)
so2_sim   = a[:]->so2(:,0,J,I)
o3_sim    = a[:]->o3(:,0,J,I)

so4_sim_260   = a[:]->so4_a01(:,3,J,I) + a[:]->so4_a02(:,3,J,I) +a[:]->so4_a03(:,3,J,I) +a[:]->so4_a04(:,3,J,I) +a[:]->so4_a05(:,3,J,I) +a[:]->so4_a06(:,3,J,I)
no3_sim_260   = a[:]->no3_a01(:,3,J,I) + a[:]->no3_a02(:,3,J,I) +a[:]->no3_a03(:,3,J,I) +a[:]->no3_a04(:,3,J,I) +a[:]->no3_a05(:,3,J,I) +a[:]->no3_a06(:,3,J,I)
nh4_sim_260   = a[:]->nh4_a01(:,3,J,I) + a[:]->nh4_a02(:,3,J,I) +a[:]->nh4_a03(:,3,J,I) +a[:]->nh4_a04(:,3,J,I) +a[:]->nh4_a05(:,3,J,I) +a[:]->nh4_a06(:,3,J,I)
chl_sim_260   = a[:]->cl_a01(:,3,J,I)  + a[:]->cl_a02(:,3,J,I)  +a[:]->cl_a03(:,3,J,I)  +a[:]->cl_a04(:,3,J,I)  +a[:]->cl_a05(:,3,J,I)  +a[:]->cl_a06(:,3,J,I)
oc_sim_260    = a[:]->oc_a01(:,3,J,I) + a[:]->oc_a02(:,3,J,I) +a[:]->oc_a03(:,3,J,I) +a[:]->oc_a04(:,3,J,I) +a[:]->oc_a05(:,3,J,I) +a[:]->oc_a06(:,3,J,I)
printVarSummary(so4_sim)
p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)

;APPLYING COMPONENT-CORRECTIONS TO MATCH WITH OBSERVATIONS
;bc_sim = 0.4 * bc_sim
;no3_sim = 0.4 * no3_sim
;so4_sim = 3 * so4_sim


co_sim  = 1000* co_sim
no2_sim  = 1000* no2_sim
so2_sim  = 1000* so2_sim
o3_sim   = 1000* o3_sim
pblh = a[:]->PBLH(:,J,I)
pblh_subset = pblh(111:686)

timearr = ispan (1,576,1)
timearr@units = "hours since 2014-10-15 00:00:00"


so4_sim_subset = so4_sim(111:686)
no3_sim_subset = no3_sim(111:686)
nh4_sim_subset = nh4_sim(111:686)
chl_sim_subset = chl_sim(111:686)
oc_sim_subset = oc_sim(111:686)
bc_sim_subset = bc_sim(111:686)
co_sim_subset = co_sim(111:686)
no2_sim_subset = no2_sim(111:686)
so2_sim_subset = so2_sim(111:686)
o3_sim_subset = o3_sim(111:686)

so4_sim_260_subset = so4_sim_260(111:686)
no3_sim_260_subset = no3_sim_260(111:686)
nh4_sim_260_subset = nh4_sim_260(111:686)
chl_sim_260_subset = chl_sim_260(111:686)
oc_sim_260_subset = oc_sim_260(111:686)

d = ((p+pb)/(287.058*t2))
d_subset = d(111:686)

do i = 0, 575
 so4_sim_subset(i) = so4_sim_subset(i) * d_subset(i)
 no3_sim_subset(i) = no3_sim_subset(i) * d_subset(i)
 nh4_sim_subset(i) = nh4_sim_subset(i) * d_subset(i)
 chl_sim_subset(i) = chl_sim_subset(i) * d_subset(i)
 oc_sim_subset(i)  = oc_sim_subset(i) * d_subset(i)
 bc_sim_subset(i)  = bc_sim_subset(i) * d_subset(i)
 co_sim_subset(i)  = co_sim_subset(i) * d_subset(i)
 no2_sim_subset(i) = no2_sim_subset(i) * d_subset(i)
 so2_sim_subset(i) = so2_sim_subset(i) * d_subset(i)
 o3_sim_subset(i)  = o3_sim_subset(i) * d_subset(i)
end do

so4_sim_260_subset = 1.15 * so4_sim_260_subset 
no3_sim_260_subset = 1.15 * no3_sim_260_subset
nh4_sim_260_subset = 1.15 * nh4_sim_260_subset
chl_sim_260_subset = 1.15 * chl_sim_260_subset
oc_sim_260_subset  = 1.15 * oc_sim_260_subset




;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   filename = "/data1/tabish/surface_data/IAPdata-pollutant.csv"

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
  so2 = where(so2.lt.0,0,so2)
  so2 = where(so2.gt.80,so2@_FillValue,so2)
  no2 = where(no2.lt.0,0,no2)
  o3  = where(o3.lt.0,0,o3)

; READ IN AEROSOL SPECIES AT 260M
  org_260    = tofloat(str_get_field(lines_useful,22,delim))
  so4_260    = tofloat(str_get_field(lines_useful,23,delim))
  no3_260    = tofloat(str_get_field(lines_useful,24,delim))
  nh4_260    = tofloat(str_get_field(lines_useful,25,delim))
  chl_260    = tofloat(str_get_field(lines_useful,26,delim))
 
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


co = remoutlier(co)
so2 = remoutlier(so2)
no2 = remoutlier(no2)
o3 = remoutlier(o3)
so4 = remoutlier(so4)
no3 = remoutlier(no3)
nh4 = remoutlier(nh4)

org_260 = remoutlier(org_260)
org_260 = where(org_260.lt.0,org_260@_FillValue,org_260)
so4_260 = remoutlier(so4_260)
no3_260 = remoutlier(no3_260)
nh4_260 = remoutlier(nh4_260)
chl_260 = remoutlier(chl_260)
so4_260 = where(so4_260.lt.0,so4_260@_FillValue,so4_260)
no3_260 = where(no3_260.lt.0,no3_260@_FillValue,no3_260)
nh4_260 = where(nh4_260.lt.0,nh4_260@_FillValue,nh4_260)
chl_260 = where(chl_260.lt.0,chl_260@_FillValue,chl_260)
;print ("co="+co_subset +" so2="+so2_subset)

;  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

  var_matrix_no3  = new((/2,576/),float)  
  var_matrix_nh4  = new((/2,576/),float)  
  var_matrix_so4  = new((/2,576/),float)  
  var_matrix_oc  = new((/2,576/),float)  
  var_matrix_bc  = new((/2,576/),float)  
  var_matrix_chl  = new((/2,576/),float)  
  var_matrix_co   = new((/2,576/),float)  
  var_matrix_no2  = new((/2,576/),float)  
  var_matrix_so2  = new((/2,576/),float)  
  var_matrix_o3   = new((/2,576/),float)  
 
  var_matrix_oc_260  = new((/2,576/),float)  
  var_matrix_so4_260  = new((/2,576/),float)  
  var_matrix_no3_260  = new((/2,576/),float)  
  var_matrix_nh4_260  = new((/2,576/),float)  
  var_matrix_chl_260  = new((/2,576/),float)  
printVarSummary(no3_sim_subset)
var_matrix_no3(0,:) = (/no3_sim_subset/)
var_matrix_no3(1,:) = no3(0:575)
var_matrix_nh4(0,:) = (/nh4_sim_subset/)
var_matrix_nh4(1,:) = nh4(0:575)
var_matrix_so4(0,:) = (/so4_sim_subset/)
var_matrix_so4(1,:) = so4(0:575)
var_matrix_oc(0,:) = (/oc_sim_subset/)
var_matrix_oc(1,:) = org(0:575)
var_matrix_bc(0,:) = (/bc_sim_subset/)
var_matrix_bc(1,:) = bc(0:575)
var_matrix_chl(0,:) = (/chl_sim_subset/)
var_matrix_chl(1,:) = chl(0:575)
var_matrix_co(0,:)  = (/co_sim_subset/)
var_matrix_co(1,:)  = co(0:575)
var_matrix_no2(0,:) = (/no2_sim_subset/)
var_matrix_no2(1,:) = no2(0:575)
var_matrix_so2(0,:) = (/so2_sim_subset/)
var_matrix_so2(1,:) = so2(0:575)
var_matrix_o3(0,:)  = (/o3_sim_subset/)
var_matrix_o3(1,:)  = o3(0:575)

var_matrix_oc_260(0,:)  = (/oc_sim_260_subset/)
var_matrix_oc_260(1,:)  = org_260(0:575)

var_matrix_so4_260(0,:)  = (/so4_sim_260_subset/)
var_matrix_so4_260(1,:)  = so4_260(0:575)

var_matrix_no3_260(0,:)  = (/no3_sim_260_subset/)
var_matrix_no3_260(1,:)  = no3_260(0:575)

var_matrix_nh4_260(0,:)  = (/nh4_sim_260_subset/)
var_matrix_nh4_260(1,:)  = nh4_260(0:575)

var_matrix_chl_260(0,:)  = (/chl_sim_260_subset/)
var_matrix_chl_260(1,:)  = chl_260(0:575)




;---Start the graphics
wks = gsn_open_wks("png","IAP_15Oct-7Nov_ts_controlrunso4_ECMWF") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
res@tiMainString     = "Surface pollutants at IAP ground site"          ; add title
;res@gsnMaximize = True
res@vpKeepAspect=True
res@vpWidthF    = 2
res@vpHeightF   = 0.4
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0/)  
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  2.0, 2.0/)          ; make second line thicker
res@xyLineColors      = (/"blue","red"/)          ; change line color
;--------------------------------------------------
; The time_axis_label function adds additional
; resources to "res" to produce nicely-formatted 
; time labels on X axis. This function only works 
; if you have a time "units" recognized by the 
; cd_calendar function.
;--------------------------------------------------
  restick           = True
;  restick@ttmFormat = "%D_%H"
  restick@ttmFormat = "%D"
  restick@ttmNumTicks = 15
;  restick@ttmMajorStride= 12
;  restick@ttmMinorStride= 1
;  res@tmXBAutoPrecision    = False
  time_axis_labels(timearr,res,restick)

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
  res@tmYRMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmYRLabelDeltaF      = 2.0     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .90                  ; move units right
  res@pmLegendOrthogonalPosF = -0.75               ; move units down
  res@pmLegendWidthF         = 0.3                ; Change width and
  res@pmLegendHeightF        = 0.15                ; height of legend.
  res@lgPerimOn              = False               ; turn off box around
  res@lgLabelFontHeightF     = .05                 ; label font height
  res@xyExplicitLegendLabels = (/"model","obs"/)         ; create explicit labels
  res@gsnDraw  = False                          ; don't draw
  res@gsnFrame = False                          ; don't advance frame

;printVarSummary(times_subset)
; Change y axis string and color for each plot.
  res@tiYAxisString = "OC"

print("so far so good..")
printVarSummary(timearr)
printVarSummary(var_matrix_oc)


  xy1 = gsn_csm_xy(wks,timearr,var_matrix_oc,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots
  
  res@tiYAxisString = "BC"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_bc,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_no3,res)

  res@tiYAxisString = "SO4"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_so4,res)

  res@tiYAxisString = "NH4"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_nh4,res)

  res@tiYAxisString = "CHL"
  xy6 = gsn_csm_xy(wks,timearr,var_matrix_chl,res)

  res@tiYAxisString = "CO"
  xy7 = gsn_csm_xy(wks,timearr,var_matrix_co,res)

  res@tiYAxisString = "SO2"
  xy8 = gsn_csm_xy(wks,timearr,var_matrix_so2,res)

  res@tiYAxisString = "NO2"
  xy9 = gsn_csm_xy(wks,timearr,var_matrix_no2,res)

  res@tiYAxisString = "O3"
  xy10 = gsn_csm_xy(wks,timearr,var_matrix_o3,res)

  res@tiYAxisString = "PBLH"
  xy11 = gsn_csm_xy(wks,timearr,pblh_subset,res)

  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
  amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5,xy6,xy7,xy8,xy9,xy10,xy11/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)
print(d_subset)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Surface pollutants at IAP 260m site"          ; add title
  res@tiYAxisString = "OC"
  
  xy12 = gsn_csm_xy(wks,timearr,var_matrix_oc_260,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "Chl"
  xy13 = gsn_csm_xy(wks,timearr,var_matrix_chl_260,res)    ; They won't be drawn yet.

  res@tiYAxisString = "NO3"
  xy14 = gsn_csm_xy(wks,timearr,var_matrix_no3_260,res)

  res@tiYAxisString = "SO4"
  xy15 = gsn_csm_xy(wks,timearr,var_matrix_so4_260,res)

  res@tiYAxisString = "Nh4"
  xy16 = gsn_csm_xy(wks,timearr,var_matrix_nh4_260,res)

amid1 = gsn_attach_plots(xy12,(/xy13,xy14,xy15,xy16/),res1,res2)

;plot = gsn_csm_xy(wks,times,chl,res1)
draw(xy12)
frame(wks)

print("org(0) = " + org(0))
print("so4(0) = " + so4(0))
print("no3(0) = " + no3(0))
print("nh4(0) = " + nh4(0))
print("chl(0) = " + chl(0))
print("bc(0) = " + bc(0))

print("co(0) = " + co(0))
print("no2(0) = " + no2(0))
print("o3(0) = " + o3(0))
print("so2(0) = " + so2(0))

print("org_260(0) = " + org_260(0))
print("so4_260(0) = " + so4_260(0))
print("no3_260(0) = " + no3_260(0))
print("nh4_260(0) = " + nh4_260(0))
print("chl_260(0) = " + chl_260(0))
end
