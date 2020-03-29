; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol1 = 32
ncol2 = 16
data1 = readAsciiTable("IAP_ts.txt", ncol1, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data2 = readAsciiTable("IAP260m_ts.txt", ncol2, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data1@_FillValue = -999.0
data2@_FillValue = -999.0
print("table read-in successfully")


ocsim = (/data1(:,0)/)
ocobs = (/data1(:,3)/)

no3sim = (/data1(:,8)/)
no3obs = (/data1(:,11)/)

so4sim = (/data1(:,12)/)
so4obs = (/data1(:,15)/)

nh4sim = (/data1(:,16)/)
nh4obs = (/data1(:,19)/)


ocsim260 = (/data2(:,0)/)
ocobs260 = (/data2(:,3)/)

no3sim260 = (/data2(:,4)/)
no3obs260 = (/data2(:,7)/)

so4sim260 = (/data2(:,8)/)
so4obs260 = (/data2(:,11)/)

nh4sim260 = (/data2(:,12)/)
nh4obs260 = (/data2(:,15)/)


ocsimavg = avg(ocsim)
ocobsavg = avg(ocobs)

no3simavg = avg(no3sim)
no3obsavg = avg(no3obs)

so4simavg = avg(so4sim)
so4obsavg = avg(so4obs)

nh4simavg = avg(nh4sim)
nh4obsavg = avg(nh4obs)



ocsim260avg = avg(ocsim260)
ocobs260avg = avg(ocobs260)

no3sim260avg = avg(no3sim260)
no3obs260avg = avg(no3obs260)

so4sim260avg = avg(so4sim260)
so4obs260avg = avg(so4obs260)

nh4sim260avg = avg(nh4sim260)
nh4obs260avg = avg(nh4obs260)

surface_sim_total = ocsimavg + no3simavg + so4simavg + nh4simavg
upper_sim_total = ocsim260avg + no3sim260avg + so4sim260avg + nh4sim260avg

ocsimpc = (ocsimavg/surface_sim_total) * 100.0
no3simpc = (no3simavg/surface_sim_total) * 100.0
so4simpc = (so4simavg/surface_sim_total) * 100.0
nh4simpc = (nh4simavg/surface_sim_total) * 100.0

ocsim260pc = (ocsim260avg/upper_sim_total) * 100.0
no3sim260pc = (no3sim260avg/upper_sim_total) * 100.0
so4sim260pc = (so4sim260avg/upper_sim_total) * 100.0
nh4sim260pc = (nh4sim260avg/upper_sim_total) * 100.0

ocsimratio = ocsim260avg/ocsimavg
no3simratio = no3sim260avg/no3simavg
so4simratio = so4sim260avg/so4simavg
nh4simratio = nh4sim260avg/nh4simavg

ocobsratio = ocobs260avg/ocobsavg
no3obsratio = no3obs260avg/no3obsavg
so4obsratio = so4obs260avg/so4obsavg
nh4obsratio = nh4obs260avg/nh4obsavg

print("Surface:	oc:no3:so4:nh4="+ocsimpc+":"+no3simpc+":"+so4simpc+":"+nh4simpc)
print("260m   :	oc:no3:so4:nh4="+ocsim260pc+":"+no3sim260pc+":"+so4sim260pc+":"+nh4sim260pc)
print("260m/surface ratio for model: oc no3 so4 nh4 ="+ocsimratio+" "+no3simratio+" "+so4simratio+" "+nh4simratio)
print("260m/surface ratio for obs  : oc no3 so4 nh4 ="+ocobsratio+" "+no3obsratio+" "+so4obsratio+" "+nh4obsratio)



end
