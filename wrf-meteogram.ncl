; Example series of plotting meteograms with WRF ARW model data
; First let's just get and plot t2 at a point
; Add some inrfto to the plot
; Add slp to the plot
; Add a time-Z plot above slp and t2
; Use wrf_user_ll_to_ij to get the point of interest
; Clean up the plot


;***********************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
;***********************************************
begin
;***********************************************

FILES_QNSENONNUDGED = systemfunc (" ls -1 /data3/tabish/QNSE-nonnudged/wrfout_d03_2014-* ")
a = addfiles(FILES_QNSENONNUDGED,"r")
;-----------------------------------------------------------------------

; Find the ij location for the point if interest
  lat = 39.97
  lon = 116.37
  llres = True
  llres@ReturnInt = True   ; Return integer values
  locij = wrf_user_ll_to_ij(a, lon, lat, llres)
  locij = locij - 1        ; array pointers in NCL space
  locX = locij(0)
  locY = locij(1)

  taus = (/ 1., 2., 3., 4., 5. /)       ; create a time reference

; get time information and strip out the day and hour
times  = wrf_times_c(a[:]->Times,0) 

;  dims = dimsizes(times_in_file)
;  times = new(dims(0),string)
;  do i=0,dims(0)-1
;    times(i) = chartostring(times_in_file(i,8:12))
;  end do

  wks = gsn_open_wks("x11","vertdist_pm25_qnsenonnudged")    ; open a workstation
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
;-----------------------------------------------------------------------

;  tc    = wrf_user_getvar(a,"tc",-1)    ; get tc for all times
;  pm25  = wrf_user_getvar(a,"PM2_5_DRY",-1)    ; get tc for all times
;  uvmet = wrf_user_getvar(a,"uvmet",-1) ; get rotated u and v comp of wind
pm25 = a[:]->PM2_5_DRY(:,:,:,:)
;  umet = uvmet(0,:,:,:,:)
;  vmet = uvmet(1,:,:,:,:)

;-----------------------------------------------------------------------

 ; tc_point  = tc(:,:,locY,locX)
  pm25_point= pm25(:,0:9,locY,locX)
  pm25_sur= pm25(:,0,locY,locX)
  pblh_point= a[:]->PBLH(:,locY,locX)
 ; u_point   = umet(:,:,locY,locX)
 ; v_point   = vmet(:,:,locY,locX)

; Swap the dimensions as we want to plot time on the X axis later
;  tt        = tc_point(bottom_top|:,Time|:)
  pm25t     = pm25_point(bottom_top|:,Time|:)
;  ugrid     = u_point(bottom_top|:,Time|:)
;  vgrid     = v_point(bottom_top|:,Time|:)

print(dimsizes(times))
print(dimsizes(pblh_point))
;-----------------------------------------------------------------------

  res2D = True                            ; Set basic resources 
  res2D@gsnDraw              = False      ; Don't draw individual plot.
  res2D@gsnFrame             = False      ; Don't advance frame.
  res2D@vpXF                 = 0.15       ; x location
  res2D@vpYF                 = 0.90       ; y location
  res2D@vpWidthF             = 0.70       ; width
  res2D@vpHeightF            = 0.40       ; height
  res2D@tiXAxisString        = "PM2.5 in ug/m^3"
  res2D@tiXAxisFontHeightF   = 0.016
;  res2D@tmXBMode             = "Explicit"
;  res2D@tmXBValues           = taus
;  res2D@tmXBLabels           = times
;  res2D@tmXBLabelJust        = "CenterCenter"
;  res2D@tmXBLabelFontHeightF = .012


  tt_res = res2D
;  tt_res@sfXArray                 = taus
  tt_res@gsnSpreadColors          = True             ; use full range of colors
  tt_res@cnFillOn                 = True             ; turns on color fill
  tt_res@cnLevelSelectionMode     = "ManualLevels"   ; set levels manually
  tt_res@cnMinLevelValF           = 0.
  tt_res@cnMaxLevelValF           = 550.
  tt_res@cnLevelSpacingF          = 25
  tt_res@cnLinesOn                = False
  tt_res@cnLineLabelsOn           = False
  tt_res@cnInfoLabelOn            = False
  tt_res@pmLabelBarDisplayMode    = "Always"         ; Add a label bar
  tt_res@pmLabelBarSide           = "Bottom"
  tt_res@pmLabelBarOrthogonalPosF = -0.15
;  tt_res@pmLabelBarParallelPosF   = 0.44
  tt_res@lbAutoManage             = False
  tt_res@lbLabelAutoStride        = True
  tt_res@lbOrientation            = "Horizontal"
  tt_res@lbPerimOn                = False
;  tt_res@lbJustification          = "BottomLeft"
  tt_res@lbBoxMinorExtentF        = 0.13
  tt_res@lbLabelFontHeightF       = 0.012
  tt_res@lbBoxLinesOn             = False
  tt_res@tiMainString             = "Vertical distribution for lat=" + lat + " ; lon=" + lon


  uv_res = res2D
;  uv_res@vfXArray         = taus
  uv_res@vcRefAnnoOn      = False         ; turns off the ref vector
  uv_res@vcRefLengthF     = 0.040         ; set length of ref vector
  uv_res@vcGlyphStyle     = "WindBarb"    ; turn on wind barbs


  res1D = True                            ; Set basic resources both will use
  res1D@vpXF              = 0.15          ; The left side of the box location
  res1D@vpWidthF          = 0.70          ; The Width of the plot box
  res1D@vpHeightF         = 0.10          ; The height of the plot box
;  res1D@tmXBMode          = "Explicit"    ; Define own tick mark labels.
;  res1D@tmXBValues        = taus          ; location of explicit labels
;  res1D@tmXBLabels        = times         ; labels are the locations
  res1D@tmXTOn            = False         ; turn off the top tick marks
  res1D@xyLineThicknesses = 2             ; increase line thickness
  res1D@gsnDraw           = False         ; Don't draw individual plot.
  res1D@gsnFrame          = False         ; Don't advance frame.
 
 restick           = True
 restick@ttmFormat = "%D_%H"
; restick@ttmFormat = "%D"
  restick@ttmNumTicks = 6
 restick@ttmMajorStride= 24
 restick@ttmMinorStride= 1
  time_axis_labels(times,tt_res,restick)


 
  pblh_res = res1D
  pblh_res@vpYF             = 0.20          ; The top side of the plot box loc
  pblh_res@xyLineColor      = "blue"        ; set line color

  time_axis_labels(times,pblh_res,restick)
;-----------------------------------------------------------------------

  ttfill    = gsn_contour(wks,pm25t,tt_res)
 ; windlayer = gsn_vector(wks,ugrid,vgrid,uv_res)
 ; overlay(ttfill,windlayer)
 pblh_plot  = gsn_csm_xy(wks,times,pblh_point,pblh_res)
 pm25_plot  = gsn_csm_xy(wks,times,pm25_sur,pblh_res)

;  res1D@gsnMaximize         = True
;  res2D@gsnAttachPlotsXAxis = True

; xy1 will be the base plot.
;  amid = gsn_attach_plots(ttfill,(/pm25_plot,pblh_plot/),res1D,res2D)


  draw(ttfill) 
  draw(pblh_plot) 

  frame(wks)                            ; now frame the plot   

;-----------------------------------------------------------------------

end

