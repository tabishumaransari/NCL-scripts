;THIS SCRIPT WRITES A LANDMASK FOR THE SPECIFIED PROVINCES TO A NEW NETCDF FILE

; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "./shapefile_utils.ncl"

begin
;  wrf_filename  = "/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Oct_BTHonly.nc"
  shp_filename1 = "/home/tabish/china-shapefile/CHN_adm1.shp"    ; State outlines
  shp_filename2 = "/home/tabish/china-shapefile/CHN_adm2.shp"    ; County outlines
  a1 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2.nc","r")
  a2 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Nov_8lev_0.5BTHso2.nc","r")
  a3 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2.nc","r")
  
   c = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","w")
 ;  c = addfile("APECmask.nc","w")
 
;---Read any 4d variable and lat/lon coordinates off wrfchemi file.
  emis1 = a1->E_SO2
  emis2 = a2->E_SO2
  emis3 = a3->E_SO2
  
  so2_t0_l0_d01       = a1->E_SO2(0,0,:,:)
  so2_t0_l0_d01@lat2d = a1->XLAT(:,:)
  so2_t0_l0_d01@lon2d = a1->XLONG(:,:)

  so2_t0_l0_d02       = a2->E_SO2(0,0,:,:)
  so2_t0_l0_d02@lat2d = a2->XLAT(:,:)
  so2_t0_l0_d02@lon2d = a2->XLONG(:,:)

  so2_t0_l0_d03       = a3->E_SO2(0,0,:,:)
  so2_t0_l0_d03@lat2d = a3->XLAT(:,:)
  so2_t0_l0_d03@lon2d = a3->XLONG(:,:)


;---Set all emission values to 0 except for those over areas of interest which will be equal to 1.
  opt             = True
  opt@debug       = True
 ;opt@shape_var   = "NAME_1"
  opt@shape_var   = "NAME_2"
 ; areas_of_interest = (/"Beijing","Hebei","Tianjin"/)
 ; areas_of_interest = (/"Beijing"/)
 ; areas_of_interest = (/"Hebei","Tianjin"/)
   areas_of_interest = (/"Beijing","Langfang","Baoding","Tianjin","Tangshan","Cangzhou","Shijiazhuang","Hengshui","Dezhou","Binzhou","Dongying","Xingtai","Handan","Liaocheng","Jinan","Zibo"/)
 ; areas_of_interest = (/"Beijing","Langfang","Baoding","Shijiazhuang","Xingtai","Handan"/)
  opt@shape_names = areas_of_interest
  opt@return_mask = True ; THIS RETURNS A MATRIX OF 0 AND 1 INSTEAD OF MASKED DATA
  print("masking D01 data...")
  emis_mask_d01    = shapefile_mask_data(so2_t0_l0_d01,shp_filename2,opt)
  print("masking D02 data...")
  emis_mask_d02    = shapefile_mask_data(so2_t0_l0_d02,shp_filename2,opt)
  print("masking D03 data...")
  emis_mask_d03    = shapefile_mask_data(so2_t0_l0_d03,shp_filename2,opt)
  
  emis_mask_d01_4d = conform_dims(dimsizes(emis1),emis_mask_d01,(/2,3/)) ;
  emis_mask_d02_4d = conform_dims(dimsizes(emis2),emis_mask_d02,(/2,3/)) ;
  emis_mask_d03_4d = conform_dims(dimsizes(emis3),emis_mask_d03,(/2,3/)) ;
  
  c->APEC2mask_d01 = emis_mask_d01_4d
  c->APEC2mask_d02 = emis_mask_d02_4d
  c->APEC2mask_d03 = emis_mask_d03_4d
print("Success!!!")
end

