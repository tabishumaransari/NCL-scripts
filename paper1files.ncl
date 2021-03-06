begin
begTime = get_cpu_time()
setfileoption("nc","Format","LargeFile")

DATADir = "/mnt/rasher/APEC2full/"
FILES1 = systemfunc (" ls -1 " + DATADir + "subset_d03* ")
print(FILES1)
a1 = addfiles(FILES1,"r")
b1 = addfile("/home/tabish/paper1files/fullAPEC2-surface_d03.nc","c")

b1->XLAT  = a1[:]->XLAT
b1->XLONG = a1[:]->XLONG

;b1->T2 = a1[:]->T2
;b1->U10 = a1[:]->U10
;b1->V10 = a1[:]->V10
;b1->PBLH = a1[:]->PBLH
b1->PM2_5_DRY = (/a1[:]->PM2_5_DRY(:,0,:,:)/)
b1->PM10 = (/a1[:]->PM10(:,0,:,:)/)
b1->so2 = (/a1[:]->so2(:,0,:,:)/)
b1->sulf = (/a1[:]->sulf(:,0,:,:)/)
b1->no2 = (/a1[:]->no2(:,0,:,:)/)
b1->no = (/a1[:]->no(:,0,:,:)/)
b1->o3 = (/a1[:]->o3(:,0,:,:)/)
b1->nh3 = (/a1[:]->nh3(:,0,:,:)/)
b1->no3 = (/a1[:]->no3(:,0,:,:)/)
b1->co = (/a1[:]->co(:,0,:,:)/)

b1->so4_a01 = (/a1[:]->so4_a01(:,0,:,:)/)
b1->so4_a02 = (/a1[:]->so4_a02(:,0,:,:)/)
b1->so4_a03 = (/a1[:]->so4_a03(:,0,:,:)/)
b1->so4_a04 = (/a1[:]->so4_a04(:,0,:,:)/)
b1->so4_a05 = (/a1[:]->so4_a05(:,0,:,:)/)
b1->so4_a06 = (/a1[:]->so4_a06(:,0,:,:)/)
b1->so4_a07 = (/a1[:]->so4_a07(:,0,:,:)/)
b1->so4_a08 = (/a1[:]->so4_a08(:,0,:,:)/)

b1->no3_a01 = (/a1[:]->no3_a01(:,0,:,:)/)
b1->no3_a02 = (/a1[:]->no3_a02(:,0,:,:)/)
b1->no3_a03 = (/a1[:]->no3_a03(:,0,:,:)/)
b1->no3_a04 = (/a1[:]->no3_a04(:,0,:,:)/)
b1->no3_a05 = (/a1[:]->no3_a05(:,0,:,:)/)
b1->no3_a06 = (/a1[:]->no3_a06(:,0,:,:)/)
b1->no3_a07 = (/a1[:]->no3_a07(:,0,:,:)/)
b1->no3_a08 = (/a1[:]->no3_a08(:,0,:,:)/)

b1->cl_a01 = (/a1[:]->cl_a01(:,0,:,:)/)
b1->cl_a02 = (/a1[:]->cl_a02(:,0,:,:)/)
b1->cl_a03 = (/a1[:]->cl_a03(:,0,:,:)/)
b1->cl_a04 = (/a1[:]->cl_a04(:,0,:,:)/)
b1->cl_a05 = (/a1[:]->cl_a05(:,0,:,:)/)
b1->cl_a06 = (/a1[:]->cl_a06(:,0,:,:)/)
b1->cl_a07 = (/a1[:]->cl_a07(:,0,:,:)/)
b1->cl_a08 = (/a1[:]->cl_a08(:,0,:,:)/)

b1->nh4_a01 = (/a1[:]->nh4_a01(:,0,:,:)/)
b1->nh4_a02 = (/a1[:]->nh4_a02(:,0,:,:)/)
b1->nh4_a03 = (/a1[:]->nh4_a03(:,0,:,:)/)
b1->nh4_a04 = (/a1[:]->nh4_a04(:,0,:,:)/)
b1->nh4_a05 = (/a1[:]->nh4_a05(:,0,:,:)/)
b1->nh4_a06 = (/a1[:]->nh4_a06(:,0,:,:)/)
b1->nh4_a07 = (/a1[:]->nh4_a07(:,0,:,:)/)
b1->nh4_a08 = (/a1[:]->nh4_a08(:,0,:,:)/)

b1->na_a01 = (/a1[:]->na_a01(:,0,:,:)/)
b1->na_a02 = (/a1[:]->na_a02(:,0,:,:)/)
b1->na_a03 = (/a1[:]->na_a03(:,0,:,:)/)
b1->na_a04 = (/a1[:]->na_a04(:,0,:,:)/)
b1->na_a05 = (/a1[:]->na_a05(:,0,:,:)/)
b1->na_a06 = (/a1[:]->na_a06(:,0,:,:)/)
b1->na_a07 = (/a1[:]->na_a07(:,0,:,:)/)
b1->na_a08 = (/a1[:]->na_a08(:,0,:,:)/)

b1->oc_a01 = (/a1[:]->oc_a01(:,0,:,:)/)
b1->oc_a02 = (/a1[:]->oc_a02(:,0,:,:)/)
b1->oc_a03 = (/a1[:]->oc_a03(:,0,:,:)/)
b1->oc_a04 = (/a1[:]->oc_a04(:,0,:,:)/)
b1->oc_a05 = (/a1[:]->oc_a05(:,0,:,:)/)
b1->oc_a06 = (/a1[:]->oc_a06(:,0,:,:)/)
b1->oc_a07 = (/a1[:]->oc_a07(:,0,:,:)/)
b1->oc_a08 = (/a1[:]->oc_a08(:,0,:,:)/)

b1->bc_a01 = (/a1[:]->bc_a01(:,0,:,:)/)
b1->bc_a02 = (/a1[:]->bc_a02(:,0,:,:)/)
b1->bc_a03 = (/a1[:]->bc_a03(:,0,:,:)/)
b1->bc_a04 = (/a1[:]->bc_a04(:,0,:,:)/)
b1->bc_a05 = (/a1[:]->bc_a05(:,0,:,:)/)
b1->bc_a06 = (/a1[:]->bc_a06(:,0,:,:)/)
b1->bc_a07 = (/a1[:]->bc_a07(:,0,:,:)/)
b1->bc_a08 = (/a1[:]->bc_a08(:,0,:,:)/)

print("Subsetting time: " + (get_cpu_time() - begTime)/60.0 +" minutes")
print("written file for domain 3")
;wallClockElapseTime(wcStrt, "Total Wallclock time", 0)





end
