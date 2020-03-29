;THIS SCRIPT WILL CALCULATE NH3 EMISSIONS OVER BTH FROM D01, D02 AND D03 WRFCHEMI FILES
begin

a = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r") 
b1_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r") 
b1_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r") 

b2_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d02_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
b2_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")

b3_00z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
b3_12z = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")

print("reading variables...")
mask_d01 = a->BTHmask_d01(0,0,:,:)
mask_d02 = a->BTHmask_d02(0,0,:,:)
mask_d03 = a->BTHmask_d03(0,0,:,:)

nh3_d01 = (b1_00z->E_NH3(0,0,:,:)+ b1_00z->E_NH3(1,0,:,:)+ b1_00z->E_NH3(2,0,:,:) + b1_00z->E_NH3(3,0,:,:)+ b1_00z->E_NH3(4,0,:,:)+ b1_00z->E_NH3(5,0,:,:)+ b1_00z->E_NH3(6,0,:,:)+ b1_00z->E_NH3(7,0,:,:)+ b1_00z->E_NH3(8,0,:,:)+ b1_00z->E_NH3(9,0,:,:)+ b1_00z->E_NH3(10,0,:,:)+ b1_00z->E_NH3(11,0,:,:)+ b1_12z->E_NH3(0,0,:,:)+ b1_12z->E_NH3(1,0,:,:)+ b1_12z->E_NH3(2,0,:,:)+ b1_12z->E_NH3(3,0,:,:)+ b1_12z->E_NH3(4,0,:,:)+ b1_12z->E_NH3(5,0,:,:)+ b1_12z->E_NH3(6,0,:,:)+ b1_12z->E_NH3(7,0,:,:)+ b1_12z->E_NH3(8,0,:,:)+ b1_12z->E_NH3(9,0,:,:)+ b1_12z->E_NH3(10,0,:,:)+ b1_12z->E_NH3(11,0,:,:))/24.0 

nh3_d02 = (b2_00z->E_NH3(0,0,:,:)+ b2_00z->E_NH3(1,0,:,:)+ b2_00z->E_NH3(2,0,:,:) + b2_00z->E_NH3(3,0,:,:)+ b2_00z->E_NH3(4,0,:,:)+ b2_00z->E_NH3(5,0,:,:)+ b2_00z->E_NH3(6,0,:,:)+ b2_00z->E_NH3(7,0,:,:)+ b2_00z->E_NH3(8,0,:,:)+ b2_00z->E_NH3(9,0,:,:)+ b2_00z->E_NH3(10,0,:,:)+ b2_00z->E_NH3(11,0,:,:)+ b2_12z->E_NH3(0,0,:,:)+ b2_12z->E_NH3(1,0,:,:)+ b2_12z->E_NH3(2,0,:,:)+ b2_12z->E_NH3(3,0,:,:)+ b2_12z->E_NH3(4,0,:,:)+ b2_12z->E_NH3(5,0,:,:)+ b2_12z->E_NH3(6,0,:,:)+ b2_12z->E_NH3(7,0,:,:)+ b2_12z->E_NH3(8,0,:,:)+ b2_12z->E_NH3(9,0,:,:)+ b2_12z->E_NH3(10,0,:,:)+ b2_12z->E_NH3(11,0,:,:))/24.0

nh3_d03 = (b3_00z->E_NH3(0,0,:,:)+ b3_00z->E_NH3(1,0,:,:)+ b3_00z->E_NH3(2,0,:,:) + b3_00z->E_NH3(3,0,:,:)+ b3_00z->E_NH3(4,0,:,:)+ b3_00z->E_NH3(5,0,:,:)+ b3_00z->E_NH3(6,0,:,:)+ b3_00z->E_NH3(7,0,:,:)+ b3_00z->E_NH3(8,0,:,:)+ b3_00z->E_NH3(9,0,:,:)+ b3_00z->E_NH3(10,0,:,:)+ b3_00z->E_NH3(11,0,:,:)+ b3_12z->E_NH3(0,0,:,:)+ b3_12z->E_NH3(1,0,:,:)+ b3_12z->E_NH3(2,0,:,:)+ b3_12z->E_NH3(3,0,:,:)+ b3_12z->E_NH3(4,0,:,:)+ b3_12z->E_NH3(5,0,:,:)+ b3_12z->E_NH3(6,0,:,:)+ b3_12z->E_NH3(7,0,:,:)+ b3_12z->E_NH3(8,0,:,:)+ b3_12z->E_NH3(9,0,:,:)+ b3_12z->E_NH3(10,0,:,:)+ b3_12z->E_NH3(11,0,:,:))/24.0

print("variables read from all domains. Now modifying values over BTH region...")

nh3_d01   = where(mask_d01.eq.1, nh3_d01, 0.0)
nh3_d02   = where(mask_d02.eq.1, nh3_d02, 0.0)
nh3_d03   = where(mask_d03.eq.1, nh3_d03, 0.0)

print("NH3 emissions cropped over BTH for all domains")
nh3_d01sum = sum(nh3_d01)
nh3_d02sum = sum(nh3_d02)
nh3_d03sum = sum(nh3_d03)

;converting (mol km-2 hr-1) to (kT yr-1)

nh3_d01sum = 729*17*24*365*10^-9*nh3_d01sum
nh3_d02sum = 81*17*24*365*10^-9*nh3_d02sum
nh3_d03sum = 9*17*24*365*10^-9*nh3_d03sum

print("NH3 emissions for 2010 from D01 = "+nh3_d01sum+" kT/yr")
print("NH3 emissions for 2010 from D02 = "+nh3_d02sum+" kT/yr")
print("NH3 emissions for 2010 from D03 = "+nh3_d03sum+" kT/yr")

end
