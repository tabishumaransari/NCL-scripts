begin
  diri = "./"
  fili = "wrfchemi_00z_d01_pow_Oct.nc"
  a    = addfile(diri+fili,"r")

  SO2  =  a->E_SO2 ;;;;;EXTRACTING THE SURFACE EMISSIONS
  printVarSummary(SO2)

  dimSO2 = dimsizes(SO2)
  print(dimSO2)

  ntim   = dimSO2(0)
  nlat   = dimSO2(2)
  mlon   = dimSO2(3)
  klev   = 8

;;NOW PARTITIONING INTO 8 LEVELS
;;E_SO2 MUST BE PRE-ALLOCATED

  E_SO2 = new((/ntim,klev,nlat,mlon/),typeof(SO2),getVarFillValue(SO2))
  E_SO2(:,0,:,:) = 0.0 * SO2(:,0,:,:)
  E_SO2(:,1,:,:) = 0.3 * SO2(:,0,:,:)
  E_SO2(:,2,:,:) = 0.3 * SO2(:,0,:,:)
  E_SO2(:,3,:,:) = 0.1 * SO2(:,0,:,:)
  E_SO2(:,4,:,:) = 0.1 * SO2(:,0,:,:)
  E_SO2(:,5,:,:) = 0.1 * SO2(:,0,:,:)
  E_SO2(:,6,:,:) = 0.05 * SO2(:,0,:,:)
  E_SO2(:,7,:,:) = 0.05 * SO2(:,0,:,:)

  copy_VarMeta(SO2, E_SO2)
  printVarSummary(E_SO2)

;; add more meta data

;  lev            = ispan(1,klev,1)   ; ??????
;  lev!0         = "lev"
;  lev@long_name = "level"
;  lev@units     = "..."

  E_SO2!0     = "Time"    ; add coordinate variable
  E_SO2!1     = "emissions_zdim_stag"    ; add coordinate variable
  E_SO2!2     = "south_north"    ; add coordinate variable
  E_SO2!3     = "west_east"    ; add coordinate variable
;  E_SO2&lev =  lev

;  E_SO2@long_name = "artificial: "+SO2@long_name
  printVarSummary(E_SO2)

  ;=================================
  diro = "./"
  filo = "dummy.nc"
  ptho = diro+filo
  b    = addfile(ptho,"c")
  b->E_SO2 = E_SO2

end
