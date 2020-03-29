begin
a1 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a2 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a3 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a4 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a5 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a6 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Nov_8lev_0.5so2_0.7nox.nc","w")
a7 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Oct_8lev_0.5so2_0.7nox.nc","w")
a8 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Oct_8lev_0.5so2_0.7nox.nc","w")
a9 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Oct_8lev_0.5so2_0.7nox.nc","w")
a10 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Oct_8lev_0.5so2_0.7nox.nc","w")
a11 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Oct_8lev_0.5so2_0.7nox.nc","w")
a12 = addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Oct_8lev_0.5so2_0.7nox.nc","w")

print("All files read. Now overwriting Ketone emissions")
a1->E_KET = 1.3377 * a1->E_ALD
a2->E_KET = 1.3377 * a2->E_ALD
a3->E_KET = 1.3377 * a3->E_ALD
a4->E_KET = 1.3377 * a4->E_ALD
a5->E_KET = 1.3377 * a5->E_ALD
a6->E_KET = 1.3377 * a6->E_ALD
a7->E_KET = 1.3377 * a7->E_ALD
a8->E_KET = 1.3377 * a8->E_ALD
a9->E_KET = 1.3377 * a9->E_ALD
a10->E_KET = 1.3377 * a10->E_ALD
a11->E_KET = 1.3377 * a11->E_ALD
a12->E_KET = 1.3377 * a12->E_ALD
print("E_KET overwritten in all files. Success!")

end
