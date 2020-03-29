begin
a= addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","w")
b1= addfile("/home/tabish/WPS/geo_em.d01.nc","r")
b2= addfile("/home/tabish/WPS/geo_em.d02.nc","r")

mask_d01 = a->BAPEC2mask_d01
mask_d01 = where(mask_d01.eq.2,3,mask_d01)
mask_d01 = where(mask_d01.eq.1,2,mask_d01)
mask_d01_1d = mask_d01(0,0,:,:)
print(dimsizes(mask_d01_1d))
mask_d01_1d(42:83,68:113) = where(mask_d01_1d(42:83,68:113).eq.0,1,mask_d01_1d(42:83,68:113))
ABCmask_d01 = conform_dims(dimsizes(mask_d01),mask_d01_1d,(/2,3/))
a->ABCmask_d01 = ABCmask_d01




print("success!!!")
end
