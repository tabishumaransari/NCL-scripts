begin
a=addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_so4_allnormal.nc","r")

vNames = getfilevarnames (a) ; get names of all variables on file
nNames = dimsizes (vNames)   ; number of variables on the file
print (vNames)               ; print all variable names on file
      
do n=0,nNames-1              ; loop thru each variable
  v = a->$vNames(n)$        ; read the varible to memory
  dimv = dimsizes(v)        ; dimension size of the variable
  rank = dimsizes(dimv)     ; rank [ie: number of dimensions]
  delete(v)
  delete(dimv)
  delete(rank)
end do
end
