begin
  diri = "./"
  fili = "wrfchemi_12z_d02_agri_Oct.nc"
  a    = addfile(diri+fili,"r")

  Times   =  a->Times
  XLONG   =  a->XLONG
  XLAT    =  a->XLAT
  CO      =  a->E_CO ;;;;;EXTRACTING THE SURFACE EMISSIONS
  HCHO    =  a->E_HCHO ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ALD     =  a->E_ALD ;;;;;EXTRACTING THE SURFACE EMISSIONS
  CH3OH   =  a->E_CH3OH ;;;;;EXTRACTING THE SURFACE EMISSIONS
  C2H5OH  =  a->E_C2H5OH ;;;;;EXTRACTING THE SURFACE EMISSIONS
  SO2     =  a->E_SO2 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  TOL     =  a->E_TOL ;;;;;EXTRACTING THE SURFACE EMISSIONS
  NH3     =  a->E_NH3 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  NO      =  a->E_NO ;;;;;EXTRACTING THE SURFACE EMISSIONS
  NO2     =  a->E_NO2 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  OL2     =  a->E_OL2 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  OLT     =  a->E_OLT ;;;;;EXTRACTING THE SURFACE EMISSIONS
  OLI     =  a->E_OLI ;;;;;EXTRACTING THE SURFACE EMISSIONS
  KET     =  a->E_KET ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ETH     =  a->E_ETH ;;;;;EXTRACTING THE SURFACE EMISSIONS
  HC3     =  a->E_HC3 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  HC5     =  a->E_HC5 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  HC8     =  a->E_HC8 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  XYL     =  a->E_XYL ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ECI     =  a->E_ECI ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ECJ     =  a->E_ECJ ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ORGI    =  a->E_ORGI ;;;;;EXTRACTING THE SURFACE EMISSIONS
  ORGJ    =  a->E_ORGJ ;;;;;EXTRACTING THE SURFACE EMISSIONS
  PM25I   =  a->E_PM25I ;;;;;EXTRACTING THE SURFACE EMISSIONS
  PM25J   =  a->E_PM25J ;;;;;EXTRACTING THE SURFACE EMISSIONS
  PM_10   =  a->E_PM_10 ;;;;;EXTRACTING THE SURFACE EMISSIONS

  dimSO2 = dimsizes(SO2)
  print(dimSO2)

  ntim   = dimSO2(0)
  nlat   = dimSO2(2)
  mlon   = dimSO2(3)
  klev   = 8

;;NOW PARTITIONING INTO 8 LEVELS
;===========================================================================
  E_CO = new((/ntim,klev,nlat,mlon/),typeof(CO),getVarFillValue(CO))
  E_CO(:,0,:,:) =  CO(:,0,:,:)
  E_CO(:,1,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,2,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,3,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,4,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,5,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,6,:,:) = 0.0 * CO(:,0,:,:)
  E_CO(:,7,:,:) = 0.0 * CO(:,0,:,:)

  copy_VarMeta(CO, E_CO)

  E_CO!0     = "Time"    ; add coordinate variable
  E_CO!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_CO!2     = "south_north"    ; add coordinate variable
  E_CO!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_CO)
;===========================================================================


;===========================================================================
  E_HCHO = new((/ntim,klev,nlat,mlon/),typeof(HCHO),getVarFillValue(HCHO))
  E_HCHO(:,0,:,:) =  HCHO(:,0,:,:)
  E_HCHO(:,1,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,2,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,3,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,4,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,5,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,6,:,:) = 0.0 * HCHO(:,0,:,:)
  E_HCHO(:,7,:,:) = 0.0 * HCHO(:,0,:,:)

  copy_VarMeta(HCHO, E_HCHO)

  E_HCHO!0     = "Time"    ; add coordinate variable
  E_HCHO!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_HCHO!2     = "south_north"    ; add coordinate variable
  E_HCHO!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_HCHO)
;===========================================================================

;===========================================================================
  E_ALD = new((/ntim,klev,nlat,mlon/),typeof(ALD),getVarFillValue(ALD))
  E_ALD(:,0,:,:) =  ALD(:,0,:,:)
  E_ALD(:,1,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,2,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,3,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,4,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,5,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,6,:,:) = 0.0 * ALD(:,0,:,:)
  E_ALD(:,7,:,:) = 0.0 * ALD(:,0,:,:)

  copy_VarMeta(ALD, E_ALD)

  E_ALD!0     = "Time"    ; add coordinate variable
  E_ALD!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ALD!2     = "south_north"    ; add coordinate variable
  E_ALD!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ALD)
