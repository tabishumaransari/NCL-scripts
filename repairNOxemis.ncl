;THIS SCRIPTS RESTORES ORIGINAL VALUES OF 8LEV NOX EMISSIONS IN WRFCHEMI FILES
begin
a1=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a2=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a3=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a4=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a5=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a6=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Nov_8lev_0.5BTHso2_0.7Bnox.nc","w")
a7=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d01_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
a8=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d02_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
a9=addfile("/data3/tabish/wrfchemi-management/wrfchemi_00z_d03_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
a10=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d01_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
a11=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d02_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
a12=addfile("/data3/tabish/wrfchemi-management/wrfchemi_12z_d03_total_Oct_8lev_0.5BTHso2_0.7Bnox.nc","w")
b1=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d01_total_Nov.nc","r")
b2=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d02_total_Nov.nc","r")
b3=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_total_Nov.nc","r")
b4=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d01_total_Nov.nc","r")
b5=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d02_total_Nov.nc","r")
b6=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d03_total_Nov.nc","r")
b7=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d01_total_Oct.nc","r")
b8=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d02_total_Oct.nc","r")
b9=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_00z_d03_total_Oct.nc","r")
b10=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d01_total_Oct.nc","r")
b11=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d02_total_Oct.nc","r")
b12=addfile("/data3/tabish/vert-MEIC-emis/8lev-emissions/wrfchemi_12z_d03_total_Oct.nc","r")

a1->E_NO2 = b1->E_NO2
a2->E_NO2 = b2->E_NO2
a3->E_NO2 = b3->E_NO2
a4->E_NO2 = b4->E_NO2
a5->E_NO2 = b5->E_NO2
a6->E_NO2 = b6->E_NO2
a7->E_NO2 = b7->E_NO2
a8->E_NO2 = b8->E_NO2
a9->E_NO2 = b9->E_NO2
a10->E_NO2 = b10->E_NO2
a11->E_NO2 = b11->E_NO2
a12->E_NO2 = b12->E_NO2

a1->E_NO = b1->E_NO
a2->E_NO = b2->E_NO
a3->E_NO = b3->E_NO
a4->E_NO = b4->E_NO
a5->E_NO = b5->E_NO
a6->E_NO = b6->E_NO
a7->E_NO = b7->E_NO
a8->E_NO = b8->E_NO
a9->E_NO = b9->E_NO
a10->E_NO = b10->E_NO
a11->E_NO = b11->E_NO
a12->E_NO = b12->E_NO

print("Success!")
end
