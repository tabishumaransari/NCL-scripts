;THIS SCRIPT READS IN MAPEIRE DATA AT 1KM, 3KM AND 9KM RESOLUTION, PERFORMS UNIT CONVERSION AND WRITES THEM IN A NEAT FILE
begin

data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_NFR.csv", 41, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/NFR3K.csv", 11, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/NFR9K.csv", 11, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

data1k@_FillValue = -999
data3k@_FillValue = -999
data9k@_FillValue = -999
print("MapEIre rawfile read-in successfully")


;CONVERTING ALL AEROSOLS FROM kt km-2 yr-1 TO ug m-2 s-1
data1k(:,6)  = 31.71 * data1k(:,6)  ;BC
data1k(:,31) = 31.71 * data1k(:,31) ;PM10
data1k(:,32) = 31.71 * data1k(:,32) ;PM2.5
 
data3k(:,3)  = 31.71 * data3k(:,3) ;BC
data3k(:,8)  = 31.71 * data3k(:,8) ;PM10
data3k(:,9)  = 31.71 * data3k(:,9) ;PM2.5

data9k(:,3)  = 31.71 * data9k(:,3) ;BC
data9k(:,8)  = 31.71 * data9k(:,8) ;PM10
data9k(:,9)  = 31.71 * data9k(:,9) ;PM2.5

;CONVERTING GAS-PHASE SPECIES FROM kt km-2 yr-1 TO mol km-2 hr-1
data1k(:,12) = (114155.25/28.0) * data1k(:,12)  ;CO
data1k(:,23) = (114155.25/17.0) * data1k(:,23) ;NH3
data1k(:,26) = (114155.25/30.0) * data1k(:,26) ;NO
data1k(:,35) = (114155.25/64.0) * data1k(:,35) ;SO2

data3k(:,4)  = (114155.25/28.0) * data3k(:,4)  ;CO
data3k(:,5)  = (114155.25/17.0) * data3k(:,5) ;NH3
data3k(:,7)  = (114155.25/30.0) * data3k(:,7) ;NO
data3k(:,10) = (114155.25/64.0) * data3k(:,10) ;SO2

data9k(:,4)  = (114155.25/28.0) * data9k(:,4)  ;CO
data9k(:,5)  = (114155.25/17.0) * data9k(:,5) ;NH3
data9k(:,7)  = (114155.25/30.0) * data9k(:,7) ;NO
data9k(:,10) = (114155.25/64.0) * data9k(:,10) ;SO2

;CONVERTING NMVOC SPECIES FROM kt km-2 yr-1 TO g km-2 hr-1
data1k(:,25) = 114155.25 * data1k(:,25) ;NMVOC
data3k(:,6)  = 114155.25 * data3k(:,6) ;NMVOC
data9k(:,6)  = 114155.25 * data9k(:,6) ;NMVOC



;;;;;WRITING ASCII FILES FOR USEFUL SPECIES;;;;;;
header = (/"LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10"/)
hlist = [/header/]
alist = [/data1k(:,0),data1k(:,1),data1k(:,12),data1k(:,26),data1k(:,35),data1k(:,25),data1k(:,23),data1k(:,6),data1k(:,32),data1k(:,31)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/mapeire_NFR_1k_trimmed.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("1km trimmed file written!")

delete(alist)
alist = [/data3k(:,0),data3k(:,1),data3k(:,4),data3k(:,7),data3k(:,10),data3k(:,6),data3k(:,5),data3k(:,3),data3k(:,9),data3k(:,8)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/mapeire_NFR_3k_trimmed.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("3km trimmed file written!")

delete(alist)
alist = [/data9k(:,0),data9k(:,1),data9k(:,4),data9k(:,7),data9k(:,10),data9k(:,6),data9k(:,5),data9k(:,3),data9k(:,9),data9k(:,8)/]
fname = "/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/mapeire_NFR_9k_trimmed.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("9km trimmed file written!")


end
