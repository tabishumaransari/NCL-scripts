begin

  filename = "inputparameters_ed.txt"
;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
;  print(lines)
  delim = "," 
  run       = tofloat(str_get_field(lines,1,delim))
  p1        = 100.0 * tofloat(str_get_field(lines,2,delim))
  p2        = 100.0 * tofloat(str_get_field(lines,3,delim))
  p3        = 100.0 * tofloat(str_get_field(lines,4,delim))
  p4        = 100.0 * tofloat(str_get_field(lines,5,delim))
  p5        = 100.0 * tofloat(str_get_field(lines,6,delim))
  p6        = 100.0 * tofloat(str_get_field(lines,7,delim))
  p7        = 100.0 * tofloat(str_get_field(lines,8,delim))
  p8        = 100.0 * tofloat(str_get_field(lines,9,delim))
  p9        = 100.0 * tofloat(str_get_field(lines,10,delim))
  p10       = 100.0 * tofloat(str_get_field(lines,11,delim))
  p11       = 100.0 * tofloat(str_get_field(lines,12,delim))
  p12       = 100.0 * tofloat(str_get_field(lines,13,delim))
    
print(run+" "+p1+" "+p2+" "+p3+" "+p4+" "+p5+" "+p6+" "+p7+" "+p8+" "+p9+" "+p10+" "+p11+" "+p12)

end
