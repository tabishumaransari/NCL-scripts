;THE SCRIPT READS AND FILLS NCDC STATION DATA WITH MISSING VALUES AND COMPARES THEM WITH MODEL OUTPUT FOR ALL STATIONS WITHIN D03
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
begTime = get_cpu_time()
;DATADir = "/data2/tabish/control-run-so4-ECMWF/"
DATADir = "/mnt/rasher/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

z1 = asciiread("/home/tabish/nclscripts/NCDC-combined.txt",-1,"string")
z2 = asciiread("/home/tabish/nclscripts/stn-combined.txt",-1,"string")
Tcount = 0
RHcount = 0
WScount = 0 
WDcount = 0

T_obs  = new(984,float)
RH_obs = new(984,float)
WS_obs = new(984,float)
WD_obs = new(984,float)

;;;;;;;;;;NOW PULLING OUT DERIVED METEOROLOGICAL VARIABLES FROM WRF DATA - THIS IS A ONE TIME OPERATION;;;;;;;;;;;;;;;;;;;;;;;;
print("pulling out 2m RH from wrf files")
rh2 = wrf_user_getvar(a,"rh2",-1)  ; RH the efficient way
printVarSummary(rh2)
print("time taken: " + (get_cpu_time() - begTime)/60.0)

print("pulling out 2m Temperature in Kelvin from wrf files")
begTime = get_cpu_time()
;T = wrf_user_getvar(a,"tc",-1)
T = a[:]->T2
print("converting to degC")
T = T - 273.15
print("time taken: " + (get_cpu_time() - begTime)/60.0)

print("pulling out UVMET from wrf files")
begTime = get_cpu_time()
uvmet = wrf_user_getvar(a,"uvmet10",-1)
umet = uvmet(0,:,:,:)
vmet = uvmet(1,:,:,:)
print("Time taken: " + (get_cpu_time() - begTime)/60.0)

z1_station = str_match(z1, stnnumber); SEARCH FOR THE PARTICULAR STATION
z2_station = str_match(z2, stnnumber); SEARCH FOR THE PARTICULAR STATION
print("dimension of this station")
print(dimsizes(z1_station))

emptyrow = stnnumber + " ***** ************ ***   * *** *** *** * * *  *** ** ** ** ** ** ** ** ** *   **   ** ****** ***** ****** *** *** ***** ***** ***** ***** **"

HOUR   = stringtofloat(str_get_cols(z1_station, 21,22)) 
HOURdim = dimsizes(HOUR)
fullhour=0
fill=0
z1_station_full = new(1008, string)

do i = 0,1005; THIS FAILS FOR ONE STATION WHERE ONLY 3 VALUES ARE PRESENT WITHIN 42 DAYS 
 if(fullhour.eq.24) then
  fullhour = 0
 end if
 print("i="+i + " fill="+fill + " fullhour="+fullhour) 
 if((fill.lt.HOURdim).and.(HOUR(fill).eq.fullhour)) then ; THIS CONDITION IS VIOLATED FOR THE SPECIFIC STATION
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
printVarSummary(loc)
print("J="+J +" I="+I)
;print(z1_station_full)
print("Time taken to repair obs data: " + (get_cpu_time() - begTime))
begTime = get_cpu_time()
print("calculating observed RH from Temp and Dewp")
RH = 100*(exp((17.625*DEWPC)/(243.04+DEWPC))/exp((17.625*TEMPC)/(243.04+TEMPC)))
print("Time taken to compute obs RH: " + (get_cpu_time() - begTime))
begTime = get_cpu_time()

T_obs(0:143) = TEMPC(0:143)
T_obs(144:983) = TEMPC(145:984)

RH_obs(0:143) = RH(0:143)
RH_obs(144:983) = RH(145:984)

WS_obs(0:143) = WSPEED(0:143)
WS_obs(144:983) = WSPEED(145:984)

WD_obs(0:143) = WDIR(0:143)
WD_obs(144:983) = WDIR(145:984)

T_obs_crop  = T_obs(48:983)
RH_obs_crop = RH_obs(48:983)
WS_obs_crop = WS_obs(48:983)
WD_obs_crop = WD_obs(48:983)

;;;;;;;;;;NOW PULLING OUT WRF DATA FROM THE STATION GRID;;;;;;;;;;;;;;;;;;;;;;;;

printVarSummary(rh2)
RH_sim = rh2(48:983,J,I)
T_sim = T(48:983,J,I)
u_sim = umet(48:983,J,I)
v_sim = vmet(48:983,J,I)
WS_sim =  wind_speed(u_sim,v_sim)
WD_sim = wind_direction(u_sim,v_sim,0)

