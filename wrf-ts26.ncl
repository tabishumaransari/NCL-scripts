;TO PLOT IAP TOWERMET VS WRF DATA
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

undef("throwhour")
function throwhour(var)
begin
s = 0.0
c = 0.0
fill =0
var_00 = new(784,float)
;var_00 = new(1000,float)
do i =1,9307
 now = var(i)
 next= var(i+1)
 if(.not.ismissing(now)).and.(.not.ismissing(next)) then
  s = s + now
  c = c + 1.0
 end if
 if(.not.ismissing(now)).and.(ismissing(next)) then
  s = s + now
  c = c + 1.0
  var_00(fill) = (s/c) ; THIS SHOULD BE TRUE 784 TIMES ONLY
  print("fill="+fill+" count="+c)
  s=0.0
  c=0.0
  fill = fill +1
 end if
end do
  s = s + next
  c = c + 1.0
  var_00(fill) = (s/c) ; THIS IS FOR THE LAST HOUR
  print("fill="+fill+" count="+c)
  print("success")
return(var_00)
end

undef("throwhour2"); THIS IS ONLY FOR WIND SPEED AS IT HAS CRAZY MISSING VALUES
function throwhour2(var,var2)
begin
s = 0.0
c = 0.0
fill =0
var_00 = new(784,float)
;var_00 = new(1000,float)
do i =1,9307
 now   = var(i)
 next  = var(i+1)
 now2  = var2(i)
 next2 = var2(i+1)
 if(.not.ismissing(now2)).and.(.not.ismissing(next2)) then
  s = s + now
  c = c + 1.0
 end if
 if(.not.ismissing(now2)).and.(ismissing(next2)) then
  s = s + now
  c = c + 1.0
  var_00(fill) = (s/c) ; THIS SHOULD BE TRUE 784 TIMES ONLY
  print("fill="+fill+" count="+c)
  s=0.0
  c=0.0
  fill = fill +1
 end if
end do
  s = s + next
  c = c + 1.0
  var_00(fill) = (s/c) ; THIS IS FOR THE LAST HOUR
  print("fill="+fill+" count="+c)
  print("success")
return(var_00)
end

;CALCULATING WIND DIRECTION THE CLASSIC WAY
undef("winddir")
function winddir(u,v)
begin
WD = new(745,float)
do i = 0,744
 if (u(i).ge.0 .and. v(i).ge.0)
  f = v(i)/u(i)
  wd_rad = atan(f)
  wd_deg = 57.295779513 * wd_rad
  WD(i) = wd_deg
 end if

 if (u(i).le.0 .and. v(i).ge.0)
  f = v(i)/(-u(i))
  wd_rad = atan(f)
  wd_deg = 57.295779513 * wd_rad
  WD(i) = 180 - wd_deg
 end if

 if (u(i).le.0 .and. v(i).le.0)
  f = v(i)/u(i)
  wd_rad = atan(f)
  wd_deg = 57.295779513 * wd_rad
  WD(i) = 180 + wd_deg
 end if

 if (u(i).ge.0 .and. v(i).le.0)
  f = (-v(i))/u(i)
  wd_rad = atan(f)
  wd_deg = 57.295779513 * wd_rad
  WD(i) = 360 - wd_deg
 end if
end do
return(WD)
end


;MAIN PROGRAM
begin
begTime = get_cpu_time()
DATADir = "/data3/tabish/control-run/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

;qv = a[:]->QVAPOR
;print("read qvapor")
;P  = a[:]->P                  ; perturbation
;print("read perturbation pressure")
;Pb = a[:]->PB                 ; base state pressure
;print("read base state pressure")
;P  = P + Pb                   ; total pressure
;print("computed total pressure")
;theta = a[:]->T               ; perturbation potential temperature (theta+t0)
;print("read perturbation potential temperature")
;theta = theta + 300.
;print("added 300")
;TK = wrf_tk (P, theta)
;print("TK calculated!")
;RH = wrf_rh (qv, P, TK)
;print("RH calculated the inefficient way")
;printVarSummary(RH)

RH = wrf_user_getvar(a,"rh",-1)  ; RH the efficient way
print("RH calculated the efficient way")
printVarSummary(RH)


T = wrf_user_getvar(a,"tc",-1) 
uvmet = wrf_user_getvar(a,"uvmet",-1)
umet = uvmet(0,:,:,:,:)
vmet = uvmet(1,:,:,:,:)

