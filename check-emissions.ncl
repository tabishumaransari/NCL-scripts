begin

DATADir = "/data3/tabish/vert-MEIC-emis/pulse-wrfchemi/for6daypulsenov/"
FILES1    = systemfunc (" ls -1 " + DATADir + "*d01")
FILES2    = systemfunc (" ls -1 " + DATADir + "*d02")
FILES3    = systemfunc (" ls -1 " + DATADir + "*d03")

print(FILES1)
print(FILES2)
print(FILES3)

a1  = addfiles(FILES1,"r")
a2  = addfiles(FILES2,"r")
a3  = addfiles(FILES3,"r")

eci_d01  = a1[:]->E_ECI(:,0,62,89)
eci_d02  = a2[:]->E_ECI(:,0,61,64)
eci_d03  = a3[:]->E_ECI(:,0,144,79)

ecj_d01  = a1[:]->E_ECJ(:,0,62,89)
ecj_d02  = a2[:]->E_ECJ(:,0,61,64)
ecj_d03  = a3[:]->E_ECJ(:,0,144,79)

orgi_d01  = a1[:]->E_ORGI(:,0,62,89)
orgi_d02  = a2[:]->E_ORGI(:,0,61,64)
orgi_d03  = a3[:]->E_ORGI(:,0,144,79)

orgj_d01  = a1[:]->E_ORGJ(:,0,62,89)
orgj_d02  = a2[:]->E_ORGJ(:,0,61,64)
orgj_d03  = a3[:]->E_ORGJ(:,0,144,79)

pm25i_d01  = a1[:]->E_PM25I(:,0,62,89)
pm25i_d02  = a2[:]->E_PM25I(:,0,61,64)
pm25i_d03  = a3[:]->E_PM25I(:,0,144,79)

pm25j_d01  = a1[:]->E_PM25J(:,0,62,89)
pm25j_d02  = a2[:]->E_PM25J(:,0,61,64)
pm25j_d03  = a3[:]->E_PM25J(:,0,144,79)

so4i_d01  = a1[:]->E_SO4I(:,0,62,89)
so4i_d02  = a2[:]->E_SO4I(:,0,61,64)
so4i_d03  = a3[:]->E_SO4I(:,0,144,79)

so4j_d01  = a1[:]->E_SO4J(:,0,62,89)
so4j_d02  = a2[:]->E_SO4J(:,0,61,64)
so4j_d03  = a3[:]->E_SO4J(:,0,144,79)

pm10_d01  = a1[:]->E_PM_10(:,0,62,89)
pm10_d02  = a2[:]->E_PM_10(:,0,61,64)
pm10_d03  = a3[:]->E_PM_10(:,0,144,79)


;print (sprintf("%9.4f",eci_d01 )    +" " \
;          +sprintf("%9.4f", ecj_d01) +"  " \
;          +sprintf("%9.4f", orgi_d01) +"  " \
;          +sprintf("%9.4f", orgj_d01) +"  " \
;          +sprintf("%9.4f", pm25i_d01) +"  " \
;          +sprintf("%9.4f", pm25j_d01) +"  " \
;          +sprintf("%9.4f", pm10_d01) +"  " \
;          +sprintf("%9.4f", so4i_d01) +"  " \
;          +sprintf("%9.4f", so4j_d01))

print(orgj_d03)

end
