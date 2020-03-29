begin

a = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r") 
b100zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Nov_8lev_0.5so2_0.7nox.nc","w") 
b200zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Nov_8lev_0.5so2_0.7nox.nc","w") 
b300zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Nov_8lev_0.5so2_0.7nox.nc","w") 

b112zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Nov_8lev_0.5so2_0.7nox.nc","w")
b212zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Nov_8lev_0.5so2_0.7nox.nc","w")
b312zNov = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Nov_8lev_0.5so2_0.7nox.nc","w")

b100zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Oct_8lev_0.5so2_0.7nox.nc","w")
b200zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Oct_8lev_0.5so2_0.7nox.nc","w")
b300zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Oct_8lev_0.5so2_0.7nox.nc","w")

b112zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Oct_8lev_0.5so2_0.7nox.nc","w")
b212zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Oct_8lev_0.5so2_0.7nox.nc","w")
b312zOct = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Oct_8lev_0.5so2_0.7nox.nc","w")

print("reading variables...")
mask_d01 = a->THmask_d01
mask_d02 = a->THmask_d02
mask_d03 = a->THmask_d03

so2_b100zNov = b100zNov->E_SO2
so2_b200zNov = b200zNov->E_SO2
so2_b300zNov = b300zNov->E_SO2
so2_b112zNov = b112zNov->E_SO2
so2_b212zNov = b212zNov->E_SO2
so2_b312zNov = b312zNov->E_SO2
so2_b100zOct = b100zOct->E_SO2
so2_b200zOct = b200zOct->E_SO2
so2_b300zOct = b300zOct->E_SO2
so2_b112zOct = b112zOct->E_SO2
so2_b212zOct = b212zOct->E_SO2
so2_b312zOct = b312zOct->E_SO2

no2_b100zNov = b100zNov->E_NO2
no2_b200zNov = b200zNov->E_NO2
no2_b300zNov = b300zNov->E_NO2
no2_b112zNov = b112zNov->E_NO2
no2_b212zNov = b212zNov->E_NO2
no2_b312zNov = b312zNov->E_NO2
no2_b100zOct = b100zOct->E_NO2
no2_b200zOct = b200zOct->E_NO2
no2_b300zOct = b300zOct->E_NO2
no2_b112zOct = b112zOct->E_NO2
no2_b212zOct = b212zOct->E_NO2
no2_b312zOct = b312zOct->E_NO2

no_b100zNov = b100zNov->E_NO
no_b200zNov = b200zNov->E_NO
no_b300zNov = b300zNov->E_NO
no_b112zNov = b112zNov->E_NO
no_b212zNov = b212zNov->E_NO
no_b312zNov = b312zNov->E_NO
no_b100zOct = b100zOct->E_NO
no_b200zOct = b200zOct->E_NO
no_b300zOct = b300zOct->E_NO
no_b112zOct = b112zOct->E_NO
no_b212zOct = b212zOct->E_NO
no_b312zOct = b312zOct->E_NO

print("variables read. Now modifying values over TH region...")

;so2_b100zNov = where(mask_d01.eq.1, 0.5*so2_b100zNov, so2_b100zNov)
;so2_b200zNov = where(mask_d02.eq.1, 0.5*so2_b200zNov, so2_b200zNov)
;so2_b300zNov = where(mask_d03.eq.1, 0.5*so2_b300zNov, so2_b300zNov)
;so2_b112zNov = where(mask_d01.eq.1, 0.5*so2_b112zNov, so2_b112zNov)
;so2_b212zNov = where(mask_d02.eq.1, 0.5*so2_b212zNov, so2_b212zNov)
;so2_b312zNov = where(mask_d03.eq.1, 0.5*so2_b312zNov, so2_b312zNov)
;so2_b100zOct = where(mask_d01.eq.1, 0.5*so2_b100zOct, so2_b100zOct)
;so2_b200zOct = where(mask_d02.eq.1, 0.5*so2_b200zOct, so2_b200zOct)
;so2_b300zOct = where(mask_d03.eq.1, 0.5*so2_b300zOct, so2_b300zOct)
;so2_b112zOct = where(mask_d01.eq.1, 0.5*so2_b112zOct, so2_b112zOct)
;so2_b212zOct = where(mask_d02.eq.1, 0.5*so2_b212zOct, so2_b212zOct)
;so2_b312zOct = where(mask_d03.eq.1, 0.5*so2_b312zOct, so2_b312zOct)

