load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
begin
a1 = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_12z_d03_agri_Nov.nc","r")
a2 = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_12z_d03_ind_Nov.nc","r")
a3 = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_12z_d03_pow_Nov.nc","r")
a4 = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_12z_d03_tran_Nov.nc","r")

b = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_so4_0-3normal_4-11APEC1.nc","w")
c = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r")
mask1 = c->BAPEC1mask_d03(4:11,:,:,:) ;THE MASK IS SUBSET TO MATCH THE DIMENSIONS OF THE VARIABLE THAT NEEDS TO BE MASKED
 
;;;;writing variables for 00-12 hrs;;;;;
b->Times  = a1->Times
b->XLAT   = a1->XLAT
b->XLONG  = a1->XLONG

ald_agri = a1->E_ALD
ald_ind  = a2->E_ALD
ald_pow  = a3->E_ALD
ald_tran = a4->E_ALD

ald_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*ald_agri(4:11,:,:,:), ald_agri(4:11,:,:,:)) ;40% REDUCTION OVER  FOR AGRICULTURE, SAME ELSEWHERE
ald_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*ald_agri(4:11,:,:,:), ald_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

ald_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*ald_ind(4:11,:,:,:), ald_ind(4:11,:,:,:))
ald_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*ald_ind(4:11,:,:,:), ald_ind(4:11,:,:,:))

ald_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*ald_pow(4:11,:,:,:), ald_pow(4:11,:,:,:))
ald_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*ald_pow(4:11,:,:,:), ald_pow(4:11,:,:,:))

ald_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*ald_tran(4:11,:,:,:), ald_tran(4:11,:,:,:))
ald_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*ald_tran(4:11,:,:,:), ald_tran(4:11,:,:,:))


co_agri = a1->E_CO
co_ind  = a2->E_CO
co_pow  = a3->E_CO
co_tran = a4->E_CO

co_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*co_agri(4:11,:,:,:), co_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
co_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*co_agri(4:11,:,:,:), co_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

co_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*co_ind(4:11,:,:,:), co_ind(4:11,:,:,:))
co_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*co_ind(4:11,:,:,:), co_ind(4:11,:,:,:))

co_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*co_pow(4:11,:,:,:), co_pow(4:11,:,:,:))
co_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*co_pow(4:11,:,:,:), co_pow(4:11,:,:,:))

co_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*co_tran(4:11,:,:,:), co_tran(4:11,:,:,:))
co_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*co_tran(4:11,:,:,:), co_tran(4:11,:,:,:))


ol2_agri = a1->E_OL2
ol2_ind  = a2->E_OL2
ol2_pow  = a3->E_OL2
ol2_tran = a4->E_OL2

ol2_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*ol2_agri(4:11,:,:,:), ol2_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
ol2_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*ol2_agri(4:11,:,:,:), ol2_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

ol2_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*ol2_ind(4:11,:,:,:), ol2_ind(4:11,:,:,:))
ol2_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*ol2_ind(4:11,:,:,:), ol2_ind(4:11,:,:,:))

ol2_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*ol2_pow(4:11,:,:,:), ol2_pow(4:11,:,:,:))
ol2_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*ol2_pow(4:11,:,:,:), ol2_pow(4:11,:,:,:))

ol2_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*ol2_tran(4:11,:,:,:), ol2_tran(4:11,:,:,:))
ol2_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*ol2_tran(4:11,:,:,:), ol2_tran(4:11,:,:,:))


eth_agri = a1->E_ETH
eth_ind  = a2->E_ETH
eth_pow  = a3->E_ETH
eth_tran = a4->E_ETH

eth_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*eth_agri(4:11,:,:,:), eth_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
eth_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*eth_agri(4:11,:,:,:), eth_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

eth_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*eth_ind(4:11,:,:,:), eth_ind(4:11,:,:,:))
eth_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*eth_ind(4:11,:,:,:), eth_ind(4:11,:,:,:))

eth_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*eth_pow(4:11,:,:,:), eth_pow(4:11,:,:,:))
eth_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*eth_pow(4:11,:,:,:), eth_pow(4:11,:,:,:))

eth_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*eth_tran(4:11,:,:,:), eth_tran(4:11,:,:,:))
eth_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*eth_tran(4:11,:,:,:), eth_tran(4:11,:,:,:))


c2h5oh_agri = a1->E_C2H5OH
c2h5oh_ind  = a2->E_C2H5OH
c2h5oh_pow  = a3->E_C2H5OH
c2h5oh_tran = a4->E_C2H5OH

c2h5oh_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*c2h5oh_agri(4:11,:,:,:), c2h5oh_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
c2h5oh_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*c2h5oh_agri(4:11,:,:,:), c2h5oh_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

c2h5oh_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*c2h5oh_ind(4:11,:,:,:), c2h5oh_ind(4:11,:,:,:))
c2h5oh_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*c2h5oh_ind(4:11,:,:,:), c2h5oh_ind(4:11,:,:,:))

