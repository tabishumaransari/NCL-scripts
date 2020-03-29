;TIME-SERIES FOR IAP POLLUTANT DATA FOR CONTROL RUN: 15OCT - 12NOV

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
print("Initializing arrays...")
;INITIALIZING OBS ARRAYS TO HOLD VALUES FROM 15OCT0000HRS TO 13NOV0000HRS MINUS 16OCT0000HRS

_260 = new(696,float)


print("reading wrf directories...")
DATADir1 = "/data2/tabish/control-run-so4-ECMWF/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
a = addfiles(FILES1,"r")
print("all wrf files loaded.")
times  = wrf_times_c(a[:]->Times,0)
I=79
J=144

bc_sim_260    = a[:]->bc_a01(:,3,J,I) + a[:]->bc_a02(:,3,J,I) +a[:]->bc_a03(:,3,J,I) +a[:]->bc_a04(:,3,J,I) +a[:]->bc_a05(:,3,J,I) +a[:]->bc_a06(:,3,J,I)
bc_sim_260_subset = bc_sim_260(112:807)
bc_sim_260_subset  = 1.15 * oc_sim_260_subset



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
  org_full         = tofloat(str_get_field(lines_useful,3,delim))
  org(0:31)        = org_full(0:31)
  org(32:695)      = org_full(33:696)
  so4_full         = tofloat(str_get_field(lines_useful,4,delim))
  so4(0:31)        = so4_full(0:31)
  so4(32:695)      = so4_full(33:696)
  no3_full         = tofloat(str_get_field(lines_useful,5,delim))
  no3(0:31)        = no3_full(0:31)
  no3(32:695)      = no3_full(33:696)
  nh4_full         = tofloat(str_get_field(lines_useful,6,delim))
  nh4(0:31)        = nh4_full(0:31)
  nh4(32:695)      = nh4_full(33:696)
  chl_full         = tofloat(str_get_field(lines_useful,7,delim))
  chl(0:31)        = chl_full(0:31)
  chl(32:695)      = chl_full(33:696)
  bc_full          = tofloat(str_get_field(lines_useful,8,delim))
  bc(0:31)         = bc_full(0:31)
  bc(32:695)       = bc_full(33:696)

; READ IN GASEOUS SPECIES AT GROUND SITE
  co_full         = tofloat(str_get_field(lines_useful,15,delim))
  co(0:31)        = co_full(0:31)
  co(32:695)      = co_full(33:696)
  no_full         = tofloat(str_get_field(lines_useful,16,delim))
  no(0:31)        = no_full(0:31)
  no(32:695)      = no_full(33:696)
  no2_full        = tofloat(str_get_field(lines_useful,17,delim))
  no2(0:31)       = no2_full(0:31)
  no2(32:695)     = no2_full(33:696)
  o3_full         = tofloat(str_get_field(lines_useful,19,delim))
  o3(0:31)        = o3_full(0:31)
  o3(32:695)      = o3_full(33:696)
  so2_full        = tofloat(str_get_field(lines_useful,20,delim))
  so2(0:31)       = so2_full(0:31)
  so2(32:695)     = so2_full(33:696)
  
;  co              = co*1000
  so2	          = so2*10
  so2 = where(so2.lt.0,0,so2)
  so2 = where(so2.gt.80,so2@_FillValue,so2)
  no2 = where(no2.lt.0,0,no2)
  o3  = where(o3.lt.0,0,o3)

