begin
a1 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d03_Dec_res.nc","r")
a2 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d03_Dec_ind.nc","r")
a3 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d03_Dec_pow.nc","r")
a4 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d03_Dec_tran.nc","r")
b1 = addfile("/data3/tabish/wrfchemi_MEIC2013/wrfchemi_00z_d03_Dec_total.nc","w")


;;;;writing variables for 00-12 hrs;;;;;
b1->E_ALD    = a1->E_ALD + a2->E_ALD + a3->E_ALD + a4->E_ALD 
b1->E_CO    = a1->E_CO + a2->E_CO + a3->E_CO + a4->E_CO 
b1->E_OL2    = a1->E_OL2 + a2->E_OL2 + a3->E_OL2 + a4->E_OL2 
b1->E_ETH    = a1->E_ETH + a2->E_ETH + a3->E_ETH + a4->E_ETH 
b1->E_C2H5OH    = a1->E_C2H5OH + a2->E_C2H5OH + a3->E_C2H5OH + a4->E_C2H5OH 
b1->E_HCHO    = a1->E_HCHO + a2->E_HCHO + a3->E_HCHO + a4->E_HCHO 
b1->E_OLI    = a1->E_OLI + a2->E_OLI + a3->E_OLI + a4->E_OLI 
b1->E_CH3OH    = a1->E_CH3OH + a2->E_CH3OH + a3->E_CH3OH + a4->E_CH3OH 
b1->E_NH3    = a1->E_NH3 + a2->E_NH3 + a3->E_NH3 + a4->E_NH3 
b1->E_NO    = a1->E_NO + a2->E_NO + a3->E_NO + a4->E_NO 
b1->E_NO2    = a1->E_NO2 + a2->E_NO2 + a3->E_NO2 + a4->E_NO2 
b1->E_OLT    = a1->E_OLT + a2->E_OLT + a3->E_OLT + a4->E_OLT 
b1->E_SO2    = a1->E_SO2 + a2->E_SO2 + a3->E_SO2 + a4->E_SO2 
b1->E_TOL    = a1->E_TOL + a2->E_TOL + a3->E_TOL + a4->E_TOL 
b1->E_XYL    = a1->E_XYL + a2->E_XYL + a3->E_XYL + a4->E_XYL 
b1->E_HC3    = a1->E_HC3 + a2->E_HC3 + a3->E_HC3 + a4->E_HC3 
b1->E_HC5    = a1->E_HC5 + a2->E_HC5 + a3->E_HC5 + a4->E_HC5 
b1->E_HC8    = a1->E_HC8 + a2->E_HC8 + a3->E_HC8 + a4->E_HC8 
b1->E_ECI    = a1->E_ECI + a2->E_ECI + a3->E_ECI + a4->E_ECI 
b1->E_ECJ    = a1->E_ECJ + a2->E_ECJ + a3->E_ECJ + a4->E_ECJ 
b1->E_ORGI    = a1->E_ORGI + a2->E_ORGI + a3->E_ORGI + a4->E_ORGI 
b1->E_ORGJ    = a1->E_ORGJ + a2->E_ORGJ + a3->E_ORGJ + a4->E_ORGJ 
b1->E_PM25I    = a1->E_PM25I + a2->E_PM25I + a3->E_PM25I + a4->E_PM25I 
b1->E_PM25J    = a1->E_PM25J + a2->E_PM25J + a3->E_PM25J + a4->E_PM25J 
b1->E_PM_10    = a1->E_PM_10 + a2->E_PM_10 + a3->E_PM_10 + a4->E_PM_10 


print("All sectors added successfully!")

end
