begin

filename = "/home/tabish/Downloads/accuracyData1.csv"

;---Read in file as array of strings so we can parse each line
lines = asciiread(filename,-1,"string")

lines_a = str_match(lines, ",a,"); SEARCH FOR 00HRS OBSERVATIONS
lines_b = str_match(lines, ",b,"); SEARCH FOR 00HRS OBSERVATIONS
lines_c = str_match(lines, ",c,"); SEARCH FOR 00HRS OBSERVATIONS
lines_d = str_match(lines, ",d,"); SEARCH FOR 00HRS OBSERVATIONS

;printVarSummary(lines)
;printVarSummary(lines_a)
;print("printing the first row of lines_a")
;print(lines_a(0))

delim = "," ; delimiter

sum_a1 = 0.0
sum_a2 = 0.0
sum_a3 = 0.0
sum_a4 = 0.0
sum_a5 = 0.0
sum_a6 = 0.0
sum_a7 = 0.0
sum_a8 = 0.0
sum_a9 = 0.0
sum_a10 = 0.0
sum_a11 = 0.0
sum_a12 = 0.0


do i= 0,575
 seq = tofloat(str_get_field(lines_d(i),7,delim)) 
 cor = tofloat(str_get_field(lines_d(i),9,delim)) 
 if(seq.eq.1) then
  sum_a1 = sum_a1 + cor
 end if

 if(seq.eq.2) then
  sum_a2 = sum_a2 + cor
 end if
 
 if(seq.eq.3) then
  sum_a3 = sum_a3 + cor
 end if

 if(seq.eq.4) then
  sum_a4 = sum_a4 + cor
 end if

 if(seq.eq.5) then
  sum_a5 = sum_a5 + cor
 end if

 if(seq.eq.6) then
  sum_a6 = sum_a6 + cor
 end if

 if(seq.eq.7) then
  sum_a7 = sum_a7 + cor
 end if

 if(seq.eq.8) then
  sum_a8 = sum_a8 + cor
 end if

 if(seq.eq.9) then
  sum_a9 = sum_a9 + cor
 end if

 if(seq.eq.10) then
  sum_a10 = sum_a10 + cor
 end if

 if(seq.eq.11) then
  sum_a11 = sum_a11 + cor
 end if

 if(seq.eq.12) then
  sum_a12 = sum_a12 + cor
 end if

end do

ave_a1 = sum_a1/48.0
ave_a2 = sum_a2/48.0
ave_a3 = sum_a3/48.0
ave_a4 = sum_a4/48.0
ave_a5 = sum_a5/48.0
ave_a6 = sum_a6/48.0
ave_a7 = sum_a7/48.0
ave_a8 = sum_a8/48.0
ave_a9 = sum_a9/48.0
ave_a10 = sum_a10/48.0
ave_a11 = sum_a11/48.0
ave_a12 = sum_a12/48.0

print("The avg CORRECT value for group d for sequence 1 ="+ave_a1)
print("The avg CORRECT value for group d for sequence 2 ="+ave_a2)
print("The avg CORRECT value for group d for sequence 3 ="+ave_a3)
print("The avg CORRECT value for group d for sequence 4 ="+ave_a4)
print("The avg CORRECT value for group d for sequence 5 ="+ave_a5)
print("The avg CORRECT value for group d for sequence 6 ="+ave_a6)
print("The avg CORRECT value for group d for sequence 7 ="+ave_a7)
print("The avg CORRECT value for group d for sequence 8 ="+ave_a8)
print("The avg CORRECT value for group d for sequence 9 ="+ave_a9)
print("The avg CORRECT value for group d for sequence 10 ="+ave_a10)
print("The avg CORRECT value for group d for sequence 11 ="+ave_a11)
print("The avg CORRECT value for group d for sequence 12 ="+ave_a12)



end
