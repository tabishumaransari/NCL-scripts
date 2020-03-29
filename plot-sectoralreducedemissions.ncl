begin
a1=addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2=addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
b1=addfile("/data3/tabish/vert-MEIC-emis/sectoral-sensitivity-wrfchemi/wrfchemi_00z_d01_Oct_all_Ai100Ap100At100Ar100Bi100Bp100Bt100Br100Ci100Cp100Ct0Cr100.nc","r")
b2=addfile("/data3/tabish/vert-MEIC-emis/sectoral-sensitivity-wrfchemi/wrfchemi_12z_d01_Oct_all_Ai100Ap100At100Ar100Bi100Bp100Bt100Br100Ci100Cp100Ct0Cr100.nc","r")
c  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d01_2014-10-17_010000.nc","r"); importing just for map projection information


emis_normal_1  = a1->E_PM25J(0,0,:,:)
dims = dimsizes(emis_normal_1)
emis_normal   = new((/24,8,dims(0),dims(1)/),typeof(emis_normal_1),emis_normal_1@_FillValue)
emis_reduced = new((/24,8,dims(0),dims(1)/),typeof(emis_normal_1),emis_normal_1@_FillValue)
vNames = getfilevarnames (a1) ; get names of all variables on file
nNames = dimsizes (vNames)   ; number of variables on the file
print (vNames)               ; print all variable names on file

wks = gsn_open_wks("pdf","emisdiff_d01_run11")
gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
;gsn_define_colormap(wks,"hotres")

; Set some basic resources
  res = True
  res@MainTitle                   = ""
  pltres = True
  pltres@PanelPlot  = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
  res@lbLabelBarOn = True       ; Turn off individual label bars
  res@NoHeaderFooter           = True            ; Switch headers and footers off



;  res@cnLevelSelectionMode = "ManualLevels"
;  res@cnMinLevelValF = 0
;  res@cnMaxLevelValF = 0.1
;  res@cnLevelSpacingF = 0.01

    mpres             = True   ; Set map options
    opts = res
    opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map


do n=3,nNames-1              ; START VARIABLE LOOP

plots = new ( (/24,8/), graphic )
do h =0,7
 do i =0,11
  emis_normal(i,h,:,:)     = a1->$vNames(n)$(i,h,:,:)
  emis_normal(i+12,h,:,:)  = a2->$vNames(n)$(i,h,:,:)
  emis_reduced(i,h,:,:)    = b1->$vNames(n)$(i,h,:,:)
  emis_reduced(i+12,h,:,:) = b2->$vNames(n)$(i,h,:,:)
 end do
end do

emis_diff = emis_normal - emis_reduced

do h =0,7   ;START HEIGHT LOOP
do t = 0,23
   contour_emisdiff = wrf_contour(c,wks,emis_diff(t,h,:,:),opts)
   plots(t,h) = wrf_map_overlays(c,wks,(/contour_emisdiff/),pltres,mpres)
end do

  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "emission difference for "+vNames(n)+" for vert level "+h
    pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
;    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
;    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.13
    res@gsnFrame         = False
;    india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp"
;    lnres                  = True
;    lnres@gsLineColor      = "black"
;    lnres@gsLineThicknessF = 1.5

;do i=0,23
; unistr = unique_string("polyl")
; plots@$unistr$ = gsn_add_shapefile_polylines(wks,plots(i,h),india_shp_name,lnres)
;end do
gsn_panel(wks,(/plots(:,h)/),(/4,6/),pnlres)

end do ; END HEIGHT LOOP
delete(plots)
end do ; END VARIABLE LOOP
end
