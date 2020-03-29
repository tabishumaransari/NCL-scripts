begin
ncol = 32
data = readAsciiTable("IAP_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table-surface read-in successfully")
printVarSummary(data)

oc_apec = data(:,1)
oc_obs  = data(:,3)

bc_apec = data(:,5)
bc_obs  = data(:,7)

no3_apec = data(:,9)
no3_obs  = data(:,11)

nh4_apec = data(:,17)
nh4_obs  = data(:,19)

so4_apec = data(:,13)
so4_obs  = data(:,15)

rc_oc   = regline (oc_obs,oc_apec)
rc_bc   = regline (bc_obs,bc_apec)
rc_no3  = regline (no3_obs,no3_apec)
rc_nh4  = regline (nh4_obs,nh4_apec)
rc_so4  = regline (so4_obs,so4_apec)


cc_oc   = escorc (oc_obs,oc_apec)
cc_bc   = escorc (bc_obs,bc_apec)
cc_no3  = escorc (no3_obs,no3_apec)
cc_nh4  = escorc (nh4_obs,nh4_apec)
cc_so4  = escorc (so4_obs,so4_apec)




print(cc_so4)

end
