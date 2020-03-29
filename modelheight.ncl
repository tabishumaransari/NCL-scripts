load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

nlvmax=31

f = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-10-25_010000.nc","r")
;f = addfile("wrfout_d03_150s_chemdt30m","r")

Z = wrf_user_getvar(f,"height", -1) ;m Model Height
Zter = wrf_user_getvar(f,"ter" , -1) ;m Terrain Height

;Zcat = Z(:,0:nlvmax-1,:,:)
Zcat=Z
do kk = 0, nlvmax-1
    Zcat(:,kk,:,:) = Zcat(:,kk,:,:) - Zter
end do

print(Zcat(0,:,144,79))
