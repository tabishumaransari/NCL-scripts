begin
begTime = get_cpu_time()
;DATADir = "/mnt/rasher/APEC2full/"
DATADir = "/mnt/rasher/control-run-so4-ECMWF/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")

;FETCHING FULL LIST OF PM2.5 FOR 1ST STATION - ALL FILES ARE CONCATENATED
pm25 = a[:]->PM2_5_DRY(:,0,145,79)

;NOW ADDING OTHER STATION VALUES TO THE LIST
Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)

 pm25 = pm25 + a[:]->PM2_5_DRY(:,0,J,I)
end do

pm25 = pm25/12.0

header = (/"BaselineFull"/)
hlist = [/header/]
alist = [/pm25/]
print("alist created...now writing")
fname = "Baselinefull_ts.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f")
print("time taken in minutes: " + (get_cpu_time() - begTime)/60.0)
end

