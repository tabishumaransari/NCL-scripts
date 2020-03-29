undef("compcompare")
function compcompare(a,I,J)
begin
p  = a[:]->P(:,0,J,I)
pb = a[:]->PB(:,0,J,I)
t2 = a[:]->T2(:,J,I)
d = ((p+pb)/(287.058*t2))
PM25 = a[:]->PM2_5_DRY(:,0,J,I)
oc = a[:]->oc_a01(:,0,J,I) + a[:]->oc_a02(:,0,J,I) + a[:]->oc_a03(:,0,J,I) + a[:]->oc_a04(:,0,J,I) + a[:]->oc_a05(:,0,J,I) + a[:]->oc_a06(:,0,J,I)
bc = a[:]->bc_a01(:,0,J,I) + a[:]->bc_a02(:,0,J,I) + a[:]->bc_a03(:,0,J,I) + a[:]->bc_a04(:,0,J,I) + a[:]->bc_a05(:,0,J,I) + a[:]->bc_a06(:,0,J,I)
no3 = a[:]->no3_a01(:,0,J,I) + a[:]->no3_a02(:,0,J,I) + a[:]->no3_a03(:,0,J,I) + a[:]->no3_a04(:,0,J,I) + a[:]->no3_a05(:,0,J,I) + a[:]->no3_a06(:,0,J,I)
nh4 = a[:]->nh4_a01(:,0,J,I) + a[:]->nh4_a02(:,0,J,I) + a[:]->nh4_a03(:,0,J,I) + a[:]->nh4_a04(:,0,J,I) + a[:]->nh4_a05(:,0,J,I) + a[:]->nh4_a06(:,0,J,I)
so4 = a[:]->so4_a01(:,0,J,I) + a[:]->so4_a02(:,0,J,I) + a[:]->so4_a03(:,0,J,I) + a[:]->so4_a04(:,0,J,I) + a[:]->so4_a05(:,0,J,I) + a[:]->so4_a06(:,0,J,I)
na = a[:]->na_a01(:,0,J,I) + a[:]->na_a02(:,0,J,I) + a[:]->na_a03(:,0,J,I) + a[:]->na_a04(:,0,J,I) + a[:]->na_a05(:,0,J,I) + a[:]->na_a06(:,0,J,I)
cl = a[:]->cl_a01(:,0,J,I) + a[:]->cl_a02(:,0,J,I) + a[:]->cl_a03(:,0,J,I) + a[:]->cl_a04(:,0,J,I) + a[:]->cl_a05(:,0,J,I) + a[:]->cl_a06(:,0,J,I)
oin = a[:]->oin_a01(:,0,J,I) + a[:]->oin_a02(:,0,J,I) + a[:]->oin_a03(:,0,J,I) + a[:]->oin_a04(:,0,J,I) + a[:]->oin_a05(:,0,J,I) + a[:]->oin_a06(:,0,J,I)
len = dimsizes(oc)

do i=0,len-1
 oc(i) = oc(i) * d(i)
 bc(i) = bc(i) * d(i)
 no3(i) = no3(i) * d(i)
 nh4(i) = nh4(i) * d(i)
 so4(i) = so4(i) * d(i)
 na(i) = na(i) * d(i)
 cl(i) = cl(i) * d(i)
 oin(i) = oin(i) * d(i)
end do

total= oc+bc+no3+nh4+so4+na+cl+oin
return([/oc,bc,no3,nh4,so4,na,cl,oin,total,PM25/])
end




;MAIN PROGRAM
begin
DATADir1 = "/data2/tabish/control-run-so4-ECMWF/23-25oct/"
DATADir2 = "/data2/tabish/what-if_run/23-25oct/"
FILES1 = systemfunc (" ls -1 " + DATADir1 + "wrfout_d03_2014-* ")
FILES2 = systemfunc (" ls -1 " + DATADir2 + "wrfout_d03_2014-* ")
a = addfiles(FILES1,"r")
b = addfiles(FILES2,"r")
var1 = compcompare(a,79,144) ;INITIALIZING WITH FIRST STATION VALUES
var2 = compcompare(b,79,144) ;INITIALIZING WITH FIRST STATION VALUES
oc_a  =var1[0]
bc_a  =var1[1]
no3_a =var1[2]
nh4_a =var1[3]
so4_a =var1[4]
na_a  =var1[5]
cl_a  =var1[6]
oin_a =var1[7]
total_a =var1[8]
PM25_a  =var1[9]

