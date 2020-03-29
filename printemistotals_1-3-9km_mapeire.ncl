; THIS SCRIPT WRITES ONLY THE USEFUL VARIABLES IN A TEXT FILE. THE UNITS ARE RETAINED

begin
;BEGIN READING 1KM DATA
;ncols are different for different datasets at 1km resolution
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_NFR.csv", 41, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_A.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_B.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_C.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_D.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_E.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_F.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_G.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_H.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_I.csv", 44, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_J.csv", 49, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_K.csv", 48, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_L.csv", 48, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_O.csv", 48, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data1k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/Native/Output_P.csv", 48, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
printVarSummary(data1k)
;data1k@_FillValue = -999
print ("Total emissions at 1km resolution")

;APPROPRITATE COLUMNS FOR PRINTING FOR NFR_TOTAL
; print("LON="+decimalPlaces(data1k(:,0),2,True))
; print("LAT="+decimalPlaces(data1k(:,1),2,True))
; print("BC total="+decimalPlaces(sum(data1k(:,6)),2,True))
; print("CO total="+decimalPlaces(sum(data1k(:,12)),2,True))
; print("NH3 total="+decimalPlaces(sum(data1k(:,23)),2,True))
; print("NMVOC total="+decimalPlaces(sum(data1k(:,25)),2,True))
; print("NOx total="+decimalPlaces(sum(data1k(:,26)),2,True))
; print("PM10 total="+decimalPlaces(sum(data1k(:,31)),2,True))
; print("PM25 total="+decimalPlaces(sum(data1k(:,32)),2,True))
; print("SOx total="+decimalPlaces(sum(data1k(:,35)),2,True))


;APPROPRITATE COLUMNS FOR PRINTING FOR A-H and J SECTORS
 print("BC total="+decimalPlaces(sum(data1k(:,14)),2,True))
 print("CO total="+decimalPlaces(sum(data1k(:,20)),2,True))
 print("NH3 total="+decimalPlaces(sum(data1k(:,31)),2,True))
 print("NMVOC total="+decimalPlaces(sum(data1k(:,33)),2,True))
 print("NOx total="+decimalPlaces(sum(data1k(:,34)),2,True))
 print("PM10 total="+decimalPlaces(sum(data1k(:,39)),2,True))
 print("PM25 total="+decimalPlaces(sum(data1k(:,40)),2,True))
 print("SOx total="+decimalPlaces(sum(data1k(:,43)),2,True))

;APPROPRITATE COLUMNS FOR PRINTING FOR I SECTOR
; print("BC total="+decimalPlaces(sum(data1k(:,9)),2,True))
; print("CO total="+decimalPlaces(sum(data1k(:,15)),2,True))
; print("NH3 total="+decimalPlaces(sum(data1k(:,26)),2,True))
; print("NMVOC total="+decimalPlaces(sum(data1k(:,28)),2,True))
; print("NOx total="+decimalPlaces(sum(data1k(:,29)),2,True))
; print("PM10 total="+decimalPlaces(sum(data1k(:,34)),2,True))
; print("PM25 total="+decimalPlaces(sum(data1k(:,35)),2,True))
; print("SOx total="+decimalPlaces(sum(data1k(:,38)),2,True))

;APPROPRITATE COLUMNS FOR PRINTING FOR K-P SECTORS
; print("BC total="+decimalPlaces(sum(data1k(:,13)),2,True))
; print("CO total="+decimalPlaces(sum(data1k(:,19)),2,True))
; print("NH3 total="+decimalPlaces(sum(data1k(:,30)),2,True))
; print("NMVOC total="+decimalPlaces(sum(data1k(:,32)),2,True))
; print("NOx total="+decimalPlaces(sum(data1k(:,33)),2,True))
; print("PM10 total="+decimalPlaces(sum(data1k(:,38)),2,True))
; print("PM25 total="+decimalPlaces(sum(data1k(:,39)),2,True))
; print("SOx total="+decimalPlaces(sum(data1k(:,42)),2,True))



;BEGIN READING 3KM DATA
ncol = 11
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/NFR3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/A3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/B3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/C3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/D3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/E3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/F3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/G3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/H3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/I3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/J3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/K3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/L3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/O3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data3k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/3k/P3K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data3k@_FillValue = -999
printVarSummary(data3k)
print ("Total emissions at 3km resolution")
 print("BC total="+decimalPlaces((9.0*sum(data3k(:,3))),2,True))
 print("CO total="+decimalPlaces((9.0*sum(data3k(:,4))),2,True))
 print("NH3 total="+decimalPlaces((9.0*sum(data3k(:,5))),2,True))
 print("NMVOC total="+decimalPlaces((9.0*sum(data3k(:,6))),2,True))
 print("NOx total="+decimalPlaces((9.0*sum(data3k(:,7))),2,True))
 print("PM10 total="+decimalPlaces((9.0*sum(data3k(:,8))),2,True))
 print("PM25 total="+decimalPlaces((9.0*sum(data3k(:,9))),2,True))
 print("SOx total="+decimalPlaces((9.0*sum(data3k(:,10))),2,True))


;BEGIN READING 9KM DATA
ncol = 11
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/NFR9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/A9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/B9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/C9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/D9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/E9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/F9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/G9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/H9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/I9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/J9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/K9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/L9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/O9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
;data9k = readAsciiTable("/media/tabish/DataDisk/Dublin-study/mapeire-sita/9k/P9K.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data9k@_FillValue = -999
printVarSummary(data9k)
print ("Total emissions at 9km resolution")
 print("BC total="+decimalPlaces((81*sum(data9k(:,3))),2,True))
 print("CO total="+decimalPlaces((81*sum(data9k(:,4))),2,True))
 print("NH3 total="+decimalPlaces((81*sum(data9k(:,5))),2,True))
 print("NMVOC total="+decimalPlaces((81*sum(data9k(:,6))),2,True))
 print("NOx total="+decimalPlaces((81*sum(data9k(:,7))),2,True))
 print("PM10 total="+decimalPlaces((81*sum(data9k(:,8))),2,True))
 print("PM25 total="+decimalPlaces((81*sum(data9k(:,9))),2,True))
 print("SOx total="+decimalPlaces((81*sum(data9k(:,10))),2,True))


;;;;;WRITING ASCII FILE OF DAILY MEAN WIND SPEED AND DIRECTION;;;;;;
;header = (/"LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10"/)
;hlist = [/header/]
;alist = [/data(:,0),data(:,1),data(:,11),data(:,25),data(:,34),data(:,24),data(:,22),data(:,5),data(:,31),data(:,30)/]
;print("alist created...now writing")
;fname = "NFR_trimmed.txt"
;write_table(fname, "w", hlist, "%s")
;write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
;print("written!")


end
