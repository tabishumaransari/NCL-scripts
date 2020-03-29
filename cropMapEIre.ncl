; These files still have to be loaded manually

begin
ncol = 10
data = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/nclscripts/mapeire_trimmed.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

data@_FillValue = -999 
print("MapEIre trimmed file read-in successfully")

printVarSummary(data)

lon = data(:,0)
lat = data(:,1)

datac = new((/115770,10/),typeof(data))

count = 0
do i = 0,dimsizes(lon)-1 ;LOOP OVER ALL ROWS IN THE MAPEIRE TRIMMED DATA
 if ((lon(i).gt.-10.518).and.(lon(i).lt.-6.11838).and.(lat(i).gt.51.4388).and.(lat(i).lt.55.3653)) then
   datac(count,:) = data(i,:) 
   print("i="+i+" count="+count)
   count = count + 1
 end if
end do

;;;;;WRITING ASCII FILE OF DAILY MEAN WIND SPEED AND DIRECTION;;;;;;
header = (/"LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10"/)
hlist = [/header/]
alist = [/datac(:,0),datac(:,1),datac(:,2),datac(:,3),datac(:,4),datac(:,5),datac(:,6),datac(:,7),datac(:,8),datac(:,9)/]
print("alist created...now writing")
fname = "mapeire_cropped.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("written!")


end
