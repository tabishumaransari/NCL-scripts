load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
begin

DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
;times       = a[:]->Times
times       = wrf_user_getvar(a,"times",-1)
printVarSummary(times)
pm25    = a[:]->PM2_5_DRY(:,0,J,I)
pm10    = a[:]->PM10(:,0,J,I)
co      = a[:]->co(:,0,J,I)
no      = a[:]->no(:,0,J,I)
no2     = a[:]->no2(:,0,J,I)
so2     = a[:]->so2(:,0,J,I)
o3      = a[:]->o3(:,0,J,I)

;pm25_corr   = new(985,float)
;pm10_corr   = new(985,float)
;co_corr   = new(985,float)
;no2_corr   = new(985,float)
;so2_corr   = new(985,float)
;o3_corr   = new(985,float)

;pm25_corr(0:143) = pm25_sim(0:143)
;pm25_corr(144)   = pm25_corr@_FillValue
;pm25_corr(145:984) = pm25_sim(144:983)
;pmcoarse_sim = pm10_sim - pm25_sim

no      = 1000* no
no2     = 1000* no2
so2     = 1000* so2
o3      = 1000* o3

;print(times + " PM2.5= " + pm25_sim+ " so2="+so2_sim+" no2="+no2_sim+" o3="+o3_sim+" co="+co_sim)

alist = [/times, pm25, pm10, co, no, no2, so2, o3/]
alist1= [/times/]

;write_table("wrf-surfacepol.txt", "w", alist, "%s%f%16.2f%16.2f%16.2f%16.2f%16.2f")
write_table("wrf-surfacepol_"+station+"_control-run.txt", "w", alist, "%s%f%f%f%f%f%f%f")
;write_table("wrf-surfacepol_"+station+".txt", "w", alist1, "%s")

delete(alist)
delete(times)
delete(pm25)
delete(pm10)
delete(co)
delete(no)
delete(no2)
delete(so2)
delete(o3)
end
