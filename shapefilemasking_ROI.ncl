;THIS SCRIPT WRITES A LANDMASK FOR THE SPECIFIED PROVINCES TO A NEW NETCDF FILE

; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "./shapefile_utils.ncl"

begin
;  wrf_filename  = "/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Oct_BTHonly.nc"
  shp_filename0 =  "/media/tabish/DataDisk/LEC_desktopbackup_23092019/nclscripts/ROI-shapefile/gadm36_IRL_0.shp"    ; State outlines
  a1 = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d01.nc","r")
  a2 = addfile("/home/tabish/Downloads/mapeire-sita/wrfchemi_00z_d02.nc","r")
  c  = addfile("/home/tabish/Downloads/mapeire-sita/ROImask.nc","c")
 
;---Read any 4d variable and lat/lon coordinates off wrfchemi file.
  emis1 = a1->E_SO2
  emis2 = a2->E_SO2
  printVarSummary(emis1)  

  so2_t0_l0_d01       = a1->E_SO2(0,0,:,:)
  so2_t0_l0_d01@lat2d = a1->XLAT(:,:)
  so2_t0_l0_d01@lon2d = a1->XLONG(:,:)

  so2_t0_l0_d02       = a2->E_SO2(0,0,:,:)
  so2_t0_l0_d02@lat2d = a2->XLAT(:,:)
  so2_t0_l0_d02@lon2d = a2->XLONG(:,:)


;---Set all emission values to 0 except for those over areas of interest which will be equal to 1.
  opt             = True
  opt@debug       = True
  opt@shape_var   = "NAME_0"
  areas_of_interest = (/"Ireland"/)
  opt@shape_names = areas_of_interest
  opt@return_mask = True ; THIS RETURNS A MATRIX OF 0 AND 1 INSTEAD OF MASKED DATA
  print("masking D01 data...")
  emis_mask_d01    = shapefile_mask_data(so2_t0_l0_d01,shp_filename0,opt)
  print("masking D02 data...")
  emis_mask_d02    = shapefile_mask_data(so2_t0_l0_d02,shp_filename0,opt)
 
  emis_mask_d01_4d = conform_dims(dimsizes(emis1),emis_mask_d01,(/2,3/)) ;
  emis_mask_d02_4d = conform_dims(dimsizes(emis2),emis_mask_d02,(/2,3/)) ;
 
copy_VarAtts(emis1,emis_mask_d01_4d)    ; Copy metadata from so2 emissions to roimask
copy_VarAtts(emis2,emis_mask_d02_4d)    ; Copy metadata from so2 emissions to roimask
  

  c->ROImask_d01 = (/emis_mask_d01_4d/)
  c->ROImask_d02 = (/emis_mask_d02_4d/)


print("Success!!!")
end