c2h5oh_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*c2h5oh_pow(4:11,:,:,:), c2h5oh_pow(4:11,:,:,:))
c2h5oh_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*c2h5oh_pow(4:11,:,:,:), c2h5oh_pow(4:11,:,:,:))

c2h5oh_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*c2h5oh_tran(4:11,:,:,:), c2h5oh_tran(4:11,:,:,:))
c2h5oh_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*c2h5oh_tran(4:11,:,:,:), c2h5oh_tran(4:11,:,:,:))


hcho_agri = a1->E_HCHO
hcho_ind  = a2->E_HCHO
hcho_pow  = a3->E_HCHO
hcho_tran = a4->E_HCHO

hcho_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*hcho_agri(4:11,:,:,:), hcho_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
hcho_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*hcho_agri(4:11,:,:,:), hcho_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

hcho_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*hcho_ind(4:11,:,:,:), hcho_ind(4:11,:,:,:))
hcho_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*hcho_ind(4:11,:,:,:), hcho_ind(4:11,:,:,:))

hcho_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*hcho_pow(4:11,:,:,:), hcho_pow(4:11,:,:,:))
hcho_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*hcho_pow(4:11,:,:,:), hcho_pow(4:11,:,:,:))

hcho_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*hcho_tran(4:11,:,:,:), hcho_tran(4:11,:,:,:))
hcho_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*hcho_tran(4:11,:,:,:), hcho_tran(4:11,:,:,:))

oli_agri = a1->E_OLI
oli_ind  = a2->E_OLI
oli_pow  = a3->E_OLI
oli_tran = a4->E_OLI

oli_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*oli_agri(4:11,:,:,:), oli_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
oli_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*oli_agri(4:11,:,:,:), oli_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

oli_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*oli_ind(4:11,:,:,:), oli_ind(4:11,:,:,:))
oli_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*oli_ind(4:11,:,:,:), oli_ind(4:11,:,:,:))

oli_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*oli_pow(4:11,:,:,:), oli_pow(4:11,:,:,:))
oli_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*oli_pow(4:11,:,:,:), oli_pow(4:11,:,:,:))

oli_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*oli_tran(4:11,:,:,:), oli_tran(4:11,:,:,:))
oli_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*oli_tran(4:11,:,:,:), oli_tran(4:11,:,:,:))

ket_agri = a1->E_KET
ket_ind  = a2->E_KET
ket_pow  = a3->E_KET
ket_tran = a4->E_KET

ket_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*ket_agri(4:11,:,:,:), ket_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
ket_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*ket_agri(4:11,:,:,:), ket_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

ket_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*ket_ind(4:11,:,:,:), ket_ind(4:11,:,:,:))
ket_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*ket_ind(4:11,:,:,:), ket_ind(4:11,:,:,:))

ket_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*ket_pow(4:11,:,:,:), ket_pow(4:11,:,:,:))
ket_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*ket_pow(4:11,:,:,:), ket_pow(4:11,:,:,:))

ket_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*ket_tran(4:11,:,:,:), ket_tran(4:11,:,:,:))
ket_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*ket_tran(4:11,:,:,:), ket_tran(4:11,:,:,:))

ch3oh_agri = a1->E_CH3OH
ch3oh_ind  = a2->E_CH3OH
ch3oh_pow  = a3->E_CH3OH
ch3oh_tran = a4->E_CH3OH

ch3oh_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*ch3oh_agri(4:11,:,:,:), ch3oh_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
ch3oh_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*ch3oh_agri(4:11,:,:,:), ch3oh_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

ch3oh_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*ch3oh_ind(4:11,:,:,:), ch3oh_ind(4:11,:,:,:))
ch3oh_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*ch3oh_ind(4:11,:,:,:), ch3oh_ind(4:11,:,:,:))

ch3oh_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*ch3oh_pow(4:11,:,:,:), ch3oh_pow(4:11,:,:,:))
ch3oh_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*ch3oh_pow(4:11,:,:,:), ch3oh_pow(4:11,:,:,:))

ch3oh_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*ch3oh_tran(4:11,:,:,:), ch3oh_tran(4:11,:,:,:))
ch3oh_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*ch3oh_tran(4:11,:,:,:), ch3oh_tran(4:11,:,:,:))

nh3_agri = a1->E_NH3
nh3_ind  = a2->E_NH3
nh3_pow  = a3->E_NH3
nh3_tran = a4->E_NH3

;nh3_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*nh3_agri(4:11,:,:,:), nh3_agri(4:11,:,:,:)) ;NH3 IS ASSUMED TO BE 100% FROM AGRICULTURE AND 0% RESIDENTIAL
;nh3_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*nh3_agri(4:11,:,:,:), nh3_agri(4:11,:,:,:)) ;SO THIS SECTOR IS UNCHANGED

nh3_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*nh3_ind(4:11,:,:,:), nh3_ind(4:11,:,:,:))
nh3_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*nh3_ind(4:11,:,:,:), nh3_ind(4:11,:,:,:))