; READ IN AEROSOL SPECIES AT 260M
  org_260_full    = tofloat(str_get_field(lines_useful,22,delim))
  org_260(0:31)   = org_260_full(0:31)
  org_260(32:695) = org_260_full(33:696)

  so4_260_full    = tofloat(str_get_field(lines_useful,23,delim))
  so4_260(0:31)   = so4_260_full(0:31)
  so4_260(32:695) = so4_260_full(33:696)

  no3_260_full    = tofloat(str_get_field(lines_useful,24,delim))
  no3_260(0:31)   = no3_260_full(0:31)
  no3_260(32:695) = no3_260_full(33:696)

  nh4_260_full    = tofloat(str_get_field(lines_useful,25,delim))
  nh4_260(0:31)   = nh4_260_full(0:31)
  nh4_260(32:695) = nh4_260_full(33:696)

  chl_260_full    = tofloat(str_get_field(lines_useful,26,delim))
  chl_260(0:31)   = chl_260_full(0:31)
  chl_260(32:695) = chl_260_full(33:696)
 
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
print("All obs arrays prepared now")
;  timefull     = tofloat(str_get_field(lines_full,11,delim))
;  datetime     = str_get_field(lines_full,10,delim1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

  var_matrix_no3  = new((/4,696/),float)  
  var_matrix_nh4  = new((/4,696/),float)  
  var_matrix_so4  = new((/4,696/),float)  
  var_matrix_oc  = new((/4,696/),float)  
  var_matrix_bc  = new((/4,696/),float)  
  var_matrix_chl  = new((/4,696/),float)  
  var_matrix_co   = new((/4,696/),float)  
  var_matrix_no2  = new((/4,696/),float)  
  var_matrix_so2  = new((/4,696/),float)  
  var_matrix_o3   = new((/4,696/),float)  
 
  var_matrix_oc_260  = new((/4,696/),float)  
  var_matrix_so4_260  = new((/4,696/),float)  
  var_matrix_no3_260  = new((/4,696/),float)  
  var_matrix_nh4_260  = new((/4,696/),float)  
  var_matrix_chl_260  = new((/4,696/),float)  

var_matrix_no3(0,:) = (/no3_sim_subset/)
var_matrix_no3(1,:) = (/no3_sim_subset_b/)
var_matrix_no3(2,:) = (/no3_sim_subset_c/)
var_matrix_no3(3,:) = no3

no3Octavg_Obs = avg(no3(71:286))
no3Octavg_baseline = avg(no3_sim_subset(71:286))
no3Octavg_controls = avg(no3_sim_subset_c(71:286))

no3Novavg_Obs = avg(no3(455:670))
no3Novavg_baseline = avg(no3_sim_subset(455:670))
no3Novavg_controls = avg(no3_sim_subset_b(455:670))


var_matrix_nh4(0,:) = (/nh4_sim_subset/)
var_matrix_nh4(1,:) = (/nh4_sim_subset_b/)
var_matrix_nh4(2,:) = (/nh4_sim_subset_c/)
var_matrix_nh4(3,:) = nh4

nh4Octavg_Obs = avg(nh4(71:286))
nh4Octavg_baseline = avg(nh4_sim_subset(71:286))
nh4Octavg_controls = avg(nh4_sim_subset_c(71:286))

nh4Novavg_Obs = avg(nh4(455:670))
nh4Novavg_baseline = avg(nh4_sim_subset(455:670))
nh4Novavg_controls = avg(nh4_sim_subset_b(455:670))



var_matrix_so4(0,:) = (/so4_sim_subset/)
var_matrix_so4(1,:) = (/so4_sim_subset_b/)
var_matrix_so4(2,:) = (/so4_sim_subset_c/)
var_matrix_so4(3,:) = so4

so4Octavg_Obs = avg(so4(71:286))
so4Octavg_baseline = avg(so4_sim_subset(71:286))
so4Octavg_controls = avg(so4_sim_subset_c(71:286))

so4Novavg_Obs = avg(so4(455:670))
so4Novavg_baseline = avg(so4_sim_subset(455:670))
so4Novavg_controls = avg(so4_sim_subset_b(455:670))


var_matrix_oc(0,:) = (/oc_sim_subset/)
var_matrix_oc(1,:) = (/oc_sim_subset_b/)
var_matrix_oc(2,:) = (/oc_sim_subset_c/)
var_matrix_oc(3,:) = org

ocOctavg_Obs = avg(org(71:286))
ocOctavg_baseline = avg(oc_sim_subset(71:286))
ocOctavg_controls = avg(oc_sim_subset_c(71:286))

ocNovavg_Obs = avg(org(455:670))
ocNovavg_baseline = avg(oc_sim_subset(455:670))
ocNovavg_controls = avg(oc_sim_subset_b(455:670))

var_matrix_bc(0,:) = (/bc_sim_subset/)
var_matrix_bc(1,:) = (/bc_sim_subset_b/)
var_matrix_bc(2,:) = (/bc_sim_subset_c/)
var_matrix_bc(3,:) = bc

bcOctavg_Obs = avg(bc(71:286))
bcOctavg_baseline = avg(bc_sim_subset(71:286))
bcOctavg_controls = avg(bc_sim_subset_c(71:286))

bcNovavg_Obs = avg(bc(455:670))
bcNovavg_baseline = avg(bc_sim_subset(455:670))
bcNovavg_controls = avg(bc_sim_subset_b(455:670))


var_matrix_chl(0,:) = (/chl_sim_subset/)
var_matrix_chl(1,:) = (/chl_sim_subset_b/)
var_matrix_chl(2,:) = (/chl_sim_subset_c/)
var_matrix_chl(3,:) = chl

chlOctavg_Obs = avg(chl(71:286))
chlOctavg_baseline = avg(chl_sim_subset(71:286))
chlOctavg_controls = avg(chl_sim_subset_c(71:286))

chlNovavg_Obs = avg(chl(455:670))
chlNovavg_baseline = avg(chl_sim_subset(455:670))
chlNovavg_controls = avg(chl_sim_subset_b(455:670))


var_matrix_co(0,:)  = (/co_sim_subset/)
var_matrix_co(1,:)  = (/co_sim_subset_b/)
var_matrix_co(2,:)  = (/co_sim_subset_c/)
var_matrix_co(3,:)  = co

coOctavg_Obs = avg(co(71:286))
coOctavg_baseline = avg(co_sim_subset(71:286))
coOctavg_controls = avg(co_sim_subset_c(71:286))

coNovavg_Obs = avg(co(455:670))
coNovavg_baseline = avg(co_sim_subset(455:670))
coNovavg_controls = avg(co_sim_subset_b(455:670))


var_matrix_no2(0,:) = (/no2_sim_subset/)
var_matrix_no2(1,:) = (/no2_sim_subset_b/)
var_matrix_no2(2,:) = (/no2_sim_subset_c/)
var_matrix_no2(3,:) = no2

no2Octavg_Obs = avg(no2(71:286))
no2Octavg_baseline = avg(no2_sim_subset(71:286))
no2Octavg_controls = avg(no2_sim_subset_c(71:286))

no2Novavg_Obs = avg(no2(455:670))
no2Novavg_baseline = avg(no2_sim_subset(455:670))
no2Novavg_controls = avg(no2_sim_subset_b(455:670))

var_matrix_so2(0,:) = (/so2_sim_subset/)
var_matrix_so2(1,:) = (/so2_sim_subset_b/)
var_matrix_so2(2,:) = (/so2_sim_subset_c/)
var_matrix_so2(3,:) = so2

so2Octavg_Obs = avg(so2(71:286))
so2Octavg_baseline = avg(so2_sim_subset(71:286))
so2Octavg_controls = avg(so2_sim_subset_c(71:286))

so2Novavg_Obs = avg(so2(455:670))
so2Novavg_baseline = avg(so2_sim_subset(455:670))
so2Novavg_controls = avg(so2_sim_subset_b(455:670))

var_matrix_o3(0,:)  = (/o3_sim_subset/)
var_matrix_o3(1,:)  = (/o3_sim_subset_b/)
var_matrix_o3(2,:)  = (/o3_sim_subset_c/)
var_matrix_o3(3,:)  = o3

o3Octavg_Obs = avg(o3(71:286))
o3Octavg_baseline = avg(o3_sim_subset(71:286))
o3Octavg_controls = avg(o3_sim_subset_c(71:286))

o3Novavg_Obs = avg(o3(455:670))
o3Novavg_baseline = avg(o3_sim_subset(455:670))
o3Novavg_controls = avg(o3_sim_subset_b(455:670))



var_matrix_oc_260(0,:)  = oc_sim_260_subset
var_matrix_oc_260(1,:)  = oc_sim_260_subset_b
var_matrix_oc_260(2,:)  = oc_sim_260_subset_c
var_matrix_oc_260(3,:)  = org_260
var_matrix_so4_260(0,:)  = so4_sim_260_subset
var_matrix_so4_260(1,:)  = so4_sim_260_subset_b
var_matrix_so4_260(2,:)  = so4_sim_260_subset_c
var_matrix_so4_260(3,:)  = so4_260
var_matrix_no3_260(0,:)  = no3_sim_260_subset
var_matrix_no3_260(1,:)  = no3_sim_260_subset_b
var_matrix_no3_260(2,:)  = no3_sim_260_subset_c
var_matrix_no3_260(3,:)  = no3_260
var_matrix_nh4_260(0,:)  = nh4_sim_260_subset
var_matrix_nh4_260(1,:)  = nh4_sim_260_subset_b
var_matrix_nh4_260(2,:)  = nh4_sim_260_subset_c
var_matrix_nh4_260(3,:)  = nh4_260
var_matrix_chl_260(0,:)  = chl_sim_260_subset
var_matrix_chl_260(1,:)  = chl_sim_260_subset_b
var_matrix_chl_260(2,:)  = chl_sim_260_subset_c
var_matrix_chl_260(3,:)  = chl_260


header1 = (/"ocsim ocAPEC ocOct ocObs bcsim bcAPEC bcOct bcObs no3sim no3APEC no3Oct no3Obs so4sim so4APEC so4Oct so4Obs nh4sim nh4APEC nh4Oct nh4Obs cosim coAPEC coOct coObs no2sim no2APEC no2Oct no2Obs o3sim o3APEC o3Oct o3Obs"/)
header2 = (/"ocsim ocAPEC ocOct ocObs no3sim no3APEC no3Oct no3Obs so4sim so4APEC so4Oct so4Obs nh4sim nh4APEC nh4Oct nh4Obs"/)

var_matrix_oc@_FillValue  = -999
var_matrix_bc@_FillValue  = -999
var_matrix_no3@_FillValue = -999
var_matrix_so4@_FillValue = -999
var_matrix_nh4@_FillValue = -999
var_matrix_co@_FillValue  = -999
var_matrix_no2@_FillValue = -999
var_matrix_o3@_FillValue  = -999

var_matrix_oc_260@_FillValue   = -999
var_matrix_no3_260@_FillValue  = -999
var_matrix_so4_260@_FillValue  = -999
var_matrix_nh4_260@_FillValue  = -999

hlist1 = [/header1/]
hlist2 = [/header2/]

alist1 = [/var_matrix_oc(0,:),var_matrix_oc(1,:),var_matrix_oc(2,:),var_matrix_oc(3,:),var_matrix_bc(0,:),var_matrix_bc(1,:),var_matrix_bc(2,:),var_matrix_bc(3,:),var_matrix_no3(0,:),var_matrix_no3(1,:),var_matrix_no3(2,:),var_matrix_no3(3,:),var_matrix_so4(0,:),var_matrix_so4(1,:),var_matrix_so4(2,:),var_matrix_so4(3,:),var_matrix_nh4(0,:),var_matrix_nh4(1,:),var_matrix_nh4(2,:),var_matrix_nh4(3,:),var_matrix_co(0,:),var_matrix_co(1,:),var_matrix_co(2,:),var_matrix_co(3,:),var_matrix_no2(0,:),var_matrix_no2(1,:),var_matrix_no2(2,:),var_matrix_no2(3,:),var_matrix_o3(0,:),var_matrix_o3(1,:),var_matrix_o3(2,:),var_matrix_o3(3,:)/]

alist2 = [/var_matrix_oc_260(0,:),var_matrix_oc_260(1,:),var_matrix_oc_260(2,:),var_matrix_oc_260(3,:),var_matrix_no3_260(0,:),var_matrix_no3_260(1,:),var_matrix_no3_260(2,:),var_matrix_no3_260(3,:),var_matrix_so4_260(0,:),var_matrix_so4_260(1,:),var_matrix_so4_260(2,:),var_matrix_so4_260(3,:),var_matrix_nh4_260(0,:),var_matrix_nh4_260(1,:),var_matrix_nh4_260(2,:),var_matrix_nh4_260(3,:)/]

print("alist created...now writing")
fname1 = "IAP_ts.txt"
fname2 = "IAP260m_ts.txt"
write_table(fname1, "w", hlist1, "%s")
write_table(fname1, "a", alist1, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

write_table(fname2, "w", hlist2, "%s")
write_table(fname2, "a", alist2, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

print("#~~~~~~~~~~~~~~~#~~~~~~~~~~~~~#~~~~~~~~~~~~~~#~~~~~~~~~~~~~~#")
print("#~~~~~~~~~~~~~~~#~~~~~~~APEC Period~~~#~~~October Period~~~~#")
print("#~~~~~~~~~~~~~~~#~~~~~~~~~~~~~#~~~~~~~~~~~~~~#~~~~~~~~~~~~~~#")
print("OC")
print("Oberved mean:        "+ocNovavg_Obs+"       "+ocOctavg_Obs)
print("Sim mean (baseline): "+ocNovavg_baseline+"       "+ocOctavg_baseline)
print("Sim mean (controls): "+ocNovavg_controls+"       "+ocOctavg_controls)
print("Absolute improvement: "+(ocNovavg_baseline-ocNovavg_controls)+"       "+(ocOctavg_baseline-ocOctavg_controls))
print("Relative improvement(%): "+((ocNovavg_baseline-ocNovavg_controls)*100/ocNovavg_baseline)+"       "+((ocOctavg_baseline-ocOctavg_controls)*100/ocOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("BC")
print("Oberved mean:        "+bcNovavg_Obs+"       "+bcOctavg_Obs)
print("Sim mean (baseline): "+bcNovavg_baseline+"       "+bcOctavg_baseline)
print("Sim mean (controls): "+bcNovavg_controls+"       "+bcOctavg_controls)
print("Absolute improvement: "+(bcNovavg_baseline-bcNovavg_controls)+"       "+(bcOctavg_baseline-bcOctavg_controls))
print("Relative improvement(%): "+((bcNovavg_baseline-bcNovavg_controls)*100/bcNovavg_baseline)+"       "+((bcOctavg_baseline-bcOctavg_controls)*100/bcOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO3")
print("Oberved mean:        "+no3Novavg_Obs+"       "+no3Octavg_Obs)
print("Sim mean (baseline): "+no3Novavg_baseline+"       "+no3Octavg_baseline)
print("Sim mean (controls): "+no3Novavg_controls+"       "+no3Octavg_controls)
print("Absolute improvement: "+(no3Novavg_baseline-no3Novavg_controls)+"       "+(no3Octavg_baseline-no3Octavg_controls))
print("Relative improvement(%): "+((no3Novavg_baseline-no3Novavg_controls)*100/no3Novavg_baseline)+"       "+((no3Octavg_baseline-no3Octavg_controls)*100/no3Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NH4")
print("Oberved mean:        "+nh4Novavg_Obs+"       "+nh4Octavg_Obs)
print("Sim mean (baseline): "+nh4Novavg_baseline+"       "+nh4Octavg_baseline)
print("Sim mean (controls): "+nh4Novavg_controls+"       "+nh4Octavg_controls)
print("Absolute improvement: "+(nh4Novavg_baseline-nh4Novavg_controls)+"       "+(nh4Octavg_baseline-nh4Octavg_controls))
print("Relative improvement(%): "+((nh4Novavg_baseline-nh4Novavg_controls)*100/nh4Novavg_baseline)+"       "+((nh4Octavg_baseline-nh4Octavg_controls)*100/nh4Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO4")
print("Oberved mean:        "+so4Novavg_Obs+"       "+so4Octavg_Obs)
print("Sim mean (baseline): "+so4Novavg_baseline+"       "+so4Octavg_baseline)
print("Sim mean (controls): "+so4Novavg_controls+"       "+so4Octavg_controls)
print("Absolute improvement: "+(so4Novavg_baseline-so4Novavg_controls)+"       "+(so4Octavg_baseline-so4Octavg_controls))
print("Relative improvement(%): "+((so4Novavg_baseline-so4Novavg_controls)*100/so4Novavg_baseline)+"       "+((so4Octavg_baseline-so4Octavg_controls)*100/so4Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("CHL")
print("Oberved mean:        "+chlNovavg_Obs+"       "+chlOctavg_Obs)
print("Sim mean (baseline): "+chlNovavg_baseline+"       "+chlOctavg_baseline)
print("Sim mean (controls): "+chlNovavg_controls+"       "+chlOctavg_controls)
print("Absolute improvement: "+(chlNovavg_baseline-chlNovavg_controls)+"       "+(chlOctavg_baseline-chlOctavg_controls))
print("Relative improvement(%): "+((chlNovavg_baseline-chlNovavg_controls)*100/chlNovavg_baseline)+"       "+((chlOctavg_baseline-chlOctavg_controls)*100/chlOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("CO")
print("Oberved mean:        "+coNovavg_Obs+"       "+coOctavg_Obs)
print("Sim mean (baseline): "+coNovavg_baseline+"       "+coOctavg_baseline)
print("Sim mean (controls): "+coNovavg_controls+"       "+coOctavg_controls)
print("Absolute improvement: "+(coNovavg_baseline-coNovavg_controls)+"       "+(coOctavg_baseline-coOctavg_controls))
print("Relative improvement(%): "+((coNovavg_baseline-coNovavg_controls)*100/coNovavg_baseline)+"       "+((coOctavg_baseline-coOctavg_controls)*100/coOctavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("NO2")
print("Oberved mean:        "+no2Novavg_Obs+"       "+no2Octavg_Obs)
print("Sim mean (baseline): "+no2Novavg_baseline+"       "+no2Octavg_baseline)
print("Sim mean (controls): "+no2Novavg_controls+"       "+no2Octavg_controls)
print("Absolute improvement: "+(no2Novavg_baseline-no2Novavg_controls)+"       "+(no2Octavg_baseline-no2Octavg_controls))
print("Relative improvement(%): "+((no2Novavg_baseline-no2Novavg_controls)*100/no2Novavg_baseline)+"       "+((no2Octavg_baseline-no2Octavg_controls)*100/no2Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("SO2")
print("Oberved mean:        "+so2Novavg_Obs+"       "+so2Octavg_Obs)
print("Sim mean (baseline): "+so2Novavg_baseline+"       "+so2Octavg_baseline)
print("Sim mean (controls): "+so2Novavg_controls+"       "+so2Octavg_controls)
print("Absolute improvement: "+(so2Novavg_baseline-so2Novavg_controls)+"       "+(so2Octavg_baseline-so2Octavg_controls))
print("Relative improvement(%): "+((so2Novavg_baseline-so2Novavg_controls)*100/so2Novavg_baseline)+"       "+((so2Octavg_baseline-so2Octavg_controls)*100/so2Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("O3")
print("Oberved mean:        "+o3Novavg_Obs+"       "+o3Octavg_Obs)
print("Sim mean (baseline): "+o3Novavg_baseline+"       "+o3Octavg_baseline)
print("Sim mean (controls): "+o3Novavg_controls+"       "+o3Octavg_controls)
print("Absolute improvement: "+(o3Novavg_baseline-o3Novavg_controls)+"       "+(o3Octavg_baseline-o3Octavg_controls))
print("Relative improvement(%): "+((o3Novavg_baseline-o3Novavg_controls)*100/o3Novavg_baseline)+"       "+((o3Octavg_baseline-o3Octavg_controls)*100/o3Octavg_baseline))
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

print("Total time taken in minutes: "+((get_cpu_time() - begTime)/60.0))

end
