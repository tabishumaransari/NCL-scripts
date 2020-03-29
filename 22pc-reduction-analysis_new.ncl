; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 24
data = readAsciiTable("12stmean_ts_zeroemis.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
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
 print((i+15)+" Oct: baseline-avg="+baseline_avg+" controls-avg="+controls_avg+" %age benefit="+pcbenefit)
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

dailymean_withoutcont = new(39,float)
dailymean_withcont    = new(39,float)

do i = 0, 38 ; BUILDING THE WITH- AND WITHOUT-CONTROLS ARRAYS TO HOLD DAILY AVERAGES FOR THE 39 DAYS
 dayavg = avg(pm25obs(sp:sp+23))
 dailymean_withoutcont(i) = dayavg
 dailymean_withcont(i) = 0.78*dayavg
 if(i.eq.22)then  
  dailymean_withoutcont(i) = 1.288* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.23)then
  dailymean_withoutcont(i) = 1.224* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.24)then
  dailymean_withoutcont(i) = 1.212* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.25)then
  dailymean_withoutcont(i) = 1.324* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.26)then
  dailymean_withoutcont(i) = 1.300* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.27)then
  dailymean_withoutcont(i) = 1.263* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.28)then
  dailymean_withoutcont(i) = 1.251* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.29)then
  dailymean_withoutcont(i) = 1.217* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.30)then
  dailymean_withoutcont(i) = 1.159* dayavg
  dailymean_withcont(i) = dayavg
 end if
 if(i.eq.31)then
  dailymean_withoutcont(i) = 1.335* dayavg
  dailymean_withcont(i) = dayavg
 end if
 sp = sp +24
end do


sp = 0
c1_apec = 0
c2_apec = 0

do i = 0, 36 
  first  = dailymean_withoutcont(i) 
  second = dailymean_withoutcont(i+1)
  third  = dailymean_withoutcont(i+2)
  print("Day "+(i+1))
  if((first.gt.75.0).or.(second.gt.75.0).or.(third.gt.75.0)) then
   print("BEFORE CONTROLS: 1st="+first+" 2nd="+second+" 3rd="+third+" THE MEETING CANNOT BE ORGANIZED")
  else
   print("BEFORE CONTROLS: 1st="+first+" 2nd="+second+" 3rd="+third+" THE MEETING CAN BE ORGANIZED")
   c1 = c1+1
   if((i.ge.22).and.(i.le.31))then
    c1_apec = c1_apec + 1
   end if
  end if

  first  = dailymean_withcont(i)
  second = dailymean_withcont(i+1)
  third  = dailymean_withcont(i+2)
  if((first.gt.75.0).or.(second.gt.75.0).or.(third.gt.75.0)) then
   print("AFTER CONTROLS: 1st="+first+" 2nd="+second+" 3rd="+third+" THE MEETING CANNOT BE ORGANIZED")
  else
   print("AFTER CONTROLS: 1st="+first+" 2nd="+second+" 3rd="+third+" THE MEETING CAN BE ORGANIZED")
   c2 = c2+1
   if((i.ge.22).and.(i.le.31))then
    c2_apec = c2_apec + 1
   end if
  end if
end do

print("The meeting can be organized on "+c1+"/37 slots in total and "+c1_apec+"/8 slots during APEC period without controls")
print("The meeting can be organized on "+c2+"/37 slots in total and "+c2_apec+"/8 slots during APEC period with controls")

end