RH_0_sim = RH(40:784,0,144,79)
RH_1_sim = RH(40:784,1,144,79)
RH_2_sim = RH(40:784,2,144,79)
RH_3_sim = RH(40:784,3,144,79)
RH_4_sim = RH(40:784,4,144,79)

T_0_sim = T(40:784,0,144,79)
T_1_sim = T(40:784,1,144,79)
T_2_sim = T(40:784,2,144,79)
T_3_sim = T(40:784,3,144,79)
T_4_sim = T(40:784,4,144,79)

u_0_sim = umet(40:784,0,144,79)
u_1_sim = umet(40:784,1,144,79)
u_2_sim = umet(40:784,2,144,79)
u_3_sim = umet(40:784,3,144,79)
u_4_sim = umet(40:784,4,144,79)

v_0_sim = vmet(40:784,0,144,79)
v_1_sim = vmet(40:784,1,144,79)
v_2_sim = vmet(40:784,2,144,79)
v_3_sim = vmet(40:784,3,144,79)
v_4_sim = vmet(40:784,4,144,79)

WS_0_sim =  ((u_0_sim ^ 2)  + (v_0_sim ^ 2)) ^ 0.5
WS_1_sim =  ((u_1_sim ^ 2)  + (v_1_sim ^ 2)) ^ 0.5
WS_2_sim =  ((u_2_sim ^ 2)  + (v_2_sim ^ 2)) ^ 0.5
WS_3_sim =  ((u_3_sim ^ 2)  + (v_3_sim ^ 2)) ^ 0.5
WS_4_sim =  ((u_4_sim ^ 2)  + (v_4_sim ^ 2)) ^ 0.5

WD_0_sim = winddir(u_0_sim,v_0_sim)
WD_1_sim = winddir(u_1_sim,v_1_sim)
WD_2_sim = winddir(u_2_sim,v_2_sim)
WD_3_sim = winddir(u_3_sim,v_3_sim)
WD_4_sim = winddir(u_4_sim,v_4_sim)


;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filename = "/data1/tabish/surface_data/IAP-towermet.csv"
delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
delim = "," ; delimiter

;---Read in file as array of strings so we can parse each line
 lines = asciiread(filename,-1,"string")
 str = ",9.96921e+36,"
 lines = str_sub_str(lines,",,",str); REPLACE BLANK SPACES WITH ZERO
 lines = str_sub_str(lines,",,",str); REPLACE ANY REMAINING BLANK SPACES WITH ZERO
;lines = where(lines.ne.9.96921e+36, lines, "0")
;lines = str_sub_str(lines,"9.96921e+36","0"); REPLACE ANY REMAINING BLANK SPACES WITH ZERO
 mins    = tofloat(str_get_field(lines,3,delim1))
 mins    = where((mins.ge.45).or.(mins.le.15),mins,mins@_FillValue)
;print(mins)
 lines_useful = where(mins.ne.mins@_FillValue,lines,lines@_FillValue)
print(lines_useful)
; lines_useful = str_match(lines, ":00"); SEARCH FOR 00HRS OBSERVATIONS
;  str = "," + lines_useful@_FillValue + ","
;  lines_useful = str_sub_str(lines_useful,",,",str); REPLACE BLANK SPACES WITH MISSING VALUES

