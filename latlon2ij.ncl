load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

  a = addfile("/mnt/rasher/control-run-so4-ECMWF/wrfout_d03_2014-10-11_000000.nc","r")
  opt = True
  loc_IAP  = wrf_user_ll_to_ij(a,116.3711,39.9744,opt)    ;lon,lat for IAP tower Beijing 
  loc_545110  = wrf_user_ll_to_ij(a,116.6031,40.0799,opt)  ;lon,lat for Beijing Capital International Meteorological station 
  loc_252  = wrf_user_ll_to_ij(a,116.366,39.8673,opt) ;lon,lat for wanshouxigong- STATION ID 110000252 
  loc_041  = wrf_user_ll_to_ij(a,116.17,40.2865,opt) ;lon lat for dingling - STATION ID 110000041
  loc_244  = wrf_user_ll_to_ij(a,116.434,39.9522,opt) ; LON LAT FOR DONGSI - STATION ID 110000244
  loc_245  = wrf_user_ll_to_ij(a,116.434,39.8745,opt) ; LON LAT FOR TIANTAN - STATION ID 110000 110000245
  loc_247  = wrf_user_ll_to_ij(a,116.473,39.9716,opt) ; LON LAT FOR NONGZHANGUAN - STATION ID 110000247
  loc_250  = wrf_user_ll_to_ij(a,116.361,39.9425,opt) ; LON LAT FOR GUANYUAN - STATION ID 110000250
  loc_251  = wrf_user_ll_to_ij(a,116.315,39.9934,opt) ; LON LAT FOR HAIDIANQUWANLIU - STATION ID 110000251
  loc_253  = wrf_user_ll_to_ij(a,116.72,40.1438,opt) ; LON LAT FOR SHUNYIXINCHENG - STATION ID 110000253
  loc_254  = wrf_user_ll_to_ij(a,116.644,40.3937,opt) ; LON LAT FOR HUAIROUZHEN - STATION ID 110000254
  loc_255  = wrf_user_ll_to_ij(a,116.23,40.1952,opt) ; LON LAT FOR CHANGPINGZHEN - STATION ID 110000255
  loc_246  = wrf_user_ll_to_ij(a,116.40,39.98,opt) ; LON LAT FOR AOTIZHONGXIN - STATION ID 110000246
  loc_249  = wrf_user_ll_to_ij(a,116.225,39.9279,opt) ; LON LAT FOR GUCHENG - STATION ID 110000249
  Tianjin  = wrf_user_ll_to_ij(a,117.3616,39.3434,opt) ; LON LAT FOR TIANJIN   

  loc_IAP = loc_IAP -1          ; To convert to NCL subscripts
  loc_545110 = loc_545110 -1          ; To convert to NCL subscripts
  loc_252 = loc_252 -1          ; To convert to NCL subscripts
  loc_041 = loc_041 -1          ; To convert to NCL subscripts
  loc_244 = loc_244 -1          ; To convert to NCL subscripts
  loc_245 = loc_245 -1          ; To convert to NCL subscripts
  loc_247 = loc_247 -1          ; To convert to NCL subscripts
  loc_250 = loc_250 -1          ; To convert to NCL subscripts
  loc_251 = loc_251 -1          ; To convert to NCL subscripts
  loc_253 = loc_253 -1          ; To convert to NCL subscripts
  loc_254 = loc_254 -1          ; To convert to NCL subscripts
  loc_255 = loc_255 -1          ; To convert to NCL subscripts
  loc_246 = loc_246 -1          ; To convert to NCL subscripts
  loc_249 = loc_249 -1          ; To convert to NCL subscripts
  Tianjin = Tianjin -1

  print("I,J VALUES FOR STATION IAP ARE " + loc_IAP)
  print("I,J VALUES FOR STATION Beijing Intl ARE " + loc_545110)
  print("I,J VALUES FOR STATION 252 ARE " + loc_252)
  print("I,J VALUES FOR STATION 041 ARE " + loc_041)
  print("I,J VALUES FOR STATION 244 ARE " + loc_244)
  print("I,J VALUES FOR STATION 245 ARE " + loc_245)
  print("I,J VALUES FOR STATION 247 ARE " + loc_247)
  print("I,J VALUES FOR STATION 250 ARE " + loc_250)
  print("I,J VALUES FOR STATION 251 ARE " + loc_251)
  print("I,J VALUES FOR STATION 253 ARE " + loc_253)
  print("I,J VALUES FOR STATION 254 ARE " + loc_254)
  print("I,J VALUES FOR STATION 255 ARE " + loc_255)
  print("I,J VALUES FOR STATION Aotizhongxin ARE " + loc_246)
  print("I,J VALUES FOR STATION 249 ARE " + loc_249)
  print("I,J VALUES FOR TIANJIN ARE " + Tianjin)

