load "./shapefile_utils.ncl"
;sname = "/home/tabish/china-shapefile/CHN_adm2.shp"
sname = "/media/tabish/DataDisk/LEC_desktopbackup_23092019/nclscripts/ROI-shapefile/gadm36_IRL_0.shp"
f = addfile(sname,"r")
print_shapefile_info(sname)
shapename1 = f->NAME_0
;shapename2 = f->NAME_3
;shapename = f->NAME_2
print(shapename1)
;plot_shapefile(sname)