nh3_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*nh3_pow(4:11,:,:,:), nh3_pow(4:11,:,:,:))
nh3_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*nh3_pow(4:11,:,:,:), nh3_pow(4:11,:,:,:))

nh3_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*nh3_tran(4:11,:,:,:), nh3_tran(4:11,:,:,:))
nh3_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*nh3_tran(4:11,:,:,:), nh3_tran(4:11,:,:,:))

no_agri = a1->E_NO
no_ind  = a2->E_NO
no_pow  = a3->E_NO
no_tran = a4->E_NO

no_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*no_agri(4:11,:,:,:), no_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
no_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*no_agri(4:11,:,:,:), no_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

no_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*no_ind(4:11,:,:,:), no_ind(4:11,:,:,:))
no_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*no_ind(4:11,:,:,:), no_ind(4:11,:,:,:))

no_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*no_pow(4:11,:,:,:), no_pow(4:11,:,:,:))
no_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*no_pow(4:11,:,:,:), no_pow(4:11,:,:,:))

no_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*no_tran(4:11,:,:,:), no_tran(4:11,:,:,:))
no_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*no_tran(4:11,:,:,:), no_tran(4:11,:,:,:))

no2_agri = a1->E_NO2
no2_ind  = a2->E_NO2
no2_pow  = a3->E_NO2
no2_tran = a4->E_NO2

no2_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*no2_agri(4:11,:,:,:), no2_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
no2_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*no2_agri(4:11,:,:,:), no2_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

no2_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*no2_ind(4:11,:,:,:), no2_ind(4:11,:,:,:))
no2_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*no2_ind(4:11,:,:,:), no2_ind(4:11,:,:,:))

no2_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*no2_pow(4:11,:,:,:), no2_pow(4:11,:,:,:))
no2_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*no2_pow(4:11,:,:,:), no2_pow(4:11,:,:,:))

no2_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*no2_tran(4:11,:,:,:), no2_tran(4:11,:,:,:))
no2_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*no2_tran(4:11,:,:,:), no2_tran(4:11,:,:,:))

olt_agri = a1->E_OLT
olt_ind  = a2->E_OLT
olt_pow  = a3->E_OLT
olt_tran = a4->E_OLT

olt_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*olt_agri(4:11,:,:,:), olt_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
olt_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*olt_agri(4:11,:,:,:), olt_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

olt_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*olt_ind(4:11,:,:,:), olt_ind(4:11,:,:,:))
olt_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*olt_ind(4:11,:,:,:), olt_ind(4:11,:,:,:))

olt_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*olt_pow(4:11,:,:,:), olt_pow(4:11,:,:,:))
olt_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*olt_pow(4:11,:,:,:), olt_pow(4:11,:,:,:))

olt_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*olt_tran(4:11,:,:,:), olt_tran(4:11,:,:,:))
olt_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*olt_tran(4:11,:,:,:), olt_tran(4:11,:,:,:))

so2_agri = a1->E_SO2
so2_ind  = a2->E_SO2
so2_pow  = a3->E_SO2
so2_tran = a4->E_SO2

so2_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*so2_agri(4:11,:,:,:), so2_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
so2_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*so2_agri(4:11,:,:,:), so2_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

so2_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*so2_ind(4:11,:,:,:), so2_ind(4:11,:,:,:))
so2_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*so2_ind(4:11,:,:,:), so2_ind(4:11,:,:,:))

so2_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*so2_pow(4:11,:,:,:), so2_pow(4:11,:,:,:))
so2_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*so2_pow(4:11,:,:,:), so2_pow(4:11,:,:,:))

so2_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*so2_tran(4:11,:,:,:), so2_tran(4:11,:,:,:))
so2_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*so2_tran(4:11,:,:,:), so2_tran(4:11,:,:,:))

tol_agri = a1->E_TOL
tol_ind  = a2->E_TOL
tol_pow  = a3->E_TOL
tol_tran = a4->E_TOL

tol_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*tol_agri(4:11,:,:,:), tol_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
tol_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*tol_agri(4:11,:,:,:), tol_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

tol_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*tol_ind(4:11,:,:,:), tol_ind(4:11,:,:,:))
tol_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*tol_ind(4:11,:,:,:), tol_ind(4:11,:,:,:))

tol_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*tol_pow(4:11,:,:,:), tol_pow(4:11,:,:,:))
tol_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*tol_pow(4:11,:,:,:), tol_pow(4:11,:,:,:))

tol_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*tol_tran(4:11,:,:,:), tol_tran(4:11,:,:,:))
tol_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*tol_tran(4:11,:,:,:), tol_tran(4:11,:,:,:))

xyl_agri = a1->E_XYL
xyl_ind  = a2->E_XYL
xyl_pow  = a3->E_XYL
xyl_tran = a4->E_XYL

xyl_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*xyl_agri(4:11,:,:,:), xyl_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
xyl_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*xyl_agri(4:11,:,:,:), xyl_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

