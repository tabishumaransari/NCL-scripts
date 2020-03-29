begin

  filename = "MLH.txt"

;---Read in file as array of strings so we can parse each line
  lines = asciiread(filename,-1,"string")
  lines_fullhour = str_match(lines, ":00")
;  print(lines_fullhour)
  lines_fullhour = str_sub_str(lines_fullhour,",,",",-999,") 
  print(lines_fullhour)
  delim = "," ; multiple delimiters to separate day from date to find missing times
  mlh        = tofloat(str_get_field(lines_fullhour,1,delim))
  datetime   = str_get_field(lines_fullhour,2,delim)
  print(mlh+"	"+datetime)  
;print(mlh)


end
