;THIS SCRIPT WILL CREATE EMISSION FILES FOR THE MASTERS STUDENT WITH 50% REDUCED TRANSPORT EMISSIONS OVER BEIJING AND BTH
begin

a = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r") 
b = addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d03_tran_Oct.nc","r") 
c = addfile("/data3/tabish/wrfchemi-management/forMSCstudent/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_0.5Btran.nc","w") 

print("reading variables...")
mask_d01 = a->Bmask_d01
mask_d02 = a->Bmask_d02
mask_d03 = a->Bmask_d03

ald = b->E_ALD
co  = b->E_CO
ol2 = b->E_OL2
eth = b->E_ETH
c2h5oh = b->E_C2H5OH
hcho = b->E_HCHO
oli = b->E_OLI
ket = b->E_KET
ch3oh = b->E_CH3OH
nh3 = b->E_NH3
no2 = b->E_NO2
no = b->E_NO
olt = b->E_OLT
so2 = b->E_SO2
tol = b->E_TOL
xyl = b->E_XYL
hc3 = b->E_HC3
hc5 = b->E_HC5
hc8 = b->E_HC8
eci = b->E_ECI
ecj = b->E_ECJ
orgi = b->E_ORGI
orgj = b->E_ORGJ
pm25i = b->E_PM25I
pm25j = b->E_PM25J
pm10 = b->E_PM_10
;so4i = b->E_SO4I
;so4j = b->E_SO4J


print("variables read from transport sector file. Now modifying values over BTH region...")

ald   = where(mask_d03.eq.1, 0.5*ald, 0.0)
co    = where(mask_d03.eq.1, 0.5*co, 0.0)
ol2   = where(mask_d03.eq.1, 0.5*ol2, 0.0)
eth   = where(mask_d03.eq.1, 0.5*eth, 0.0)
c2h5oh= where(mask_d03.eq.1, 0.5*c2h5oh, 0.0)
hcho  = where(mask_d03.eq.1, 0.5*hcho, 0.0)
oli   = where(mask_d03.eq.1, 0.5*oli, 0.0)
ket   = where(mask_d03.eq.1, 0.5*ket, 0.0)
ch3oh = where(mask_d03.eq.1, 0.5*ch3oh, 0.0)
nh3   = where(mask_d03.eq.1, 0.5*nh3, 0.0)
no    = where(mask_d03.eq.1, 0.5*no, 0.0)
no2   = where(mask_d03.eq.1, 0.5*no2, 0.0)
olt   = where(mask_d03.eq.1, 0.5*olt, 0.0)
so2   = where(mask_d03.eq.1, 0.5*so2, 0.0)
tol   = where(mask_d03.eq.1, 0.5*tol, 0.0)
xyl   = where(mask_d03.eq.1, 0.5*xyl, 0.0)
hc3   = where(mask_d03.eq.1, 0.5*hc3, 0.0)
hc5   = where(mask_d03.eq.1, 0.5*hc5, 0.0)
hc8   = where(mask_d03.eq.1, 0.5*hc8, 0.0)
eci   = where(mask_d03.eq.1, 0.5*eci, 0.0)
ecj   = where(mask_d03.eq.1, 0.5*ecj, 0.0)
orgi  = where(mask_d03.eq.1, 0.5*orgi, 0.0)
orgj  = where(mask_d03.eq.1, 0.5*orgj, 0.0)
pm25i = where(mask_d03.eq.1, 0.5*pm25i, 0.0)
pm25j = where(mask_d03.eq.1, 0.5*pm25j, 0.0)
pm10  = where(mask_d03.eq.1, 0.5*pm10, 0.0)
;so4i  = where(mask_d01.eq.1, 0.5*so4i, 0.0)
;so4j  = where(mask_d01.eq.1, 0.5*so4j, 0.0)
print("Transport variables reduced to 50% over BTH and zero elsewhere.")

print("Now reading-off variables from the new file to modify them")
ALD    = c->E_ALD
CO     = c->E_CO
OL2    = c->E_OL2
ETH    = c->E_ETH
C2H5OH = c->E_C2H5OH
HCHO   = c->E_HCHO
OLI    = c->E_OLI
KET    = c->E_KET
CH3OH  = c->E_CH3OH
NH3    = c->E_NH3
NO     = c->E_NO
NO2    = c->E_NO2
OLT    = c->E_OLT
SO2    = c->E_SO2
TOL    = c->E_TOL
XYL    = c->E_XYL
HC3    = c->E_HC3
HC5    = c->E_HC5
HC8    = c->E_HC8
ECI    = c->E_ECI
ECJ    = c->E_ECJ
ORGI   = c->E_ORGI
ORGJ   = c->E_ORGJ
PM25I  = c->E_PM25I
PM25J  = c->E_PM25J
PM10   = c->E_PM_10
;SO4I   = c->E_SO4I
;SO4J   = c->E_SO4J

print("modifying the temporary variables")
ALD = ALD - ald
CO = CO - co
OL2 = OL2 - ol2
ETH = ETH - eth
C2H5OH = C2H5OH - c2h5oh
HCHO = HCHO - hcho
OLI = OLI - oli
KET = KET - ket
CH3OH = CH3OH - ch3oh
NH3 = NH3 - nh3
NO = NO - no
NO2 = NO2 - no2
OLT = OLT - olt
SO2 = SO2 - so2
TOL = TOL - tol
XYL = XYL - xyl
HC3 = HC3 - hc3
HC5 = HC5 - hc5
HC8 = HC8 - hc8
ECI = ECI - eci
ECJ = ECJ - ecj
ORGI = ORGI - orgi
ORGJ = ORGJ - orgj
PM25I = PM25I - pm25i
PM25J = PM25J - pm25j
PM10 = PM10 - pm10
;SO4I = SO4I - so4i
;SO4J = SO4J - so4j

print("Writing them back to the new file..")
c->E_ALD  = ALD
c->E_CO   = CO
c->E_OL2  = OL2
c->E_ETH  = ETH
c->E_C2H5OH = C2H5OH
c->E_HCHO = HCHO 
c->E_OLI = OLI
c->E_KET = KET
c->E_CH3OH = CH3OH
c->E_NH3 = NH3
c->E_NO = NO
c->E_NO2 = NO2
c->E_OLT = OLT
c->E_SO2 = SO2
c->E_TOL = TOL
c->E_XYL = XYL
c->E_HC3 = HC3
c->E_HC5 = HC5
c->E_HC8 = HC8
c->E_ECI = ECI
c->E_ECJ = ECJ
c->E_ORGI = ORGI
c->E_ORGJ = ORGJ
c->E_PM25I = PM25I
c->E_PM25J = PM25J
c->E_PM_10 = PM10
;c->E_SO4I = SO4I
;c->E_SO4J = SO4J


print("Success! All variables modified accordingly.")
end
