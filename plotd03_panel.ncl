load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

  a1 = addfile("/mnt/rasher/zero-out_runs/run0/subset_d03_2014-10-23_010000.nc","r")           ; Open a file
  a2 = addfile("/mnt/rasher/zero-out_runs/run0/subset_d03_2014-10-24_010000.nc","r")           ; Open a file
  b = addfile("/mnt/rasher/control-run-so4-ECMWF/wrfout_d03_2014-10-24_010000.nc","r")           ; Open a file
  wks = gsn_open_wks("pdf","episode-maps")         ; Create a plot workstation

  opts = True                                  ; Set some Basic Plot options
;  opts@MainTitle = "GEOGRID FIELDS"
  opts@InitTime = False                        ; Do not plot time or footers
  opts@Footer = False    

  pehla = a1->PM2_5_DRY(15:23,0,:,:)           ; Read the variable to memory
  dusra = a2->PM2_5_DRY(0:14,0,:,:)           ; Read the variable to memory
  pehlaSum = dim_sum_n(pehla,0)
  dusraSum = dim_sum_n(dusra,0)
  pm25 = (pehlaSum+dusraSum)/24.0
  pm25@description=""
  printVarSummary(pm25)

  res = opts                                   ; Use basic options for this field
  res@cnFillOn = True                          ; Create a color fill plot
  ;res@cnFillPalette       = "BlGrYeOrReVi200"      ; Set color map
  res@cnFillPalette       = "WhiteYellowOrangeRed"      ; Set color map
  ;res@cnFillPalette       = "MPL_Greys"      ; Set color map
  res@ContourParameters = (/ 25, 325, 25 /) ; Set the levels
  res@gsnFrame        = False                    ; don't advance frame yet
  res@gsnDraw         = False                    ; don't draw plot
  res@lbLabelBarOn = False
  
  ;res@pmLabelBarOrthogonalPosF = -0.05
  contour = wrf_contour(a1,wks,pm25,res)

  pltres = True                                ; Set plot options
  pltres@NoHeaderFooter = True  
  pltres@PanelPlot = True 
  mpres = True                                 ; Set map options
  mpres@mpOutlineBoundarySets       = "Noboundaries"
;  mpres@mpUSStateLineDashPattern    = 0
;  mpres@mpOutlineOn           = True
;  mpres@mpDataBaseVersion        = "MediumRes"
;  mpres@mpDataSetName            = "Earth..4"      ; U.S. counties

mpres@tmXBMajorOutwardLengthF = 0.0 
mpres@mpGeophysicalLineColor      = "Black"  ; Overwrite basic map settings
  mpres@mpGridLineColor             = "Black"
  mpres@mpLimbLineColor             = "Black"
  mpres@mpNationalLineColor         = "Black"
  mpres@mpPerimLineColor            = "Black"
  mpres@mpUSStateLineColor          = "Black"

  plot1 = wrf_map_overlays(b,wks,(/contour/),pltres,mpres) ; Plot field over map background

txres               = True
;txres@txFont = "helvetica-bold"
txres@txFontHeightF = 0.02
;txres@txFontThicknessF = 4.0
;dum = gsn_add_text(wks,plot1,"Beijing avg=338",115.7,42,txres)

;ADD DISTRICT BOUNDARIES WITH THICKER BLACK LINES
india_shp_name    = "/home/tabish/Shapefiles/China/CHN_adm1.shp"
lnres                  = True
lnres@gsLineColor      = "black"
lnres@gsLineThicknessF = 1
india_id = gsn_add_shapefile_polylines(wks,plot1,india_shp_name,lnres)




;;;NOW FOR EPISODE 2;;;
  a1 = addfile("/mnt/rasher/zero-out_runs/run0/subset_d03_2014-10-29_010000.nc","r")           ; Open a file
  a2 = addfile("/mnt/rasher/zero-out_runs/run0/subset_d03_2014-10-30_010000.nc","r")           ; Open a file
  pehla = a1->PM2_5_DRY(15:23,0,:,:)           ; Read the variable to memory
  dusra = a2->PM2_5_DRY(0:14,0,:,:)           ; Read the variable to memory
  pehlaSum = dim_sum_n(pehla,0)
  dusraSum = dim_sum_n(dusra,0)
  pm25 = (pehlaSum+dusraSum)/24.0

  res@lbLabelBarOn = False
  res@ContourParameters = (/ 0, 340, 20 /) ; Set the levels
  contour = wrf_contour(a1,wks,pm25,res)
  plot2 = wrf_map_overlays(b,wks,(/contour/),pltres,mpres) ; Plot field over map background

;dum2 = gsn_add_text(wks,plot2,"Beijing avg=258",115.7,42,txres)

 China_id2 = gsn_add_shapefile_polylines(wks,plot2,india_shp_name,lnres)

  ; Panel the WRF plots.
    pnlres                            = True
    ;pnlres@txString                   = t@description + "  (" + t@units + ")"
    pnlres@gsnPanelXWhiteSpacePercent = 5       ; Add white space b/w plots.
    pnlres@gsnPanelYWhiteSpacePercent = 1       ; Add white space b/w plots.
    pnlres@gsnPanelLabelBar           = True    ; Turn on common labelbar
    ;pnlres@lbLabelAutoStride          = True    ; Spacing of lbar labels.
    pnlres@lbBoxMinorExtentF          = 0.15
   ; pnlres@amOrthogonalPosF = -2
    pnlres@pmLabelBarOrthogonalPosF = 0.27
;txres               = True
;txres@txFontHeightF = 0.020
;dum = gsn_add_text(wks,"Beijing avg=258 ~F33~m~F21~gm~S~-3~N~",114,41,txres)


pnlres@gsnFrame = False
    gsn_panel(wks,(/plot1,plot2/),(/1,2/),pnlres)
; Draw a text string at the bottom
  txres               = True
  txres@txFontHeightF = 0.012
  gsn_text_ndc(wks,"PM~B~2.5~N~ in ~F33~m~F21~gm~S~-3~N~",0.5,0.404,txres)

  frame(wks)


end