;===========================================================================

;===========================================================================
  E_CH3OH = new((/ntim,klev,nlat,mlon/),typeof(CH3OH),getVarFillValue(CH3OH))
  E_CH3OH(:,0,:,:) =  CH3OH(:,0,:,:)
  E_CH3OH(:,1,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,2,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,3,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,4,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,5,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,6,:,:) = 0.0 * CH3OH(:,0,:,:)
  E_CH3OH(:,7,:,:) = 0.0 * CH3OH(:,0,:,:)

  copy_VarMeta(CH3OH, E_CH3OH)

  E_CH3OH!0     = "Time"    ; add coordinate variable
  E_CH3OH!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_CH3OH!2     = "south_north"    ; add coordinate variable
  E_CH3OH!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_CH3OH)
;===========================================================================

;===========================================================================
  E_C2H5OH = new((/ntim,klev,nlat,mlon/),typeof(C2H5OH),getVarFillValue(C2H5OH))
  E_C2H5OH(:,0,:,:) =  C2H5OH(:,0,:,:)
  E_C2H5OH(:,1,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,2,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,3,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,4,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,5,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,6,:,:) = 0.0 * C2H5OH(:,0,:,:)
  E_C2H5OH(:,7,:,:) = 0.0 * C2H5OH(:,0,:,:)

  copy_VarMeta(C2H5OH, E_C2H5OH)

  E_C2H5OH!0     = "Time"    ; add coordinate variable
  E_C2H5OH!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_C2H5OH!2     = "south_north"    ; add coordinate variable
  E_C2H5OH!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_C2H5OH)
;===========================================================================
;===========================================================================
  E_SO2 = new((/ntim,klev,nlat,mlon/),typeof(SO2),getVarFillValue(SO2))
  E_SO2(:,0,:,:) = SO2(:,0,:,:)
  E_SO2(:,1,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,2,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,3,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,4,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,5,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,6,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,7,:,:) = 0.0 * SO2(:,0,:,:)

  copy_VarMeta(SO2, E_SO2)

  E_SO2!0     = "Time"    ; add coordinate variable
  E_SO2!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_SO2!2     = "south_north"    ; add coordinate variable
  E_SO2!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_SO2)
;===========================================================================
;===========================================================================
  E_TOL = new((/ntim,klev,nlat,mlon/),typeof(TOL),getVarFillValue(TOL))
  E_TOL(:,0,:,:) = TOL(:,0,:,:)
  E_TOL(:,1,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,2,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,3,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,4,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,5,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,6,:,:) = 0.0 * TOL(:,0,:,:)
  E_TOL(:,7,:,:) = 0.0 * TOL(:,0,:,:)

  copy_VarMeta(TOL, E_TOL)

  E_TOL!0     = "Time"    ; add coordinate variable
  E_TOL!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_TOL!2     = "south_north"    ; add coordinate variable
  E_TOL!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_TOL)
;===========================================================================
;===========================================================================
  E_NH3 = new((/ntim,klev,nlat,mlon/),typeof(NH3),getVarFillValue(NH3))
  E_NH3(:,0,:,:) =  NH3(:,0,:,:)
  E_NH3(:,1,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,2,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,3,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,4,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,5,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,6,:,:) = 0.0 * NH3(:,0,:,:)
  E_NH3(:,7,:,:) = 0.0 * NH3(:,0,:,:)

  copy_VarMeta(NH3, E_NH3)

  E_NH3!0     = "Time"    ; add coordinate variable
  E_NH3!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_NH3!2     = "south_north"    ; add coordinate variable
  E_NH3!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_NH3)
;===========================================================================
;===========================================================================
  E_NO = new((/ntim,klev,nlat,mlon/),typeof(NO),getVarFillValue(NO))
  E_NO(:,0,:,:) =  NO(:,0,:,:)
  E_NO(:,1,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,2,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,3,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,4,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,5,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,6,:,:) = 0.0 * NO(:,0,:,:)
  E_NO(:,7,:,:) = 0.0 * NO(:,0,:,:)

  copy_VarMeta(NO, E_NO)

  E_NO!0     = "Time"    ; add coordinate variable
  E_NO!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_NO!2     = "south_north"    ; add coordinate variable
  E_NO!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_NO)