xyl_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*xyl_ind(4:11,:,:,:), xyl_ind(4:11,:,:,:))
xyl_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*xyl_ind(4:11,:,:,:), xyl_ind(4:11,:,:,:))

xyl_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*xyl_pow(4:11,:,:,:), xyl_pow(4:11,:,:,:))
xyl_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*xyl_pow(4:11,:,:,:), xyl_pow(4:11,:,:,:))

xyl_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*xyl_tran(4:11,:,:,:), xyl_tran(4:11,:,:,:))
xyl_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*xyl_tran(4:11,:,:,:), xyl_tran(4:11,:,:,:))

hc3_agri = a1->E_HC3
hc3_ind  = a2->E_HC3
hc3_pow  = a3->E_HC3
hc3_tran = a4->E_HC3

hc3_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc3_agri(4:11,:,:,:), hc3_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
hc3_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc3_agri(4:11,:,:,:), hc3_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

hc3_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc3_ind(4:11,:,:,:), hc3_ind(4:11,:,:,:))
hc3_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc3_ind(4:11,:,:,:), hc3_ind(4:11,:,:,:))

hc3_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc3_pow(4:11,:,:,:), hc3_pow(4:11,:,:,:))
hc3_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc3_pow(4:11,:,:,:), hc3_pow(4:11,:,:,:))

hc3_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc3_tran(4:11,:,:,:), hc3_tran(4:11,:,:,:))
hc3_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc3_tran(4:11,:,:,:), hc3_tran(4:11,:,:,:))

hc5_agri = a1->E_HC5
hc5_ind  = a2->E_HC5
hc5_pow  = a3->E_HC5
hc5_tran = a4->E_HC5

hc5_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc5_agri(4:11,:,:,:), hc5_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
hc5_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc5_agri(4:11,:,:,:), hc5_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

hc5_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc5_ind(4:11,:,:,:), hc5_ind(4:11,:,:,:))
hc5_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc5_ind(4:11,:,:,:), hc5_ind(4:11,:,:,:))

hc5_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc5_pow(4:11,:,:,:), hc5_pow(4:11,:,:,:))
hc5_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc5_pow(4:11,:,:,:), hc5_pow(4:11,:,:,:))

hc5_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc5_tran(4:11,:,:,:), hc5_tran(4:11,:,:,:))
hc5_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc5_tran(4:11,:,:,:), hc5_tran(4:11,:,:,:))

hc8_agri = a1->E_HC8
hc8_ind  = a2->E_HC8
hc8_pow  = a3->E_HC8
hc8_tran = a4->E_HC8

hc8_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc8_agri(4:11,:,:,:), hc8_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
hc8_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc8_agri(4:11,:,:,:), hc8_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

hc8_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc8_ind(4:11,:,:,:), hc8_ind(4:11,:,:,:))
hc8_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc8_ind(4:11,:,:,:), hc8_ind(4:11,:,:,:))

hc8_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*hc8_pow(4:11,:,:,:), hc8_pow(4:11,:,:,:))
hc8_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*hc8_pow(4:11,:,:,:), hc8_pow(4:11,:,:,:))

hc8_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*hc8_tran(4:11,:,:,:), hc8_tran(4:11,:,:,:))
hc8_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*hc8_tran(4:11,:,:,:), hc8_tran(4:11,:,:,:))

eci_agri = a1->E_ECI
eci_ind  = a2->E_ECI
eci_pow  = a3->E_ECI
eci_tran = a4->E_ECI

eci_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*eci_agri(4:11,:,:,:), eci_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
eci_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*eci_agri(4:11,:,:,:), eci_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

eci_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*eci_ind(4:11,:,:,:), eci_ind(4:11,:,:,:))
eci_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*eci_ind(4:11,:,:,:), eci_ind(4:11,:,:,:))

eci_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*eci_pow(4:11,:,:,:), eci_pow(4:11,:,:,:))
eci_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*eci_pow(4:11,:,:,:), eci_pow(4:11,:,:,:))

eci_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*eci_tran(4:11,:,:,:), eci_tran(4:11,:,:,:))
eci_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*eci_tran(4:11,:,:,:), eci_tran(4:11,:,:,:))

ecj_agri = a1->E_ECJ
ecj_ind  = a2->E_ECJ
ecj_pow  = a3->E_ECJ
ecj_tran = a4->E_ECJ

ecj_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*ecj_agri(4:11,:,:,:), ecj_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
ecj_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*ecj_agri(4:11,:,:,:), ecj_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

ecj_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*ecj_ind(4:11,:,:,:), ecj_ind(4:11,:,:,:))
ecj_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*ecj_ind(4:11,:,:,:), ecj_ind(4:11,:,:,:))

ecj_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*ecj_pow(4:11,:,:,:), ecj_pow(4:11,:,:,:))
ecj_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*ecj_pow(4:11,:,:,:), ecj_pow(4:11,:,:,:))

ecj_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*ecj_tran(4:11,:,:,:), ecj_tran(4:11,:,:,:))
ecj_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*ecj_tran(4:11,:,:,:), ecj_tran(4:11,:,:,:))

