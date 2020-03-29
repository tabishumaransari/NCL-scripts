load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
begin
a1 = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_agri_Nov.nc","r")
a2 = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_ind_Nov.nc","r")
a3 = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_pow_Nov.nc","r")
a4 = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_tran_Nov.nc","r")
b1 = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_total_Nov.nc","c")
b = addfile("wrfchemi_00z_d03_total_Nov.nc","r")
 

;;;;writing variables for 00-12 hrs;;;;;
b1->Times  = b->Times
b1->XLAT   = b->XLAT
b1->XLONG  = b->XLONG

E_ALD    = (/a1->E_ALD(:,:,:,:)/) + (/a2->E_ALD(:,:,:,:)/) + (/a3->E_ALD(:,:,:,:)/) + (/a4->E_ALD(:,:,:,:)/) 
E_ALD!0     = "Time"    ; add coordinate variable
E_ALD!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ALD!2     = "south_north"    ; add coordinate variable
E_ALD!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ALD, E_ALD)
printVarSummary(E_ALD)
b1->E_ALD = E_ALD

E_CO    = (/a1->E_CO/) + (/a2->E_CO/) + (/a3->E_CO/) + (/a4->E_CO/) 
E_CO!0     = "Time"    ; add coordinate variable
E_CO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_CO!2     = "south_north"    ; add coordinate variable
E_CO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_CO, E_CO)
printVarSummary(E_CO)
b1->E_CO = E_CO

E_OL2    = (/a1->E_OL2/) + (/a2->E_OL2/) + (/a3->E_OL2/) + (/a4->E_OL2/) 
E_OL2!0     = "Time"    ; add coordinate variable
E_OL2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OL2!2     = "south_north"    ; add coordinate variable
E_OL2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OL2, E_OL2)
printVarSummary(E_OL2)
b1->E_OL2 = E_OL2

E_ETH    = (/a1->E_ETH/) + (/a2->E_ETH/) + (/a3->E_ETH/) + (/a4->E_ETH/) 
E_ETH!0     = "Time"    ; add coordinate variable
E_ETH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ETH!2     = "south_north"    ; add coordinate variable
E_ETH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ETH, E_ETH)
printVarSummary(E_ETH)
b1->E_ETH = E_ETH

E_C2H5OH    = (/a1->E_C2H5OH/) + (/a2->E_C2H5OH/) + (/a3->E_C2H5OH/) + (/a4->E_C2H5OH/) 
E_C2H5OH!0     = "Time"    ; add coordinate variable
E_C2H5OH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_C2H5OH!2     = "south_north"    ; add coordinate variable
E_C2H5OH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_C2H5OH, E_C2H5OH)
printVarSummary(E_C2H5OH)
b1->E_C2H5OH = E_C2H5OH

E_HCHO    = (/a1->E_HCHO/) + (/a2->E_HCHO/) + (/a3->E_HCHO/) + (/a4->E_HCHO/) 
E_HCHO!0     = "Time"    ; add coordinate variable
E_HCHO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HCHO!2     = "south_north"    ; add coordinate variable
E_HCHO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HCHO, E_HCHO)
printVarSummary(E_HCHO)
b1->E_HCHO = E_HCHO

E_OLI    = (/a1->E_OLI/) + (/a2->E_OLI/) + (/a3->E_OLI/) + (/a4->E_OLI/) 
E_OLI!0     = "Time"    ; add coordinate variable
E_OLI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OLI!2     = "south_north"    ; add coordinate variable
E_OLI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OLI, E_OLI)
printVarSummary(E_OLI)
b1->E_OLI = E_OLI

E_KET    = (/a1->E_KET/) + (/a2->E_KET/) + (/a3->E_KET/) + (/a4->E_KET/) 
E_KET!0     = "Time"    ; add coordinate variable
E_KET!1     = "emissions_zdim_stag"    ; add coordinate variable
E_KET!2     = "south_north"    ; add coordinate variable
E_KET!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_KET, E_KET)
printVarSummary(E_KET)
b1->E_KET = E_KET

