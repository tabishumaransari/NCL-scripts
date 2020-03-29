begin
DATADir1 = "/data2/tabish/control-run-so4-ECMWF/"
DATADir2 = "/data2/tabish/best-guess_run/"
DATADir3 = "/data2/tabish/what-if_run/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
FILES3 = systemfunc (" ls -1 " + DATADir3 + "wrfout_d03_2014-* ")
a = addfiles(FILES1,"r")
b = addfiles(FILES2,"r")
c = addfiles(FILES3,"r")
pm25_a    = a[:]->PM2_5_DRY(:,0,145,79)
pm25_b    = b[:]->PM2_5_DRY(:,0,145,79)
pm25_c    = c[:]->PM2_5_DRY(:,0,145,79)

print("Length of control-run array =" + dimsizes(pm25_a))
print("Length of APEC-run array =" + dimsizes(pm25_b))
print("Length of Oct-run array =" + dimsizes(pm25_c))

end
