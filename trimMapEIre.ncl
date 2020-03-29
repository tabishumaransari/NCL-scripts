; These files still have to be loaded manually

begin
ncol = 37
data = readAsciiTable("/home/tabish/Downloads/mapeire-sita/Output.csv", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

data@_FillValue = -999 
print("MapEIre rawfile read-in successfully")

printVarSummary(data)

;CONVERTING ALL EMISSIONS FROM Kt/yr TO g/yr
data(:,2:) = data(:,2:) * 1000000000.0

;CONVERTING ALL EMISSIONS FROM g/yr TO g/hr
data(:,2:) = data(:,2:)/8670.0

;CONVERTING gas-phase EMISSIONS FROM g/hr TO mol/hr
data(:,2) = data(:,2)/28.0 ;CO
data(:,3) = data(:,3)/30.0 ;NO
data(:,4) = data(:,4)/64.0 ;SO2
data(:,6) = data(:,6)/17.0 ;NH3
;NMVOCs are still kept in g/hr. They can be converted to moles after being apportioned to individual species.

 print("LON   = "+data(0:19,0))
 print("LAT   = "+data(0:19,1))
 print("BC    = "+data(0:19,5))
 print("CO    = "+data(0:19,11))
 print("NH3   = "+data(0:19,22))
 print("NMVOC = "+data(0:19,24))
 print("NOx   = "+data(0:19,25))
 print("PM10  = "+data(0:19,30))
 print("PM2.5 = "+data(0:19,31))
 print("SOx   = "+data(0:19,34))


;;;;;WRITING ASCII FILE OF DAILY MEAN WIND SPEED AND DIRECTION;;;;;;
header = (/"LON LAT CO NOX SO2 NMVOC NH3 BC PM25 PM10"/)
hlist = [/header/]
alist = [/data(:,0),data(:,1),data(:,11),data(:,25),data(:,34),data(:,24),data(:,22),data(:,5),data(:,31),data(:,30)/]
print("alist created...now writing")
fname = "mapeire_trimmed.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f %9.4f")
print("written!")


end
