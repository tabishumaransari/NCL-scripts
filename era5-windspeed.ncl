begin
a = addfile("/media/tabish/DataDisk/ERA5/ERA5_uvw_1000-975-950hpa_27-30Jun2011.nc","r")
u = a->u
v = a->v
w = a->w

printVarSummary(u)
printVarSummary(v)
;printVarSummary(w)


u_corr = 0.0012*u
u_corr = u_corr-0.6127
;v_corr = ((0.0012*v)-1.7441)
;v_corr = ((0.0012*v)-1.7441)

print("Transformed")
printMinMax(u_corr,1)
;printMinMax(v_corr,1)




;  wks   = gsn_open_wks ("x11", "windvectors-Oct2011")       ; send graphics to PNG file
;  res                      = True
;  res@gsnMaximize          = True    ; Maximize plot in frame
;  res@tiMainString         = "No resources set"

;U = u(0,0,0:260,1160:1438)
;V = u(0,0,0:260,1160:1438)


;printVarSummary(U)

;Uthin = U(::5,::5)
;Vthin = V(::5,::5)

;printMinMax(u,True)
  
;  res=True
;  res@vcGlyphStyle     = "CurlyVector"   ; curly vectors


 ; vector = gsn_csm_vector(wks,Uthin,Vthin,res)

;  res@vcMonoLineArrowColor = False  ; color arrows based on magnitude
;  res@vcRefLengthF         = 0.03313608
;  res@vcMinFracLengthF     = 0.3
;  res@vcLevelPalette       = "temp1" ; set color map

;  res@tiMainString         = "Line-Drawn Vectors (colored by magnitude)"

;  vector = gsn_csm_vector(wks,Uthin,Vthin,res)

;  res@vcLineArrowThicknessF= 2. 
;  res@vcGlyphStyle     = "CurlyVector"   ; curly vectors
;  res@tiMainString         = "Thickened Vectors"

;  vector = gsn_csm_vector(wks,Uthin,Vthin,res)




end
