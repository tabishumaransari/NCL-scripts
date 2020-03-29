begin
a_agri = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_00z_d01_agri_Nov.nc","r")
a_ind = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_00z_d01_ind_Nov.nc","r")
a_pow = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_00z_d01_pow_Nov.nc","r")
a_tran = addfile("/data3/tabish/vert-MEIC-emis/8lev-sectoralemis-transformed/wrfchemi_00z_d01_tran_Nov.nc","r")

b = addfile("/data3/tabish/vert-MEIC-emis/APEC-wrfchemi/wrfchemi_00z_d01_total_","w")
c = addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","r")


end
