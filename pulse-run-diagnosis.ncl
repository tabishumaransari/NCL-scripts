begin
a1 = addfile("/data2/tabish/control-run-so4-ECMWF/wrfout_d03_2014-10-17_010000.nc","r")
;a2 = addfile("/rasher/tabish/pulse-runs/BeijingOct18/subset_d03_2014-10-17_010000.nc","r")
a2 = addfile("/rasher/tabish/pulse-runs/subset_d03_2014-10-17_010000.nc","r")

pm25_sim_a1    = a1->co(:,0,145,79)
pm25_sim_a2    = a2->co(:,0,145,79)

print("baseline="+1000*pm25_sim_a1+" pulse="+1000*pm25_sim_a2)
end
