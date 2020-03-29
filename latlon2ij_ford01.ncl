load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

  a = addfile("/data1/tabish/APEC-baseline/wrfout_d02_2014-10-11_00:00:00.nc","r")
  opt = True
  LL  = wrf_user_ll_to_ij(a,113.336,36.0581,opt) ; LON LAT FOR GUCHENG - STATION ID 110000249
  LR  = wrf_user_ll_to_ij(a,119.394,35.7411,opt) ; LON LAT FOR GUCHENG - STATION ID 110000249
  UL  = wrf_user_ll_to_ij(a,113.644,42.7948,opt) ; LON LAT FOR GUCHENG - STATION ID 110000249
  UR  = wrf_user_ll_to_ij(a,120.258,42.4514,opt) ; LON LAT FOR GUCHENG - STATION ID 110000249

  LL = LL -1
  LR = LR -1
  UL = UL -1
  UR = UR -1

  print("I,J VALUES FOR LL ARE " + LL)
  print("I,J VALUES FOR LR ARE " + LR)
  print("I,J VALUES FOR UL ARE " + UL)
  print("I,J VALUES FOR UR ARE " + UR)
