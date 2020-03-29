;CALCULATES THE FACTOR TO WHICH THE 25% CURRENT PRIMARY SO4 HAS TO BE MULTIPLIED 

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

DATADir = "/data3/tabish/control-run/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
I=79
J=144
so4_sim     = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) + a[:]->so4_a03(:,0,J,I) + a[:]->so4_a04(:,0,J,I) + a[:]->so4_a05(:,0,J,I) + a[:]->so4_a06(:,0,J,I)  
so4_sim_260 = a[:]->so4_a01(:,3,J,I) + a[:]->so4_a02(:,3,J,I) + a[:]->so4_a03(:,3,J,I) + a[:]->so4_a04(:,3,J,I) + a[:]->so4_a05(:,3,J,I) + a[:]->so4_a06(:,3,J,I)
p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)

so4_sim_subset = so4_sim(111:807)
so4_sim_260_subset = so4_sim_260(111:807)

d = ((p+pb)/(287.058*t2))
d_subset = d(111:807)

do i = 0, 696
 so4_sim_subset(i) = so4_sim_subset(i) * d_subset(i)
end do

so4_sim_260_subset = 1.15 * so4_sim_260_subset 



DATADir2 = "/data2/tabish/control-run-so4/"
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
b = addfiles(FILES2,"r")
so4_sim_b   = b[:]->so4_a01(:,0,J,I) + b[:]->so4_a02(:,0,J,I) +b[:]->so4_a03(:,0,J,I) +b[:]->so4_a04(:,0,J,I) +b[:]->so4_a05(:,0,J,I) +b[:]->so4_a06(:,0,J,I)
so4_sim_260_b   = b[:]->so4_a01(:,3,J,I) + b[:]->so4_a02(:,3,J,I) +b[:]->so4_a03(:,3,J,I) +b[:]->so4_a04(:,3,J,I) +b[:]->so4_a05(:,3,J,I) +b[:]->so4_a06(:,3,J,I)
p  = b[:]->P(:,0,J,I)
pb = b[:]->PB(:,0,J,I)
t2 = b[:]->T2(:,J,I)

so4_sim_subset_b     = so4_sim_b(111:807)
so4_sim_260_subset_b = so4_sim_260_b(111:807)

d = ((p+pb)/(287.058*t2))
d_subset = d(111:807)

do i = 0, 696
 so4_sim_subset_b(i) = so4_sim_subset_b(i) * d_subset(i)
end do

so4_sim_260_subset_b = 1.15 * so4_sim_260_subset_b

FNLmean    = avg(so4_sim_subset)
FNLso4mean = avg(so4_sim_subset_b)

FNLmean260    = avg(so4_sim_260_subset)
FNLso4mean260 = avg(so4_sim_260_subset_b)


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


OBSso4mean = avg(so4)
OBSso4mean260 = avg(so4_260)

print("FNL so4 mean with only secondary so4 = "+ FNLmean)
print("FNL so4 mean with secondary and 25% primary so4 = "+ FNLso4mean)
print("OBS so4 mean  = "+ OBSso4mean)

print("FNL so4 mean with only secondary so4 at 260m = "+ FNLmean260)
print("FNL so4 mean with secondary and 25% primary so4 at 260m = "+ FNLso4mean260)
print("OBS so4 mean at 260m = "+ OBSso4mean260)



end

