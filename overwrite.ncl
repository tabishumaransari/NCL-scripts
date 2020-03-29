begin
;Open a dummy file called wrfchemi_MEIC_d0x with EDGAR-HTAP emissions whose values will be eventually replaced

a= addfile("wrfchemi_00z_d02_MEIC-comparison","w")
b= addfile("MEIC_Oct_d02.nc","r")

E_CO_total = b->co(:,0,:,:) + b->co(:,1,:,:) + b->co(:,2,:,:)  + b->co(:,3,:,:) + b->co(:,4,:,:)
a->E_CO= (3600.0/28.0)*E_CO_total
;a->E_C2H4= (3600.0/28.0)*b->c2h4
;a->E_C2H6= (3600.0/30.0)*b->c2h6
;a->E_CH2O= (3600.0/30.0)*b->hcho
;a->E_CH3OH= (3600.0/32.0)*b->meoh
;a->E_NH3= (3600.0/17.0)*b->nh3
;a->E_NO= (3600.0/30.0)*b->no
;a->E_NO2= (3600.0/46.0)*b->no2
;a->E_SO2= (3600.0/64.0)*b->so2
;a->E_TOL= (3600.0/92.0)*b->tol

E_BC_total= b->bc(:,0,:,:) + b->bc(:,1,:,:)+ b->bc(:,2,:,:)+ b->bc(:,3,:,:)+ b->bc(:,4,:,:)
a->E_BC= E_BC_total

E_OC_total= b->oc(:,0,:,:) + b->oc(:,1,:,:)+ b->oc(:,2,:,:)+ b->oc(:,3,:,:)+ b->oc(:,4,:,:)
a->E_OC= E_OC_total

E_PM_25_total= E_OC_total + E_BC_total +  b->pm25(:,0,:,:) + b->pm25(:,1,:,:)+ b->pm25(:,2,:,:)+ b->pm25(:,3,:,:)+ b->pm25(:,4,:,:)
a->E_PM_25 = E_PM_25_total

E_PM_10_total= E_PM_25_total + b->pm10(:,0,:,:) +b->pm10(:,1,:,:) + b->pm10(:,2,:,:)+ b->pm10(:,3,:,:)+ b->pm10(:,4,:,:)
a->E_PM_10= E_PM_10_total
print("Success!!")
end
