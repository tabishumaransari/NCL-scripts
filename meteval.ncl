;THE SCRIPT READS AND FILLS NCDC STATION DATA WITH MISSING VALUES AND COMPARES THEM WITH MODEL OUTPUT
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

z1 = asciiread("/data1/tabish/nclscripts/NCDC-combined.txt",-1,"string")
z2 = asciiread("/data1/tabish/nclscripts/stn-combined.txt",-1,"string")
z1_station = str_match(z1, stnnumber); SEARCH FOR THE PARTICULAR STATION
z2_station = str_match(z2, stnnumber); SEARCH FOR THE PARTICULAR STATION
print("dimension of this station")
print(dimsizes(z1_station))

emptyrow = stnnumber + " ***** ************ ***   * *** *** *** * * *  *** ** ** ** ** ** ** ** ** *   **   ** ****** ***** ****** *** *** ***** ***** ***** ***** **"

HOUR   = stringtofloat(str_get_cols(z1_station, 21,22)) 
fullhour=0
fill=0
z1_station_full = new(1008, string)

do i = 0,1005
 if(fullhour.eq.24) then
  fullhour = 0
 end if
 print("i="+i + " fill="+fill + " fullhour="+fullhour) 
 if(HOUR(fill).eq.fullhour) then
  z1_station_full(i) = z1_station(fill)
  fill = fill + 1
 else
  z1_station_full(i) = emptyrow  
 end if
 fullhour = fullhour + 1
end do

z1_station_full(1006) = emptyrow
z1_station_full(1007) = emptyrow

if(dimsizes(z1_station).eq.dimsizes(z1_station_full))then
 z1_station_full = z1_station
end if


LAT    = stringtofloat(str_get_cols(z2_station, 128,135))
LON    = stringtofloat(str_get_cols(z2_station, 137,145))
loc    = wrf_user_ll_to_ij(a,LON,LAT,True)
loc = loc -1
I = loc(0)
J = loc(1)

USAF   = stringtofloat(str_get_cols(z1_station_full, 1,6))
YEAR   = stringtofloat(str_get_cols(z1_station_full, 13,16))
MONTH  = stringtofloat(str_get_cols(z1_station_full, 17,18))
DAY    = stringtofloat(str_get_cols(z1_station_full, 19,20))
HR     = stringtofloat(str_get_cols(z1_station_full, 21,22))
MIN    = stringtofloat(str_get_cols(z1_station_full, 23,24))
WDIR   = stringtofloat(str_get_cols(z1_station_full, 26,28))
WDIR   = where(WDIR.eq.990,9.96921e+36,WDIR)
WSPEED = stringtofloat(str_get_cols(z1_station_full, 30,32))
TEMP   = stringtofloat(str_get_cols(z1_station_full, 83,86))
DEWP   = stringtofloat(str_get_cols(z1_station_full, 88,91))
SLP    = stringtofloat(str_get_cols(z1_station_full, 93,98))
STP    = stringtofloat(str_get_cols(z1_station_full, 106,111))
DEWPC = (DEWP - 32) / 1.8  ; CONVERT FARENHEIT TO CELSIUS
TEMPC = (TEMP - 32) / 1.8
;print(TEMPC +" "+WSPEED+" "+WDIR)
print(LAT + " " + LON)
print("I="+I +" J="+J)
;print(z1_station_full)
print("Time taken to repair obs data: " + (get_cpu_time() - begTime))
begTime = get_cpu_time()
print("calculating observed RH from Temp and Dewp")
RH = 100*(exp((17.625*DEWPC)/(243.04+DEWPC))/exp((17.625*TEMPC)/(243.04+TEMPC)))
print("Time taken to compute obs RH: " + (get_cpu_time() - begTime))
begTime = get_cpu_time()
T_obs  = new(984,float)
RH_obs = new(984,float)
WS_obs = new(984,float)
WD_obs = new(984,float)

T_obs(0:143) = TEMPC(0:143)
T_obs(144:983) = TEMPC(145:984)

RH_obs(0:143) = RH(0:143)
RH_obs(144:983) = RH(145:984)

WS_obs(0:143) = WSPEED(0:143)
WS_obs(144:983) = WSPEED(145:984)

WD_obs(0:143) = WDIR(0:143)
WD_obs(144:983) = WDIR(145:984)

Tcount = 0
RHcount = 0
WScount = 0
WDcount = 0

