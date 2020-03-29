;THIS SCRIPT PLOTS TOTAL EMISSION FLUX PER SPECIES FOR EACH MODEL DOMAIN 

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

;READING FILES
a2_me = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d02_mapeire.nc","r")
a2_ed = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d02.nc","r")

a3_me = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d03_mapeire.nc","r")
a3_ed = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d03_edgar.nc","r")

c2 = addfile("/home/tabish/Downloads/mapeire-sita/ref2.nc","r")
c3 = addfile("/home/tabish/Downloads/mapeire-sita/ref3.nc","r")

;THERE ARE NO VERTICAL LEVELS AND NO DIURNAL CYCLE SO FIRST TIME AND FIRST VERTICAL LEVEL DATA CAN BE READ AND COMPARED
co_d02_ed = a2_ed->E_NO(0,0,:,:) ; * 3600.0 ; converting from g km-2 s-1 to g km-2 hr-1
co_d02_me = a2_me->E_NO(0,0,:,:)

co_d03_ed = a3_ed->E_NO(0,0,:,:) ;* 3600.0
co_d03_me = a3_me->E_NO(0,0,:,:)

;co_d02_ed@description = ""
;co_d02_me@description = ""
;co_d02_me@units = ""
;co_d03_ed@description = ""
;co_d03_me@description = ""
;co_d03_me@units = ""


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING OPTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  type = "pdf"
  wks = gsn_open_wks(type,"NO_EDGARvsMapEIre_emissions-panel")         ; Create a plot workstation
  ;gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  ;gsn_define_colormap(wks,"WhiteYellowOrangeRed")
  ;gsn_define_colormap(wks,"hotres")
   gsn_define_colormap(wks,"MPL_Reds")
; Set some basic resources
  res = True
;  res@MainTitle                   = "PM2.5 Emissions"
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
  opts@cnLevels = (/10,25,50,75,100,200,400,600,800,1000,1500,2000,3000,4000,5000,6000/) ; set levels for CO
;  opts@cnLevels = (/5,10,15,20,25,50,75,100,150,200,250,300,350,400/) ; set levels for NO
;  opts@cnLevels = (/5,10,15,20,25,50,75,100,150,200,250,300,350,400,500,600,700,800,900/) ; set levels for SO2
  ;opts@cnLevels = (/5,10,15,20,25,30,35,40,50,60,70,80,90,100,110/) ; set levels for NH3
  ;opts@ContourParameters = (/0, 0.2, 0.004/)
  ;opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
  ; opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
  contour_d02_ed = wrf_contour(a2_ed,wks,co_d02_ed,opts)
  contour_d02_me = wrf_contour(a2_me,wks,co_d02_me,opts)

  contour_d03_ed = wrf_contour(a3_ed,wks,co_d03_ed,opts)
  contour_d03_me = wrf_contour(a3_me,wks,co_d03_me,opts)

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

 plot1 = wrf_map_overlays(c2,wks,(/contour_d02_ed/),pltres,mpres)
 plot2 = wrf_map_overlays(c2,wks,(/contour_d02_me/),pltres,mpres)
 plot3 = wrf_map_overlays(c3,wks,(/contour_d03_ed/),pltres,mpres)
 plot4 = wrf_map_overlays(c3,wks,(/contour_d03_me/),pltres,mpres)

;---Retrieve the height used for the first plot and apply to subsequent plots
;  getvalues plot1
;    "vpHeightF" : vph
;  end getvalues

;setvalues (/plot2,plot3,plot4,plot5,plot6/)
;  "vpHeightF" : vph
;end setvalues



  pltres@PanelPlot = True

  ; Panel the WRF plots.
    pnlres                            = True
   ; pnlres@txString                   = "CO emissions"
    pnlres@gsnPanelYWhiteSpacePercent = 5       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
 ;   pnlres@pmLabelBarParallelPosF = - 0.06
 ;   pnlres@pmLabelBarOrthogonalPosF = -0.025
  ;  pnlres@lbOrientation = "vertical"
  ;  pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
  ;  pnlres@lbBoxMinorExtentF          = 0.15
  pnlres@gsnPanelFigureStrings= (/"a","b","c","d"/) ; add strings to panel
  pnlres@amJust   = "TopLeft"  
  pnlres@gsnMaximize = True
  ;pnlres@gsnPaperOrientation = "landscape"  
  pnlres@gsnFrame         = False
    gsn_panel(wks,(/plot1,plot2,plot3,plot4/),(/2,2/),pnlres)

; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.015
  ;gsn_text_ndc(wks,"PM2.5 in ~F33~m~F21~g m~S~-2~N~ s~S~-1",0.51,0.17,txres)
  gsn_text_ndc(wks,"NO in mol km~S~-2~N~ hr~S~-1",0.5,0.14,txres)
  ;gsn_text_ndc(wks,"PM10 in g km~S~-2~N~ hr~S~-1",0.5,0.14,txres)
  frame(wks)



end
