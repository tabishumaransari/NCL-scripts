;TO PLOT IAP TOWERMET VS WRF DATA WITH IMPROVED AUTOMATIC FUNCTIONS FOR WS AND WD
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

;MAIN PROGRAM
begin
begTime = get_cpu_time()
;DATADir = "/data3/tabish/control-run/"
DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

RH = wrf_user_getvar(a,"rh",-1)  ; RH the efficient way
print("RH calculated the efficient way")
printVarSummary(RH)


T = wrf_user_getvar(a,"tc",-1) 
uvmet = wrf_user_getvar(a,"uvmet",-1)
umet = uvmet(0,:,:,:,:)
vmet = uvmet(1,:,:,:,:)

RH_3_sim = RH(40:784,3,144,79)
T_3_sim = T(40:784,3,144,79)
u_3_sim = umet(40:784,3,144,79)
v_3_sim = vmet(40:784,3,144,79)

WS_3_sim = wind_speed(u_3_sim,v_3_sim)
WD_3_sim = wind_direction(u_3_sim,v_3_sim,0)


;;;;;;;;;;;;;;OBSERVATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filename = "/data1/tabish/surface_data/IAP-towermet.csv"
delim1 = ", :" ; multiple delimiters to separate day from date to find missing times
delim = "," ; delimiter

;---Read in file as array of strings so we can parse each line
 lines = asciiread(filename,-1,"string")
 str = ",9.96921e+36,"
 lines = str_sub_str(lines,",,",str); REPLACE BLANK SPACES WITH ZERO
 lines = str_sub_str(lines,",,",str); REPLACE ANY REMAINING BLANK SPACES WITH ZERO
 mins    = tofloat(str_get_field(lines,3,delim1))
 mins    = where((mins.ge.45).or.(mins.le.15),mins,mins@_FillValue)
 lines_useful = where(mins.ne.mins@_FillValue,lines,lines@_FillValue)
print(lines_useful)

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


T_3 = 0.25 * (T180 + T200 + T240 + T280)
RH_3 = 0.25 * (RH180 + RH200 + RH240 + RH280)
WD_3 = 0.25 * (WD180 + WD200 + WD240 + WD280)
WS_3 = 0.5 * 0.25 * (Vse180 + Vnw180 + Vse200 + Vnw200 + Vse240 + Vnw240 + Vse280 + Vnw280)


T_3_00 = throwhour(T_3)
RH_3_00 = throwhour(RH_3)
WD_3_00 = throwhour(WD_3)
WS_3_00 = throwhour2(WS_3,T_3)
;WS_3_00 = throwhour(WS_3)



;PREPARING THE SIM AND OBS ARRAYS TO BE PLOTTED
T_3_obs = T_3_00(31:775)
RH_3_obs = RH_3_00(31:775)
WD_3_obs = WD_3_00(31:775)
WS_3_obs = WS_3_00(31:775)

print("done")

var_matrix_T3  = new((/2,745/),float)

var_matrix_RH3  = new((/2,745/),float)

var_matrix_WS3  = new((/2,745/),float)

var_matrix_WD3  = new((/2,745/),float)

var_matrix_T3(0,:) = (/T_3_sim/)
var_matrix_T3(1,:) = T_3_obs

var_matrix_RH3(0,:) = (/RH_3_sim/)
var_matrix_RH3(1,:) = RH_3_obs

var_matrix_WS3(0,:) = (/WS_3_sim/)
var_matrix_WS3(1,:) = WS_3_obs

var_matrix_WD3(0,:) = (/WD_3_sim/)
var_matrix_WD3(1,:) = WD_3_obs

header = (/"Tsim Tobs RHsim RHobs WSsim WSobs WDsim WDobs"/)

var_matrix_T3@_FillValue  = -999
var_matrix_RH3@_FillValue = -999
var_matrix_WS3@_FillValue = -999
var_matrix_WD3@_FillValue = -999

hlist = [/header/]
alist = [/var_matrix_T3(0,:),var_matrix_T3(1,:),var_matrix_RH3(0,:),var_matrix_RH3(1,:),var_matrix_WS3(0,:),var_matrix_WS3(1,:),var_matrix_WD3(0,:),var_matrix_WD3(1,:)/]
print("alist created...now writing")
fname = "IAPtowermet_modlev3_ts.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

print("Completed in " + (get_cpu_time() - begTime)/60.0 + " minutes")

end
