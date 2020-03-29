;THIS SCRIPT WILL CALCULATE NH3 EMISSIONS OVER BTH FROM D01, D02 AND D03 WRFCHEMI FILES
begin

a = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r") 
b1_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w") 
b1_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w") 

b2_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d02_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w")
b2_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w")

b3_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w")
b3_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2nh3_so4_allnormal.nc","w")


print("reading variables...")
mask_d01 = a->BTHmask_d01
mask_d02 = a->BTHmask_d02
mask_d03 = a->BTHmask_d03

nh3_00z_d01 = b1_00z->E_NH3
nh3_00z_d02 = b2_00z->E_NH3
nh3_00z_d03 = b3_00z->E_NH3
nh3_12z_d01 = b1_12z->E_NH3
nh3_12z_d02 = b2_12z->E_NH3
nh3_12z_d03 = b3_12z->E_NH3
print("Modifying NH3 over BTH...")
nh3_00z_d01   = where(mask_d01.eq.1, 0.5*nh3_00z_d01, nh3_00z_d01)
nh3_00z_d02   = where(mask_d02.eq.1, 0.5*nh3_00z_d02, nh3_00z_d02)
nh3_00z_d03   = where(mask_d03.eq.1, 0.5*nh3_00z_d03, nh3_00z_d03)
nh3_12z_d01   = where(mask_d01.eq.1, 0.5*nh3_12z_d01, nh3_12z_d01)
nh3_12z_d02   = where(mask_d02.eq.1, 0.5*nh3_12z_d02, nh3_12z_d02)
nh3_12z_d03   = where(mask_d03.eq.1, 0.5*nh3_12z_d03, nh3_12z_d03)

b1_00z->E_NH3 = nh3_00z_d01
b2_00z->E_NH3 = nh3_00z_d02
b3_00z->E_NH3 = nh3_00z_d03
b1_12z->E_NH3 = nh3_12z_d01
b2_12z->E_NH3 = nh3_12z_d02
b3_12z->E_NH3 = nh3_12z_d03

print("Done!")

end
