;   Example script - plot terrain (using some basic WRF scripts)
;   Overwrite basic map background settings
;   November 2008

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin

  a = addfile("/data1/tabish/results-APEC-14-15/wrfout_d01_150s_chemdt0.nc","r")           ; Open a file
  b = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2_so4_allnormal.nc","r")
  c = addfile("/data1/tabish/emit/MEIC2013/wrfchemi_d01_2013-01-01_00.nc","r")

  type = "png"

  wks = gsn_open_wks(type,"emiscompare2010-2013_no2_d01")         ; Create a plot workstation
    gsn_define_colormap(wks,"WhiteYellowOrangeRed")
  ;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  ; gsn_define_colormap(wks,"hotres")
plot_co = new ( 2, graphic );
; Set some basic resources
  res = True
;  res@MainTitle                   = "Emissions: NMVOC"
  pltres = True
  mpres = True
  res@cnFillOn          = True               ; Create a color fill plot

 ; times= a->Times  
  co1 = 0.125*(b->E_NO2(0,0,:,:) + b->E_NO2(0,1,:,:) + b->E_NO2(0,2,:,:) + b->E_NO2(0,3,:,:) + b->E_NO2(0,4,:,:) + b->E_NO2(0,5,:,:) + b->E_NO2(0,6,:,:) + b->E_NO2(0,7,:,:)) 
  co2 = 0.1428*(c->E_NO2(0,0,:,:) + c->E_NO2(0,1,:,:) + c->E_NO2(0,2,:,:) + c->E_NO2(0,3,:,:) + c->E_NO2(0,4,:,:) + c->E_NO2(0,5,:,:) + c->E_NO2(0,6,:,:)) 
  co1@description = "MEIC 2010 NO2 emissions at 0000HRS" 
  co2@description = "MEIC 2013 NO2 emissions at 0000HRS" 
   
res@lbLabelBarOn = False       ; Turn off individual label bars
res@NoHeaderFooter           = True            ; Switch headers and footers off
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Plotting options                
  mpres             = True   ; Set map options
  mpres@mpOutlineOn = False  ; Turn off map outlines
  mpres@mpFillOn    = False  ; Turn off map fill
  pltres@PanelPlot  = True   ; Tells wrf_map_overlays not to remove overlays
      opts = res                         
     ; opts@ContourParameters = (/0, 0.1, 20/)
      opts@cnLevelSelectionMode = "ExplicitLevels" ; set explicit contour levels 
     ;opts@cnLevels = (/0.0001,0.0002,0.0004, 0.0005, 0.001, 0.002, 0.003, 0.004, 0.005,0.006,0.007,0.008,0.009,0.010,0.015,0.020,0.03,0.04,0.05,0.075,0.1,0.2,0.3/) ; for pm25i
     ;opts@cnLevels = (/0.0001,0.0002,0.0004, 0.0005, 0.001, 0.002, 0.003, 0.004, 0.005,0.006,0.007,0.008,0.009,0.010/) ; for so4i
     ;opts@cnLevels = (/0.1,0.2,0.3,0.4,0.5,1,2,5,10,15,20,25,30,40,50,60,70,80,90/) ; for so2
      opts@cnLevels = (/0.01,0.02,0.03,0.04,0.05,0.1,0.2,0.3,0.4,0.5,1,2,5/) ; for no2
     ;opts@pmLabelBarOrthogonalPosF = .000001           ; move whole thing down
      opts@gsnSpreadColorEnd = -3  ; End third from the last color in color map
      contour_co1 = wrf_contour(a,wks,co1,opts)
      contour_co2 = wrf_contour(a,wks,co2,opts)
      delete(opts)
  

; MAKE PLOTS                                       
 plot_co(0) = wrf_map_overlays(a,wks,contour_co1,pltres,mpres)
 plot_co(1) = wrf_map_overlays(a,wks,contour_co2,pltres,mpres)

  india_shp_name    = "/data1/tabish/Shapefiles/China/CHN_adm1.shp"
  lnres                  = True

  lnres@gsLineColor      = "black"
  lnres@gsLineThicknessF = 1.5   
do i=0,1
  unistr = unique_string("polyl")
  plot_co@$unistr$ = gsn_add_shapefile_polylines(wks,plot_co(i),india_shp_name,lnres)
end do

resP                     = True                ; modify the panel plot
resP@gsnPanelMainString = "MEIC 2010 and 2013 emissions for NO2"
resP@gsnPanelLabelBar  = True
gsn_panel(wks,plot_co,(/1,2/),resP)
end