;  print(lines_useful)
;  datetime         = str_get_field(lines_useful,2,delim)
;  time         = tofloat(str_get_field(lines_useful,11,delim))
;  print ("Time="+datetime)

  T8         = tofloat(str_get_field(lines_useful,2,delim))
  RH8        = tofloat(str_get_field(lines_useful,3,delim))
  WD8        = tofloat(str_get_field(lines_useful,4,delim))
  Vse8       = tofloat(str_get_field(lines_useful,5,delim))
  Vse8       = where(Vse8.ne.0,Vse8,Vse8@_FillValue)
  Vnw8       = tofloat(str_get_field(lines_useful,6,delim))
  Vnw8       = where(Vnw8.ne.0,Vnw8,Vnw8@_FillValue)
 
  T15         = tofloat(str_get_field(lines_useful,7,delim))
  RH15        = tofloat(str_get_field(lines_useful,8,delim))
  WD15        = tofloat(str_get_field(lines_useful,9,delim))
  Vse15       = tofloat(str_get_field(lines_useful,10,delim))
  Vse15       = where(Vse15.ne.0,Vse15,Vse15@_FillValue)
  Vnw15       = tofloat(str_get_field(lines_useful,11,delim))
  Vnw15       = where(Vnw15.ne.0,Vnw15,Vnw15@_FillValue)
  
  T32         = tofloat(str_get_field(lines_useful,12,delim))
  RH32        = tofloat(str_get_field(lines_useful,13,delim))
  WD32        = tofloat(str_get_field(lines_useful,14,delim))
  Vse32       = tofloat(str_get_field(lines_useful,15,delim))
  Vse32       = where(Vse32.ne.0,Vse32,Vse32@_FillValue)
  Vnw32       = tofloat(str_get_field(lines_useful,16,delim))
  Vnw32       = where(Vnw32.ne.0,Vnw32,Vnw32@_FillValue)
  
  T47         = tofloat(str_get_field(lines_useful,17,delim))
  RH47        = tofloat(str_get_field(lines_useful,18,delim))
  WD47        = tofloat(str_get_field(lines_useful,19,delim))
  Vse47       = tofloat(str_get_field(lines_useful,20,delim))
  Vse47       = where(Vse47.ne.0,Vse47,Vse47@_FillValue)
  Vnw47       = tofloat(str_get_field(lines_useful,21,delim))
  Vnw47       = where(Vnw47.ne.0,Vnw47,Vnw47@_FillValue)
  
  T63         = tofloat(str_get_field(lines_useful,22,delim))
  RH63        = tofloat(str_get_field(lines_useful,23,delim))
  WD63        = tofloat(str_get_field(lines_useful,24,delim))
  Vse63       = tofloat(str_get_field(lines_useful,25,delim))
  Vse63       = where(Vse63.ne.0,Vse63,Vse63@_FillValue)
  Vnw63       = tofloat(str_get_field(lines_useful,26,delim))
  Vnw63       = where(Vnw63.ne.0,Vnw63,Vnw63@_FillValue)
  
  T80         = tofloat(str_get_field(lines_useful,27,delim))
  RH80        = tofloat(str_get_field(lines_useful,28,delim))
  WD80        = tofloat(str_get_field(lines_useful,29,delim))
  Vse80       = tofloat(str_get_field(lines_useful,30,delim))
  Vse80       = where(Vse80.ne.0,Vse80,Vse80@_FillValue)
  Vnw80       = tofloat(str_get_field(lines_useful,31,delim))
  Vnw80       = where(Vnw80.ne.0,Vnw80,Vnw80@_FillValue)

  T102         = tofloat(str_get_field(lines_useful,32,delim))
  RH102        = tofloat(str_get_field(lines_useful,33,delim))
  WD102        = tofloat(str_get_field(lines_useful,34,delim))
  Vse102       = tofloat(str_get_field(lines_useful,35,delim))
  Vse102       = where(Vse102.ne.0,Vse102,Vse102@_FillValue)
  Vnw102       = tofloat(str_get_field(lines_useful,36,delim))
  Vnw102       = where(Vnw102.ne.0,Vnw102,Vnw102@_FillValue)

  T120         = tofloat(str_get_field(lines_useful,37,delim))
  RH120        = tofloat(str_get_field(lines_useful,38,delim))
  WD120        = tofloat(str_get_field(lines_useful,39,delim))
  Vse120       = tofloat(str_get_field(lines_useful,40,delim))
  Vse120       = where(Vse120.ne.0,Vse120,Vse120@_FillValue)
  Vnw120       = tofloat(str_get_field(lines_useful,41,delim))
  Vnw120       = where(Vnw120.ne.0,Vnw120,Vnw120@_FillValue)

  T140         = tofloat(str_get_field(lines_useful,42,delim))
  RH140        = tofloat(str_get_field(lines_useful,43,delim))
  WD140        = tofloat(str_get_field(lines_useful,44,delim))
  Vse140       = tofloat(str_get_field(lines_useful,45,delim))
  Vse140       = where(Vse140.ne.0,Vse140,Vse140@_FillValue)
  Vnw140       = tofloat(str_get_field(lines_useful,46,delim))
  Vnw140       = where(Vnw140.ne.0,Vnw140,Vnw140@_FillValue)

  T160         = tofloat(str_get_field(lines_useful,47,delim))
  RH160        = tofloat(str_get_field(lines_useful,48,delim))
  WD160        = tofloat(str_get_field(lines_useful,49,delim))
  Vse160       = tofloat(str_get_field(lines_useful,50,delim))
  Vse160       = where(Vse160.ne.0,Vse160,Vse160@_FillValue)
  Vnw160       = tofloat(str_get_field(lines_useful,51,delim))
  Vnw160       = where(Vnw160.ne.0,Vnw160,Vnw160@_FillValue)

  T180         = tofloat(str_get_field(lines_useful,52,delim))
  RH180        = tofloat(str_get_field(lines_useful,53,delim))
  WD180        = tofloat(str_get_field(lines_useful,54,delim))
  Vse180       = tofloat(str_get_field(lines_useful,55,delim))
  Vse180       = where(Vse180.ne.0,Vse180,Vse180@_FillValue)
  Vnw180       = tofloat(str_get_field(lines_useful,56,delim))
  Vnw180       = where(Vnw180.ne.0,Vnw180,Vnw180@_FillValue)

  T200         = tofloat(str_get_field(lines_useful,57,delim))
  RH200        = tofloat(str_get_field(lines_useful,58,delim))
  WD200        = tofloat(str_get_field(lines_useful,59,delim))
  Vse200       = tofloat(str_get_field(lines_useful,60,delim))
  Vse200       = where(Vse200.ne.0,Vse200,Vse200@_FillValue)
  Vnw200       = tofloat(str_get_field(lines_useful,61,delim))
  Vnw200       = where(Vnw200.ne.0,Vnw200,Vnw200@_FillValue)

  T240         = tofloat(str_get_field(lines_useful,62,delim))
  RH240        = tofloat(str_get_field(lines_useful,63,delim))
  WD240        = tofloat(str_get_field(lines_useful,64,delim))
  Vse240       = tofloat(str_get_field(lines_useful,65,delim))
  Vse240       = where(Vse240.ne.0,Vse240,Vse240@_FillValue)
  Vnw240       = tofloat(str_get_field(lines_useful,66,delim))
  Vnw240       = where(Vnw240.ne.0,Vnw240,Vnw240@_FillValue)

  T280         = tofloat(str_get_field(lines_useful,67,delim))
  RH280        = tofloat(str_get_field(lines_useful,68,delim))
  WD280        = tofloat(str_get_field(lines_useful,69,delim))
  Vse280       = tofloat(str_get_field(lines_useful,70,delim))
  Vse280       = where(Vse280.ne.0,Vse280,Vse280@_FillValue)
  Vnw280       = tofloat(str_get_field(lines_useful,71,delim))
  Vnw280       = where(Vnw280.ne.0,Vnw280,Vnw280@_FillValue)

  T320         = tofloat(str_get_field(lines_useful,72,delim))
  RH320        = tofloat(str_get_field(lines_useful,73,delim))
  WD320        = tofloat(str_get_field(lines_useful,74,delim))
  Vse320       = tofloat(str_get_field(lines_useful,75,delim))
  Vse320       = where(Vse320.ne.0,Vse320,Vse320@_FillValue)
  Vnw320       = tofloat(str_get_field(lines_useful,76,delim))
  Vnw320       = where(Vnw320.ne.0,Vnw320,Vnw320@_FillValue)