;REPAIRING WIND DIRECTION FOR BETTER CORRELATIONS
do i=0,935
if(.not.ismissing(WD_obs_crop(i))) then
 if(WD_obs_crop(i).gt.WD_sim(i)) then
  if((WD_obs_crop(i) - WD_sim(i)).gt.180)then
   WD_sim(i) = WD_sim(i) + 180
  end if
 end if
 if(WD_obs_crop(i).lt.WD_sim(i)) then
  if((WD_sim(i) - WD_obs_crop(i)).gt.180) then
   WD_obs_crop(i) = WD_obs_crop(i) + 180
  end if
 end if
end if
;CALCULATING NO. OF PAIRS OF NON-MISSING DATA
if(.not.ismissing(T_obs_crop(i))) then Tcount = Tcount+1 end if
if(.not.ismissing(RH_obs_crop(i))) then RHcount = RHcount+1 end if
if(.not.ismissing(WS_obs_crop(i))) then WScount = WScount+1 end if
if(.not.ismissing(WD_obs_crop(i))) then WDcount = WDcount+1 end if
end do
print("Repaired Wind Direction")



T_obs_EP1  = T_obs_crop(72:215)
T_obs_EP2  = T_obs_crop(216:335)
T_obs_EP3  = T_obs_crop(336:503)
T_obs_APEC = T_obs_crop(528:767)

RH_obs_EP1  = RH_obs_crop(72:215)
RH_obs_EP2  = RH_obs_crop(216:335)
RH_obs_EP3  = RH_obs_crop(336:503)
RH_obs_APEC = RH_obs_crop(528:767)

WS_obs_EP1  = WS_obs_crop(72:215)
WS_obs_EP2  = WS_obs_crop(216:335)
WS_obs_EP3  = WS_obs_crop(336:503)
WS_obs_APEC = WS_obs_crop(528:767)

WD_obs_EP1  = WD_obs_crop(72:215)
WD_obs_EP2  = WD_obs_crop(216:335)
WD_obs_EP3  = WD_obs_crop(336:503)
WD_obs_APEC = WD_obs_crop(528:767)


T_sim_EP1  = T_sim(72:215)
T_sim_EP2  = T_sim(216:335)
T_sim_EP3  = T_sim(336:503)
T_sim_APEC = T_sim(528:767) 

RH_sim_EP1  = RH_sim(72:215)
RH_sim_EP2  = RH_sim(216:335)
RH_sim_EP3  = RH_sim(336:503)
RH_sim_APEC = RH_sim(528:767)

WS_sim_EP1  = WS_sim(72:215)
WS_sim_EP2  = WS_sim(216:335)
WS_sim_EP3  = WS_sim(336:503)
WS_sim_APEC = WS_sim(528:767)

WD_sim_EP1  = WD_sim(72:215)
WD_sim_EP2  = WD_sim(216:335)
WD_sim_EP3  = WD_sim(336:503)
WD_sim_APEC = WD_sim(528:767)


;;;;;;;;;;NOW CALCULATING STATS FOR ALL MET VARIABLES;;;;;;;;;
;;;;;;;;;FOR FULL 39 DAYS 
T_sim_avg = decimalPlaces(avg(T_sim),2,True)
T_obs_avg = decimalPlaces(avg(T_obs_crop),2,True)
T_bias    = decimalPlaces((T_sim_avg - T_obs_avg),2,True)
T_rmse    = decimalPlaces(dim_rmsd(T_sim,T_obs_crop),2,True)
T_r       = decimalPlaces(escorc(T_sim,T_obs_crop),2,True)

RH_sim_avg = decimalPlaces(avg(RH_sim),2,True)
RH_obs_avg = decimalPlaces(avg(RH_obs_crop),2,True)
RH_bias    = decimalPlaces((RH_sim_avg - RH_obs_avg),2,True)
RH_rmse    = decimalPlaces(dim_rmsd(RH_sim,RH_obs_crop),2,True)
RH_r       = decimalPlaces(escorc(RH_sim,RH_obs_crop),2,True)

WS_sim_avg = decimalPlaces(avg(WS_sim),2,True)
WS_obs_avg = decimalPlaces(avg(WS_obs_crop),2,True)
WS_bias    = decimalPlaces((WS_sim_avg - WS_obs_avg),2,True)
WS_rmse    = decimalPlaces(dim_rmsd(WS_sim,WS_obs_crop),2,True)
WS_r       = decimalPlaces(escorc(WS_sim,WS_obs_crop),2,True)