oc_b  =var2[0]
bc_b  =var2[1]
no3_b =var2[2]
nh4_b =var2[3]
so4_b =var2[4]
na_b  =var2[5]
cl_b  =var2[6]
oin_b =var2[7]
total_b =var2[8]
PM25_b  =var2[9]


;print(oc+"	"+bc+"	"+no3+"	"+nh4+"	"+so4+"	"+na+"	"+cl+"	"+oin+"	"+total+"	"+PM25)
Iarr = (/79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/141,155,144,141,144,143,145,151,160,152,142/)

do count=0,10
 I = Iarr(count)
 J = Jarr(count)
 print(I + "," + J)
 var1 = compcompare(a,I,J)
 var2 = compcompare(b,I,J)
 oc_a  = oc_a + var1[0]
 bc_a  = bc_a + var1[1]
 no3_a = no3_a + var1[2]
 nh4_a = nh4_a + var1[3]
 so4_a = so4_a + var1[4]
 na_a  = na_a + var1[5]
 cl_a  = cl_a + var1[6]
 oin_a = oin_a + var1[7]
 total_a = total_a + var1[8]
 PM25_a  = PM25_a + var1[9]

 oc_b  = oc_b + var2[0]
 bc_b  = bc_b + var2[1]
 no3_b = no3_b + var2[2]
 nh4_b = nh4_b + var2[3]
 so4_b = so4_b + var2[4]
 na_b  = na_b + var2[5]
 cl_b  = cl_b + var2[6]
 oin_b = oin_b + var2[7]
 total_b = total_b + var2[8]
 PM25_b  = PM25_b + var2[9]

end do

 oc_a  = oc_a/12.0
 bc_a  = bc_a/12.0 
 no3_a = no3_a/12.0 
 nh4_a = nh4_a/12.0 
 so4_a = so4_a/12.0 
 na_a  = na_a/12.0 
 cl_a  = cl_a/12.0 
 oin_a = oin_a/12.0 
 total_a = total_a/12.0 
 PM25_a  = PM25_a/12.0 

cl_a = where(cl_a.eq.0.0,cl_a@_FillValue,cl_a)



 oc_b  = oc_b/12.0
 bc_b  = bc_b/12.0
 no3_b = no3_b/12.0
 nh4_b = nh4_b/12.0
 so4_b = so4_b/12.0
 na_b  = na_b/12.0
 cl_b  = cl_b/12.0
 oin_b = oin_b/12.0
 total_b = total_b/12.0
 PM25_b  = PM25_b/12.0

oc_benefit = 100.0* (oc_a - oc_b)/oc_a
bc_benefit = 100.0* (bc_a - bc_b)/bc_a
no3_benefit = 100.0* (no3_a - no3_b)/no3_a
nh4_benefit = 100.0* (nh4_a - nh4_b)/nh4_a
so4_benefit = 100.0* (so4_a - so4_b)/so4_a
na_benefit = 100.0* (na_a - na_b)/na_a
cl_benefit = 100.0* (cl_a - cl_b)/cl_a
oin_benefit = 100.0* (oin_a - oin_b)/oin_a
total_benefit = 100.0* (total_a - total_b)/total_a
PM25_benefit = 100.0* (PM25_a - PM25_b)/PM25_a


;print(oc_benefit+"	"+bc_benefit+"	"+no3_benefit+"	"+nh4_benefit+"	"+so4_benefit+"	"+na_benefit+"	"+cl_benefit+"	"+oin_benefit+"	"+total_benefit+"	"+PM25_benefit)
print(oc_a+"	"+bc_a+"	"+no3_a+"	"+nh4_a+"	"+so4_a+"	"+na_a+"	"+cl_a+"	"+oin_a+"	"+total_a+"	"+PM25_a)

end
