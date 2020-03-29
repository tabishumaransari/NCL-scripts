ncol = 10
data = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/mapeire_NFR_3k_trimcrop.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("MapEIre 3km trimcrop file read-in successfully")

;READING IN EACH COLUMN TO A SEPARATE ARRAY
LON   = data(:,0)
LAT   = data(:,1)
CO    = data(:,2)
NO    = data(:,3)
SO2   = data(:,4)
NMVOC = data(:,5)
NH3   = data(:,6)
BC    = data(:,7)
PM25  = data(:,8)
PM10  = data(:,9)

;USER-DEFINED FUNCTION TO FIND THE NEAREST POINT AND RETURN CORRESPONDING ROW IN THE DATA
undef("nearestrow")
function nearestrow(lon,lat)
begin
 min_d = 100.0
 do i = 0, dimsizes(LAT)-1
  d = (LON(i)-lon)^2 + (LAT(i)-lat)^2 
  if(d.lt.min_d)then
   min_d = d
   row = i
  end if
 end do
 return(row)
end


begin
a = addfile ("/media/tabish/DataDisk/Dublin-study/mapeire-sita/mapeire-wrfchemi/wrfchemi_00z_d02_mapeire1.nc","w")
b = addfile ("/media/tabish/DataDisk/Dublin-study/mapeire-sita/ROImask.nc","r")
d02mask = b->ROImask_d02

;READING OFF KEY VARIABLES TO OVERWRITE LATER
lat = a->XLAT
lon = a->XLONG
co = a->E_CO
no = a->E_NO
so2 = a->E_SO2
nmvoc = a->E_C2H6
nh3 = a->E_NH3
bc = a->E_ECI
pm25 = a->E_PM25I
pm10 = a->E_PM_10
print(dimsizes(lat))
x=dimsizes(lat(:,0))
y=dimsizes(lat(0,:))

printMinMax(lon,True)
printMinMax(lat,True)


do i = 0, x-1
 do j = 0, y-1
  if(d02mask(0,0,i,j).eq.1)then
    r = nearestrow(lon(i,j),lat(i,j))
    print("i="+i+" j="+j+" lon="+lon(i,j)+" lat="+lat(i,j)+" nearest row="+r)
    co(0,0,i,j)    = CO(r)
    no(0,0,i,j)    = NO(r)
    so2(0,0,i,j)   = SO2(r)
    nmvoc(0,0,i,j) = NMVOC(r)
    nh3(0,0,i,j)   = NH3(r)
    bc(0,0,i,j)    = BC(r)
    pm25(0,0,i,j)  = PM25(r)
    pm10(0,0,i,j)  = PM10(r)
  end if
 end do
end do

a->me_CO    = co ;updating CO grid with MapEIre data
a->me_NO    = no ;updating CO grid with MapEIre data
a->me_SO2   = so2 ;updating CO grid with MapEIre data
a->me_NMVOC = nmvoc ;updating CO grid with MapEIre data
a->me_NH3   = nh3 ;updating CO grid with MapEIre data
a->me_BC    = bc ;updating CO grid with MapEIre data
a->me_PM25  = pm25 ;updating CO grid with MapEIre data
a->me_PM10  = pm10 ;updating CO grid with MapEIre data
print("success!")

end