orgi_agri = a1->E_ORGI
orgi_ind  = a2->E_ORGI
orgi_pow  = a3->E_ORGI
orgi_tran = a4->E_ORGI

orgi_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*orgi_agri(4:11,:,:,:), orgi_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
orgi_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*orgi_agri(4:11,:,:,:), orgi_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

orgi_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*orgi_ind(4:11,:,:,:), orgi_ind(4:11,:,:,:))
orgi_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*orgi_ind(4:11,:,:,:), orgi_ind(4:11,:,:,:))

orgi_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*orgi_pow(4:11,:,:,:), orgi_pow(4:11,:,:,:))
orgi_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*orgi_pow(4:11,:,:,:), orgi_pow(4:11,:,:,:))

orgi_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*orgi_tran(4:11,:,:,:), orgi_tran(4:11,:,:,:))
orgi_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*orgi_tran(4:11,:,:,:), orgi_tran(4:11,:,:,:))

orgj_agri = a1->E_ORGJ
orgj_ind  = a2->E_ORGJ
orgj_pow  = a3->E_ORGJ
orgj_tran = a4->E_ORGJ

orgj_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*orgj_agri(4:11,:,:,:), orgj_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
orgj_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*orgj_agri(4:11,:,:,:), orgj_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

orgj_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*orgj_ind(4:11,:,:,:), orgj_ind(4:11,:,:,:))
orgj_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*orgj_ind(4:11,:,:,:), orgj_ind(4:11,:,:,:))

orgj_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*orgj_pow(4:11,:,:,:), orgj_pow(4:11,:,:,:))
orgj_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*orgj_pow(4:11,:,:,:), orgj_pow(4:11,:,:,:))

orgj_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*orgj_tran(4:11,:,:,:), orgj_tran(4:11,:,:,:))
orgj_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*orgj_tran(4:11,:,:,:), orgj_tran(4:11,:,:,:))

pm25i_agri = a1->E_PM25I
pm25i_ind  = a2->E_PM25I
pm25i_pow  = a3->E_PM25I
pm25i_tran = a4->E_PM25I

pm25i_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*pm25i_agri(4:11,:,:,:), pm25i_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
pm25i_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm25i_agri(4:11,:,:,:), pm25i_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

pm25i_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*pm25i_ind(4:11,:,:,:), pm25i_ind(4:11,:,:,:))
pm25i_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm25i_ind(4:11,:,:,:), pm25i_ind(4:11,:,:,:))

pm25i_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*pm25i_pow(4:11,:,:,:), pm25i_pow(4:11,:,:,:))
pm25i_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm25i_pow(4:11,:,:,:), pm25i_pow(4:11,:,:,:))

pm25i_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*pm25i_tran(4:11,:,:,:), pm25i_tran(4:11,:,:,:))
pm25i_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm25i_tran(4:11,:,:,:), pm25i_tran(4:11,:,:,:))

pm25j_agri = a1->E_PM25J
pm25j_ind  = a2->E_PM25J
pm25j_pow  = a3->E_PM25J
pm25j_tran = a4->E_PM25J

pm25j_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*pm25j_agri(4:11,:,:,:), pm25j_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
pm25j_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm25j_agri(4:11,:,:,:), pm25j_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

pm25j_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*pm25j_ind(4:11,:,:,:), pm25j_ind(4:11,:,:,:))
pm25j_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm25j_ind(4:11,:,:,:), pm25j_ind(4:11,:,:,:))

pm25j_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*pm25j_pow(4:11,:,:,:), pm25j_pow(4:11,:,:,:))
pm25j_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm25j_pow(4:11,:,:,:), pm25j_pow(4:11,:,:,:))

pm25j_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*pm25j_tran(4:11,:,:,:), pm25j_tran(4:11,:,:,:))
pm25j_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm25j_tran(4:11,:,:,:), pm25j_tran(4:11,:,:,:))

pm10_agri = a1->E_PM_10
pm10_ind  = a2->E_PM_10
pm10_pow  = a3->E_PM_10
pm10_tran = a4->E_PM_10

pm10_agri(4:11,:,:,:) = where(mask1.eq.2, 0.20*pm10_agri(4:11,:,:,:), pm10_agri(4:11,:,:,:)) ;80% REDUCTION OVER BEIJING FOR ALL SECTORS, SAME ELSEWHERE
pm10_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm10_agri(4:11,:,:,:), pm10_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

pm10_ind(4:11,:,:,:) = where(mask1.eq.2, 0.20*pm10_ind(4:11,:,:,:), pm10_ind(4:11,:,:,:))
pm10_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm10_ind(4:11,:,:,:), pm10_ind(4:11,:,:,:))

pm10_pow(4:11,:,:,:) = where(mask1.eq.2, 0.20*pm10_pow(4:11,:,:,:), pm10_pow(4:11,:,:,:))
pm10_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*pm10_pow(4:11,:,:,:), pm10_pow(4:11,:,:,:))

