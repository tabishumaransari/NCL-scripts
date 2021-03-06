begin
a1 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d01_Dec_ind.nc","w")
a2 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_12z_d01_Dec_ind.nc","w")
b1 = addfile("/data1/wildo/emissions/Dec2016_d01.nc","r")

;;;;reading off variables for 00-12 hrs;;;;conversion factors are to convert from kg km-2 s-1 to mol km-2 hr-1
E_ALD_00z    = 81.81 * b1->ald2(0:11,1,:,:)
E_CO_00z     = 128.57 * b1->co(0:11,1,:,:)
E_OL2_00z    = 128.57 * b1->c2h4(0:11,1,:,:)
E_ETH_00z    = 120 * b1->c2h6(0:11,1,:,:)
E_C2H5OH_00z = 78.26 * b1->anol(0:11,1,:,:)
E_HCHO_00z   = 120 * b1->hcho(0:11,1,:,:)
E_OLI_00z    = 85.71 * b1->olei(0:11,1,:,:)
E_CH3OH_00z  = 112.5 * b1->meoh(0:11,1,:,:)
E_NH3_00z    = 211.76 * b1->nh3(0:11,1,:,:)
E_NO_00z     = 120 * b1->no(0:11,1,:,:)
E_NO2_00z    = 78.26 * b1->no2(0:11,1,:,:)
E_OLT_00z    = 85.71 * b1->olet(0:11,1,:,:)
E_SO2_00z    = 56.25 * b1->so2(0:11,1,:,:)
E_TOL_00z    = 39.13 * b1->tol(0:11,1,:,:)
E_XYL_00z    = 33.96 * b1->xyl(0:11,1,:,:)
E_HC3_00z    = 15.624 * b1->par(0:11,1,:,:)
E_HC5_00z    = 15.624 * b1->par(0:11,1,:,:)
E_HC8_00z    = 15.624 * b1->par(0:11,1,:,:)

E_ECI_00z    = 0.2 * b1->bc(0:11,1,:,:)
E_ECJ_00z    = 0.8 * b1->bc(0:11,1,:,:)
E_ORGI_00z   = 0.32 * b1->oc(0:11,1,:,:)
E_ORGJ_00z   = 1.28 * b1->oc(0:11,1,:,:)
E_PM25I_00z  = 0.2 * b1->pm25(0:11,1,:,:)
E_PM25J_00z  = 0.8 * b1->pm25(0:11,1,:,:)
E_PM_10_00z  = b1->pm10(0:11,1,:,:)


;;;;reading off variables for 13-24 hrs;;;;
E_ALD_12z    = 81.81 * b1->ald2(12:23,1,:,:)
E_CO_12z     = 128.57 * b1->co(12:23,1,:,:)
E_OL2_12z    = 128.57 * b1->c2h4(12:23,1,:,:)
E_ETH_12z    = 120 * b1->c2h6(12:23,1,:,:)
E_C2H5OH_12z = 78.26 * b1->anol(12:23,1,:,:)
E_HCHO_12z   = 120 * b1->hcho(12:23,1,:,:)
E_OLI_12z    = 85.71 * b1->olei(12:23,1,:,:)
E_CH3OH_12z  = 112.5 * b1->meoh(12:23,1,:,:)
E_NH3_12z    = 211.76 * b1->nh3(12:23,1,:,:)
E_NO_12z     = 120 * b1->no(12:23,1,:,:)
E_NO2_12z    = 78.26 * b1->no2(12:23,1,:,:)
E_OLT_12z    = 85.71 * b1->olet(12:23,1,:,:)
E_SO2_12z    = 56.25 * b1->so2(12:23,1,:,:)
E_TOL_12z    = 39.13 * b1->tol(12:23,1,:,:)
E_XYL_12z    = 33.96 * b1->xyl(12:23,1,:,:)
E_HC3_12z    = 15.624 * b1->par(12:23,1,:,:)
E_HC5_12z    = 15.624 * b1->par(12:23,1,:,:)
E_HC8_12z    = 15.624 * b1->par(12:23,1,:,:)

E_ECI_12z    = 0.2 * b1->bc(12:23,1,:,:)
E_ECJ_12z    = 0.8 * b1->bc(12:23,1,:,:)
E_ORGI_12z   = 0.32 * b1->oc(12:23,1,:,:)
E_ORGJ_12z   = 1.28 * b1->oc(12:23,1,:,:)
E_PM25I_12z  = 0.2 * b1->pm25(12:23,1,:,:)
E_PM25J_12z  = 0.8 * b1->pm25(12:23,1,:,:)
E_PM_10_12z  = b1->pm10(12:23,1,:,:)
;printVarSummary(a1->E_ALD)
;printVarSummary(E_ALD_00z)