E_CH3OH    = (/a1->E_CH3OH/) + (/a2->E_CH3OH/) + (/a3->E_CH3OH/) + (/a4->E_CH3OH/) 
E_CH3OH!0     = "Time"    ; add coordinate variable
E_CH3OH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_CH3OH!2     = "south_north"    ; add coordinate variable
E_CH3OH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_CH3OH, E_CH3OH)
printVarSummary(E_CH3OH)
b1->E_CH3OH = E_CH3OH

E_NH3    = (/a1->E_NH3/) + (/a2->E_NH3/) + (/a3->E_NH3/) + (/a4->E_NH3/) 
E_NH3!0     = "Time"    ; add coordinate variable
E_NH3!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NH3!2     = "south_north"    ; add coordinate variable
E_NH3!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NH3, E_NH3)
printVarSummary(E_NH3)
b1->E_NH3 = E_NH3

E_NO    = (/a1->E_NO/) + (/a2->E_NO/) + (/a3->E_NO/) + (/a4->E_NO/) 
E_NO!0     = "Time"    ; add coordinate variable
E_NO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NO!2     = "south_north"    ; add coordinate variable
E_NO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NO, E_NO)
printVarSummary(E_NO)
b1->E_NO = E_NO

E_NO2    = (/a1->E_NO2/) + (/a2->E_NO2/) + (/a3->E_NO2/) + (/a4->E_NO2/) 
E_NO2!0     = "Time"    ; add coordinate variable
E_NO2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NO2!2     = "south_north"    ; add coordinate variable
E_NO2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NO2, E_NO2)
printVarSummary(E_NO2)
b1->E_NO2 = E_NO2

E_OLT    = (/a1->E_OLT/) + (/a2->E_OLT/) + (/a3->E_OLT/) + (/a4->E_OLT/) 
E_OLT!0     = "Time"    ; add coordinate variable
E_OLT!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OLT!2     = "south_north"    ; add coordinate variable
E_OLT!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OLT, E_OLT)
printVarSummary(E_OLT)
b1->E_OLT = E_OLT

E_SO2    = (/a1->E_SO2/) + (/a2->E_SO2/) + (/a3->E_SO2/) + (/a4->E_SO2/) 
E_SO2!0     = "Time"    ; add coordinate variable
E_SO2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_SO2!2     = "south_north"    ; add coordinate variable
E_SO2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_SO2, E_SO2)
printVarSummary(E_SO2)
b1->E_SO2 = E_SO2

E_TOL    = (/a1->E_TOL/) + (/a2->E_TOL/) + (/a3->E_TOL/) + (/a4->E_TOL/) 
E_TOL!0     = "Time"    ; add coordinate variable
E_TOL!1     = "emissions_zdim_stag"    ; add coordinate variable
E_TOL!2     = "south_north"    ; add coordinate variable
E_TOL!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_TOL, E_TOL)
printVarSummary(E_TOL)
b1->E_TOL = E_TOL

E_XYL    = (/a1->E_XYL/) + (/a2->E_XYL/) + (/a3->E_XYL/) + (/a4->E_XYL/) 
E_XYL!0     = "Time"    ; add coordinate variable
E_XYL!1     = "emissions_zdim_stag"    ; add coordinate variable
E_XYL!2     = "south_north"    ; add coordinate variable
E_XYL!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_XYL, E_XYL)
printVarSummary(E_XYL)
b1->E_XYL = E_XYL

E_HC3    = (/a1->E_HC3/) + (/a2->E_HC3/) + (/a3->E_HC3/) + (/a4->E_HC3/) 
E_HC3!0     = "Time"    ; add coordinate variable
E_HC3!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC3!2     = "south_north"    ; add coordinate variable
E_HC3!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC3, E_HC3)
printVarSummary(E_HC3)
b1->E_HC3 = E_HC3

