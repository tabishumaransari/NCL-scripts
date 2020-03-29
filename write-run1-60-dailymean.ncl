begin
;LETS READ RUN1-60 DATA WHICH WERE USED TO TRAIN THE EMULATOR. THESE HAVE 264 ROWS AND 60 COLUMNS
ncol = 60
data = readAsciiTable("run1-60_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")
data = where(data.lt.0.0,0.0,data)
printVarSummary(data)

data_dailymean  = new((/11,60/),float) ;11 values of daily contribution for 12 parameters (sector/region)
sp = 0
do i= 0,10
 do j= 0,59
  data_dailymean(i,j) = avg(data(sp:sp+23,j))
  print(i+" "+j+" "+sp+"-"+(sp+23))
 end do
 sp = sp + 24
end do


header = (/"run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12 run13 run14 run15 run16 run17 run18 run19 run20 run21 run22 run23 run24 run25 run26 run27 run28 run29 run30 run31 run32 run33 run34 run35 run36 run37 run38 run39 run40 run41 run42 run43 run44 run45 run46 run47 run48 run49 run50 run51 run52 run53 run54 run55 run56 run57 run58 run59 run60"/)
hlist = [/header/]
alist = [/data_dailymean(:,0), data_dailymean(:,1),data_dailymean(:,2),data_dailymean(:,3),data_dailymean(:,4),data_dailymean(:,5),data_dailymean(:,6),data_dailymean(:,7),data_dailymean(:,8),data_dailymean(:,9),data_dailymean(:,10), data_dailymean(:,11), data_dailymean(:,12),data_dailymean(:,13),data_dailymean(:,14),data_dailymean(:,15),data_dailymean(:,16),data_dailymean(:,17),data_dailymean(:,18),data_dailymean(:,19),data_dailymean(:,20), data_dailymean(:,21),data_dailymean(:,22),data_dailymean(:,23),data_dailymean(:,24),data_dailymean(:,25),data_dailymean(:,26),data_dailymean(:,27),data_dailymean(:,28),data_dailymean(:,29),data_dailymean(:,30), data_dailymean(:,31),data_dailymean(:,32),data_dailymean(:,33),data_dailymean(:,34),data_dailymean(:,35),data_dailymean(:,36),data_dailymean(:,37),data_dailymean(:,38),data_dailymean(:,39),data_dailymean(:,40), data_dailymean(:,41),data_dailymean(:,42),data_dailymean(:,43),data_dailymean(:,44),data_dailymean(:,45),data_dailymean(:,46),data_dailymean(:,47),data_dailymean(:,48),data_dailymean(:,49),data_dailymean(:,50), data_dailymean(:,51),data_dailymean(:,52),data_dailymean(:,53),data_dailymean(:,54),data_dailymean(:,55),data_dailymean(:,56),data_dailymean(:,57),data_dailymean(:,58),data_dailymean(:,59)/]
print("alist created...now writing")
fname = "run1-60_dailymean.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")

end
