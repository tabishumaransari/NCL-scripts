begin
a = addfile("/data3/tabish/APEC-baseline/wrfout_d03_2014-10-11_00:00:00.nc","r")
print ("LL= " + a->XLONG(0,0,0) +", "+ a->XLAT(0,0,0))
print ("LR= " + a->XLONG(0,0,176) +", "+ a->XLAT(0,0,176))
print ("UR= " + a->XLONG(0,242,176) +", "+ a->XLAT(0,242,176))
print ("UL= " + a->XLONG(0,242,0) +", "+ a->XLAT(0,242,0))

end
