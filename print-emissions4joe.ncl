begin
a = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
b = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
tol1 = a->E_TOL(:,8,144,79)
tol2 = b->E_TOL(:,8,144,79)
emis_gmt = new(24,float)
emis_bjt = new(24,float)
emis_gmt(0:11)=tol1
emis_gmt(12:23)=tol2
emis_bjt(0:7)=emis_gmt(16:23)
emis_bjt(8:23)=emis_gmt(0:15)
print(emis_bjt)

end