pm10_tran(4:11,:,:,:) = where(mask1.eq.2, 0.20*pm10_tran(4:11,:,:,:), pm10_tran(4:11,:,:,:))
pm10_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*pm10_tran(4:11,:,:,:), pm10_tran(4:11,:,:,:))

so4i_agri = a1->E_SO4I
so4i_ind  = a2->E_SO4I
so4i_pow  = a3->E_SO4I
so4i_tran = a4->E_SO4I

so4i_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*so4i_agri(4:11,:,:,:), so4i_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
so4i_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*so4i_agri(4:11,:,:,:), so4i_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

so4i_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*so4i_ind(4:11,:,:,:), so4i_ind(4:11,:,:,:))
so4i_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*so4i_ind(4:11,:,:,:), so4i_ind(4:11,:,:,:))

so4i_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*so4i_pow(4:11,:,:,:), so4i_pow(4:11,:,:,:))
so4i_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*so4i_pow(4:11,:,:,:), so4i_pow(4:11,:,:,:))

so4i_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*so4i_tran(4:11,:,:,:), so4i_tran(4:11,:,:,:))
so4i_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*so4i_tran(4:11,:,:,:), so4i_tran(4:11,:,:,:))

so4j_agri = a1->E_SO4J
so4j_ind  = a2->E_SO4J
so4j_pow  = a3->E_SO4J
so4j_tran = a4->E_SO4J

so4j_agri(4:11,:,:,:) = where(mask1.eq.2, 0.60*so4j_agri(4:11,:,:,:), so4j_agri(4:11,:,:,:)) ;40% REDUCTION OVER BEIJING FOR AGRICULTURE, SAME ELSEWHERE
so4j_agri(4:11,:,:,:) = where(mask1.eq.1, 0.70*so4j_agri(4:11,:,:,:), so4j_agri(4:11,:,:,:)) ;30% REDUCTION OVER APEC1 REGION, SAME ELSEWHERE

so4j_ind(4:11,:,:,:) = where(mask1.eq.2, 0.50*so4j_ind(4:11,:,:,:), so4j_ind(4:11,:,:,:))
so4j_ind(4:11,:,:,:) = where(mask1.eq.1, 0.65*so4j_ind(4:11,:,:,:), so4j_ind(4:11,:,:,:))

so4j_pow(4:11,:,:,:) = where(mask1.eq.2, 0.50*so4j_pow(4:11,:,:,:), so4j_pow(4:11,:,:,:))
so4j_pow(4:11,:,:,:) = where(mask1.eq.1, 0.65*so4j_pow(4:11,:,:,:), so4j_pow(4:11,:,:,:))

so4j_tran(4:11,:,:,:) = where(mask1.eq.2, 0.60*so4j_tran(4:11,:,:,:), so4j_tran(4:11,:,:,:))
so4j_tran(4:11,:,:,:) = where(mask1.eq.1, 0.70*so4j_tran(4:11,:,:,:), so4j_tran(4:11,:,:,:))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

E_ALD    = (/ald_agri/) + (/ald_ind/) + (/ald_pow/) + (/ald_tran/) 
E_ALD!0     = "Time"    ; add coordinate variable
E_ALD!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ALD!2     = "south_north"    ; add coordinate variable
E_ALD!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ALD, E_ALD)
printVarSummary(E_ALD)
b->E_ALD = E_ALD

E_CO    = (/co_agri/) + (/co_ind/) + (/co_pow/) + (/co_tran/) 
E_CO!0     = "Time"    ; add coordinate variable
E_CO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_CO!2     = "south_north"    ; add coordinate variable
E_CO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_CO, E_CO)
printVarSummary(E_CO)
b->E_CO = E_CO

E_OL2    = (/ol2_agri/) + (/ol2_ind/) + (/ol2_pow/) + (/ol2_tran/) 
E_OL2!0     = "Time"    ; add coordinate variable
E_OL2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OL2!2     = "south_north"    ; add coordinate variable
E_OL2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OL2, E_OL2)
printVarSummary(E_OL2)
b->E_OL2 = E_OL2

E_ETH    = (/eth_agri/) + (/eth_ind/) + (/eth_pow/) + (/eth_tran/) 
E_ETH!0     = "Time"    ; add coordinate variable
E_ETH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ETH!2     = "south_north"    ; add coordinate variable
E_ETH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ETH, E_ETH)
printVarSummary(E_ETH)
b->E_ETH = E_ETH

E_C2H5OH    = (/c2h5oh_agri/) + (/c2h5oh_ind/) + (/c2h5oh_pow/) + (/c2h5oh_tran/) 
E_C2H5OH!0     = "Time"    ; add coordinate variable
E_C2H5OH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_C2H5OH!2     = "south_north"    ; add coordinate variable
E_C2H5OH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_C2H5OH, E_C2H5OH)
printVarSummary(E_C2H5OH)
b->E_C2H5OH = E_C2H5OH

