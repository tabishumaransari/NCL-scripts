begin

;LETS READ BASELINE DATA. THIS HAS 984 ROWS EXCLUDING HEADER AND 1 COLUMN
ncol = 1
baseline  = readAsciiTable("Baselinefull_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
apec2full = readAsciiTable("APEC2full_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
print("table read-in successfully")
printVarSummary(baseline)
printVarSummary(apec2full)

baseline_subset = baseline(40:975,0)
apec2full_subset = apec2full(40:975,0)
printVarSummary(baseline_subset)
printVarSummary(apec2full_subset)

baseline_dm = new(39,float)
apec2full_dm = new(39,float)
redarray = new(39,float)
redarray_gt75 = new(39,float)



count = 0
do i = 0,38
 ;print(i+"="+count+":"+(count+23))
 baseline_dm(i)  = avg(baseline_subset(count:count+23))
 apec2full_dm(i) = avg(apec2full_subset(count:count+23))
 red = ((baseline_dm(i)-apec2full_dm(i))*100.0)/baseline_dm(i)
 red = decimalPlaces(red ,2,True)
 redarray(i) = red
 if(baseline_dm(i).gt.75)then
  redarray_gt75(i) = red
 end if
 day = i+12
 s = "Oct"
 if(i.gt.19)then 
  day = i-19
  s = "Nov"
 end if
 print("reduction for "+day+s+"="+red)
 if(red.lt.22) then
  print("baseline="+baseline_dm(i))
 end if
 count = count + 24
end do


print(redarray+" "+redarray_gt75)
print("mean of % daily reduction="+(avg(redarray)))
print("SD of % daily reduction="+(stddev(redarray)))


print("mean of % daily reduction="+(avg(redarray_gt75)))
print("SD of % daily reduction="+(stddev(redarray_gt75)))


end
