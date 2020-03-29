;THIS SCRIPTS READS IN SURFACE POLLUTANT DATA FROM 1492 SURFACE STATIONS ACROSS CHINA AND PREPARES A SCATTER PLOT FOR EACH POLLUTANT VS WRF SIMULATED VALUES
begin
begTime = get_cpu_time()
;diri = "/data1/tabish/surface_data/12Oct2014-15Nov2014_filled/"
;fname = systemfunc("ls -1 " + diri + "201410*")
fname = systemfunc("ls -1 /data1/tabish/surface_data/12Oct2014-15Nov2014_filled/201410* /data1/tabish/surface_data/12Oct2014-15Nov2014_filled/20141101000000.txt")

DATADir = "/data2/tabish/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

polstations = asciiread("polstations_D03",-1,"string")
stnnumber_array = stringtodouble(str_get_cols(polstations, 4,14))
;stnnumber_array = todouble(str_get_field(polstations,1," ")) ;extract 1st column of the first file for station number
lat_array       = todouble(str_get_field(polstations,2," ")) ;extract 2nd column of the first file for LON
lon_array       = todouble(str_get_field(polstations,3," ")) ;extract 3rd column of the first file for LAT
print(stnnumber_array+" "+lon_array+" "+lat_array)

stnlen = dimsizes(stnnumber_array)
LEN = 480 * stnlen 
print(LEN)
;DECLARE LARGE ARRAYS FOR CORRELATION
pm25_obs = new (LEN,float,-999)
pm25_sim = new (LEN,float,-999)
pm10_obs = new (LEN,float,-999)
pm10_sim = new (LEN,float,-999)
co_obs   = new (LEN,float,-999)
co_sim   = new (LEN,float,-999)
no2_obs  = new (LEN,float,-999)
no2_sim  = new (LEN,float,-999)
so2_obs  = new (LEN,float,-999)
so2_sim  = new (LEN,float,-999)
o3_obs   = new (LEN,float,-999)
o3_sim   = new (LEN,float,-999)
count = 0
sp = 0
ep = 479
delim = " "
do i = 0, stnlen-1 ; LOOP OVER 1312 SURFACE POLLUTANT STATIONS PRESENT WITHIN D01
;do i = 0, 2 ; LOOP OVER 1312 SURFACE POLLUTANT STATIONS PRESENT WITHIN D01
 stnnumber = stnnumber_array(i)
 lon       = lon_array(i)
 lat       = lat_array(i)
; print("Now working on station no. "+stnnumber+" lat="+lat+" lon="+lon)
 do j = 0, 480 ; BEGIN TIME LOOP
  lines = asciiread(fname(j),-1,"string"); READ THE DATA FOR ALL STATIONS FOR THE Jth TIME
  line_station = str_match(lines, stnnumber); SEARCH FOR THE PARTICULAR STATION
  filename = str_get_cols(fname(j), 54,67)
;  print(line_station)
  if(j.ne.104)then pm25_obs(count) = tofloat(str_get_field(line_station,4,delim)) end if ;extract 4th column of the first file to initialize pm2.5
  if(j.ne.104)then pm10_obs(count) = tofloat(str_get_field(line_station,5,delim)) end if ;extract 5th column of the first file to initialize pm10
  if(j.ne.104)then co_obs(count)   = tofloat(str_get_field(line_station,6,delim)) end if ;extract 6th column of the first file to initialize CO
  if(j.ne.104)then no2_obs(count)  = tofloat(str_get_field(line_station,7,delim)) end if ;extract 7th column of the first file to initialize NO2
  if(j.ne.104)then so2_obs(count)  = tofloat(str_get_field(line_station,8,delim)) end if ;extract 8th column of the first file to initialize SO2
  if(j.ne.104)then o3_obs(count)   = tofloat(str_get_field(line_station,9,delim)) end if ;extract 9th column of the first file to initialize O3
  if(j.ne.104)then print(filename+" i="+i+" j="+j+" count="+count+" "+stnnumber+" "+lon+" "+lat+" "+pm25_obs(count)+" "+pm10_obs(count)) end if 
  if(j.ne.104)then count = count + 1 end if 
  delete(lines)
 end do ; END TIME LOOP
 ;RETRIEVE CORREPONDING SIMULATED VALUE FROM WRF D03
  loc    = wrf_user_ll_to_ij(a,lon,lat,True)
  loc = loc -1
  I = loc(0)
  J = loc(1)
  print("I="+I+" J="+J)
  print("sp="+sp +" ep="+ep)
  pm25sim = a[:]->PM2_5_DRY(:,0,J,I)
  pm10sim = a[:]->PM10(:,0,J,I)
  cosim = a[:]->co(:,0,J,I)
  no2sim = a[:]->no2(:,0,J,I)
  so2sim = a[:]->so2(:,0,J,I)
  o3sim = a[:]->o3(:,0,J,I)
  pm25_sim(sp:ep) = pm25sim(40:519)
  pm10_sim(sp:ep) = pm10sim(40:519)
  co_sim(sp:ep)   = cosim(40:519)
  no2_sim(sp:ep)  = no2sim(40:519)
  so2_sim(sp:ep)  = so2sim(40:519)
  o3_sim(sp:ep)   = o3sim(40:519)
  sp = sp + 480
  ep = ep + 480
  delete(pm25sim)
  delete(pm10sim)
  delete(cosim)
  delete(no2sim)
  delete(so2sim)
  delete(o3sim)

end do ; END STATION LOOP
 pm25_obs = where(pm25_obs.eq.0,-999,pm25_obs)
 pm10_obs = where(pm10_obs.eq.0,-999,pm10_obs)
 co_obs   = where(co_obs.eq.0,-999,co_obs/1.1642)
 no2_obs  = where(no2_obs.eq.0,-999,no2_obs/1.9125)
 so2_obs  = where(so2_obs.eq.0,-999,so2_obs/2.6609)
 o3_obs   = where(o3_obs.eq.0,-999,o3_obs/1.9957)

 no2_sim = 1000*no2_sim
 so2_sim = 1000*so2_sim
 o3_sim = 1000*o3_sim

alist = [/pm25_obs, pm10_obs, co_obs, no2_obs, so2_obs, o3_obs/]
blist = [/pm25_sim, pm10_sim, co_sim, no2_sim, so2_sim, o3_sim/]
write_table("corr-array-obs_d03", "w", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
write_table("corr-array-sim_d03", "w", blist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")

print("Done!")
print("script runtime: " + (get_cpu_time() - begTime)/60.0)
end
