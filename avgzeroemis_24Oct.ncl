begin
ncol = 24 ; COLUMNS CORRESPOND TO THE 11 DAYS HERE
data = readAsciiTable("12stmean_ts_zeroemis.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
printVarSummary(data)

tabish = avg(data(287:310,3))
print("Daily avg for 24thOct for zeroemisnew run is: "+tabish)

end
