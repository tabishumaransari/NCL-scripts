;ONLY FOR AOTIZHONGXIN FOR NOx
; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
DATADir1  = "/data2/tabish/control-run-so4-ECMWF/forpulse8nov/"
DATADir2 = "/rasher/tabish/pulse-runs/BeijingNov8/"

FILES1   = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2   = systemfunc (" ls -1 " + DATADir2 + "subset_d03_2014-* ")

a1  = addfiles(FILES1,"r")
a2  = addfiles(FILES2,"r")

;oin_baseline=a1[:]->oin_a01(:,0,144,79) + a1[:]->oin_a02(:,0,144,79) + a1[:]->oin_a03(:,0,144,79)+ a1[:]->oin_a04(:,0,144,79)+ a1[:]->oin_a05(:,0,144,79)+ a1[:]->oin_a06(:,0,144,79)+ a1[:]->oin_a07(:,0,144,79)+ a1[:]->oin_a08(:,0,144,79)
;oin_pulse   =a2[:]->oin_a01(:,0,144,79) + a2[:]->oin_a02(:,0,144,79) + a2[:]->oin_a03(:,0,144,79)+ a2[:]->oin_a04(:,0,144,79)+ a2[:]->oin_a05(:,0,144,79)+ a2[:]->oin_a06(:,0,144,79)+ a2[:]->oin_a07(:,0,144,79)+ a2[:]->oin_a08(:,0,144,79)

pm25_baseline  = a1[:]->PM2_5_DRY(:,0,144,79)
pm25_pulse     = a2[:]->PM2_5_DRY(:,0,144,79)

print(pm25_baseline+"	"+pm25_pulse)
;print(co_baseline+"	"+co_pulse)
;print(pm25_baseline-pm25_pulse)
end