;print(Vse320)
T_0 = 0.5 * (T8 + T15)
RH_0 = 0.5 * (RH8 + RH15)
WD_0 = 0.5 * (WD8 + WD15)
WS_0 = 0.5 * 0.5 * (Vse8 + Vnw8 + Vse15 + Vnw15)

T_1 = 0.25 * (T32 + T47 + T63 + T80)
RH_1 = 0.25 * (RH32 + RH47 + RH63 + RH80)
WD_1 = 0.25 * (WD32 + WD47 + WD63 + WD80)
WS_1 = 0.5 * 0.25 * (Vse32 + Vnw32 + Vse47 + Vnw47 + Vse63 + Vnw63 + Vse80 + Vnw80)

T_2 = 0.25 * (T102 + T120 + T140 + T160)
RH_2 = 0.25 * (RH102 + RH120 + RH140 + RH160)
WD_2 = 0.25 * (WD102 + WD120 + WD140 + WD160)
WS_2 = 0.5 * 0.25 * (Vse102 + Vnw102 + Vse120 + Vnw120 + Vse140 + Vnw140 + Vse160 + Vnw160)

T_3 = 0.25 * (T180 + T200 + T240 + T280)
RH_3 = 0.25 * (RH180 + RH200 + RH240 + RH280)
WD_3 = 0.25 * (WD180 + WD200 + WD240 + WD280)
WS_3 = 0.5 * 0.25 * (Vse180 + Vnw180 + Vse200 + Vnw200 + Vse240 + Vnw240 + Vse280 + Vnw280)