;===========================================================================
;===========================================================================
  E_NO2 = new((/ntim,klev,nlat,mlon/),typeof(NO2),getVarFillValue(NO2))
  E_NO2(:,0,:,:) =  NO2(:,0,:,:)
  E_NO2(:,1,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,2,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,3,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,4,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,5,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,6,:,:) = 0.0 * NO2(:,0,:,:)
  E_NO2(:,7,:,:) = 0.0 * NO2(:,0,:,:)

  copy_VarMeta(NO2, E_NO2)

  E_NO2!0     = "Time"    ; add coordinate variable
  E_NO2!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_NO2!2     = "south_north"    ; add coordinate variable
  E_NO2!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_NO2)
;===========================================================================
;===========================================================================
  E_OL2 = new((/ntim,klev,nlat,mlon/),typeof(OL2),getVarFillValue(OL2))
  E_OL2(:,0,:,:) =  OL2(:,0,:,:)
  E_OL2(:,1,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,2,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,3,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,4,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,5,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,6,:,:) = 0.0 * OL2(:,0,:,:)
  E_OL2(:,7,:,:) = 0.0 * OL2(:,0,:,:)

  copy_VarMeta(OL2, E_OL2)

  E_OL2!0     = "Time"    ; add coordinate variable
  E_OL2!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_OL2!2     = "south_north"    ; add coordinate variable
  E_OL2!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_OL2)
;===========================================================================
;===========================================================================
  E_OLT = new((/ntim,klev,nlat,mlon/),typeof(OLT),getVarFillValue(OLT))
  E_OLT(:,0,:,:) =  OLT(:,0,:,:)
  E_OLT(:,1,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,2,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,3,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,4,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,5,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,6,:,:) = 0.0 * OLT(:,0,:,:)
  E_OLT(:,7,:,:) = 0.0 * OLT(:,0,:,:)

  copy_VarMeta(OLT, E_OLT)

  E_OLT!0     = "Time"    ; add coordinate variable
  E_OLT!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_OLT!2     = "south_north"    ; add coordinate variable
  E_OLT!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_OLT)
;===========================================================================
;===========================================================================
  E_OLI = new((/ntim,klev,nlat,mlon/),typeof(OLI),getVarFillValue(OLI))
  E_OLI(:,0,:,:) =  OLI(:,0,:,:)
  E_OLI(:,1,:,:) = 0.0 * OLI(:,0,:,:)
  E_OLI(:,2,:,:) = 0.0 * OLI(:,0,:,:)
  E_OLI(:,3,:,:) = 0.0 * OLI(:,0,:,:)
  E_OLI(:,4,:,:) = 0.0 * OLI (:,0,:,:)
  E_OLI(:,5,:,:) = 0.0 * OLI(:,0,:,:)
  E_OLI(:,6,:,:) = 0.0 * OLI(:,0,:,:)
  E_OLI(:,7,:,:) = 0.0 * OLI(:,0,:,:)

  copy_VarMeta(OLI, E_OLI)

  E_OLI!0     = "Time"    ; add coordinate variable
  E_OLI!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_OLI!2     = "south_north"    ; add coordinate variable
  E_OLI!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_OLI)
;===========================================================================
;===========================================================================
  E_KET = new((/ntim,klev,nlat,mlon/),typeof(KET),getVarFillValue(KET))
  E_KET(:,0,:,:) =  KET(:,0,:,:)
  E_KET(:,1,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,2,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,3,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,4,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,5,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,6,:,:) = 0.0 * KET(:,0,:,:)
  E_KET(:,7,:,:) = 0.0 * KET(:,0,:,:)

  copy_VarMeta(KET, E_KET)

  E_KET!0     = "Time"    ; add coordinate variable
  E_KET!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_KET!2     = "south_north"    ; add coordinate variable
  E_KET!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_KET)
;===========================================================================
;===========================================================================
  E_ETH = new((/ntim,klev,nlat,mlon/),typeof(ETH),getVarFillValue(ETH))
  E_ETH(:,0,:,:) =  ETH(:,0,:,:)
  E_ETH(:,1,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,2,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,3,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,4,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,5,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,6,:,:) = 0.0 * ETH(:,0,:,:)
  E_ETH(:,7,:,:) = 0.0 * ETH(:,0,:,:)

  copy_VarMeta(ETH, E_ETH)

  E_ETH!0     = "Time"    ; add coordinate variable
  E_ETH!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ETH!2     = "south_north"    ; add coordinate variable
  E_ETH!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ETH)
