;THIS SCRIPT OUTPUTS THE MIN AND MAX VALUES OF LAT AND LON FOR REPUBLIC OF IRELAND REGION FROM DOMAINS 1 AND 2
begin
a = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d01.nc","r")
b = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d02.nc","r")
c = addfile("/home/tabish/Downloads/mapeire-sita/ROImask.nc","r")

d01mask = c->ROImask_d01
d02mask = c->ROImask_d02

printVarSummary(d01mask)

d01lat = a->XLAT
d01lon = a->XLONG

d02lat = b->XLAT
d02lon = b->XLONG

d01lat@_FillValue = -999
d02lon@_FillValue = -999
d01lat@_FillValue = -999
d02lon@_FillValue = -999

;MASKING LAT AND LON ARRAYS BASED ON ROIMASK
d01lat = where(d01mask(0,0,:,:).eq.1,d01lat,d01lat@_FillValue)
d01lon = where(d01mask(0,0,:,:).eq.1,d01lon,d01lon@_FillValue)

d02lat = where(d02mask(0,0,:,:).eq.1,d02lat,d02lat@_FillValue)
d02lon = where(d02mask(0,0,:,:).eq.1,d02lon,d02lon@_FillValue)

printMinMax(d01lat,True)
printMinMax(d01lon,True)
printMinMax(d02lat,True)
printMinMax(d02lon,True)

end