;;;;writing variables for 00-12 hrs;;;;;
a1->E_ALD(:,0,:,:)    = (/E_ALD_00z(:,:,:)/)
a1->E_CO(:,0,:,:)     = (/E_CO_00z(:,:,:)/)
a1->E_OL2(:,0,:,:)    = (/E_OL2_00z(:,:,:)/)
a1->E_ETH(:,0,:,:)    = (/E_ETH_00z(:,:,:)/)
a1->E_C2H5OH(:,0,:,:) = (/E_C2H5OH_00z(:,:,:)/)
a1->E_HCHO(:,0,:,:)   = (/E_HCHO_00z(:,:,:)/)
a1->E_OLI(:,0,:,:)    = (/E_OLI_00z(:,:,:)/)
a1->E_CH3OH(:,0,:,:)  = (/E_CH3OH_00z(:,:,:)/)
a1->E_NH3(:,0,:,:)    = (/E_NH3_00z(:,:,:)/)
a1->E_NO(:,0,:,:)     = (/E_NO_00z(:,:,:)/)
a1->E_NO2(:,0,:,:)    = (/E_NO2_00z(:,:,:)/)
a1->E_OLT(:,0,:,:)    = (/E_OLT_00z(:,:,:)/)
a1->E_SO2(:,0,:,:)    = (/E_SO2_00z(:,:,:)/)
a1->E_TOL(:,0,:,:)    = (/E_TOL_00z(:,:,:)/)
a1->E_XYL(:,0,:,:)    = (/E_XYL_00z(:,:,:)/)
a1->E_HC3(:,0,:,:)    = (/E_HC3_00z(:,:,:)/)
a1->E_HC5(:,0,:,:)    = (/E_HC5_00z(:,:,:)/)
a1->E_HC8(:,0,:,:)    = (/E_HC8_00z(:,:,:)/)

a1->E_ECI(:,0,:,:)    = (/E_ECI_00z(:,:,:)/)
a1->E_ECJ(:,0,:,:)    = (/E_ECJ_00z(:,:,:)/)
a1->E_ORGI(:,0,:,:)   = (/E_ORGI_00z(:,:,:)/)
a1->E_ORGJ(:,0,:,:)   = (/E_ORGJ_00z(:,:,:)/)
a1->E_PM25I(:,0,:,:)  = (/E_PM25I_00z(:,:,:)/)
a1->E_PM25J(:,0,:,:)  = (/E_PM25J_00z(:,:,:)/)
a1->E_PM_10(:,0,:,:)  = (/E_PM_10_00z(:,:,:)/)
print("wrfchemi_00z overwritten successfully")

;;;;writing variables for 13-24 hrs;;;;;
a2->E_ALD(:,0,:,:)    = (/E_ALD_12z(:,:,:)/)
a2->E_CO(:,0,:,:)     = (/E_CO_12z(:,:,:)/)
a2->E_OL2(:,0,:,:)    = (/E_OL2_12z(:,:,:)/)
a2->E_ETH(:,0,:,:)    = (/E_ETH_12z(:,:,:)/)
a2->E_C2H5OH(:,0,:,:) = (/E_C2H5OH_12z(:,:,:)/)
a2->E_HCHO(:,0,:,:)   = (/E_HCHO_12z(:,:,:)/)
a2->E_OLI(:,0,:,:)    = (/E_OLI_12z(:,:,:)/)
a2->E_CH3OH(:,0,:,:)  = (/E_CH3OH_12z(:,:,:)/)
a2->E_NH3(:,0,:,:)    = (/E_NH3_12z(:,:,:)/)
a2->E_NO(:,0,:,:)     = (/E_NO_12z(:,:,:)/)
a2->E_NO2(:,0,:,:)    = (/E_NO2_12z(:,:,:)/)
a2->E_OLT(:,0,:,:)    = (/E_OLT_12z(:,:,:)/)
a2->E_SO2(:,0,:,:)    = (/E_SO2_12z(:,:,:)/)
a2->E_TOL(:,0,:,:)    = (/E_TOL_12z(:,:,:)/)
a2->E_XYL(:,0,:,:)    = (/E_XYL_12z(:,:,:)/)
a2->E_HC3(:,0,:,:)    = (/E_HC3_12z(:,:,:)/)
a2->E_HC5(:,0,:,:)    = (/E_HC5_12z(:,:,:)/)
a2->E_HC8(:,0,:,:)    = (/E_HC8_12z(:,:,:)/)

a2->E_ECI(:,0,:,:)    = (/E_ECI_12z(:,:,:)/)
a2->E_ECJ(:,0,:,:)    = (/E_ECJ_12z(:,:,:)/)
a2->E_ORGI(:,0,:,:)   = (/E_ORGI_12z(:,:,:)/)
a2->E_ORGJ(:,0,:,:)   = (/E_ORGJ_12z(:,:,:)/)
a2->E_PM25I(:,0,:,:)  = (/E_PM25I_12z(:,:,:)/)
a2->E_PM25J(:,0,:,:)  = (/E_PM25J_12z(:,:,:)/)
a2->E_PM_10(:,0,:,:)  = (/E_PM_10_12z(:,:,:)/)
print("wrfchemi_12z overwritten successfully")


end
