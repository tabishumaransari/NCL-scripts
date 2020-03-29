;THIS SCRIPT PLOTS TOTAL EMISSION FLUX PER SPECIES FOR EACH MODEL DOMAIN 

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;READING REFERENCE FILES FOR MAP PROJECTIONS
a1 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d02_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a3 = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")

c1  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d01_2014-10-10_000000.nc","r")
c2  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d02_2014-10-10_000000.nc","r")
c3  = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-10-10_000000.nc","r")

;DOMAIN 1
a1_00z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a1_12z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a1_00z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
a1_12z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d01_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")

;DOMAIN 2
a2_00z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d02_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2_12z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2_00z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d02_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
a2_12z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d02_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")

;DOMAIN 3
a3_00z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a3_12z_Oct = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")
a3_00z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
a3_12z_Nov = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")


;FUNCTION TO SUM ACROSS 8 VERT LEVELS THEN AVERAGE OVER TIME
undef("avgsum")
function avgsum(var)
begin
;DOMAIN 1 OCTOBER
 var1               = a1_00z_Oct->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a1_12z_Oct->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d01_Oct = (var1_vsum_tavg + var2_vsum_tavg)/2.0 
 result_d01_Oct@description = ""
;DOMAIN 1 NOVEMBER
 var1               = a1_00z_Nov->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a1_12z_Nov->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d01_Nov = (var1_vsum_tavg + var2_vsum_tavg)/2.0 
 result_d01_Nov@description = ""
 delete([/var1,var1_vsum,var1_vsum_tavg/])
 delete([/var2,var2_vsum,var2_vsum_tavg/])


;DOMAIN 2 OCTOBER
 var1               = a2_00z_Oct->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a2_12z_Oct->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d02_Oct     = (var1_vsum_tavg + var2_vsum_tavg)/2.0
 result_d02_Oct@description = ""

;DOMAIN 2 NOVEMBER
 var1               = a2_00z_Nov->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a2_12z_Nov->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d02_Nov = (var1_vsum_tavg + var2_vsum_tavg)/2.0 
 result_d02_Nov@description = ""
 
 delete([/var1,var1_vsum,var1_vsum_tavg/])
 delete([/var2,var2_vsum,var2_vsum_tavg/])

;DOMAIN 3 OCTOBER
 var1               = a3_00z_Oct->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a3_12z_Oct->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d03_Oct = (var1_vsum_tavg + var2_vsum_tavg)/2.0
 result_d03_Oct@description = ""

;DOMAIN 3 NOVEMBER
 var1               = a3_00z_Nov->$var$
 var1_vsum          = dim_sum_n_Wrap(var1,1)
 var1_vsum_tavg     = dim_avg_n_Wrap(var1_vsum,0)

 var2               = a3_12z_Nov->$var$
 var2_vsum          = dim_sum_n_Wrap(var2,1)
 var2_vsum_tavg     = dim_avg_n_Wrap(var2_vsum,0)

 result_d03_Nov = (var1_vsum_tavg + var2_vsum_tavg)/2.0 
 result_d03_Nov@description = ""
 delete([/var1,var1_vsum,var1_vsum_tavg/])
 delete([/var2,var2_vsum,var2_vsum_tavg/])

 return([/result_d01_Oct, result_d01_Nov,result_d02_Oct, result_d02_Nov,result_d03_Oct, result_d03_Nov/])

end


print("Preparing 2D arrays for CO")
var1 = avgsum("E_HCHO")
var2 = avgsum("E_ALD")
var3 = avgsum("E_CH3OH")
var4 = avgsum("E_C2H5OH")
var5 = avgsum("E_TOL")
var6 = avgsum("E_OL2")
var7 = avgsum("E_OLT")
var8 = avgsum("E_OLI")
var9 = avgsum("E_KET")
var10 = avgsum("E_ETH")
var11 = avgsum("E_HC3")
var12 = avgsum("E_HC5")
var13 = avgsum("E_HC8")
var14 = avgsum("E_XYL")


d01_Oct = (var1[0]+var2[0]+var3[0]+var4[0]+var5[0]+var6[0]+var7[0]+var8[0]+var9[0]+ var10[0]+var11[0]+var12[0]+var13[0]+var14[0])
d01_Nov = (var1[1]+var2[1]+var3[1]+var4[1]+var5[1]+var6[1]+var7[1]+var8[1]+var9[1]+ var10[1]+var11[1]+var12[1]+var13[1]+var14[1])
d02_Oct = (var1[2]+var2[2]+var3[2]+var4[2]+var5[2]+var6[2]+var7[2]+var8[2]+var9[2]+ var10[2]+var11[2]+var12[2]+var13[2]+var14[2])
d02_Nov = (var1[3]+var2[3]+var3[3]+var4[3]+var5[3]+var6[3]+var7[3]+var8[3]+var9[3]+ var10[3]+var11[3]+var12[3]+var13[3]+var14[3])
d03_Oct = (var1[4]+var2[4]+var3[4]+var4[4]+var5[4]+var6[4]+var7[4]+var8[4]+var9[4]+ var10[4]+var11[4]+var12[4]+var13[4]+var14[4])
d03_Nov = (var1[5]+var2[5]+var3[5]+var4[5]+var5[5]+var6[5]+var7[5]+var8[5]+var9[5]+ var10[5]+var11[5]+var12[5]+var13[5]+var14[5])