E_HC5    = (/a1->E_HC5/) + (/a2->E_HC5/) + (/a3->E_HC5/) + (/a4->E_HC5/) 
E_HC5!0     = "Time"    ; add coordinate variable
E_HC5!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC5!2     = "south_north"    ; add coordinate variable
E_HC5!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC5, E_HC5)
printVarSummary(E_HC5)
b1->E_HC5 = E_HC5

E_HC8    = (/a1->E_HC8/) + (/a2->E_HC8/) + (/a3->E_HC8/) + (/a4->E_HC8/) 
E_HC8!0     = "Time"    ; add coordinate variable
E_HC8!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC8!2     = "south_north"    ; add coordinate variable
E_HC8!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC8, E_HC8)
printVarSummary(E_HC8)
b1->E_HC8 = E_HC8

E_ECI    = (/a1->E_ECI/) + (/a2->E_ECI/) + (/a3->E_ECI/) + (/a4->E_ECI/) 
E_ECI!0     = "Time"    ; add coordinate variable
E_ECI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ECI!2     = "south_north"    ; add coordinate variable
E_ECI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECI, E_ECI)
printVarSummary(E_ECI)
b1->E_ECI = E_ECI

E_ECJ    = (/a1->E_ECJ/) + (/a2->E_ECJ/) + (/a3->E_ECJ/) + (/a4->E_ECJ/) 
E_ECJ!0     = "Time"    ; add coordinate variable
E_ECJ!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ECJ!2     = "south_north"    ; add coordinate variable
E_ECJ!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECJ, E_ECJ)
printVarSummary(E_ECJ)
b1->E_ECJ = E_ECJ

E_ORGI    = (/a1->E_ORGI/) + (/a2->E_ORGI/) + (/a3->E_ORGI/) + (/a4->E_ORGI/) 
E_ORGI!0     = "Time"    ; add coordinate variable
E_ORGI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ORGI!2     = "south_north"    ; add coordinate variable
E_ORGI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ORGI, E_ORGI)
printVarSummary(E_ORGI)
b1->E_ORGI = E_ORGI

E_ORGJ    = (/a1->E_ORGJ/) + (/a2->E_ORGJ/) + (/a3->E_ORGJ/) + (/a4->E_ORGJ/) 
E_ORGJ!0     = "Time"    ; add coordinate variable
E_ORGJ!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ORGJ!2     = "south_north"    ; add coordinate variable
E_ORGJ!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ORGJ, E_ORGJ)
printVarSummary(E_ORGJ)
b1->E_ORGJ = E_ORGJ

E_PM25I    = (/a1->E_PM25I/) + (/a2->E_PM25I/) + (/a3->E_PM25I/) + (/a4->E_PM25I/) 
E_PM25I!0     = "Time"    ; add coordinate variable
E_PM25I!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM25I!2     = "south_north"    ; add coordinate variable
E_PM25I!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM25I, E_PM25I)
printVarSummary(E_PM25I)
b1->E_PM25I = E_PM25I

E_PM25J    = (/a1->E_PM25J/) + (/a2->E_PM25J/) + (/a3->E_PM25J/) + (/a4->E_PM25J/) 
E_PM25J!0     = "Time"    ; add coordinate variable
E_PM25J!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM25J!2     = "south_north"    ; add coordinate variable
E_PM25J!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM25J, E_PM25J)
printVarSummary(E_PM25J)
b1->E_PM25J = E_PM25J

E_PM_10    = (/a1->E_PM_10/) + (/a2->E_PM_10/) + (/a3->E_PM_10/) + (/a4->E_PM_10/) 
E_PM_10!0     = "Time"    ; add coordinate variable
E_PM_10!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM_10!2     = "south_north"    ; add coordinate variable
E_PM_10!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM_10, E_PM_10)
printVarSummary(E_PM_10)
b1->E_PM_10 = E_PM_10

copy_VarAtts(b, b1) ; contributed.ncl 

print("All sectors added successfully!")

end