E_HCHO    = (/hcho_agri/) + (/hcho_ind/) + (/hcho_pow/) + (/hcho_tran/) 
E_HCHO!0     = "Time"    ; add coordinate variable
E_HCHO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HCHO!2     = "south_north"    ; add coordinate variable
E_HCHO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HCHO, E_HCHO)
printVarSummary(E_HCHO)
b->E_HCHO = E_HCHO

E_OLI    = (/oli_agri/) + (/oli_ind/) + (/oli_pow/) + (/oli_tran/) 
E_OLI!0     = "Time"    ; add coordinate variable
E_OLI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OLI!2     = "south_north"    ; add coordinate variable
E_OLI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OLI, E_OLI)
printVarSummary(E_OLI)
b->E_OLI = E_OLI

E_KET    = (/ket_agri/) + (/ket_ind/) + (/ket_pow/) + (/ket_tran/) 
E_KET!0     = "Time"    ; add coordinate variable
E_KET!1     = "emissions_zdim_stag"    ; add coordinate variable
E_KET!2     = "south_north"    ; add coordinate variable
E_KET!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_KET, E_KET)
printVarSummary(E_KET)
b->E_KET = E_KET

E_CH3OH    = (/ch3oh_agri/) + (/ch3oh_ind/) + (/ch3oh_pow/) + (/ch3oh_tran/) 
E_CH3OH!0     = "Time"    ; add coordinate variable
E_CH3OH!1     = "emissions_zdim_stag"    ; add coordinate variable
E_CH3OH!2     = "south_north"    ; add coordinate variable
E_CH3OH!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_CH3OH, E_CH3OH)
printVarSummary(E_CH3OH)
b->E_CH3OH = E_CH3OH

E_NH3    = (/nh3_agri/) + (/nh3_ind/) + (/nh3_pow/) + (/nh3_tran/) 
E_NH3!0     = "Time"    ; add coordinate variable
E_NH3!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NH3!2     = "south_north"    ; add coordinate variable
E_NH3!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NH3, E_NH3)
printVarSummary(E_NH3)
b->E_NH3 = E_NH3

E_NO    = (/no_agri/) + (/no_ind/) + (/no_pow/) + (/no_tran/) 
E_NO!0     = "Time"    ; add coordinate variable
E_NO!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NO!2     = "south_north"    ; add coordinate variable
E_NO!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NO, E_NO)
printVarSummary(E_NO)
b->E_NO = E_NO

E_NO2    = (/no2_agri/) + (/no2_ind/) + (/no2_pow/) + (/no2_tran/) 
E_NO2!0     = "Time"    ; add coordinate variable
E_NO2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_NO2!2     = "south_north"    ; add coordinate variable
E_NO2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_NO2, E_NO2)
printVarSummary(E_NO2)
b->E_NO2 = E_NO2

E_OLT    = (/olt_agri/) + (/olt_ind/) + (/olt_pow/) + (/olt_tran/) 
E_OLT!0     = "Time"    ; add coordinate variable
E_OLT!1     = "emissions_zdim_stag"    ; add coordinate variable
E_OLT!2     = "south_north"    ; add coordinate variable
E_OLT!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_OLT, E_OLT)
printVarSummary(E_OLT)
b->E_OLT = E_OLT

E_SO2    = (/so2_agri/) + (/so2_ind/) + (/so2_pow/) + (/so2_tran/) 
E_SO2!0     = "Time"    ; add coordinate variable
E_SO2!1     = "emissions_zdim_stag"    ; add coordinate variable
E_SO2!2     = "south_north"    ; add coordinate variable
E_SO2!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_SO2, E_SO2)
printVarSummary(E_SO2)
b->E_SO2 = E_SO2

E_TOL    = (/tol_agri/) + (/tol_ind/) + (/tol_pow/) + (/tol_tran/) 
E_TOL!0     = "Time"    ; add coordinate variable
E_TOL!1     = "emissions_zdim_stag"    ; add coordinate variable
E_TOL!2     = "south_north"    ; add coordinate variable
E_TOL!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_TOL, E_TOL)
printVarSummary(E_TOL)
b->E_TOL = E_TOL

E_XYL    = (/xyl_agri/) + (/xyl_ind/) + (/xyl_pow/) + (/xyl_tran/) 
E_XYL!0     = "Time"    ; add coordinate variable
E_XYL!1     = "emissions_zdim_stag"    ; add coordinate variable
E_XYL!2     = "south_north"    ; add coordinate variable
E_XYL!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_XYL, E_XYL)
printVarSummary(E_XYL)
b->E_XYL = E_XYL

E_HC3    = (/hc3_agri/) + (/hc3_ind/) + (/hc3_pow/) + (/hc3_tran/) 
E_HC3!0     = "Time"    ; add coordinate variable
E_HC3!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC3!2     = "south_north"    ; add coordinate variable
E_HC3!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC3, E_HC3)
printVarSummary(E_HC3)
b->E_HC3 = E_HC3

