; Example of using panels with WRF data

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
  a1 = addfile("/data3/tabish/vert-MEIC-emis/wrfchemi_00z_d01_total_Oct.nc","r")
  a2 = addfile("/data3/tabish/vert-MEIC-emis/wrfchemi_12z_d01_total_Oct.nc","r")
    
  ald  = (1.0/24.0)*(a1->E_ALD(0,0,:,:) + a1->E_ALD(1,0,:,:) + a1->E_ALD(2,0,:,:) + a1->E_ALD(3,0,:,:) + a1->E_ALD(4,0,:,:) + a1->E_ALD(5,0,:,:) + a1->E_ALD(6,0,:,:) + a1->E_ALD(7,0,:,:) + a1->E_ALD(8,0,:,:) + a1->E_ALD(9,0,:,:) + a1->E_ALD(10,0,:,:) + a1->E_ALD(11,0,:,:) + a2->E_ALD(0,0,:,:) + a2->E_ALD(1,0,:,:) + a2->E_ALD(2,0,:,:) + a2->E_ALD(3,0,:,:) + a2->E_ALD(4,0,:,:) + a2->E_ALD(5,0,:,:) + a2->E_ALD(6,0,:,:) + a2->E_ALD(7,0,:,:) + a2->E_ALD(8,0,:,:) + a2->E_ALD(9,0,:,:) + a2->E_ALD(10,0,:,:) + a2->E_ALD(11,0,:,:))   
  ket = a1->E_KET(0,0,:,:)
  
  chinaket = where(ald.ne.0,ket,0) 
aldsum = sum(ald)   
ketsum = sum(ket)
chinaketsum =sum(chinaket)   

print ("aldsum="+aldsum + " ketsum="+ketsum+ " chinaketsum="+chinaketsum)
end