d01_Oct@description = ""
d01_Nov@description = ""
d02_Oct@description = ""
d02_Nov@description = ""
d03_Oct@description = ""
d03_Nov@description = ""
printVarSummary(d01_Oct)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING OPTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  type = "eps"
  wks = gsn_open_wks(type,"NMVOC_emissions-panel")         ; Create a plot workstation
  ;gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  ;gsn_define_colormap(wks,"WhiteYellowOrangeRed")
  ;gsn_define_colormap(wks,"hotres")
   gsn_define_colormap(wks,"MPL_Reds")
; Set some basic resources
  res = True
  res@MainTitle                   = "PM2.5 Emissions"
  res@lbLabelBarOn = False       ; Turn off individual label bars

  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot
  pltres@PanelPlot = True
  res@NoHeaderFooter           = True            ; Switch headers and footers off
  mpres@mpOutlineOn = True  ; Turn on map outlines
  mpres@mpFillOn    = False  ; Turn off map fill
  
  opts = res                         
  opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
  ;opts@cnLevels = (/0,0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008,0.009,0.01,0.015,0.02,0.025,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2/) ; set levels 
  ;opts@cnLevels = (/10,25,50,75,100,200,400,600,800,1000,1500,2000,3000,4000,5000,6000/) ; set levels for CO
  ;opts@cnLevels = (/5,10,15,20,25,50,75,100,150,200,250,300,350,400,450/) ; set levels for NO
  ;opts@cnLevels = (/5,10,15,20,25,50,75,100,150,200,250,300,350,400,500,600,700,800,900/) ; set levels for SO2
  ;opts@cnLevels = (/5,10,15,20,25,30,35,40,50,60,70,80,90,100,110/) ; set levels for NH3
  opts@cnLevels = (/5,10,15,20,25,30,35,40,50,60,70,80,90,100,150,200,250,300,350,400,450/) ; set levels for NMVOCs
  ;opts@ContourParameters = (/0, 0.2, 0.004/)
  ;opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
  ; opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
  contour_d01_Oct = wrf_contour(a1,wks,d01_Oct,opts)
  contour_d02_Oct = wrf_contour(a2,wks,d02_Oct,opts)
  contour_d03_Oct = wrf_contour(a3,wks,d03_Oct,opts)

  contour_d01_Nov = wrf_contour(a1,wks,d01_Nov,opts)
  contour_d02_Nov = wrf_contour(a2,wks,d02_Nov,opts)
  contour_d03_Nov = wrf_contour(a3,wks,d03_Nov,opts)

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
mpres@tmXTOn = True
mpres@tmYROn = True
  mpres@tmXBMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  mpres@tmXBMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  mpres@tmYLMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  mpres@tmYLMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  mpres@tmXTMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  mpres@tmXTMinorOutwardLengthF = 0.0               ; draw minor ticks inward
  mpres@tmYRMajorOutwardLengthF = 0.0               ; draw tickmarks inward
  mpres@tmYRMinorOutwardLengthF = 0.0               ; draw minor ticks inward

  mpres@tmXBLabelFontHeightF = 0.017

 plot1 = wrf_map_overlays(c1,wks,(/contour_d01_Oct/),pltres,mpres)
 plot2 = wrf_map_overlays(c2,wks,(/contour_d02_Oct/),pltres,mpres)
 plot3 = wrf_map_overlays(c3,wks,(/contour_d03_Oct/),pltres,mpres)
 plot4 = wrf_map_overlays(c1,wks,(/contour_d01_Nov/),pltres,mpres)
 plot5 = wrf_map_overlays(c2,wks,(/contour_d02_Nov/),pltres,mpres)
 plot6 = wrf_map_overlays(c3,wks,(/contour_d03_Nov/),pltres,mpres)

;---Retrieve the height used for the first plot and apply to subsequent plots
  getvalues plot1
    "vpHeightF" : vph
  end getvalues

setvalues (/plot2,plot3,plot4,plot5,plot6/)
  "vpHeightF" : vph
end setvalues



  pltres@PanelPlot = True

  ; Panel the WRF plots.
    pnlres                            = True
   ; pnlres@txString                   = "CO emissions"
    pnlres@gsnPanelYWhiteSpacePercent = 5       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    pnlres@pmLabelBarParallelPosF = - 0.06
    pnlres@pmLabelBarOrthogonalPosF = -0.025
  ;  pnlres@lbOrientation = "vertical"
  ;  pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
  ;  pnlres@lbBoxMinorExtentF          = 0.15
  pnlres@gsnPanelFigureStrings= (/"a","b","c","d","e","f"/) ; add strings to panel
  pnlres@amJust   = "TopLeft"  
  pnlres@gsnMaximize = True
  ;pnlres@gsnPaperOrientation = "landscape"  
  pnlres@gsnFrame         = False
    gsn_panel(wks,(/plot1,plot2,plot3,plot4,plot5,plot6/),(/2,3/),pnlres)

; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.015
  ;gsn_text_ndc(wks,"PM2.5 in ~F33~m~F21~g m~S~-2~N~ s~S~-1",0.51,0.17,txres)
  gsn_text_ndc(wks,"NMVOCs in mol km~S~-2~N~ hr~S~-1",0.45,0.23,txres)
  frame(wks)



end
