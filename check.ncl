begin
a= addfile("wrfchemi_00z_d02_MEIC-comparison","w")
E_PM_25_timesum = a->E_PM_25(0,0,:,:)

do i=1,23
 E_PM_25_timesum = E_PM_25_timesum + a->E_PM_25(i,0,:,:)
end do

 E_PM_25_timeavg = E_PM_25_timesum / 24.0


a->E_PM_25_timeavg = E_PM_25_timeavg
print("Success!!")
end