;===========================================================================
;===========================================================================
  E_HC3 = new((/ntim,klev,nlat,mlon/),typeof(HC3),getVarFillValue(HC3))
  E_HC3(:,0,:,:) =  HC3(:,0,:,:)
  E_HC3(:,1,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,2,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,3,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,4,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,5,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,6,:,:) = 0.0 * HC3(:,0,:,:)
  E_HC3(:,7,:,:) = 0.0 * HC3(:,0,:,:)

  copy_VarMeta(HC3, E_HC3)

  E_HC3!0     = "Time"    ; add coordinate variable
  E_HC3!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_HC3!2     = "south_north"    ; add coordinate variable
  E_HC3!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_HC3)
;===========================================================================
;===========================================================================
  E_HC5 = new((/ntim,klev,nlat,mlon/),typeof(HC5),getVarFillValue(HC5))
  E_HC5(:,0,:,:) =  HC5(:,0,:,:)
  E_HC5(:,1,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,2,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,3,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,4,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,5,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,6,:,:) = 0.0 * HC5(:,0,:,:)
  E_HC5(:,7,:,:) = 0.0 * HC5(:,0,:,:)

  copy_VarMeta(HC5, E_HC5)

  E_HC5!0     = "Time"    ; add coordinate variable
  E_HC5!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_HC5!2     = "south_north"    ; add coordinate variable
  E_HC5!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_HC5)
;===========================================================================
;===========================================================================
  E_HC8 = new((/ntim,klev,nlat,mlon/),typeof(HC8),getVarFillValue(HC8))
  E_HC8(:,0,:,:) = HC8(:,0,:,:)
  E_HC8(:,1,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,2,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,3,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,4,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,5,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,6,:,:) = 0.0 * HC8(:,0,:,:)
  E_HC8(:,7,:,:) = 0.0 * HC8(:,0,:,:)

  copy_VarMeta(HC8, E_HC8)

  E_HC8!0     = "Time"    ; add coordinate variable
  E_HC8!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_HC8!2     = "south_north"    ; add coordinate variable
  E_HC8!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_HC8)
;===========================================================================
;===========================================================================
  E_XYL = new((/ntim,klev,nlat,mlon/),typeof(XYL),getVarFillValue(XYL))
  E_XYL(:,0,:,:) =  XYL(:,0,:,:)
  E_XYL(:,1,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,2,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,3,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,4,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,5,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,6,:,:) = 0.0 * XYL(:,0,:,:)
  E_XYL(:,7,:,:) = 0.0 * XYL(:,0,:,:)

  copy_VarMeta(XYL, E_XYL)

  E_XYL!0     = "Time"    ; add coordinate variable
  E_XYL!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_XYL!2     = "south_north"    ; add coordinate variable
  E_XYL!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_XYL)
;===========================================================================
;===========================================================================
  E_ECI = new((/ntim,klev,nlat,mlon/),typeof(ECI),getVarFillValue(ECI))
  E_ECI(:,0,:,:) =  ECI(:,0,:,:)
  E_ECI(:,1,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,2,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,3,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,4,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,5,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,6,:,:) = 0.0 * ECI(:,0,:,:)
  E_ECI(:,7,:,:) = 0.0 * ECI(:,0,:,:)

  copy_VarMeta(ECI, E_ECI)

  E_ECI!0     = "Time"    ; add coordinate variable
  E_ECI!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ECI!2     = "south_north"    ; add coordinate variable
  E_ECI!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ECI)
;===========================================================================
;===========================================================================
  E_ECJ = new((/ntim,klev,nlat,mlon/),typeof(ECJ),getVarFillValue(ECJ))
  E_ECJ(:,0,:,:) =  ECJ(:,0,:,:)
  E_ECJ(:,1,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,2,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,3,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,4,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,5,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,6,:,:) = 0.0 * ECJ(:,0,:,:)
  E_ECJ(:,7,:,:) = 0.0 * ECJ(:,0,:,:)

  copy_VarMeta(ECJ, E_ECJ)

  E_ECJ!0     = "Time"    ; add coordinate variable
  E_ECJ!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ECJ!2     = "south_north"    ; add coordinate variable
  E_ECJ!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ECJ)
;===========================================================================
;===========================================================================
  E_ORGI = new((/ntim,klev,nlat,mlon/),typeof(ORGI),getVarFillValue(ORGI))
  E_ORGI(:,0,:,:) =  ORGI(:,0,:,:)
  E_ORGI(:,1,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,2,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,3,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,4,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,5,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,6,:,:) = 0.0 * ORGI(:,0,:,:)
  E_ORGI(:,7,:,:) = 0.0 * ORGI(:,0,:,:)

  copy_VarMeta(ORGI, E_ORGI)

  E_ORGI!0     = "Time"    ; add coordinate variable
  E_ORGI!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ORGI!2     = "south_north"    ; add coordinate variable
  E_ORGI!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ORGI)