E_HC5    = (/hc5_agri/) + (/hc5_ind/) + (/hc5_pow/) + (/hc5_tran/) 
E_HC5!0     = "Time"    ; add coordinate variable
E_HC5!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC5!2     = "south_north"    ; add coordinate variable
E_HC5!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC5, E_HC5)
printVarSummary(E_HC5)
b->E_HC5 = E_HC5

E_HC8    = (/hc8_agri/) + (/hc8_ind/) + (/hc8_pow/) + (/hc8_tran/) 
E_HC8!0     = "Time"    ; add coordinate variable
E_HC8!1     = "emissions_zdim_stag"    ; add coordinate variable
E_HC8!2     = "south_north"    ; add coordinate variable
E_HC8!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_HC8, E_HC8)
printVarSummary(E_HC8)
b->E_HC8 = E_HC8

E_ECI    = (/eci_agri/) + (/eci_ind/) + (/eci_pow/) + (/eci_tran/)
E_ECI!0     = "Time"    ; add coordinate variable
E_ECI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ECI!2     = "south_north"    ; add coordinate variable
E_ECI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECI, E_ECI)
printVarSummary(E_ECI)
b->E_ECI = E_ECI

E_ECJ    = (/ecj_agri/) + (/ecj_ind/) + (/ecj_pow/) + (/ecj_tran/) 
E_ECJ!0     = "Time"    ; add coordinate variable
E_ECJ!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ECJ!2     = "south_north"    ; add coordinate variable
E_ECJ!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECJ, E_ECJ)
printVarSummary(E_ECJ)
b->E_ECJ = E_ECJ

E_ORGI    = (/orgi_agri/) + (/orgi_ind/) + (/orgi_pow/) + (/orgi_tran/) 
E_ORGI!0     = "Time"    ; add coordinate variable
E_ORGI!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ORGI!2     = "south_north"    ; add coordinate variable
E_ORGI!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ORGI, E_ORGI)
printVarSummary(E_ORGI)
b->E_ORGI = E_ORGI

E_ORGJ    = (/orgj_agri/) + (/orgj_ind/) + (/orgj_pow/) + (/orgj_tran/) 
E_ORGJ!0     = "Time"    ; add coordinate variable
E_ORGJ!1     = "emissions_zdim_stag"    ; add coordinate variable
E_ORGJ!2     = "south_north"    ; add coordinate variable
E_ORGJ!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ORGJ, E_ORGJ)
printVarSummary(E_ORGJ)
b->E_ORGJ = E_ORGJ

E_PM25I    = (/pm25i_agri/) + (/pm25i_ind/) + (/pm25i_pow/) + (/pm25i_tran/) 
E_PM25I!0     = "Time"    ; add coordinate variable
E_PM25I!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM25I!2     = "south_north"    ; add coordinate variable
E_PM25I!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM25I, E_PM25I)
printVarSummary(E_PM25I)
b->E_PM25I = E_PM25I

E_PM25J    = (/pm25j_agri/) + (/pm25j_ind/) + (/pm25j_pow/) + (/pm25j_tran/) 
E_PM25J!0     = "Time"    ; add coordinate variable
E_PM25J!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM25J!2     = "south_north"    ; add coordinate variable
E_PM25J!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM25J, E_PM25J)
printVarSummary(E_PM25J)
b->E_PM25J = E_PM25J

E_PM_10    = (/pm10_agri/) + (/pm10_ind/) + (/pm10_pow/) + (/pm10_tran/) 
E_PM_10!0     = "Time"    ; add coordinate variable
E_PM_10!1     = "emissions_zdim_stag"    ; add coordinate variable
E_PM_10!2     = "south_north"    ; add coordinate variable
E_PM_10!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_PM_10, E_PM_10)
printVarSummary(E_PM_10)
b->E_PM_10 = E_PM_10

E_SO4I    = (/so4i_agri/) + (/so4i_ind/) + (/so4i_pow/) + (/so4i_tran/)
E_SO4I!0     = "Time"    ; add coordinate variable
E_SO4I!1     = "emissions_zdim_stag"    ; add coordinate variable
E_SO4I!2     = "south_north"    ; add coordinate variable
E_SO4I!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECI, E_SO4I)
printVarSummary(E_SO4I)
b->E_SO4I = E_SO4I

E_SO4J    = (/so4j_agri/) + (/so4j_ind/) + (/so4j_pow/) + (/so4j_tran/)
E_SO4J!0     = "Time"    ; add coordinate variable
E_SO4J!1     = "emissions_zdim_stag"    ; add coordinate variable
E_SO4J!2     = "south_north"    ; add coordinate variable
E_SO4J!3     = "west_east"    ; add coordinate variable
copy_VarMeta(a1->E_ECJ, E_SO4J)
printVarSummary(E_SO4J)
b->E_SO4J = E_SO4J

;copy_VarAtts(a1, b) ; contributed.ncl THIS SCREWES THINGS UP BECAUSE AGRI FILE HAS EXTRA UNNAMED DIMENSIONS FOR SO4I AND SO4J 

print("All sectors added successfully!")

end