WD_sim_avg = decimalPlaces(avg(WD_sim),2,True)
WD_obs_avg = decimalPlaces(avg(WD_obs_crop),2,True)
WD_bias    = decimalPlaces((WD_sim_avg - WD_obs_avg),2,True)
WD_rmse    = decimalPlaces(dim_rmsd(WD_sim,WD_obs_crop),2,True)
WD_r       = decimalPlaces(escorc(WD_sim,WD_obs_crop),2,True)

print("Statistics for full 39 days for station "+stnnumber+" are:")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;FOR EPISODE1
T_sim_avg = decimalPlaces(avg(T_sim_EP1),2,True)
T_obs_avg = decimalPlaces(avg(T_obs_EP1),2,True)
T_bias    = decimalPlaces((T_sim_avg - T_obs_avg),2,True)
T_rmse    = decimalPlaces(dim_rmsd(T_sim_EP1,T_obs_EP1),2,True)
T_r       = decimalPlaces(escorc(T_sim_EP1,T_obs_EP1),2,True)

RH_sim_avg = decimalPlaces(avg(RH_sim_EP1),2,True)
RH_obs_avg = decimalPlaces(avg(RH_obs_EP1),2,True)
RH_bias    = decimalPlaces((RH_sim_avg - RH_obs_avg),2,True)
RH_rmse    = decimalPlaces(dim_rmsd(RH_sim_EP1,RH_obs_EP1),2,True)
RH_r       = decimalPlaces(escorc(RH_sim_EP1,RH_obs_EP1),2,True)

WS_sim_avg = decimalPlaces(avg(WS_sim_EP1),2,True)
WS_obs_avg = decimalPlaces(avg(WS_obs_EP1),2,True)
WS_bias    = decimalPlaces((WS_sim_avg - WS_obs_avg),2,True)
WS_rmse    = decimalPlaces(dim_rmsd(WS_sim_EP1,WS_obs_EP1),2,True)
WS_r       = decimalPlaces(escorc(WS_sim_EP1,WS_obs_EP1),2,True)

WD_sim_avg = decimalPlaces(avg(WD_sim_EP1),2,True)
WD_obs_avg = decimalPlaces(avg(WD_obs_EP1),2,True)
WD_bias    = decimalPlaces((WD_sim_avg - WD_obs_avg),2,True)
WD_rmse    = decimalPlaces(dim_rmsd(WD_sim_EP1,WD_obs_EP1),2,True)
WD_r       = decimalPlaces(escorc(WD_sim_EP1,WD_obs_EP1),2,True)

print("Statistics for Episode 1 for station "+stnnumber+" are:")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;FOR EPISODE2
T_sim_avg = decimalPlaces(avg(T_sim_EP2),2,True)
T_obs_avg = decimalPlaces(avg(T_obs_EP2),2,True)
T_bias    = decimalPlaces((T_sim_avg - T_obs_avg),2,True)
T_rmse    = decimalPlaces(dim_rmsd(T_sim_EP2,T_obs_EP2),2,True)
T_r       = decimalPlaces(escorc(T_sim_EP2,T_obs_EP2),2,True)

RH_sim_avg = decimalPlaces(avg(RH_sim_EP2),2,True)
RH_obs_avg = decimalPlaces(avg(RH_obs_EP2),2,True)
RH_bias    = decimalPlaces((RH_sim_avg - RH_obs_avg),2,True)
RH_rmse    = decimalPlaces(dim_rmsd(RH_sim_EP2,RH_obs_EP2),2,True)
RH_r       = decimalPlaces(escorc(RH_sim_EP2,RH_obs_EP2),2,True)

WS_sim_avg = decimalPlaces(avg(WS_sim_EP2),2,True)
WS_obs_avg = decimalPlaces(avg(WS_obs_EP2),2,True)
WS_bias    = decimalPlaces((WS_sim_avg - WS_obs_avg),2,True)
WS_rmse    = decimalPlaces(dim_rmsd(WS_sim_EP2,WS_obs_EP2),2,True)
WS_r       = decimalPlaces(escorc(WS_sim_EP2,WS_obs_EP2),2,True)

