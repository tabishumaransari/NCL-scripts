;THIS SCRIPT READS THE TRIMMED FILES FOR 1KM, 3KM, 9KM RESOLUTIONS AND CROPS THE DATA FOR ROI REGION
begin
ncol = 10
data = readAsciiTable("/media/tabish/DataDisk/LEC_desktopbackup_23092019/nclscripts/mapeire_trimmed.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/mapeire_NFR_1k_trimmed.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/mapeire_NFR_3k_trimmed.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/mapeire_NFR_9k_trimmed.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

data1k@_FillValue = -999 
data3k@_FillValue = -999 
data9k@_FillValue = -999 
print("MapEIre trimmed file read-in successfully")

n1 = dimsizes(data1k(:,0))
n3 = dimsizes(data3k(:,0))
n9 = dimsizes(data9k(:,0))
print(n1+"	"+n3+"	"+n9)

data1c = new((/n1,10/),typeof(data1k))
data3c = new((/n3,10/),typeof(data3k))
data9c = new((/n9,10/),typeof(data9k))

;CROPPING 1KM RESOLUTION DATA
lon = data1k(:,0)
lat = data1k(:,1)
count1 = 0
do i = 0,n1-1 ;LOOP OVER ALL ROWS IN THE MAPEIRE TRIMMED DATA
 if ((lon(i).gt.-7.00095).and.(lon(i).lt.-5.50809).and.(lat(i).gt.52.9302).and.(lat(i).lt.53.8139)) then
   data1c(count1,:) = data1k(i,:) 
  ; print("i="+i+" count="+count1)
   count1 = count1 + 1
 end if
end do
delete(lon)
delete(lat)


;CROPPING 3KM RESOLUTION DATA
lon = data3k(:,0)
lat = data3k(:,1)
count3 = 0
do i = 0,n3-1 ;LOOP OVER ALL ROWS IN THE MAPEIRE TRIMMED DATA
 if ((lon(i).gt.-10.999).and.(lon(i).lt.-3.92682).and.(lat(i).gt.51.3224).and.(lat(i).lt.55.4235)) then
   data3c(count3,:) = data3k(i,:)
 ;  print("i="+i+" count="+count3)
   count3 = count3 + 1
 end if
end do
delete(lon)
delete(lat)

;CROPPING 9KM RESOLUTION DATA
lon = data9k(:,0)
lat = data9k(:,1)
count9 = 0
do i = 0,n9-1 ;LOOP OVER ALL ROWS IN THE MAPEIRE TRIMMED DATA
 if ((lon(i).gt.-14.099).and.(lon(i).lt.4.37955).and.(lat(i).gt.49.4066).and.(lat(i).lt.59.2717)) then
   data9c(count9,:) = data9k(i,:)
   print("i="+i+" count="+count9)
   count9 = count9 + 1
 end if
end do
delete(lon)
delete(lat)

count1 = count1 -1
count3 = count3 -1
count9 = count9 -1

;;;;;  WRITING CROPPED ASCII FILES  ;;;;;;
header = (/"LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10"/)
hlist = [/header/]
alist = [/data1c(:count1,0),data1c(:count1,1),data1c(:count1,2),data1c(:count1,3),data1c(:count1,4),data1c(:count1,5),data1c(:count1,6),data1c(:count1,7),data1c(:count1,8),data1c(:count1,9)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/mapeire_NFR_1k_trimcrop.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("1km file written!")

delete(alist)
alist = [/data3c(:count3,0),data3c(:count3,1),data3c(:count3,2),data3c(:count3,3),data3c(:count3,4),data3c(:count3,5),data3c(:count3,6),data3c(:count3,7),data3c(:count3,8),data3c(:count3,9)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/mapeire_NFR_3k_trimcrop.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("3km file written!")

delete(alist)
alist = [/data9c(:count9,0),data9c(:count9,1),data9c(:count9,2),data9c(:count9,3),data9c(:count9,4),data9c(:count9,5),data9c(:count9,6),data9c(:count9,7),data9c(:count9,8),data9c(:count9,9)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/mapeire_NFR_9k_trimcrop.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("9km file written!")



end
