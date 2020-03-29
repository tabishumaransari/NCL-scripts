;************************************************
; read in data
;************************************************
 f     = addfile ("$NCARG_ROOT/lib/ncarg/data/cdf/uv300.nc","r")
 u     = f->U                                    ; get u data
;************************************************
; to plot multiple lines, you must put them into
; a mulidimensional array
;************************************************
 data      = new((/2,dimsizes(u&lat)/),float)
 data(0,:) = u(0,:,{82})
 data(1,:) = u(0,:,{-69})
;************************************************
; plotting parameters
;************************************************
 wks   = gsn_open_wks ("x11","xy")                 ; send graphics to PNG file

 res                   = True                      ; plot mods desired
 res@tiMainString      = "Example 17: Colot Fill"
 res@xyDashPattern     = 0                         ; solid line for curves
 res@gsnXYAboveFillColors = "red"
 res@gsnXYBelowFillColors = "green"
 plot  = gsn_csm_xy (wks,u&lat,data,res) ; create plot
 delete([/res@gsnXYAboveFillColors,res@gsnXYBelowFillColors/])

;======
; Create xy and add polygon
;======
 res@gsnDraw      = False
 res@gsnFrame     = False
 res@tiMainString = "Example 17: Index Fill"

 ndata        = dimsizes(data)
 nxy          = ndata(1)
 xp           = new(2*nxy, typeof(u&lat),"No_FillValue")  ; polygon coordinates
 yp           = xp

 xp(0:nxy-1)  = (/ u&lat /)            ; out
 yp(0:nxy-1)  = (/ data(0,:) /)
 xp(nxy:)     = (/ u&lat(::-1) /)      ; back  
 yp(nxy:)     = (/ data(1,::-1) /)

 print(xp+"   "+yp)

 pltxy        = gsn_csm_xy (wks,xp,yp,res) ; create plot

 resPoly = True
 resPoly@gsFillIndex = 11
 dumPoly = gsn_add_polygon (wks,pltxy,xp,yp,resPoly) ; create plot
 draw(pltxy)
 frame(wks)

