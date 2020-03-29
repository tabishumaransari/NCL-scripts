begin
a= addfile("MEIC_Nov_d03.nc","r")
b= addfile("MEICMOSAIC_bb_Nov_d03.nc","c")
print("Reading in variables..")
PM10 = a->pm10(:,4,:,:)
PM25 = a->pm25(:,4,:,:)
PMcoarse = PM10  
EC = a->bc(:,4,:,:)
OC = a->oc(:,4,:,:)
ECOC = EC + OC
PM25other = PM25 - ECOC
OA = 1.4 * OC
e_orgi = 0.2 * OA
e_orgj = 0.8 * OA
e_eci = 0.2 * EC
e_ecj = 0.8 * EC
e_pm25i = 0.2 * PM25other
e_pm25j = 0.8 * PM25other
print ("Now writing variables...")
b->e_eci = e_eci
b->e_ecj = e_ecj
b->e_orgi = e_orgi
b->e_orgj = e_orgj
b->e_pm25i = e_pm25i
b->e_pm25j = e_pm25j
b->PMcoarse = PMcoarse 
print ("Successful!")


end
