begin
;DATADir = "/data2/tabish/control-run-so4-ECMWF/"
DATADir = "/data2/tabish/control-run-so4-ECMWF_d01/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d01_2014-* ")
a = addfiles(FILES,"r")
;times = a[:]->Times

utc = wrf_user_getvar(a,"times",-1)  ; slp
print(utc(519))

end