;;;;;;;;;;NOW PULLING OUT WRF DATA FROM THE STATION GRID;;;;;;;;;;;;;;;;;;;;;;;;
print("pulling out RH from wrf files")
rh = wrf_user_getvar(a,"rh",-1)  ; RH the efficient way
print("time taken: " + (get_cpu_time() - begTime)/60.0)

print("pulling out Temperature in degC from wrf files")
begTime = get_cpu_time()
T = wrf_user_getvar(a,"tc",-1)
print("time taken: " + (get_cpu_time() - begTime)/60.0)

print("pulling out UVMET from wrf files")
begTime = get_cpu_time()
uvmet = wrf_user_getvar(a,"uvmet",-1)
umet = uvmet(0,:,:,:,:)
vmet = uvmet(1,:,:,:,:)
print("Time taken: " + (get_cpu_time() - begTime)/60.0)
printVarSummary(RH)
RH_sim = rh(:,0,J,I)
T_sim = T(:,0,J,I)
u_sim = umet(:,0,J,I)
v_sim = vmet(:,0,J,I)
WS_sim =  wind_speed(u_sim,v_sim)
WD_sim = wind_direction(u_sim,v_sim,0)

;REPAIRING WIND DIRECTION FOR BETTER CORRELATIONS
do i=0,983
if(.not.ismissing(WD_obs(i))) then
 if(WD_obs(i).gt.WD_sim(i)) then
  if((WD_obs(i) - WD_sim(i)).gt.180)then
   WD_sim(i) = WD_sim(i) + 180
  end if
 end if
 if(WD_obs(i).lt.WD_sim(i)) then
  if((WD_sim(i) - WD_obs(i)).gt.180) then
   WD_obs(i) = WD_obs(i) + 180
  end if
 end if
end if
;CALCULATING NO. OF PAIRS OF NON-MISSING DATA
if(.not.ismissing(T_obs(i))) then Tcount = Tcount+1 end if
if(.not.ismissing(RH_obs(i))) then RHcount = RHcount+1 end if
if(.not.ismissing(WS_obs(i))) then WScount = WScount+1 end if
if(.not.ismissing(WD_obs(i))) then WDcount = WDcount+1 end if
end do
print("Repaired Wind Direction")

T_sim_avg = avg(T_sim)
T_obs_avg = avg(T_obs)
T_bias    = T_sim_avg - T_obs_avg
T_rmse    = dim_rmsd(T_sim,T_obs)
T_r       = escorc(T_sim,T_obs)

RH_sim_avg = avg(RH_sim)
RH_obs_avg = avg(RH_obs)
RH_bias    = RH_sim_avg - RH_obs_avg
RH_rmse    = dim_rmsd(RH_sim,RH_obs)
RH_r       = escorc(RH_sim,RH_obs)

WS_sim_avg = avg(WS_sim)
WS_obs_avg = avg(WS_obs)
WS_bias    = WS_sim_avg - WS_obs_avg
WS_rmse    = dim_rmsd(WS_sim,WS_obs)
WS_r       = escorc(WS_sim,WS_obs)

WD_sim_avg = avg(WD_sim)
WD_obs_avg = avg(WD_obs)
WD_bias    = WD_sim_avg - WD_obs_avg
WD_rmse    = dim_rmsd(WD_sim,WD_obs)
WD_r       = escorc(WD_sim,WD_obs)

print("Average statistics for the station "+stnnumber+" are:")
print("N pairs of data for Temperature="+Tcount)
print("Temp mod.="+T_sim_avg)
print("Temp obs.="+T_obs_avg)
print("Temp Bias= "+T_bias)
print("Temp RMSE="+T_rmse)
print("Temp R="+T_r)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("N pairs of data for RH="+RHcount)
print("RH mod.="+RH_sim_avg)
print("RH obs.="+RH_obs_avg)
print("RH Bias= "+RH_bias)
print("RH RMSE="+RH_rmse)
print("RH R="+RH_r)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("N pairs of data for WS="+WScount)
print("WS mod.="+WS_sim_avg)
print("WS obs.="+WS_obs_avg)
print("WS Bias= "+WS_bias)
print("WS RMSE="+WS_rmse)
print("WS R="+WS_r)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("N pairs of data for WD="+WDcount)
print("WD mod.="+WD_sim_avg)
print("WD obs.="+WD_obs_avg)
print("WD Bias= "+WD_bias)
print("WD RMSE="+WD_rmse)
print("WD R="+WD_r)




end
