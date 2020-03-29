;WILL WRITE 12 STATION MEAN DAILY AVERAGE PM2.5 IN AN ASCII FILE
begin
;a = addfile("wrfout_d03_2014-10-20_010000.nc","r")
;b = addfile("wrfout_d03_2014-10-21_010000.nc","r")
a = addfile(A,"r")
b = addfile(B,"r")

pm25 = new(24,float)
pm25_Bejing = new(24,float)

do i=0,23
 pm25_Bejing(i) = 0.0
end do

avesum = 0.0

Iarr = (/79,79,72,80,81,81,78,77,88,85,74,75/)
Jarr = (/145,141,155,144,141,144,143,145,151,160,152,142/)

do count=0,11
 I = Iarr(count)
 J = Jarr(count)
 pm25(0:8)    = a->PM2_5_DRY(15:23,0,J,I)
 pm25(9:23)   = b->PM2_5_DRY(0:14,0,J,I)
 ave = avg(pm25)
 avesum = avesum + ave
 pm25_Bejing = pm25_Bejing + pm25
end do

ave = avesum/12.0
pm25_Bejing = pm25_Bejing/12.0
print(pm25_Bejing)
;ave  = round(ave,3)
ave = decimalPlaces(ave ,2,True)
print("Daily avg is "+ave)
;asciiwrite ("davg.txt", ave)
end

