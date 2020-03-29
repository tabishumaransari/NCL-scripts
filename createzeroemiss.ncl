;THIS SCRIPT CREATES ZERO EMISSIONS FILES NEEDED FOR ZERO EMISSIONS RUN
begin
;Duplicate files of wrfchemi-allnormal have been created with appropriate names - i just need to modify the values within
a1 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_allzero.nc","w")
a2 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Oct_8lev_0.5BTHso2_so4_allzero.nc","w")
a3 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_allzero.nc","w")

b1 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_0-3zero_4-11normal.nc","w")
b2 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Oct_8lev_0.5BTHso2_so4_0-3zero_4-11normal.nc","w")
b3 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_0-3zero_4-11normal.nc","w")

c1 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_0-3normal_4-11zero.nc","w")
c2 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Oct_8lev_0.5BTHso2_so4_0-3normal_4-11zero.nc","w")
c3 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_0-3normal_4-11zero.nc","w")


d = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r")
mask1 = d->APEC2mask_d01(:,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask2 = d->APEC2mask_d02(:,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask3 = d->APEC2mask_d03(:,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED

a1->E_ALD = where(mask1.eq.1, 0.0, a1->E_ALD) 
a2->E_ALD = where(mask2.eq.1, 0.0, a2->E_ALD) 
a3->E_ALD = where(mask3.eq.1, 0.0, a3->E_ALD) 

a1->E_CO = where(mask1.eq.1, 0.0, a1->E_CO)
a2->E_CO = where(mask2.eq.1, 0.0, a2->E_CO)
a3->E_CO = where(mask3.eq.1, 0.0, a3->E_CO)

a1->E_OL2 = where(mask1.eq.1, 0.0, a1->E_OL2)
a2->E_OL2 = where(mask2.eq.1, 0.0, a2->E_OL2)
a3->E_OL2 = where(mask3.eq.1, 0.0, a3->E_OL2)

a1->E_ETH = where(mask1.eq.1, 0.0, a1->E_ETH)
a2->E_ETH = where(mask2.eq.1, 0.0, a2->E_ETH)
a3->E_ETH = where(mask3.eq.1, 0.0, a3->E_ETH)

a1->E_C2H5OH = where(mask1.eq.1, 0.0, a1->E_C2H5OH)
a2->E_C2H5OH = where(mask2.eq.1, 0.0, a2->E_C2H5OH)
a3->E_C2H5OH = where(mask3.eq.1, 0.0, a3->E_C2H5OH)

a1->E_HCHO = where(mask1.eq.1, 0.0, a1->E_HCHO)
a2->E_HCHO = where(mask2.eq.1, 0.0, a2->E_HCHO)
a3->E_HCHO = where(mask3.eq.1, 0.0, a3->E_HCHO)

a1->E_OLI = where(mask1.eq.1, 0.0, a1->E_OLI)
a2->E_OLI = where(mask2.eq.1, 0.0, a2->E_OLI)
a3->E_OLI = where(mask3.eq.1, 0.0, a3->E_OLI)

a1->E_KET = where(mask1.eq.1, 0.0, a1->E_KET)
a2->E_KET = where(mask2.eq.1, 0.0, a2->E_KET)
a3->E_KET = where(mask3.eq.1, 0.0, a3->E_KET)

a1->E_CH3OH = where(mask1.eq.1, 0.0, a1->E_CH3OH)
a2->E_CH3OH = where(mask2.eq.1, 0.0, a2->E_CH3OH)
a3->E_CH3OH = where(mask3.eq.1, 0.0, a3->E_CH3OH)

a1->E_NH3 = where(mask1.eq.1, 0.0, a1->E_NH3)
a2->E_NH3 = where(mask2.eq.1, 0.0, a2->E_NH3)
a3->E_NH3 = where(mask3.eq.1, 0.0, a3->E_NH3)

a1->E_NO = where(mask1.eq.1, 0.0, a1->E_NO)
a2->E_NO = where(mask2.eq.1, 0.0, a2->E_NO)
a3->E_NO = where(mask3.eq.1, 0.0, a3->E_NO)

a1->E_NO2 = where(mask1.eq.1, 0.0, a1->E_NO2)
a2->E_NO2 = where(mask2.eq.1, 0.0, a2->E_NO2)
a3->E_NO2 = where(mask3.eq.1, 0.0, a3->E_NO2)

a1->E_OLT = where(mask1.eq.1, 0.0, a1->E_OLT)
a2->E_OLT = where(mask2.eq.1, 0.0, a2->E_OLT)
a3->E_OLT = where(mask3.eq.1, 0.0, a3->E_OLT)

a1->E_SO2 = where(mask1.eq.1, 0.0, a1->E_SO2)
a2->E_SO2 = where(mask2.eq.1, 0.0, a2->E_SO2)
a3->E_SO2 = where(mask3.eq.1, 0.0, a3->E_SO2)

a1->E_TOL = where(mask1.eq.1, 0.0, a1->E_TOL)
a2->E_TOL = where(mask2.eq.1, 0.0, a2->E_TOL)
a3->E_TOL = where(mask3.eq.1, 0.0, a3->E_TOL)

a1->E_XYL = where(mask1.eq.1, 0.0, a1->E_XYL)
a2->E_XYL = where(mask2.eq.1, 0.0, a2->E_XYL)
a3->E_XYL = where(mask3.eq.1, 0.0, a3->E_XYL)

a1->E_HC3 = where(mask1.eq.1, 0.0, a1->E_HC3)
a2->E_HC3 = where(mask2.eq.1, 0.0, a2->E_HC3)
a3->E_HC3 = where(mask3.eq.1, 0.0, a3->E_HC3)

a1->E_HC5 = where(mask1.eq.1, 0.0, a1->E_HC5)
a2->E_HC5 = where(mask2.eq.1, 0.0, a2->E_HC5)
a3->E_HC5 = where(mask3.eq.1, 0.0, a3->E_HC5)

a1->E_HC8 = where(mask1.eq.1, 0.0, a1->E_HC8)
a2->E_HC8 = where(mask2.eq.1, 0.0, a2->E_HC8)
a3->E_HC8 = where(mask3.eq.1, 0.0, a3->E_HC8)

a1->E_ECI = where(mask1.eq.1, 0.0, a1->E_ECI)
a2->E_ECI = where(mask2.eq.1, 0.0, a2->E_ECI)
a3->E_ECI = where(mask3.eq.1, 0.0, a3->E_ECI)

a1->E_ECJ = where(mask1.eq.1, 0.0, a1->E_ECJ)
a2->E_ECJ = where(mask2.eq.1, 0.0, a2->E_ECJ)
a3->E_ECJ = where(mask3.eq.1, 0.0, a3->E_ECJ)

a1->E_ORGI = where(mask1.eq.1, 0.0, a1->E_ORGI)
a2->E_ORGI = where(mask2.eq.1, 0.0, a2->E_ORGI)
a3->E_ORGI = where(mask3.eq.1, 0.0, a3->E_ORGI)

a1->E_ORGJ = where(mask1.eq.1, 0.0, a1->E_ORGJ)
a2->E_ORGJ = where(mask2.eq.1, 0.0, a2->E_ORGJ)
a3->E_ORGJ = where(mask3.eq.1, 0.0, a3->E_ORGJ)

a1->E_PM25I = where(mask1.eq.1, 0.0, a1->E_PM25I)
a2->E_PM25I = where(mask2.eq.1, 0.0, a2->E_PM25I)
a3->E_PM25I = where(mask3.eq.1, 0.0, a3->E_PM25I)

a1->E_PM25J = where(mask1.eq.1, 0.0, a1->E_PM25J)
a2->E_PM25J = where(mask2.eq.1, 0.0, a2->E_PM25J)
a3->E_PM25J = where(mask3.eq.1, 0.0, a3->E_PM25J)

a1->E_PM_10 = where(mask1.eq.1, 0.0, a1->E_PM_10)
a2->E_PM_10 = where(mask2.eq.1, 0.0, a2->E_PM_10)
a3->E_PM_10 = where(mask3.eq.1, 0.0, a3->E_PM_10)

a1->E_SO4I = where(mask1.eq.1, 0.0, a1->E_SO4I)
a2->E_SO4I = where(mask2.eq.1, 0.0, a2->E_SO4I)
a3->E_SO4I = where(mask3.eq.1, 0.0, a3->E_SO4I)

a1->E_SO4J = where(mask1.eq.1, 0.0, a1->E_SO4J)
a2->E_SO4J = where(mask2.eq.1, 0.0, a2->E_SO4J)
a3->E_SO4J = where(mask3.eq.1, 0.0, a3->E_SO4J)

print("allzero files modified appropriately.")
delete([/mask1,mask2,mask3/])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mask1 = d->APEC2mask_d01(0:3,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask2 = d->APEC2mask_d02(0:3,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask3 = d->APEC2mask_d03(0:3,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED

b1->E_ALD(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ALD(0:3,:,:,:))
b2->E_ALD(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ALD(0:3,:,:,:))
b3->E_ALD(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ALD(0:3,:,:,:))

b1->E_CO(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_CO(0:3,:,:,:))
b2->E_CO(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_CO(0:3,:,:,:))
b3->E_CO(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_CO(0:3,:,:,:))

b1->E_OL2(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_OL2(0:3,:,:,:))
b2->E_OL2(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_OL2(0:3,:,:,:))
b3->E_OL2(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_OL2(0:3,:,:,:))

b1->E_ETH(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ETH(0:3,:,:,:))
b2->E_ETH(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ETH(0:3,:,:,:))
b3->E_ETH(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ETH(0:3,:,:,:))

b1->E_C2H5OH(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_C2H5OH(0:3,:,:,:))
b2->E_C2H5OH(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_C2H5OH(0:3,:,:,:))
b3->E_C2H5OH(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_C2H5OH(0:3,:,:,:))

b1->E_HCHO(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_HCHO(0:3,:,:,:))
b2->E_HCHO(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_HCHO(0:3,:,:,:))
b3->E_HCHO(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_HCHO(0:3,:,:,:))

b1->E_OLI(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_OLI(0:3,:,:,:))
b2->E_OLI(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_OLI(0:3,:,:,:))
b3->E_OLI(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_OLI(0:3,:,:,:))

b1->E_KET(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_KET(0:3,:,:,:))
b2->E_KET(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_KET(0:3,:,:,:))
b3->E_KET(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_KET(0:3,:,:,:))

b1->E_CH3OH(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_CH3OH(0:3,:,:,:))
b2->E_CH3OH(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_CH3OH(0:3,:,:,:))
b3->E_CH3OH(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_CH3OH(0:3,:,:,:))

b1->E_NH3(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_NH3(0:3,:,:,:))
b2->E_NH3(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_NH3(0:3,:,:,:))
b3->E_NH3(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_NH3(0:3,:,:,:))

b1->E_NO(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_NO(0:3,:,:,:))
b2->E_NO(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_NO(0:3,:,:,:))
b3->E_NO(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_NO(0:3,:,:,:))

b1->E_NO2(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_NO2(0:3,:,:,:))
b2->E_NO2(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_NO2(0:3,:,:,:))
b3->E_NO2(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_NO2(0:3,:,:,:))

b1->E_OLT(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_OLT(0:3,:,:,:))
b2->E_OLT(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_OLT(0:3,:,:,:))
b3->E_OLT(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_OLT(0:3,:,:,:))

b1->E_SO2(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_SO2(0:3,:,:,:))
b2->E_SO2(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_SO2(0:3,:,:,:))
b3->E_SO2(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_SO2(0:3,:,:,:))

b1->E_TOL(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_TOL(0:3,:,:,:))
b2->E_TOL(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_TOL(0:3,:,:,:))
b3->E_TOL(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_TOL(0:3,:,:,:))

b1->E_XYL(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_XYL(0:3,:,:,:))
b2->E_XYL(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_XYL(0:3,:,:,:))
b3->E_XYL(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_XYL(0:3,:,:,:))

b1->E_HC3(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_HC3(0:3,:,:,:))
b2->E_HC3(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_HC3(0:3,:,:,:))
b3->E_HC3(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_HC3(0:3,:,:,:))

b1->E_HC5(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_HC5(0:3,:,:,:))
b2->E_HC5(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_HC5(0:3,:,:,:))
b3->E_HC5(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_HC5(0:3,:,:,:))

b1->E_HC8(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_HC8(0:3,:,:,:))
b2->E_HC8(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_HC8(0:3,:,:,:))
b3->E_HC8(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_HC8(0:3,:,:,:))

b1->E_ECI(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ECI(0:3,:,:,:))
b2->E_ECI(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ECI(0:3,:,:,:))
b3->E_ECI(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ECI(0:3,:,:,:))

b1->E_ECJ(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ECJ(0:3,:,:,:))
b2->E_ECJ(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ECJ(0:3,:,:,:))
b3->E_ECJ(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ECJ(0:3,:,:,:))

b1->E_ORGI(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ORGI(0:3,:,:,:))
b2->E_ORGI(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ORGI(0:3,:,:,:))
b3->E_ORGI(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ORGI(0:3,:,:,:))

b1->E_ORGJ(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_ORGJ(0:3,:,:,:))
b2->E_ORGJ(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_ORGJ(0:3,:,:,:))
b3->E_ORGJ(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_ORGJ(0:3,:,:,:))

b1->E_PM25I(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_PM25I(0:3,:,:,:))
b2->E_PM25I(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_PM25I(0:3,:,:,:))
b3->E_PM25I(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_PM25I(0:3,:,:,:))

b1->E_PM25J(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_PM25J(0:3,:,:,:))
b2->E_PM25J(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_PM25J(0:3,:,:,:))
b3->E_PM25J(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_PM25J(0:3,:,:,:))

b1->E_PM_10(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_PM_10(0:3,:,:,:))
b2->E_PM_10(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_PM_10(0:3,:,:,:))
b3->E_PM_10(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_PM_10(0:3,:,:,:))

b1->E_SO4I(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_SO4I(0:3,:,:,:))
b2->E_SO4I(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_SO4I(0:3,:,:,:))
b3->E_SO4I(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_SO4I(0:3,:,:,:))

b1->E_SO4J(0:3,:,:,:) = where(mask1.eq.1, 0.0, b1->E_SO4J(0:3,:,:,:))
b2->E_SO4J(0:3,:,:,:) = where(mask2.eq.1, 0.0, b2->E_SO4J(0:3,:,:,:))
b3->E_SO4J(0:3,:,:,:) = where(mask3.eq.1, 0.0, b3->E_SO4J(0:3,:,:,:))

print("0-3zero_4-11normal files modified appropriately.")
delete([/mask1,mask2,mask3/])

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


mask1 = d->APEC2mask_d01(4:11,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask2 = d->APEC2mask_d02(4:11,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
mask3 = d->APEC2mask_d03(4:11,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED

c1->E_ALD(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ALD(4:11,:,:,:))
c2->E_ALD(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ALD(4:11,:,:,:))
c3->E_ALD(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ALD(4:11,:,:,:))

c1->E_CO(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_CO(4:11,:,:,:))
c2->E_CO(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_CO(4:11,:,:,:))
c3->E_CO(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_CO(4:11,:,:,:))

c1->E_OL2(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_OL2(4:11,:,:,:))
c2->E_OL2(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_OL2(4:11,:,:,:))
c3->E_OL2(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_OL2(4:11,:,:,:))

c1->E_ETH(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ETH(4:11,:,:,:))
c2->E_ETH(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ETH(4:11,:,:,:))
c3->E_ETH(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ETH(4:11,:,:,:))

c1->E_C2H5OH(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_C2H5OH(4:11,:,:,:))
c2->E_C2H5OH(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_C2H5OH(4:11,:,:,:))
c3->E_C2H5OH(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_C2H5OH(4:11,:,:,:))

c1->E_HCHO(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_HCHO(4:11,:,:,:))
c2->E_HCHO(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_HCHO(4:11,:,:,:))
c3->E_HCHO(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_HCHO(4:11,:,:,:))

c1->E_OLI(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_OLI(4:11,:,:,:))
c2->E_OLI(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_OLI(4:11,:,:,:))
c3->E_OLI(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_OLI(4:11,:,:,:))

c1->E_KET(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_KET(4:11,:,:,:))
c2->E_KET(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_KET(4:11,:,:,:))
c3->E_KET(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_KET(4:11,:,:,:))

c1->E_CH3OH(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_CH3OH(4:11,:,:,:))
c2->E_CH3OH(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_CH3OH(4:11,:,:,:))
c3->E_CH3OH(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_CH3OH(4:11,:,:,:))

c1->E_NH3(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_NH3(4:11,:,:,:))
c2->E_NH3(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_NH3(4:11,:,:,:))
c3->E_NH3(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_NH3(4:11,:,:,:))

c1->E_NO(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_NO(4:11,:,:,:))
c2->E_NO(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_NO(4:11,:,:,:))
c3->E_NO(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_NO(4:11,:,:,:))

c1->E_NO2(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_NO2(4:11,:,:,:))
c2->E_NO2(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_NO2(4:11,:,:,:))
c3->E_NO2(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_NO2(4:11,:,:,:))

c1->E_OLT(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_OLT(4:11,:,:,:))
c2->E_OLT(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_OLT(4:11,:,:,:))
c3->E_OLT(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_OLT(4:11,:,:,:))

c1->E_SO2(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_SO2(4:11,:,:,:))
c2->E_SO2(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_SO2(4:11,:,:,:))
c3->E_SO2(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_SO2(4:11,:,:,:))

c1->E_TOL(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_TOL(4:11,:,:,:))
c2->E_TOL(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_TOL(4:11,:,:,:))
c3->E_TOL(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_TOL(4:11,:,:,:))

c1->E_XYL(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_XYL(4:11,:,:,:))
c2->E_XYL(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_XYL(4:11,:,:,:))
c3->E_XYL(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_XYL(4:11,:,:,:))

c1->E_HC3(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_HC3(4:11,:,:,:))
c2->E_HC3(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_HC3(4:11,:,:,:))
c3->E_HC3(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_HC3(4:11,:,:,:))

c1->E_HC5(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_HC5(4:11,:,:,:))
c2->E_HC5(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_HC5(4:11,:,:,:))
c3->E_HC5(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_HC5(4:11,:,:,:))

c1->E_HC8(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_HC8(4:11,:,:,:))
c2->E_HC8(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_HC8(4:11,:,:,:))
c3->E_HC8(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_HC8(4:11,:,:,:))

c1->E_ECI(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ECI(4:11,:,:,:))
c2->E_ECI(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ECI(4:11,:,:,:))
c3->E_ECI(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ECI(4:11,:,:,:))

c1->E_ECJ(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ECJ(4:11,:,:,:))
c2->E_ECJ(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ECJ(4:11,:,:,:))
c3->E_ECJ(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ECJ(4:11,:,:,:))

c1->E_ORGI(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ORGI(4:11,:,:,:))
c2->E_ORGI(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ORGI(4:11,:,:,:))
c3->E_ORGI(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ORGI(4:11,:,:,:))

c1->E_ORGJ(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_ORGJ(4:11,:,:,:))
c2->E_ORGJ(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_ORGJ(4:11,:,:,:))
c3->E_ORGJ(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_ORGJ(4:11,:,:,:))

c1->E_PM25I(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_PM25I(4:11,:,:,:))
c2->E_PM25I(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_PM25I(4:11,:,:,:))
c3->E_PM25I(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_PM25I(4:11,:,:,:))

c1->E_PM25J(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_PM25J(4:11,:,:,:))
c2->E_PM25J(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_PM25J(4:11,:,:,:))
c3->E_PM25J(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_PM25J(4:11,:,:,:))

c1->E_PM_10(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_PM_10(4:11,:,:,:))
c2->E_PM_10(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_PM_10(4:11,:,:,:))
c3->E_PM_10(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_PM_10(4:11,:,:,:))

c1->E_SO4I(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_SO4I(4:11,:,:,:))
c2->E_SO4I(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_SO4I(4:11,:,:,:))
c3->E_SO4I(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_SO4I(4:11,:,:,:))

c1->E_SO4J(4:11,:,:,:) = where(mask1.eq.1, 0.0, c1->E_SO4J(4:11,:,:,:))
c2->E_SO4J(4:11,:,:,:) = where(mask2.eq.1, 0.0, c2->E_SO4J(4:11,:,:,:))
c3->E_SO4J(4:11,:,:,:) = where(mask3.eq.1, 0.0, c3->E_SO4J(4:11,:,:,:))

print("0-3normal_4-11zero files modified appropriately.")
delete([/mask1,mask2,mask3/])



end
