;THIS PLOTS RH FROM APEC BASELINE AND NCDC FROM 10OCT-20NOV 2014 

; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;READ IN THE WRFOUT FILES 
DATADir = "/data3/tabish/APEC-baseline/"
FILES = systemfunc (" ls -1 " + DATADir + "wrfout_d03_2014-* ")
a = addfiles(FILES,"r")
print("files read-in successfully")
;times  = wrf_times_c(a[:]->Times,0)
;times = times + 8 ; BOTH SIMULATIONS AND OBSERVATIONS IN THIS CASE ARE IN UTC SO WE NEED TO CORRECT THE TIME-SCALE
;times_crop = times (0:1007)

;temp = a[:]->T2(0:1007,144,79) ;EXTRACT 2M TEMP FROM BEIJING INTL STATION GRID IN D03


qv = a[:]->QVAPOR
print("read qvapor")
P  = a[:]->P                  ; perturbation
print("read perturbation pressure")
Pb = a[:]->PB                 ; base state pressure
print("read base state pressure")
P  = P + Pb                   ; total pressure
print("computed total pressure")
theta = a[:]->T               ; perturbation potential temperature (theta+t0)
print("read perturbation potential temperature")
theta = theta + 300.
print("added 300")
TK = wrf_tk (P, theta)
print("TK calculated!")
RH = wrf_rh (qv, P, TK)
print("RH calculated")
printVarSummary(RH)


end
