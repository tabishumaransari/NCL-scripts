undef("usefullength") ; function name
function usefullength(a,total)
begin ; begin function
; print("New Iteration "+len+" "+total)
; print(a)
 ulen = 0 ; STARTING WITH AN INITIAL LENGTH OF BENEFITS OF ZERO HOURS
 do i = 0,119
   s = sum(a(0:i))
 ;  print(i+" "+ulen+" "+s+" "+total)
   if(s.lt.(0.98*total)) then
    ulen = i
   end if
  ; print(i+" "+ulen+" "+s+" "+total)
 end do
 return(ulen)
end ; end function


begin
ncol = 20
pm25_Beijing_Oct = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Oct = readAsciiTable("pm25_pulseruns_APEC2_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Oct = readAsciiTable("pm25_pulseruns_APEC3_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_Beijing_Nov = readAsciiTable("pm25_pulseruns_Beijing_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Nov = readAsciiTable("pm25_pulseruns_APEC2_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Nov = readAsciiTable("pm25_pulseruns_APEC3_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER


;;;;;;;;;;;;;;;;;;;FOR OCTOBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_Oct18B = pm25_Beijing_Oct(:,0)
pm25_Beijing_Oct18P = pm25_Beijing_Oct(:,1)
pm25_Beijing_Oct19B = pm25_Beijing_Oct(:,2)
pm25_Beijing_Oct19P = pm25_Beijing_Oct(:,3)
pm25_Beijing_Oct20B = pm25_Beijing_Oct(:,4)
pm25_Beijing_Oct20P = pm25_Beijing_Oct(:,5)
pm25_Beijing_Oct21B = pm25_Beijing_Oct(:,6)
pm25_Beijing_Oct21P = pm25_Beijing_Oct(:,7)
pm25_Beijing_Oct22B = pm25_Beijing_Oct(:,8)
pm25_Beijing_Oct22P = pm25_Beijing_Oct(:,9)
pm25_Beijing_Oct23B = pm25_Beijing_Oct(:,10)
pm25_Beijing_Oct23P = pm25_Beijing_Oct(:,11)
pm25_Beijing_Oct24B = pm25_Beijing_Oct(:,12)
pm25_Beijing_Oct24P = pm25_Beijing_Oct(:,13)
pm25_Beijing_Oct25B = pm25_Beijing_Oct(:,14)
pm25_Beijing_Oct25P = pm25_Beijing_Oct(:,15)
pm25_Beijing_Oct26B = pm25_Beijing_Oct(:,16)
pm25_Beijing_Oct26P = pm25_Beijing_Oct(:,17)
pm25_Beijing_Oct27B = pm25_Beijing_Oct(:,18)
pm25_Beijing_Oct27P = pm25_Beijing_Oct(:,19)

pm25_Beijing_Oct18_benefit = pm25_Beijing_Oct18B - pm25_Beijing_Oct18P
pm25_Beijing_Oct19_benefit = pm25_Beijing_Oct19B - pm25_Beijing_Oct19P
pm25_Beijing_Oct20_benefit = pm25_Beijing_Oct20B - pm25_Beijing_Oct20P
pm25_Beijing_Oct21_benefit = pm25_Beijing_Oct21B - pm25_Beijing_Oct21P
pm25_Beijing_Oct22_benefit = pm25_Beijing_Oct22B - pm25_Beijing_Oct22P
pm25_Beijing_Oct23_benefit = pm25_Beijing_Oct23B - pm25_Beijing_Oct23P
pm25_Beijing_Oct24_benefit = pm25_Beijing_Oct24B - pm25_Beijing_Oct24P
pm25_Beijing_Oct25_benefit = pm25_Beijing_Oct25B - pm25_Beijing_Oct25P
pm25_Beijing_Oct26_benefit = pm25_Beijing_Oct26B - pm25_Beijing_Oct26P
pm25_Beijing_Oct27_benefit = pm25_Beijing_Oct27B - pm25_Beijing_Oct27P



pm25_APEC2_Oct18B = pm25_APEC2_Oct(:,0)
pm25_APEC2_Oct18P = pm25_APEC2_Oct(:,1)
pm25_APEC2_Oct19B = pm25_APEC2_Oct(:,2)
pm25_APEC2_Oct19P = pm25_APEC2_Oct(:,3)
pm25_APEC2_Oct20B = pm25_APEC2_Oct(:,4)
pm25_APEC2_Oct20P = pm25_APEC2_Oct(:,5)
pm25_APEC2_Oct21B = pm25_APEC2_Oct(:,6)
pm25_APEC2_Oct21P = pm25_APEC2_Oct(:,7)
pm25_APEC2_Oct22B = pm25_APEC2_Oct(:,8)
pm25_APEC2_Oct22P = pm25_APEC2_Oct(:,9)
pm25_APEC2_Oct23B = pm25_APEC2_Oct(:,10)
pm25_APEC2_Oct23P = pm25_APEC2_Oct(:,11)
pm25_APEC2_Oct24B = pm25_APEC2_Oct(:,12)
pm25_APEC2_Oct24P = pm25_APEC2_Oct(:,13)
pm25_APEC2_Oct25B = pm25_APEC2_Oct(:,14)
pm25_APEC2_Oct25P = pm25_APEC2_Oct(:,15)
pm25_APEC2_Oct26B = pm25_APEC2_Oct(:,16)
pm25_APEC2_Oct26P = pm25_APEC2_Oct(:,17)
pm25_APEC2_Oct27B = pm25_APEC2_Oct(:,18)
pm25_APEC2_Oct27P = pm25_APEC2_Oct(:,19)
pm25_APEC2_Oct18_benefit = pm25_APEC2_Oct18B - pm25_APEC2_Oct18P
pm25_APEC2_Oct19_benefit = pm25_APEC2_Oct19B - pm25_APEC2_Oct19P
pm25_APEC2_Oct20_benefit = pm25_APEC2_Oct20B - pm25_APEC2_Oct20P
pm25_APEC2_Oct21_benefit = pm25_APEC2_Oct21B - pm25_APEC2_Oct21P
pm25_APEC2_Oct22_benefit = pm25_APEC2_Oct22B - pm25_APEC2_Oct22P
pm25_APEC2_Oct23_benefit = pm25_APEC2_Oct23B - pm25_APEC2_Oct23P
pm25_APEC2_Oct24_benefit = pm25_APEC2_Oct24B - pm25_APEC2_Oct24P
pm25_APEC2_Oct25_benefit = pm25_APEC2_Oct25B - pm25_APEC2_Oct25P
pm25_APEC2_Oct26_benefit = pm25_APEC2_Oct26B - pm25_APEC2_Oct26P
pm25_APEC2_Oct27_benefit = pm25_APEC2_Oct27B - pm25_APEC2_Oct27P


pm25_APEC3_Oct18B = pm25_APEC3_Oct(:,0)
pm25_APEC3_Oct18P = pm25_APEC3_Oct(:,1)
pm25_APEC3_Oct19B = pm25_APEC3_Oct(:,2)
pm25_APEC3_Oct19P = pm25_APEC3_Oct(:,3)
pm25_APEC3_Oct20B = pm25_APEC3_Oct(:,4)
pm25_APEC3_Oct20P = pm25_APEC3_Oct(:,5)
pm25_APEC3_Oct21B = pm25_APEC3_Oct(:,6)
pm25_APEC3_Oct21P = pm25_APEC3_Oct(:,7)
pm25_APEC3_Oct22B = pm25_APEC3_Oct(:,8)
pm25_APEC3_Oct22P = pm25_APEC3_Oct(:,9)
pm25_APEC3_Oct23B = pm25_APEC3_Oct(:,10)
pm25_APEC3_Oct23P = pm25_APEC3_Oct(:,11)
pm25_APEC3_Oct24B = pm25_APEC3_Oct(:,12)
pm25_APEC3_Oct24P = pm25_APEC3_Oct(:,13)
pm25_APEC3_Oct25B = pm25_APEC3_Oct(:,14)
pm25_APEC3_Oct25P = pm25_APEC3_Oct(:,15)
pm25_APEC3_Oct26B = pm25_APEC3_Oct(:,16)
pm25_APEC3_Oct26P = pm25_APEC3_Oct(:,17)
pm25_APEC3_Oct27B = pm25_APEC3_Oct(:,18)
pm25_APEC3_Oct27P = pm25_APEC3_Oct(:,19)
pm25_APEC3_Oct18_benefit = pm25_APEC3_Oct18B - pm25_APEC3_Oct18P
pm25_APEC3_Oct19_benefit = pm25_APEC3_Oct19B - pm25_APEC3_Oct19P
pm25_APEC3_Oct20_benefit = pm25_APEC3_Oct20B - pm25_APEC3_Oct20P
pm25_APEC3_Oct21_benefit = pm25_APEC3_Oct21B - pm25_APEC3_Oct21P
pm25_APEC3_Oct22_benefit = pm25_APEC3_Oct22B - pm25_APEC3_Oct22P
pm25_APEC3_Oct23_benefit = pm25_APEC3_Oct23B - pm25_APEC3_Oct23P
pm25_APEC3_Oct24_benefit = pm25_APEC3_Oct24B - pm25_APEC3_Oct24P
pm25_APEC3_Oct25_benefit = pm25_APEC3_Oct25B - pm25_APEC3_Oct25P
pm25_APEC3_Oct26_benefit = pm25_APEC3_Oct26B - pm25_APEC3_Oct26P
pm25_APEC3_Oct27_benefit = pm25_APEC3_Oct27B - pm25_APEC3_Oct27P


;;;;;;;;;;;FOR NOVEMBER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_Nov2B = pm25_Beijing_Nov(:,0)
pm25_Beijing_Nov2P = pm25_Beijing_Nov(:,1)
pm25_Beijing_Nov3B = pm25_Beijing_Nov(:,2)
pm25_Beijing_Nov3P = pm25_Beijing_Nov(:,3)
pm25_Beijing_Nov4B = pm25_Beijing_Nov(:,4)
pm25_Beijing_Nov4P = pm25_Beijing_Nov(:,5)
pm25_Beijing_Nov5B = pm25_Beijing_Nov(:,6)
pm25_Beijing_Nov5P = pm25_Beijing_Nov(:,7)
pm25_Beijing_Nov6B = pm25_Beijing_Nov(:,8)
pm25_Beijing_Nov6P = pm25_Beijing_Nov(:,9)
pm25_Beijing_Nov7B = pm25_Beijing_Nov(:,10)
pm25_Beijing_Nov7P = pm25_Beijing_Nov(:,11)
pm25_Beijing_Nov8B = pm25_Beijing_Nov(:,12)
pm25_Beijing_Nov8P = pm25_Beijing_Nov(:,13)
pm25_Beijing_Nov9B = pm25_Beijing_Nov(:,14)
pm25_Beijing_Nov9P = pm25_Beijing_Nov(:,15)
pm25_Beijing_Nov10B = pm25_Beijing_Nov(:,16)
pm25_Beijing_Nov10P = pm25_Beijing_Nov(:,17)
pm25_Beijing_Nov11B = pm25_Beijing_Nov(:,18)
pm25_Beijing_Nov11P = pm25_Beijing_Nov(:,19)
pm25_Beijing_Nov2_benefit = pm25_Beijing_Nov2B - pm25_Beijing_Nov2P
pm25_Beijing_Nov3_benefit = pm25_Beijing_Nov3B - pm25_Beijing_Nov3P
pm25_Beijing_Nov4_benefit = pm25_Beijing_Nov4B - pm25_Beijing_Nov4P
pm25_Beijing_Nov5_benefit = pm25_Beijing_Nov5B - pm25_Beijing_Nov5P
pm25_Beijing_Nov6_benefit = pm25_Beijing_Nov6B - pm25_Beijing_Nov6P
pm25_Beijing_Nov7_benefit = pm25_Beijing_Nov7B - pm25_Beijing_Nov7P
pm25_Beijing_Nov8_benefit = pm25_Beijing_Nov8B - pm25_Beijing_Nov8P
pm25_Beijing_Nov9_benefit = pm25_Beijing_Nov9B - pm25_Beijing_Nov9P
pm25_Beijing_Nov10_benefit = pm25_Beijing_Nov10B - pm25_Beijing_Nov10P
pm25_Beijing_Nov11_benefit = pm25_Beijing_Nov11B - pm25_Beijing_Nov11P

pm25_APEC2_Nov2B = pm25_APEC2_Nov(:,0)
pm25_APEC2_Nov2P = pm25_APEC2_Nov(:,1)
pm25_APEC2_Nov3B = pm25_APEC2_Nov(:,2)
pm25_APEC2_Nov3P = pm25_APEC2_Nov(:,3)
pm25_APEC2_Nov4B = pm25_APEC2_Nov(:,4)
pm25_APEC2_Nov4P = pm25_APEC2_Nov(:,5)
pm25_APEC2_Nov5B = pm25_APEC2_Nov(:,6)
pm25_APEC2_Nov5P = pm25_APEC2_Nov(:,7)
pm25_APEC2_Nov6B = pm25_APEC2_Nov(:,8)
pm25_APEC2_Nov6P = pm25_APEC2_Nov(:,9)
pm25_APEC2_Nov7B = pm25_APEC2_Nov(:,10)
pm25_APEC2_Nov7P = pm25_APEC2_Nov(:,11)
pm25_APEC2_Nov8B = pm25_APEC2_Nov(:,12)
pm25_APEC2_Nov8P = pm25_APEC2_Nov(:,13)
pm25_APEC2_Nov9B = pm25_APEC2_Nov(:,14)
pm25_APEC2_Nov9P = pm25_APEC2_Nov(:,15)
pm25_APEC2_Nov10B = pm25_APEC2_Nov(:,16)
pm25_APEC2_Nov10P = pm25_APEC2_Nov(:,17)
pm25_APEC2_Nov11B = pm25_APEC2_Nov(:,18)
pm25_APEC2_Nov11P = pm25_APEC2_Nov(:,19)
pm25_APEC2_Nov2_benefit = pm25_APEC2_Nov2B - pm25_APEC2_Nov2P
pm25_APEC2_Nov3_benefit = pm25_APEC2_Nov3B - pm25_APEC2_Nov3P
pm25_APEC2_Nov4_benefit = pm25_APEC2_Nov4B - pm25_APEC2_Nov4P
pm25_APEC2_Nov5_benefit = pm25_APEC2_Nov5B - pm25_APEC2_Nov5P
pm25_APEC2_Nov6_benefit = pm25_APEC2_Nov6B - pm25_APEC2_Nov6P
pm25_APEC2_Nov7_benefit = pm25_APEC2_Nov7B - pm25_APEC2_Nov7P
pm25_APEC2_Nov8_benefit = pm25_APEC2_Nov8B - pm25_APEC2_Nov8P
pm25_APEC2_Nov9_benefit = pm25_APEC2_Nov9B - pm25_APEC2_Nov9P
pm25_APEC2_Nov10_benefit = pm25_APEC2_Nov10B - pm25_APEC2_Nov10P
pm25_APEC2_Nov11_benefit = pm25_APEC2_Nov11B - pm25_APEC2_Nov11P

pm25_APEC3_Nov2B = pm25_APEC3_Nov(:,0)
pm25_APEC3_Nov2P = pm25_APEC3_Nov(:,1)
pm25_APEC3_Nov3B = pm25_APEC3_Nov(:,2)
pm25_APEC3_Nov3P = pm25_APEC3_Nov(:,3)
pm25_APEC3_Nov4B = pm25_APEC3_Nov(:,4)
pm25_APEC3_Nov4P = pm25_APEC3_Nov(:,5)
pm25_APEC3_Nov5B = pm25_APEC3_Nov(:,6)
pm25_APEC3_Nov5P = pm25_APEC3_Nov(:,7)
pm25_APEC3_Nov6B = pm25_APEC3_Nov(:,8)
pm25_APEC3_Nov6P = pm25_APEC3_Nov(:,9)
pm25_APEC3_Nov7B = pm25_APEC3_Nov(:,10)
pm25_APEC3_Nov7P = pm25_APEC3_Nov(:,11)
pm25_APEC3_Nov8B = pm25_APEC3_Nov(:,12)
pm25_APEC3_Nov8P = pm25_APEC3_Nov(:,13)
pm25_APEC3_Nov9B = pm25_APEC3_Nov(:,14)
pm25_APEC3_Nov9P = pm25_APEC3_Nov(:,15)
pm25_APEC3_Nov10B = pm25_APEC3_Nov(:,16)
pm25_APEC3_Nov10P = pm25_APEC3_Nov(:,17)
pm25_APEC3_Nov11B = pm25_APEC3_Nov(:,18)
pm25_APEC3_Nov11P = pm25_APEC3_Nov(:,19)
pm25_APEC3_Nov2_benefit = pm25_APEC3_Nov2B - pm25_APEC3_Nov2P
pm25_APEC3_Nov3_benefit = pm25_APEC3_Nov3B - pm25_APEC3_Nov3P
pm25_APEC3_Nov4_benefit = pm25_APEC3_Nov4B - pm25_APEC3_Nov4P
pm25_APEC3_Nov5_benefit = pm25_APEC3_Nov5B - pm25_APEC3_Nov5P
pm25_APEC3_Nov6_benefit = pm25_APEC3_Nov6B - pm25_APEC3_Nov6P
pm25_APEC3_Nov7_benefit = pm25_APEC3_Nov7B - pm25_APEC3_Nov7P
pm25_APEC3_Nov8_benefit = pm25_APEC3_Nov8B - pm25_APEC3_Nov8P
pm25_APEC3_Nov9_benefit = pm25_APEC3_Nov9B - pm25_APEC3_Nov9P
pm25_APEC3_Nov10_benefit = pm25_APEC3_Nov10B - pm25_APEC3_Nov10P
pm25_APEC3_Nov11_benefit = pm25_APEC3_Nov11B - pm25_APEC3_Nov11P


pm25_Beijing_matrix = new((/20,120/),float)
pm25_APEC2_matrix   = new((/20,120/),float)
pm25_APEC3_matrix   = new((/20,120/),float)

parameters   = new((/20,12/),float)

pm25_Beijing_matrix(0,:) = pm25_Beijing_Oct18_benefit
pm25_Beijing_matrix(1,:) = pm25_Beijing_Oct19_benefit
pm25_Beijing_matrix(2,:) = pm25_Beijing_Oct20_benefit
pm25_Beijing_matrix(3,:) = pm25_Beijing_Oct21_benefit
pm25_Beijing_matrix(4,:) = pm25_Beijing_Oct22_benefit
pm25_Beijing_matrix(5,:) = pm25_Beijing_Oct23_benefit
pm25_Beijing_matrix(6,:) = pm25_Beijing_Oct24_benefit
pm25_Beijing_matrix(7,:) = pm25_Beijing_Oct25_benefit
pm25_Beijing_matrix(8,:) = pm25_Beijing_Oct26_benefit
pm25_Beijing_matrix(9,:) = pm25_Beijing_Oct27_benefit
pm25_Beijing_matrix(10,:) = pm25_Beijing_Nov2_benefit
pm25_Beijing_matrix(11,:) = pm25_Beijing_Nov3_benefit
pm25_Beijing_matrix(12,:) = pm25_Beijing_Nov4_benefit
pm25_Beijing_matrix(13,:) = pm25_Beijing_Nov5_benefit
pm25_Beijing_matrix(14,:) = pm25_Beijing_Nov6_benefit
pm25_Beijing_matrix(15,:) = pm25_Beijing_Nov7_benefit
pm25_Beijing_matrix(16,:) = pm25_Beijing_Nov8_benefit
pm25_Beijing_matrix(17,:) = pm25_Beijing_Nov9_benefit
pm25_Beijing_matrix(18,:) = pm25_Beijing_Nov10_benefit
pm25_Beijing_matrix(19,:) = pm25_Beijing_Nov11_benefit

pm25_APEC2_matrix(0,:) = pm25_APEC2_Oct18_benefit
pm25_APEC2_matrix(1,:) = pm25_APEC2_Oct19_benefit
pm25_APEC2_matrix(2,:) = pm25_APEC2_Oct20_benefit
pm25_APEC2_matrix(3,:) = pm25_APEC2_Oct21_benefit
pm25_APEC2_matrix(4,:) = pm25_APEC2_Oct22_benefit
pm25_APEC2_matrix(5,:) = pm25_APEC2_Oct23_benefit
pm25_APEC2_matrix(6,:) = pm25_APEC2_Oct24_benefit
pm25_APEC2_matrix(7,:) = pm25_APEC2_Oct25_benefit
pm25_APEC2_matrix(8,:) = pm25_APEC2_Oct26_benefit
pm25_APEC2_matrix(9,:) = pm25_APEC2_Oct27_benefit
pm25_APEC2_matrix(10,:) = pm25_APEC2_Nov2_benefit
pm25_APEC2_matrix(11,:) = pm25_APEC2_Nov3_benefit
pm25_APEC2_matrix(12,:) = pm25_APEC2_Nov4_benefit
pm25_APEC2_matrix(13,:) = pm25_APEC2_Nov5_benefit
pm25_APEC2_matrix(14,:) = pm25_APEC2_Nov6_benefit
pm25_APEC2_matrix(15,:) = pm25_APEC2_Nov7_benefit
pm25_APEC2_matrix(16,:) = pm25_APEC2_Nov8_benefit
pm25_APEC2_matrix(17,:) = pm25_APEC2_Nov9_benefit
pm25_APEC2_matrix(18,:) = pm25_APEC2_Nov10_benefit
pm25_APEC2_matrix(19,:) = pm25_APEC2_Nov11_benefit

pm25_APEC3_matrix(0,:) = pm25_APEC3_Oct18_benefit
pm25_APEC3_matrix(1,:) = pm25_APEC3_Oct19_benefit
pm25_APEC3_matrix(2,:) = pm25_APEC3_Oct20_benefit
pm25_APEC3_matrix(3,:) = pm25_APEC3_Oct21_benefit
pm25_APEC3_matrix(4,:) = pm25_APEC3_Oct22_benefit
pm25_APEC3_matrix(5,:) = pm25_APEC3_Oct23_benefit
pm25_APEC3_matrix(6,:) = pm25_APEC3_Oct24_benefit
pm25_APEC3_matrix(7,:) = pm25_APEC3_Oct25_benefit
pm25_APEC3_matrix(8,:) = pm25_APEC3_Oct26_benefit
pm25_APEC3_matrix(9,:) = pm25_APEC3_Oct27_benefit
pm25_APEC3_matrix(10,:) = pm25_APEC3_Nov2_benefit
pm25_APEC3_matrix(11,:) = pm25_APEC3_Nov3_benefit
pm25_APEC3_matrix(12,:) = pm25_APEC3_Nov4_benefit
pm25_APEC3_matrix(13,:) = pm25_APEC3_Nov5_benefit
pm25_APEC3_matrix(14,:) = pm25_APEC3_Nov6_benefit
pm25_APEC3_matrix(15,:) = pm25_APEC3_Nov7_benefit
pm25_APEC3_matrix(16,:) = pm25_APEC3_Nov8_benefit
pm25_APEC3_matrix(17,:) = pm25_APEC3_Nov9_benefit
pm25_APEC3_matrix(18,:) = pm25_APEC3_Nov10_benefit
pm25_APEC3_matrix(19,:) = pm25_APEC3_Nov11_benefit





;SMOOTHING ALL 40 ARRAYS BY APPLYING A 24HR RUNNING MEAN
pm25_Beijing_matrix_sm = runave (pm25_Beijing_matrix, 24, 0)
pm25_APEC2_matrix_sm   = runave (pm25_APEC2_matrix, 24, 0)
pm25_APEC3_matrix_sm   = runave (pm25_APEC3_matrix, 24, 0)

;REMOVING ANY MISSING VALUES FROM SMOOTHED ARRAYS 
pm25_Beijing_matrix_sm = where(ismissing(pm25_Beijing_matrix_sm),0.0,pm25_Beijing_matrix_sm)
pm25_APEC2_matrix_sm = where(ismissing(pm25_APEC2_matrix_sm),0.0,pm25_APEC2_matrix_sm)
pm25_APEC3_matrix_sm = where(ismissing(pm25_APEC3_matrix_sm),0.0,pm25_APEC3_matrix_sm)


;print(pm25_Beijing_matrix+","+pm25_Beijing_matrix_sm)

print("BEIJING PULSES")
do i = 0,19 ;LOOP OVER 20 RUNS
 maxval = max(pm25_Beijing_matrix(i,:))
 maxloc = maxind(pm25_Beijing_matrix(i,:))
 minloc = maxloc + minind(pm25_Beijing_matrix(i,maxloc:))
 total = sum(pm25_Beijing_matrix(i,0:minloc))
 maxval = decimalPlaces(maxval ,2,True) 
 total = decimalPlaces(total ,2,True) 
 minloc2 = usefullength(pm25_Beijing_matrix(i,:),total)

 maxval_sm = max(pm25_Beijing_matrix_sm(i,:))
 maxloc_sm = maxind(pm25_Beijing_matrix_sm(i,:))
 minloc_sm = maxloc_sm + minind(pm25_Beijing_matrix_sm(i,maxloc_sm:))
 total_sm = sum(pm25_Beijing_matrix_sm(i,0:minloc_sm))
 maxval_sm = decimalPlaces(maxval_sm ,2,True)
 total_sm = decimalPlaces(total_sm ,2,True)

 parameters(i,0)=maxval
 parameters(i,3)=maxloc_sm
 parameters(i,6)=minloc2
 parameters(i,9)=total

 print("Pulse no."+(i+1)+"	peakvalue="+maxval+"ug/m3	timing of peak="+maxloc_sm+"hours	Length of benefits="+minloc2+"hours	Integrated benefits="+total+"ug/m3-hours")
end do


print("APEC2 PULSES")
do i = 0,19 ;LOOP OVER 20 DAYS
 maxval = max(pm25_APEC2_matrix(i,:))
 maxloc = maxind(pm25_APEC2_matrix(i,:))
 minloc = maxloc + minind(pm25_APEC2_matrix(i,maxloc:))
 total = sum(pm25_APEC2_matrix(i,0:minloc))
 maxval = decimalPlaces(maxval ,2,True)
 total = decimalPlaces(total ,2,True)  
 minloc2 = usefullength(pm25_APEC2_matrix(i,:),total)

 maxval_sm = max(pm25_APEC2_matrix_sm(i,:))
 maxloc_sm = maxind(pm25_APEC2_matrix_sm(i,:))
 minloc_sm = maxloc_sm + minind(pm25_APEC2_matrix_sm(i,maxloc_sm:))
 total_sm = sum(pm25_APEC2_matrix_sm(i,0:minloc_sm))
 maxval_sm = decimalPlaces(maxval_sm ,2,True)
 total_sm = decimalPlaces(total_sm ,2,True)
 
 parameters(i,1)=maxval
 parameters(i,4)=maxloc_sm
 parameters(i,7)=minloc2
 parameters(i,10)=total

 print("Pulse no."+(i+1)+"	peakvalue="+maxval+"ug/m3	timing of peak="+maxloc_sm+"hours	Length of benefits="+minloc2+"hours	Integrated benefits="+total+"ug/m3-hours")
end do

print("APEC3 PULSES")
do i = 0,19 ;LOOP OVER 20 DAYS
 maxval = max(pm25_APEC3_matrix(i,:))
 maxloc = maxind(pm25_APEC3_matrix(i,:))
 minloc = maxloc + minind(pm25_APEC3_matrix(i,maxloc:))
 total = sum(pm25_APEC3_matrix(i,0:minloc))
 maxval = decimalPlaces(maxval ,2,True)
 total = decimalPlaces(total ,2,True)
 minloc2 = usefullength(pm25_APEC3_matrix(i,:),total)

 maxval_sm = max(pm25_APEC3_matrix_sm(i,:))
 maxloc_sm = maxind(pm25_APEC3_matrix_sm(i,:))
 minloc_sm = maxloc_sm + minind(pm25_APEC3_matrix_sm(i,maxloc_sm:))
 total_sm = sum(pm25_APEC3_matrix_sm(i,0:minloc_sm))
 maxval_sm = decimalPlaces(maxval_sm ,2,True)
 total_sm = decimalPlaces(total_sm ,2,True)

 parameters(i,2)=maxval
 parameters(i,5)=maxloc_sm
 parameters(i,8)=minloc2
 parameters(i,11)=total


 print("Pulse no."+(i+1)+"      peakvalue="+maxval+"ug/m3       timing of peak="+maxloc_sm+"hours       Length of benefits="+minloc2+"hours     Integrated benefits="+total+"ug/m3-hours")
end do

parametersT = transpose(parameters)
parametersT = where(parametersT.lt.0,0,parametersT)

;;;;;WRITING ASCII FILE OF PULSE PARAMETERS;;;;;;
header = (/"B_peak R1_peak R2_peak B_peaktiming R1_peaktiming R2_peaktiming B_length R1_length R2_length B_intben R1_intben R2_intben"/)
hlist = [/header/]
alist = [/parametersT(0,:), parametersT(1,:),parametersT(2,:),parametersT(3,:),parametersT(4,:),parametersT(5,:),parametersT(6,:),parametersT(7,:),parametersT(8,:),parametersT(9,:),parametersT(10,:),parametersT(11,:)/]
print("alist created...now writing")
fname = "pulse-parameters.txt"
write_table(fname, "w", hlist, "%s")
write_table(fname, "a", alist, "%5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f %5.2f")





end