;===========================================================================
;===========================================================================
  E_ORGJ = new((/ntim,klev,nlat,mlon/),typeof(ORGJ),getVarFillValue(ORGJ))
  E_ORGJ(:,0,:,:) =  ORGJ(:,0,:,:)
  E_ORGJ(:,1,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,2,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,3,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,4,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,5,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,6,:,:) = 0.0 * ORGJ(:,0,:,:)
  E_ORGJ(:,7,:,:) = 0.0 * ORGJ(:,0,:,:)

  copy_VarMeta(ORGJ, E_ORGJ)

  E_ORGJ!0     = "Time"    ; add coordinate variable
  E_ORGJ!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_ORGJ!2     = "south_north"    ; add coordinate variable
  E_ORGJ!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_ORGJ)
;===========================================================================
;===========================================================================
  E_PM25I = new((/ntim,klev,nlat,mlon/),typeof(PM25I),getVarFillValue(PM25I))
  E_PM25I(:,0,:,:) =  PM25I(:,0,:,:)
  E_PM25I(:,1,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,2,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,3,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,4,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,5,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,6,:,:) = 0.0 * PM25I(:,0,:,:)
  E_PM25I(:,7,:,:) = 0.0 * PM25I(:,0,:,:)

  copy_VarMeta(PM25I, E_PM25I)

  E_PM25I!0     = "Time"    ; add coordinate variable
  E_PM25I!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_PM25I!2     = "south_north"    ; add coordinate variable
  E_PM25I!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_PM25I)
;===========================================================================
;===========================================================================
  E_PM25J = new((/ntim,klev,nlat,mlon/),typeof(PM25J),getVarFillValue(PM25J))
  E_PM25J(:,0,:,:) =  PM25J(:,0,:,:)
  E_PM25J(:,1,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,2,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,3,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,4,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,5,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,6,:,:) = 0.0 * PM25J(:,0,:,:)
  E_PM25J(:,7,:,:) = 0.0 * PM25J(:,0,:,:)

  copy_VarMeta(PM25J, E_PM25J)

  E_PM25J!0     = "Time"    ; add coordinate variable
  E_PM25J!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_PM25J!2     = "south_north"    ; add coordinate variable
  E_PM25J!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_PM25J)
;===========================================================================
;===========================================================================
  E_PM_10 = new((/ntim,klev,nlat,mlon/),typeof(PM_10),getVarFillValue(PM_10))
  E_PM_10(:,0,:,:) =  PM_10(:,0,:,:)
  E_PM_10(:,1,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,2,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,3,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,4,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,5,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,6,:,:) = 0.0 * PM_10(:,0,:,:)
  E_PM_10(:,7,:,:) = 0.0 * PM_10(:,0,:,:)

  copy_VarMeta(PM_10, E_PM_10)

  E_PM_10!0     = "Time"    ; add coordinate variable
  E_PM_10!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_PM_10!2     = "south_north"    ; add coordinate variable
  E_PM_10!3     = "west_east"    ; add coordinate variable

  printVarSummary(E_PM_10)
;===========================================================================


  ;=================================
  diro = "/data3/tabish/vert-MEIC-emis/8lev-emissions/"
  filo = "wrfchemi_12z_d02_agri_Oct.nc"
  ptho = diro+filo
  b    = addfile(ptho,"c")
  b->Times = Times
  b->XLONG = XLONG
  b->XLAT  = XLAT
  b->E_CO = E_CO
  b->E_HCHO = E_HCHO
  b->E_ALD = E_ALD
  b->E_CH3OH = E_CH3OH
  b->E_C2H5OH = E_C2H5OH
  b->E_SO2 = E_SO2
  b->E_TOL = E_TOL
  b->E_NH3 = E_NH3
  b->E_NO = E_NO
  b->E_NO2 = E_NO2
  b->E_OL2 = E_OL2
  b->E_OLT = E_OLT
  b->E_OLI = E_OLI
  b->E_KET = E_KET
  b->E_ETH = E_ETH
  b->E_HC3 = E_HC3
  b->E_HC5 = E_HC5
  b->E_HC8 = E_HC8
  b->E_XYL = E_XYL
  b->E_ECI = E_ECI
  b->E_ECJ = E_ECJ
  b->E_ORGI = E_ORGI
  b->E_ORGJ = E_ORGJ
  b->E_PM25I = E_PM25I
  b->E_PM25J = E_PM25J
  b->E_PM_10 = E_PM_10

end
