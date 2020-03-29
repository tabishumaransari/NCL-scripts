;   Example script - plot terrain (using some basic WRF scripts)
;   Overwrite basic map background settings
;   November 2008

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

  a1 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")           ; Open a file
  a2 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")           ; Open a file
  a3 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")           ; Open a file
  a4 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")           ; Open a file
  b  = addfile("/data1/tabish/run-package_06-03-2017/wrffirechemi_d03.nc","r")
  c  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-10-10_000000.nc","r")

;AVERAGE ACROSS TIME AND VERT LEVELS 
undef("TVavg")
function TVavg(emis)
begin
  emisavgT = dim_avg_Wrap( emis(south_north|:, west_east|:, emissions_zdim_stag|:, Time|:) )
  emisavgTV = dim_avg_Wrap( emisavgT(south_north|:, west_east|:, emissions_zdim_stag|:) )
return(emisavgTV)
end


  emis_anthro_pm25= (a1->E_PM25I + a1->E_PM25J + a2->E_PM25I + a2->E_PM25J + a3->E_PM25I + a3->E_PM25J + a4->E_PM25I + a4->E_PM25J)/8.0
  emis_anthro_so4 = (a1->E_SO4I + a1->E_SO4J + a2->E_SO4I + a2->E_SO4J + a3->E_SO4I + a3->E_SO4J + a4->E_SO4I + a4->E_SO4J)/8.0
  emis_anthro_ec  = (a1->E_ECI + a1->E_ECJ + a2->E_ECI + a2->E_ECJ + a3->E_ECI + a3->E_ECJ + a4->E_ECI + a4->E_ECJ)/8.0
  emis_anthro_oc  = (a1->E_ORGI + a1->E_ORGJ + a2->E_ORGI + a2->E_ORGJ + a3->E_ORGI + a3->E_ORGJ + a4->E_ORGI + a4->E_ORGJ)/11.4
  emis_anthro = (emis_anthro_pm25 + emis_anthro_so4 + emis_anthro_ec + emis_anthro_oc)/4.0
  emis_anthro!0 = "Time"
  emis_anthro!1 = "emissions_zdim_stag"
  emis_anthro!2 = "south_north"
  emis_anthro!3 = "west_east"
  printVarSummary(emis_anthro)
  emis_anthro_TVavg = TVavg(emis_anthro)
  emis_anthro_TVavg@description = "anthro emissions"
  printVarSummary(emis_anthro_TVavg)

  emis_fire = (b->ebu_in_pm25 + b->ebu_in_sulf + b->ebu_in_bc + b->ebu_in_oc)/4.0
  emis_fire!0 = "Time"
  emis_fire!1 = "emissions_zdim_stag"
  emis_fire!2 = "south_north"
  emis_fire!3 = "west_east"
  printVarSummary(emis_fire)
  emis_fire_TVavg = TVavg(emis_fire)
  emis_fire_TVavg@description = "fire emissions"
  printVarSummary(emis_fire_TVavg)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING OPTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  type = "eps"
  wks = gsn_open_wks(type,"anthro-fire_emissions_d03")         ; Create a plot workstation
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  ;gsn_define_colormap(wks,"WhiteYellowOrangeRed")
  ;gsn_define_colormap(wks,"hotres")
; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 Emissions"
  res@lbLabelBarOn = False       ; Turn off individual label bars
  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
  pltres@PanelPlot = True
  res@NoHeaderFooter           = True            ; Switch headers and footers off
  mpres@mpOutlineOn = True  ; Turn off map outlines
  mpres@mpFillOn    = False  ; Turn off map fill
      opts = res                         
      opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
      opts@cnLevels = (/0,0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.01,0.015,0.02,0.025,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2/) ; set levels 
      ;opts@ContourParameters = (/0, 0.2, 0.004/)
     ;opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
     ; opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_anthro = wrf_contour(a1,wks,emis_anthro_TVavg,opts)
      contour_fire = wrf_contour(a1,wks,emis_fire_TVavg,opts)
      delete(opts)
  mpres@mpOutlineBoundarySets       = "AllBoundaries"   ; turn on country boundaries
  mpres@mpGeophysicalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpNationalLineColor      = "Black"       ; color of cont. outlines
  mpres@mpProvincialLineColor      = "Black"       ; color of cont. outlines
  mpres@mpGeophysicalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpNationalLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpProvincialLineThicknessF = 1.5          ; thickness of outlines
  mpres@mpDataBaseVersion = "MediumRes"            ; choose higher resolution
  mpres@mpDataSetName = "Earth..4"                 ; choose most recent boundaries 
 

; MAKE PLOTS                                       
;pltres@FramePlot = False  ; do not frame plot - will do this manually later
 plot1 = wrf_map_overlays(c,wks,contour_anthro,pltres,mpres)
 plot2 = wrf_map_overlays(c,wks,contour_fire,pltres,mpres)

  pltres@PanelPlot = True

  ; Panel the WRF plots.
    pnlres                            = True
    pnlres@txString                   = "Anthro vs Fire PM2.5 emissions"
    ;pnlres@gsnPanelYWhiteSpacePercent = 13       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.13
    pnlres@gsnMaximize = True
    pnlres@gsnFrame         = False
    gsn_panel(wks,(/plot1,plot2/),(/1,2/),pnlres)

; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.015
  gsn_text_ndc(wks,"PM2.5 in ~F33~m~F21~g m~S~-2~N~ s~S~-1",0.51,0.17,txres)
  frame(wks)



end
