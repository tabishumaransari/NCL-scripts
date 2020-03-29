begin
z1 = asciiread("/data1/tabish/nclscripts/beijingIntl-545110-metdata_10Oct-20Nov2014.txt",-1,"string")
USAF   = stringtofloat(str_get_cols(z1, 1,6))
YEAR   = stringtofloat(str_get_cols(z1, 13,16))
MONTH  = stringtofloat(str_get_cols(z1, 17,18))
DAY    = stringtofloat(str_get_cols(z1, 19,20))
HOUR   = stringtofloat(str_get_cols(z1, 21,22))
MIN    = stringtofloat(str_get_cols(z1, 23,24))
WDIR   = stringtofloat(str_get_cols(z1, 26,28))
WSPEED = stringtofloat(str_get_cols(z1, 30,32))
TEMP   = stringtofloat(str_get_cols(z1, 83,86))
DEWP   = stringtofloat(str_get_cols(z1, 88,91))
SLP    = stringtofloat(str_get_cols(z1, 93,98))
STP    = stringtofloat(str_get_cols(z1, 106,111))

print(HOUR)
;print(TEMP)

;TEMPC = (TEMP - 32) / 1.8

;print(TEMPC)


;MODULE FOR FINDING MISSING TIMES
;do i = 0, 1003
; if((HOUR(i+1)-HOUR(i).ne.1).and.(HOUR(i+1)-HOUR(i).ne.-23))then
; print(MONTH(i)+"   "+ DAY(i) + "     " + HOUR(i))
; end if
;end do


end
