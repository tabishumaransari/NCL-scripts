begin
z1 = asciiread("/data1/tabish/nclscripts/aug09file.txt",-1,"string")

;printVarSummary(z1)
;print(z1(3))
;print(z1(14))

o3grid = new((/120,288/),float)


;o3 = stringtofloat(str_get_cols(z1(3), 1,3))
;print(o3)

c=1 ;COUNTER VARIABLE FOR NO. OF 03 VALUES PER ROW
n=0 ;COUNTER VARIABLE FOR NO. OF ROW
sp = 1 ;STARTING POSITION FOR FETCHING THE DIGITS
ep = 3 ;ENDING POSITION FOR FETCHING THE DIGITS

do lat = 0,119
 do lon = 0, 287

   o3 = stringtofloat(str_get_cols(z1(n+3), sp,ep)) ;WE USE N+3 HERE BECAUSE THE FIRST 3 LINES ARE JUST SOME TEXT WHICH WE DON'T WANT TO READ IN
   print("o3="+o3+" row no.="+n+" digit count="+c+" sp="+sp+" ep="+ep)
   o3grid(119-lat,lon) = o3 ; THE GRID IS POPULATED FROM BOTTOM-MOST ROW TO UPWARDS BECAUSE THE ASCII FILE HAS NEGATIVE LATTITUDES IN THE BEGINNING
   sp = sp + 3
   ep = ep + 3

   if((n.eq.0).and.(c.eq.25))then ;THIS IS ONLY FOR THE FIRST TIME. NCL SHOULD PROCEED TO NEXT LINE AFTER FETCHING 25 VALUES
    n = n + 1
    c = 0
    sp = 1
    ep = 3
   end if

   if((n.gt.0).and.((n+1)%12.eq.0).and.(c.eq.13))then ;THIS IS FOR EACH 12TH ROW WHICH IS SHORTER AND ONLY HAS 13 VALUES IN IT. NCL SHOULD MOVE TO NEXT LINE AFTER FETCHING THE 13TH VALUE
    n = n + 1
    c = 0
    sp = 1
    ep = 3
   end if

   if(((n+1)%12.ne.0).and.(c.eq.25))then ;THIS IS FOR EVERY OTHER ROW WHICH HAS 25 VALUES IN IT AND NCL SHOULD PROCEED TO NEXT LINE AFTER FETCHING 25 VALUES
    n = n + 1
    c = 0
    sp = 1
    ep = 3
   end if

   c = c + 1
 end do
end do

;AT THIS POINT THE 2D O3-COLUMN GRID HAS BEEN BUILT 
o3grid = where(o3grid.eq.999,o3grid@_FillValue,o3grid/5.0) ;REPLACING 999 WITH DEFAULT MISSING VALUE AND DIVIDING BY 5 AS REQUIRED

;CREATING LAT-LON COORDINATE ARRAYS BASED ON THE INFORMATION IN THE ASCII FILE
latarray = fspan(0,119,120)
lonarray = fspan(0,358.75,288)

do i = 0, 119
 latarray(i) = latarray(i) - 59.5
end do

do j = 0, 287
 lonarray(j) =  lonarray(j) - 179.375
end do

;ASSIGNING LATARRAY AND LONARRAY AS COORDINATE VARIABLES TO THE O3GRID

o3grid!0   = "lat"      ; name the dimension
o3grid&lat = latarray   ; assign the coordinate variable

o3grid!1   = "lon"      ; name the dimension
o3grid&lon = lonarray   ; assign the coordinate variable

a = addfile("o3column.nc","c")
a->o3col = o3grid
print("success!")



end
