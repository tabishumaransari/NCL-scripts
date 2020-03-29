; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999 
print("table read-in successfully")

pm25obs      = data(:,0)
pm25baseline = data(:,1)
pm25APECcontrols = data(:,2)
pm25Octcontrols = data(:,3)

;LET'S RECONSTRUCT OBS DATA OVER THE APEC CONTROL PERIOD BY FINDING THE PERCENTAGE CHANGE EACH DAY BETWEEN BASELINE AND CONTROLS SIMULATION

print("Oct-controls")
sp = 96
do i = 1, 10
 baseline_avg = avg(pm25baseline(sp:sp+23))
 controls_avg = avg(pm25Octcontrols(sp:sp+23))
 diff = baseline_avg - controls_avg
 pcbenefit = (diff/baseline_avg)*100.0
 print((i+15)+" Oct: baseline-avg="+baseline_avg+" %age benefit="+pcbenefit)
 sp = sp + 24
end do


print("APEC-controls")
sp = 527
do i = 1, 10
 baseline_avg = avg(pm25baseline(sp:sp+23))
 controls_avg = avg(pm25APECcontrols(sp:sp+23))
 diff = baseline_avg - controls_avg
 pcbenefit = (diff/baseline_avg)*100.0
 print((i+2)+" Nov: baseline-avg="+baseline_avg+" %age benefit="+pcbenefit)
 sp = sp + 24
end do



c1=0
c2=0
sp = 0
ep = 71

do i = 1, 37
  threeday_avg = avg(pm25obs(sp:ep))
  firstday_avg = avg(pm25obs(sp:sp+23))
  secondday_avg = avg(pm25obs(sp+24:sp+47))
  thirdday_avg = avg(pm25obs(sp+48:ep))
 ;RECONSTRUCTING 3-12NOV BASELINE OBS BY APPLYING DAILY CALCULATED GAIN FROM THE MODEL
  if(i.eq.23) then 
   threeday_avg = 1.288 * threeday_avg
   firstday_avg = 1.288 * firstday_avg
   secondday_avg = 1.288 * secondday_avg
   thirdday_avg = 1.288 * thirdday_avg
  end if

  if(i.eq.24) then
   threeday_avg = 1.224 * threeday_avg
   firstday_avg = 1.224 * firstday_avg
   secondday_avg = 1.224 * secondday_avg
   thirdday_avg = 1.224 * thirdday_avg
  end if

  if(i.eq.25) then
   threeday_avg = 1.212 * threeday_avg
   firstday_avg = 1.212 * firstday_avg
   secondday_avg = 1.212 * secondday_avg
   thirdday_avg = 1.212 * thirdday_avg
  end if

  if(i.eq.26) then
   threeday_avg = 1.324 * threeday_avg
   firstday_avg = 1.324 * firstday_avg
   secondday_avg = 1.324 * secondday_avg
   thirdday_avg = 1.324 * thirdday_avg
  end if

  if(i.eq.27) then
   threeday_avg = 1.3 * threeday_avg
   firstday_avg = 1.3 * firstday_avg
   secondday_avg = 1.3 * secondday_avg
   thirdday_avg = 1.3 * thirdday_avg
  end if

  if(i.eq.28) then
   threeday_avg = 1.263 * threeday_avg
   firstday_avg = 1.263 * firstday_avg
   secondday_avg = 1.263 * secondday_avg
   thirdday_avg = 1.263 * thirdday_avg
  end if

  if(i.eq.29) then
   threeday_avg = 1.251 * threeday_avg
   firstday_avg = 1.251 * firstday_avg
   secondday_avg = 1.251 * secondday_avg
   thirdday_avg = 1.251 * thirdday_avg
  end if

  if(i.eq.30) then
   threeday_avg = 1.217 * threeday_avg
   firstday_avg = 1.217 * firstday_avg
   secondday_avg = 1.217 * secondday_avg
   thirdday_avg = 1.217 * thirdday_avg
  end if

  if(i.eq.31) then
   threeday_avg = 1.159 * threeday_avg
   firstday_avg = 1.159 * firstday_avg
   secondday_avg = 1.159 * secondday_avg
   thirdday_avg = 1.159 * thirdday_avg
  end if

  if(i.eq.32) then
   threeday_avg = 1.335 * threeday_avg
   firstday_avg = 1.335 * firstday_avg
   secondday_avg = 1.335 * secondday_avg
   thirdday_avg = 1.335 * thirdday_avg
  end if

  print("Day"+i+" BEFORE CONTROLS: 3day avg="+threeday_avg+" 1st="+firstday_avg+" 2nd="+secondday_avg+" 3rd="+thirdday_avg)
  if((firstday_avg.gt.75.0).or.(secondday_avg.gt.75.0).or.(thirdday_avg.gt.75.0)) then
   print("The meeting can't be organized on Day "+i+" without controls")
   c1 = c1+1
  end if

  threeday_avg = 0.78 * threeday_avg
  firstday_avg = 0.78 * firstday_avg
  secondday_avg = 0.78 * secondday_avg
  thirdday_avg = 0.78 * thirdday_avg
  print("Day"+i+" AFTER CONTROLS: 3day avg="+threeday_avg+" 1st="+firstday_avg+" 2nd="+secondday_avg+" 3rd="+thirdday_avg)
  if((firstday_avg.gt.75.0).or.(secondday_avg.gt.75.0).or.(thirdday_avg.gt.75.0)) then
   print("The meeting can't be organized on Day "+i+" even with controls")
   c2 = c2+1
  end if
  sp = sp +24
  ep = ep + 24
end do

print("The meeting can't be organized on "+c1+" days out of 37 without controls")
print("The meeting can't be organized on "+c2+" days out of 37 with controls")


end
