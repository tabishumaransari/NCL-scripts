begin
;LETS READ EMULATION RUNS DATA. THESE HAVE 12 ROWS AND 264 COLUMNS
ncol = 264
data = readAsciiTable("emulation.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
printVarSummary(data)

emulation_dailymean  = new((/12,11/),float) ;11 values of daily contribution for 12 parameters (sector/region)
sp = 0
do i= 0,11
 do j= 0,10
  emulation_dailymean(i,j) = avg(data(i,sp:sp+23))
  print(i+" "+j+" "+sp+"-"+(sp+23))
  sp = sp + 24
 end do
 sp = 0
end do

header = (/"day1 day2 day3 day4 day5 day6 day7 day8 day9 day10 day11"/)
hlist = [/header/]
alist = [/emulation_dailymean(:,0), emulation_dailymean(:,1),emulation_dailymean(:,2),emulation_dailymean(:,3),emulation_dailymean(:,4),emulation_dailymean(:,5),emulation_dailymean(:,6),emulation_dailymean(:,7),emulation_dailymean(:,8),emulation_dailymean(:,9),emulation_dailymean(:,10)/]
print("alist created...now writing")
fname = "emulation-dailymean.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

end