no2_b100zNov = where(mask_d01.eq.1, 1.428571429*no2_b100zNov, no2_b100zNov)
no2_b200zNov = where(mask_d02.eq.1, 1.428571429*no2_b200zNov, no2_b200zNov)
no2_b300zNov = where(mask_d03.eq.1, 1.428571429*no2_b300zNov, no2_b300zNov)
no2_b112zNov = where(mask_d01.eq.1, 1.428571429*no2_b112zNov, no2_b112zNov)
no2_b212zNov = where(mask_d02.eq.1, 1.428571429*no2_b212zNov, no2_b212zNov)
no2_b312zNov = where(mask_d03.eq.1, 1.428571429*no2_b312zNov, no2_b312zNov)
no2_b100zOct = where(mask_d01.eq.1, 1.428571429*no2_b100zOct, no2_b100zOct)
no2_b200zOct = where(mask_d02.eq.1, 1.428571429*no2_b200zOct, no2_b200zOct)
no2_b300zOct = where(mask_d03.eq.1, 1.428571429*no2_b300zOct, no2_b300zOct)
no2_b112zOct = where(mask_d01.eq.1, 1.428571429*no2_b112zOct, no2_b112zOct)
no2_b212zOct = where(mask_d02.eq.1, 1.428571429*no2_b212zOct, no2_b212zOct)
no2_b312zOct = where(mask_d03.eq.1, 1.428571429*no2_b312zOct, no2_b312zOct)

no_b100zNov = where(mask_d01.eq.1, 1.428571429*no_b100zNov, no_b100zNov)
no_b200zNov = where(mask_d02.eq.1, 1.428571429*no_b200zNov, no_b200zNov)
no_b300zNov = where(mask_d03.eq.1, 1.428571429*no_b300zNov, no_b300zNov)
no_b112zNov = where(mask_d01.eq.1, 1.428571429*no_b112zNov, no_b112zNov)
no_b212zNov = where(mask_d02.eq.1, 1.428571429*no_b212zNov, no_b212zNov)
no_b312zNov = where(mask_d03.eq.1, 1.428571429*no_b312zNov, no_b312zNov)
no_b100zOct = where(mask_d01.eq.1, 1.428571429*no_b100zOct, no_b100zOct)
no_b200zOct = where(mask_d02.eq.1, 1.428571429*no_b200zOct, no_b200zOct)
no_b300zOct = where(mask_d03.eq.1, 1.428571429*no_b300zOct, no_b300zOct)
no_b112zOct = where(mask_d01.eq.1, 1.428571429*no_b112zOct, no_b112zOct)
no_b212zOct = where(mask_d02.eq.1, 1.428571429*no_b212zOct, no_b212zOct)
no_b312zOct = where(mask_d03.eq.1, 1.428571429*no_b312zOct, no_b312zOct)

print("All variables modified. Now writing back onto the files...")

;b100zNov->E_SO2 = so2_b100zNov
;b200zNov->E_SO2 = so2_b200zNov
;b300zNov->E_SO2 = so2_b300zNov
;b112zNov->E_SO2 = so2_b112zNov
;b212zNov->E_SO2 = so2_b212zNov
;b312zNov->E_SO2 = so2_b312zNov
;b100zOct->E_SO2 = so2_b100zOct
;b200zOct->E_SO2 = so2_b200zOct
;b300zOct->E_SO2 = so2_b300zOct
;b112zOct->E_SO2 = so2_b112zOct 
;b212zOct->E_SO2 = so2_b212zOct
;b312zOct->E_SO2 = so2_b312zOct

b100zNov->E_NO2 = no2_b100zNov
b200zNov->E_NO2 = no2_b200zNov
b300zNov->E_NO2 = no2_b300zNov
b112zNov->E_NO2 = no2_b112zNov
b212zNov->E_NO2 = no2_b212zNov
b312zNov->E_NO2 = no2_b312zNov
b100zOct->E_NO2 = no2_b100zOct
b200zOct->E_NO2 = no2_b200zOct
b300zOct->E_NO2 = no2_b300zOct
b112zOct->E_NO2 = no2_b112zOct
b212zOct->E_NO2 = no2_b212zOct
b312zOct->E_NO2 = no2_b312zOct

b100zNov->E_NO = no_b100zNov
b200zNov->E_NO = no_b200zNov
b300zNov->E_NO = no_b300zNov
b112zNov->E_NO = no_b112zNov
b212zNov->E_NO = no_b212zNov
b312zNov->E_NO = no_b312zNov
b100zOct->E_NO = no_b100zOct
b200zOct->E_NO = no_b200zOct
b300zOct->E_NO = no_b300zOct
b112zOct->E_NO = no_b112zOct
b212zOct->E_NO = no_b212zOct
b312zOct->E_NO = no_b312zOct

print("Success! All files modified accordingly.")
end