WD_sim_avg = decimalPlaces(avg(WD_sim_EP2),2,True)
WD_obs_avg = decimalPlaces(avg(WD_obs_EP2),2,True)
WD_bias    = decimalPlaces((WD_sim_avg - WD_obs_avg),2,True)
WD_rmse    = decimalPlaces(dim_rmsd(WD_sim_EP2,WD_obs_EP2),2,True)
WD_r       = decimalPlaces(escorc(WD_sim_EP2,WD_obs_EP2),2,True)

print("Statistics for Episode 2 for station "+stnnumber+" are:")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;FOR EPISODE3
T_sim_avg = decimalPlaces(avg(T_sim_EP3),2,True)
T_obs_avg = decimalPlaces(avg(T_obs_EP3),2,True)
T_bias    = decimalPlaces((T_sim_avg - T_obs_avg),2,True)
T_rmse    = decimalPlaces(dim_rmsd(T_sim_EP3,T_obs_EP3),2,True)
T_r       = decimalPlaces(escorc(T_sim_EP3,T_obs_EP3),2,True)

RH_sim_avg = decimalPlaces(avg(RH_sim_EP3),2,True)
RH_obs_avg = decimalPlaces(avg(RH_obs_EP3),2,True)
RH_bias    = decimalPlaces((RH_sim_avg - RH_obs_avg),2,True)
RH_rmse    = decimalPlaces(dim_rmsd(RH_sim_EP3,RH_obs_EP3),2,True)
RH_r       = decimalPlaces(escorc(RH_sim_EP3,RH_obs_EP3),2,True)

WS_sim_avg = decimalPlaces(avg(WS_sim_EP3),2,True)
WS_obs_avg = decimalPlaces(avg(WS_obs_EP3),2,True)
WS_bias    = decimalPlaces((WS_sim_avg - WS_obs_avg),2,True)
WS_rmse    = decimalPlaces(dim_rmsd(WS_sim_EP3,WS_obs_EP3),2,True)
WS_r       = decimalPlaces(escorc(WS_sim_EP3,WS_obs_EP3),2,True)

WD_sim_avg = decimalPlaces(avg(WD_sim_EP3),2,True)
WD_obs_avg = decimalPlaces(avg(WD_obs_EP3),2,True)
WD_bias    = decimalPlaces((WD_sim_avg - WD_obs_avg),2,True)
WD_rmse    = decimalPlaces(dim_rmsd(WD_sim_EP3,WD_obs_EP3),2,True)
WD_r       = decimalPlaces(escorc(WD_sim_EP3,WD_obs_EP3),2,True)

print("Statistics for Episode 3 for station "+stnnumber+" are:")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;FOR APEC PERIOD
T_sim_avg = decimalPlaces(avg(T_sim_APEC),2,True)
T_obs_avg = decimalPlaces(avg(T_obs_APEC),2,True)
T_bias    = decimalPlaces((T_sim_avg - T_obs_avg),2,True)
T_rmse    = decimalPlaces(dim_rmsd(T_sim_APEC,T_obs_APEC),2,True)
T_r       = decimalPlaces(escorc(T_sim_APEC,T_obs_APEC),2,True)

RH_sim_avg = decimalPlaces(avg(RH_sim_APEC),2,True)
RH_obs_avg = decimalPlaces(avg(RH_obs_APEC),2,True)
RH_bias    = decimalPlaces((RH_sim_avg - RH_obs_avg),2,True)
RH_rmse    = decimalPlaces(dim_rmsd(RH_sim_APEC,RH_obs_APEC),2,True)
RH_r       = decimalPlaces(escorc(RH_sim_APEC,RH_obs_APEC),2,True)

WS_sim_avg = decimalPlaces(avg(WS_sim_APEC),2,True)
WS_obs_avg = decimalPlaces(avg(WS_obs_APEC),2,True)
WS_bias    = decimalPlaces((WS_sim_avg - WS_obs_avg),2,True)
WS_rmse    = decimalPlaces(dim_rmsd(WS_sim_APEC,WS_obs_APEC),2,True)
WS_r       = decimalPlaces(escorc(WS_sim_APEC,WS_obs_APEC),2,True)

WD_sim_avg = decimalPlaces(avg(WD_sim_APEC),2,True)
WD_obs_avg = decimalPlaces(avg(WD_obs_APEC),2,True)
WD_bias    = decimalPlaces((WD_sim_avg - WD_obs_avg),2,True)
WD_rmse    = decimalPlaces(dim_rmsd(WD_sim_APEC,WD_obs_APEC),2,True)
WD_r       = decimalPlaces(escorc(WD_sim_APEC,WD_obs_APEC),2,True)

print("Statistics for APEC PERIOD for station "+stnnumber+" are:")
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
