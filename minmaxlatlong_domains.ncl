begin

a1 = addfile ("/media/tabish/DataDisk/Dublin-study/mapeire-sita/mapeire-wrfchemi/wrfchemi_00z_d01_mapeire1.nc","w")
a2 = addfile ("/media/tabish/DataDisk/Dublin-study/mapeire-sita/mapeire-wrfchemi/wrfchemi_00z_d02_mapeire1.nc","w")
a3 = addfile ("/media/tabish/DataDisk/Dublin-study/mapeire-sita/mapeire-wrfchemi/wrfchemi_00z_d03_mapeire1.nc","w")

;READING OFF KEY VARIABLES TO OVERWRITE LATER
lat1 = a1->XLAT
lat2 = a2->XLAT
lat3 = a3->XLAT

lon1 = a1->XLONG
lon2 = a2->XLONG
lon3 = a3->XLONG

print("------------DOMAIN 1----------------")
printMinMax(lon1,True)
printMinMax(lat1,True)


print("------------DOMAIN 2----------------")
printMinMax(lon2,True)
printMinMax(lat2,True)

print("------------DOMAIN 3----------------")
printMinMax(lon3,True)
printMinMax(lat3,True)


end