T_4 = T320
RH_4 = RH320
WD_4 = WD320
WS_4 = 0.5 * (Vse320 + Vnw320)

T_0_00 = throwhour(T_0)
T_1_00 = throwhour(T_1)
T_2_00 = throwhour(T_2)
T_3_00 = throwhour(T_3)
T_4_00 = throwhour(T_4)

RH_0_00 = throwhour(RH_0)
RH_1_00 = throwhour(RH_1)
RH_2_00 = throwhour(RH_2)
RH_3_00 = throwhour(RH_3)
RH_4_00 = throwhour(RH_4)

WD_0_00 = throwhour(WD_0)
WD_1_00 = throwhour(WD_1)
WD_2_00 = throwhour(WD_2)
WD_3_00 = throwhour(WD_3)
WD_4_00 = throwhour(WD_4)

WS_0_00 = throwhour2(WS_0,T_0)
WS_1_00 = throwhour2(WS_1,T_0)
WS_2_00 = throwhour2(WS_2,T_0)
WS_3_00 = throwhour2(WS_3,T_0)
WS_4_00 = throwhour2(WS_4,T_0)



;PREPARING THE SIM AND OBS ARRAYS TO BE PLOTTED
T_0_obs = T_0_00(31:775)
T_1_obs = T_1_00(31:775)
T_2_obs = T_2_00(31:775)
T_3_obs = T_3_00(31:775)
T_4_obs = T_4_00(31:775)

RH_0_obs = RH_0_00(31:775)
RH_1_obs = RH_1_00(31:775)
RH_2_obs = RH_2_00(31:775)
RH_3_obs = RH_3_00(31:775)
RH_4_obs = RH_4_00(31:775)

WD_0_obs = WD_0_00(31:775)
WD_1_obs = WD_1_00(31:775)
WD_2_obs = WD_2_00(31:775)
WD_3_obs = WD_3_00(31:775)
WD_4_obs = WD_4_00(31:775)

WS_0_obs = WS_0_00(31:775)
WS_1_obs = WS_1_00(31:775)
WS_2_obs = WS_2_00(31:775)
WS_3_obs = WS_3_00(31:775)
WS_4_obs = WS_4_00(31:775)


print(WS_4_00)
print("done")

var_matrix_T0  = new((/2,745/),float)
var_matrix_T1  = new((/2,745/),float)
var_matrix_T2  = new((/2,745/),float)
var_matrix_T3  = new((/2,745/),float)
var_matrix_T4  = new((/2,745/),float)

var_matrix_RH0  = new((/2,745/),float)
var_matrix_RH1  = new((/2,745/),float)
var_matrix_RH2  = new((/2,745/),float)
var_matrix_RH3  = new((/2,745/),float)
var_matrix_RH4  = new((/2,745/),float)

var_matrix_WS0  = new((/2,745/),float)
var_matrix_WS1  = new((/2,745/),float)
var_matrix_WS2  = new((/2,745/),float)
var_matrix_WS3  = new((/2,745/),float)
var_matrix_WS4  = new((/2,745/),float)

var_matrix_WD0  = new((/2,745/),float)
var_matrix_WD1  = new((/2,745/),float)
var_matrix_WD2  = new((/2,745/),float)
var_matrix_WD3  = new((/2,745/),float)
var_matrix_WD4  = new((/2,745/),float)

var_matrix_T0(0,:) = (/T_0_sim/)
var_matrix_T0(1,:) = T_0_obs
var_matrix_T1(0,:) = (/T_1_sim/)
var_matrix_T1(1,:) = T_1_obs
var_matrix_T2(0,:) = (/T_2_sim/)
var_matrix_T2(1,:) = T_2_obs
var_matrix_T3(0,:) = (/T_3_sim/)
var_matrix_T3(1,:) = T_3_obs
var_matrix_T4(0,:) = (/T_4_sim/)
var_matrix_T4(1,:) = T_4_obs

var_matrix_RH0(0,:) = (/RH_0_sim/)
var_matrix_RH0(1,:) = RH_0_obs
var_matrix_RH1(0,:) = (/RH_1_sim/)
var_matrix_RH1(1,:) = RH_1_obs
var_matrix_RH2(0,:) = (/RH_2_sim/)
var_matrix_RH2(1,:) = RH_2_obs
var_matrix_RH3(0,:) = (/RH_3_sim/)
var_matrix_RH3(1,:) = RH_3_obs
var_matrix_RH4(0,:) = (/RH_4_sim/)
var_matrix_RH4(1,:) = RH_4_obs

var_matrix_WS0(0,:) = (/WS_0_sim/)
var_matrix_WS0(1,:) = WS_0_obs
var_matrix_WS1(0,:) = (/WS_1_sim/)
var_matrix_WS1(1,:) = WS_1_obs
var_matrix_WS2(0,:) = (/WS_2_sim/)
var_matrix_WS2(1,:) = WS_2_obs
var_matrix_WS3(0,:) = (/WS_3_sim/)
var_matrix_WS3(1,:) = WS_3_obs
var_matrix_WS4(0,:) = (/WS_4_sim/)
var_matrix_WS4(1,:) = WS_4_obs

var_matrix_WD0(0,:) = (/WD_0_sim/)
var_matrix_WD0(1,:) = WD_0_obs
var_matrix_WD1(0,:) = (/WD_1_sim/)
var_matrix_WD1(1,:) = WD_1_obs
var_matrix_WD2(0,:) = (/WD_2_sim/)
var_matrix_WD2(1,:) = WD_2_obs
var_matrix_WD3(0,:) = (/WD_3_sim/)
var_matrix_WD3(1,:) = WD_3_obs
var_matrix_WD4(0,:) = (/WD_4_sim/)
var_matrix_WD4(1,:) = WD_4_obs

timearr = ispan (1,745,1)
timearr@units = "hours since 2014-10-12 00:00:00"

;---Start the graphics
wks = gsn_open_wks("png","IAP_towermet_controlrun") ; send graphics to PNG file
gsnPaperOrientation = "portrait"
;---Plotting options for time series plot
res             = True
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

; Change y axis string and color for each plot.
  res@tiMainString     = "Temperature at IAP tower"          ; add title
  res@tiYAxisString = "T4"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_T4,res)    ; Create the four plots.

  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "T3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_T3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "T2"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_T2,res)

  res@tiYAxisString = "T1"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_T1,res)

  res@tiYAxisString = "T0"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_T0,res)

  res1                     = True
  res2                     = True
;  res1@gsnMaximize         = True
  res2@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
 amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)

  draw(xy1)    ; All four plots will be drawn.
  frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Wind Speed at IAP tower"          ; add title
  res@tiYAxisString = "WS4"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_WS4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "WS3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_WS3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "WS2"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_WS2,res)

  res@tiYAxisString = "WS1"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_WS1,res)

  res@tiYAxisString = "WS0"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_WS0,res)

 amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)
draw(xy1)
frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Wind Direction at IAP tower"          ; add title
  res@tiYAxisString = "WD4"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_WD4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "WD3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_WD3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "WD2"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_WD2,res)

  res@tiYAxisString = "WD1"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_WD1,res)

  res@tiYAxisString = "WD0"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_WD0,res)

 amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)
draw(xy1)
frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  res@tiMainString     = "Relative Humidity at IAP tower"          ; add title
  res@tiYAxisString = "RH4"
  xy1 = gsn_csm_xy(wks,timearr,var_matrix_RH4,res)    ; Create the four plots.
  res@pmLegendDisplayMode    = "Never"            ; turn off legend for subsequent plots

  res@tiYAxisString = "RH3"
  xy2 = gsn_csm_xy(wks,timearr,var_matrix_RH3,res)    ; They won't be drawn yet.

  res@tiYAxisString = "RH2"
  xy3 = gsn_csm_xy(wks,timearr,var_matrix_RH2,res)

  res@tiYAxisString = "RH1"
  xy4 = gsn_csm_xy(wks,timearr,var_matrix_RH1,res)

  res@tiYAxisString = "RH0"
  xy5 = gsn_csm_xy(wks,timearr,var_matrix_RH0,res)

 amid = gsn_attach_plots(xy1,(/xy2,xy3,xy4,xy5/),res1,res2)
draw(xy1)
frame(wks)



print("Completed in " + (get_cpu_time() - begTime)/60.0 + " minutes")

end
