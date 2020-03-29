begin
ncol = 20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;READING FILES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;READING ASCII FILES FOR OCTOBER (BEIJING, APEC2 AND APEC3)
pm25_Beijing_Oct = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Oct = readAsciiTable("pm25_pulseruns_APEC2_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Oct = readAsciiTable("pm25_pulseruns_APEC3_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

;READING ASCII FILES FOR NOVBER (BEIJING, APEC2 AND APEC3)
pm25_Beijing_Nov = readAsciiTable("pm25_pulseruns_Beijing_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC2_Nov = readAsciiTable("pm25_pulseruns_APEC2_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
pm25_APEC3_Nov = readAsciiTable("pm25_pulseruns_APEC3_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER

;;;;;;;;;;;;;;;;;;;DECLARATIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;DEFINING OCTOBER MATRIX FOR ALL REGIONS
pm25_Beijing_Oct_matrix = new((/10,120/),float)
pm25_APEC2_Oct_matrix = new((/10,120/),float)
pm25_APEC3_Oct_matrix = new((/10,120/),float)

;DEFINING NOVEMBER MATRIX FOR ALL REGIONS
pm25_Beijing_Nov_matrix = new((/10,120/),float)
pm25_APEC2_Nov_matrix = new((/10,120/),float)
pm25_APEC3_Nov_matrix = new((/10,120/),float)

;DEFINING FULL 2D ARRAYS (OCT+NOV) FOR ALL REGIONS
pm25_Beijing_matrix     = new((/20,120/),float)
pm25_APEC2_matrix       = new((/20,120/),float)
pm25_APEC3_matrix       = new((/20,120/),float)
pm25_Beijing_combmatrix = new((/23,120/),float)
pm25_APEC2_combmatrix   = new((/23,120/),float)
pm25_APEC3_combmatrix   = new((/23,120/),float)

;DEFINING 2D ARRAYS FOR ALL REGIONS TO STORE 30 STATS PARAMETERS FOR EVERY HOUR
pm25_Beijing_stats            = new((/30,120/),float)
pm25_APEC2_stats              = new((/30,120/),float)
pm25_APEC3_stats              = new((/30,120/),float)

;DEFINING 1D ARRAYS FOR ALL REGIONS TO HOLD MIN, MAX AND MEAN PER HOUR
pm25_Beijing_mean            = new(120,float)
pm25_Beijing_min             = new(120,float)
pm25_Beijing_max             = new(120,float)
pm25_APEC2_mean              = new(120,float)
pm25_APEC2_min               = new(120,float)
pm25_APEC2_max               = new(120,float)
pm25_APEC3_mean              = new(120,float)
pm25_APEC3_min               = new(120,float)
pm25_APEC3_max               = new(120,float)


;;;;;;;;;;;;STORING VALUES FOR BEIJING OCTOBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_Beijing_Oct_matrix(0,:) = 100*(pm25_Beijing_Oct18B - pm25_Beijing_Oct18P)/pm25_Beijing_Oct18B
pm25_Beijing_Oct_matrix(1,:) = 100*(pm25_Beijing_Oct19B - pm25_Beijing_Oct19P)/pm25_Beijing_Oct19B
pm25_Beijing_Oct_matrix(2,:) = 100*(pm25_Beijing_Oct20B - pm25_Beijing_Oct20P)/pm25_Beijing_Oct20B
pm25_Beijing_Oct_matrix(3,:) = 100*(pm25_Beijing_Oct21B - pm25_Beijing_Oct21P)/pm25_Beijing_Oct21B
pm25_Beijing_Oct_matrix(4,:) = 100*(pm25_Beijing_Oct22B - pm25_Beijing_Oct22P)/pm25_Beijing_Oct22B
pm25_Beijing_Oct_matrix(5,:) = 100*(pm25_Beijing_Oct23B - pm25_Beijing_Oct23P)/pm25_Beijing_Oct23B
pm25_Beijing_Oct_matrix(6,:) = 100*(pm25_Beijing_Oct24B - pm25_Beijing_Oct24P)/pm25_Beijing_Oct24B
pm25_Beijing_Oct_matrix(7,:) = 100*(pm25_Beijing_Oct25B - pm25_Beijing_Oct25P)/pm25_Beijing_Oct25B
pm25_Beijing_Oct_matrix(8,:) = 100*(pm25_Beijing_Oct26B - pm25_Beijing_Oct26P)/pm25_Beijing_Oct26B
pm25_Beijing_Oct_matrix(9,:) = 100*(pm25_Beijing_Oct27B - pm25_Beijing_Oct27P)/pm25_Beijing_Oct27B

;;;;;;;;;;;;STORING VALUES FOR APEC2 OCTOBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC2_Oct_matrix(0,:) = 100*(pm25_APEC2_Oct18B - pm25_APEC2_Oct18P)/pm25_APEC2_Oct18B
pm25_APEC2_Oct_matrix(1,:) = 100*(pm25_APEC2_Oct19B - pm25_APEC2_Oct19P)/pm25_APEC2_Oct19B
pm25_APEC2_Oct_matrix(2,:) = 100*(pm25_APEC2_Oct20B - pm25_APEC2_Oct20P)/pm25_APEC2_Oct20B
pm25_APEC2_Oct_matrix(3,:) = 100*(pm25_APEC2_Oct21B - pm25_APEC2_Oct21P)/pm25_APEC2_Oct21B
pm25_APEC2_Oct_matrix(4,:) = 100*(pm25_APEC2_Oct22B - pm25_APEC2_Oct22P)/pm25_APEC2_Oct22B
pm25_APEC2_Oct_matrix(5,:) = 100*(pm25_APEC2_Oct23B - pm25_APEC2_Oct23P)/pm25_APEC2_Oct23B
pm25_APEC2_Oct_matrix(6,:) = 100*(pm25_APEC2_Oct24B - pm25_APEC2_Oct24P)/pm25_APEC2_Oct24B
pm25_APEC2_Oct_matrix(7,:) = 100*(pm25_APEC2_Oct25B - pm25_APEC2_Oct25P)/pm25_APEC2_Oct25B
pm25_APEC2_Oct_matrix(8,:) = 100*(pm25_APEC2_Oct26B - pm25_APEC2_Oct26P)/pm25_APEC2_Oct26B
pm25_APEC2_Oct_matrix(9,:) = 100*(pm25_APEC2_Oct27B - pm25_APEC2_Oct27P)/pm25_APEC2_Oct27B

;;;;;;;;;;;;STORING VALUES FOR APEC3 OCTOBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC3_Oct_matrix(0,:) = 100*(pm25_APEC3_Oct18B - pm25_APEC3_Oct18P)/pm25_APEC3_Oct18B
pm25_APEC3_Oct_matrix(1,:) = 100*(pm25_APEC3_Oct19B - pm25_APEC3_Oct19P)/pm25_APEC3_Oct19B
pm25_APEC3_Oct_matrix(2,:) = 100*(pm25_APEC3_Oct20B - pm25_APEC3_Oct20P)/pm25_APEC3_Oct20B
pm25_APEC3_Oct_matrix(3,:) = 100*(pm25_APEC3_Oct21B - pm25_APEC3_Oct21P)/pm25_APEC3_Oct21B
pm25_APEC3_Oct_matrix(4,:) = 100*(pm25_APEC3_Oct22B - pm25_APEC3_Oct22P)/pm25_APEC3_Oct22B
pm25_APEC3_Oct_matrix(5,:) = 100*(pm25_APEC3_Oct23B - pm25_APEC3_Oct23P)/pm25_APEC3_Oct23B
pm25_APEC3_Oct_matrix(6,:) = 100*(pm25_APEC3_Oct24B - pm25_APEC3_Oct24P)/pm25_APEC3_Oct24B
pm25_APEC3_Oct_matrix(7,:) = 100*(pm25_APEC3_Oct25B - pm25_APEC3_Oct25P)/pm25_APEC3_Oct25B
pm25_APEC3_Oct_matrix(8,:) = 100*(pm25_APEC3_Oct26B - pm25_APEC3_Oct26P)/pm25_APEC3_Oct26B
pm25_APEC3_Oct_matrix(9,:) = 100*(pm25_APEC3_Oct27B - pm25_APEC3_Oct27P)/pm25_APEC3_Oct27B

;;;;;;;;;;;STORING VALUES FOR BEIJING NOVEMBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_Beijing_Nov_matrix(0,:) = 100*(pm25_Beijing_Nov2B - pm25_Beijing_Nov2P)/pm25_Beijing_Nov2B
pm25_Beijing_Nov_matrix(1,:) = 100*(pm25_Beijing_Nov3B - pm25_Beijing_Nov3P)/pm25_Beijing_Nov3B
pm25_Beijing_Nov_matrix(2,:) = 100*(pm25_Beijing_Nov4B - pm25_Beijing_Nov4P)/pm25_Beijing_Nov4B
pm25_Beijing_Nov_matrix(3,:) = 100*(pm25_Beijing_Nov5B - pm25_Beijing_Nov5P)/pm25_Beijing_Nov5B
pm25_Beijing_Nov_matrix(4,:) = 100*(pm25_Beijing_Nov6B - pm25_Beijing_Nov6P)/pm25_Beijing_Nov6B
pm25_Beijing_Nov_matrix(5,:) = 100*(pm25_Beijing_Nov7B - pm25_Beijing_Nov7P)/pm25_Beijing_Nov7B
pm25_Beijing_Nov_matrix(6,:) = 100*(pm25_Beijing_Nov8B - pm25_Beijing_Nov8P)/pm25_Beijing_Nov8B
pm25_Beijing_Nov_matrix(7,:) = 100*(pm25_Beijing_Nov9B - pm25_Beijing_Nov9P)/pm25_Beijing_Nov9B
pm25_Beijing_Nov_matrix(8,:) = 100*(pm25_Beijing_Nov10B - pm25_Beijing_Nov10P)/pm25_Beijing_Nov10B
pm25_Beijing_Nov_matrix(9,:) = 100*(pm25_Beijing_Nov11B - pm25_Beijing_Nov11P)/pm25_Beijing_Nov11B

;;;;;;;;;;;STORING VALUES FOR APEC2 NOVEMBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC2_Nov_matrix(0,:) = 100*(pm25_APEC2_Nov2B - pm25_APEC2_Nov2P)/pm25_APEC2_Nov2B
pm25_APEC2_Nov_matrix(1,:) = 100*(pm25_APEC2_Nov3B - pm25_APEC2_Nov3P)/pm25_APEC2_Nov3B
pm25_APEC2_Nov_matrix(2,:) = 100*(pm25_APEC2_Nov4B - pm25_APEC2_Nov4P)/pm25_APEC2_Nov4B
pm25_APEC2_Nov_matrix(3,:) = 100*(pm25_APEC2_Nov5B - pm25_APEC2_Nov5P)/pm25_APEC2_Nov5B
pm25_APEC2_Nov_matrix(4,:) = 100*(pm25_APEC2_Nov6B - pm25_APEC2_Nov6P)/pm25_APEC2_Nov6B
pm25_APEC2_Nov_matrix(5,:) = 100*(pm25_APEC2_Nov7B - pm25_APEC2_Nov7P)/pm25_APEC2_Nov7B
pm25_APEC2_Nov_matrix(6,:) = 100*(pm25_APEC2_Nov8B - pm25_APEC2_Nov8P)/pm25_APEC2_Nov8B
pm25_APEC2_Nov_matrix(7,:) = 100*(pm25_APEC2_Nov9B - pm25_APEC2_Nov9P)/pm25_APEC2_Nov9B
pm25_APEC2_Nov_matrix(8,:) = 100*(pm25_APEC2_Nov10B - pm25_APEC2_Nov10P)/pm25_APEC2_Nov10B
pm25_APEC2_Nov_matrix(9,:) = 100*(pm25_APEC2_Nov11B - pm25_APEC2_Nov11P)/pm25_APEC2_Nov11B

;;;;;;;;;;;STORING VALUES FOR APEC3 NOVEMBER MATRIX;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
pm25_APEC3_Nov_matrix(0,:) = 100*(pm25_APEC3_Nov2B - pm25_APEC3_Nov2P)/pm25_APEC3_Nov2B
pm25_APEC3_Nov_matrix(1,:) = 100*(pm25_APEC3_Nov3B - pm25_APEC3_Nov3P)/pm25_APEC3_Nov3B
pm25_APEC3_Nov_matrix(2,:) = 100*(pm25_APEC3_Nov4B - pm25_APEC3_Nov4P)/pm25_APEC3_Nov4B
pm25_APEC3_Nov_matrix(3,:) = 100*(pm25_APEC3_Nov5B - pm25_APEC3_Nov5P)/pm25_APEC3_Nov5B
pm25_APEC3_Nov_matrix(4,:) = 100*(pm25_APEC3_Nov6B - pm25_APEC3_Nov6P)/pm25_APEC3_Nov6B
pm25_APEC3_Nov_matrix(5,:) = 100*(pm25_APEC3_Nov7B - pm25_APEC3_Nov7P)/pm25_APEC3_Nov7B
pm25_APEC3_Nov_matrix(6,:) = 100*(pm25_APEC3_Nov8B - pm25_APEC3_Nov8P)/pm25_APEC3_Nov8B
pm25_APEC3_Nov_matrix(7,:) = 100*(pm25_APEC3_Nov9B - pm25_APEC3_Nov9P)/pm25_APEC3_Nov9B
pm25_APEC3_Nov_matrix(8,:) = 100*(pm25_APEC3_Nov10B - pm25_APEC3_Nov10P)/pm25_APEC3_Nov10B
pm25_APEC3_Nov_matrix(9,:) = 100*(pm25_APEC3_Nov11B - pm25_APEC3_Nov11P)/pm25_APEC3_Nov11B


;NOW POPULATING THE APPENDED ARRAYS FOR OCT-NOV COMBINED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pm25_Beijing_matrix(0:9,:)   = pm25_Beijing_Oct_matrix 
pm25_Beijing_matrix(10:19,:) = pm25_Beijing_Nov_matrix 
pm25_APEC2_matrix(0:9,:)   = pm25_APEC2_Oct_matrix
pm25_APEC2_matrix(10:19,:) = pm25_APEC2_Nov_matrix
pm25_APEC3_matrix(0:9,:)   = pm25_APEC3_Oct_matrix
pm25_APEC3_matrix(10:19,:) = pm25_APEC3_Nov_matrix
;;;;AT THIS POINT THERE ARE JUST 3 2D ARRAYS HOLDING 20 PULSES EACH FOR THE 3 REGIONS;;;;;;;;


;;;;;;;;;;;CALCULATING STATS PER HOUR;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
opt = True
opt@PrintStat = True
do i =0,119
 pm25_Beijing_stats(:,i)            = stat_dispersion(pm25_Beijing_matrix(:,i), opt)
 pm25_APEC2_stats(:,i)              = stat_dispersion(pm25_APEC2_matrix(:,i), opt)
 pm25_APEC3_stats(:,i)              = stat_dispersion(pm25_APEC3_matrix(:,i), opt)
end do

;;;;;;;;;;;;;SAVING USEFUL STATS IN RESPECTIVE ARRAYS;;;;;;;;;;;;;;;;;;;
pm25_Beijing_mean            = pm25_Beijing_stats(0,:)
pm25_Beijing_min             = pm25_Beijing_stats(2,:)
pm25_Beijing_max             = pm25_Beijing_stats(14,:)
pm25_APEC2_mean              = pm25_APEC2_stats(0,:)
pm25_APEC2_min               = pm25_APEC2_stats(2,:)
pm25_APEC2_max               = pm25_APEC2_stats(14,:)
pm25_APEC3_mean              = pm25_APEC3_stats(0,:)
pm25_APEC3_min               = pm25_APEC3_stats(2,:)
pm25_APEC3_max               = pm25_APEC3_stats(14,:)

;;;;;;;;DAILY MEAN ANALYSIS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
day1_Beijing_min = avg(pm25_Beijing_min(0:23))
day1_Beijing_mean = avg(pm25_Beijing_mean(0:23))
day1_Beijing_max = avg(pm25_Beijing_max(0:23))
day2_Beijing_min = avg(pm25_Beijing_min(24:47))
day2_Beijing_mean = avg(pm25_Beijing_mean(24:47))
day2_Beijing_max = avg(pm25_Beijing_max(24:47))
day3_Beijing_min = avg(pm25_Beijing_min(48:71))
day3_Beijing_mean = avg(pm25_Beijing_mean(48:71))
day3_Beijing_max = avg(pm25_Beijing_max(48:71))
day4_Beijing_min = avg(pm25_Beijing_min(72:95))
day4_Beijing_mean = avg(pm25_Beijing_mean(72:95))
day4_Beijing_max = avg(pm25_Beijing_max(72:95))
day5_Beijing_min = avg(pm25_Beijing_min(96:119))
day5_Beijing_mean = avg(pm25_Beijing_mean(96:119))
day5_Beijing_max = avg(pm25_Beijing_max(96:119))

day1_APEC2_min = avg(pm25_APEC2_min(0:23))
day1_APEC2_mean = avg(pm25_APEC2_mean(0:23))
day1_APEC2_max = avg(pm25_APEC2_max(0:23))
day2_APEC2_min = avg(pm25_APEC2_min(24:47))
day2_APEC2_mean = avg(pm25_APEC2_mean(24:47))
day2_APEC2_max = avg(pm25_APEC2_max(24:47))
day3_APEC2_min = avg(pm25_APEC2_min(48:71))
day3_APEC2_mean = avg(pm25_APEC2_mean(48:71))
day3_APEC2_max = avg(pm25_APEC2_max(48:71))
day4_APEC2_min = avg(pm25_APEC2_min(72:95))
day4_APEC2_mean = avg(pm25_APEC2_mean(72:95))
day4_APEC2_max = avg(pm25_APEC2_max(72:95))
day5_APEC2_min = avg(pm25_APEC2_min(96:119))
day5_APEC2_mean = avg(pm25_APEC2_mean(96:119))
day5_APEC2_max = avg(pm25_APEC2_max(96:119))

day1_APEC3_min = avg(pm25_APEC3_min(0:23))
day1_APEC3_mean = avg(pm25_APEC3_mean(0:23))
day1_APEC3_max = avg(pm25_APEC3_max(0:23))
day2_APEC3_min = avg(pm25_APEC3_min(24:47))
day2_APEC3_mean = avg(pm25_APEC3_mean(24:47))
day2_APEC3_max = avg(pm25_APEC3_max(24:47))
day3_APEC3_min = avg(pm25_APEC3_min(48:71))
day3_APEC3_mean = avg(pm25_APEC3_mean(48:71))
day3_APEC3_max = avg(pm25_APEC3_max(48:71))
day4_APEC3_min = avg(pm25_APEC3_min(72:95))
day4_APEC3_mean = avg(pm25_APEC3_mean(72:95))
day4_APEC3_max = avg(pm25_APEC3_max(72:95))
day5_APEC3_min = avg(pm25_APEC3_min(96:119))
day5_APEC3_mean = avg(pm25_APEC3_mean(96:119))
day5_APEC3_max = avg(pm25_APEC3_max(96:119))

print("Beijing controls")
print("Max benefit:"+day1_Beijing_max+"	"+day2_Beijing_max+"	"+day3_Beijing_max+"	"+day4_Beijing_max+"	"+day5_Beijing_max)
print("Mean benefit:"+day1_Beijing_mean+"	"+day2_Beijing_mean+"	"+day3_Beijing_mean+"	"+day4_Beijing_mean+"	"+day5_Beijing_mean)
print("Min benefit:"+day1_Beijing_min+"	"+day2_Beijing_min+"	"+day3_Beijing_min+"	"+day4_Beijing_min+"	"+day5_Beijing_min)
print("APEC2 controls")
print("Max benefit:"+day1_APEC2_max+"	"+day2_APEC2_max+"	"+day3_APEC2_max+"	"+day4_APEC2_max+"	"+day5_APEC2_max)
print("Mean benefit:"+day1_APEC2_mean+"	"+day2_APEC2_mean+"	"+day3_APEC2_mean+"	"+day4_APEC2_mean+"	"+day5_APEC2_mean)
print("Min benefit:"+day1_APEC2_min+"	"+day2_APEC2_min+"	"+day3_APEC2_min+"	"+day4_APEC2_min+"	"+day5_APEC2_min)
print("APEC3 controls")
print("Max benefit:"+day1_APEC3_max+"	"+day2_APEC3_max+"	"+day3_APEC3_max+"	"+day4_APEC3_max+"	"+day5_APEC3_max)
print("Mean benefit:"+day1_APEC3_mean+"	"+day2_APEC3_mean+"	"+day3_APEC3_mean+"	"+day4_APEC3_mean+"	"+day5_APEC3_mean)
print("Min benefit:"+day1_APEC3_min+"	"+day2_APEC3_min+"	"+day3_APEC3_min+"	"+day4_APEC3_min+"	"+day5_APEC3_min)







;;;;;;CREATING APPENDED 2D ARRAYS FOR COMBINED PLOTTING OF PULSES ALONGWITH MINMAXMEAN;;;;
pm25_Beijing_combmatrix(0:19,:) = pm25_Beijing_matrix
pm25_Beijing_combmatrix(20,:)   = pm25_Beijing_min
pm25_Beijing_combmatrix(21,:)   = pm25_Beijing_mean
pm25_Beijing_combmatrix(22,:)   = pm25_Beijing_max
pm25_APEC2_combmatrix(0:19,:) = pm25_APEC2_matrix
pm25_APEC2_combmatrix(20,:)   = pm25_APEC2_min
pm25_APEC2_combmatrix(21,:)   = pm25_APEC2_mean
pm25_APEC2_combmatrix(22,:)   = pm25_APEC2_max
pm25_APEC3_combmatrix(0:19,:) = pm25_APEC3_matrix
pm25_APEC3_combmatrix(20,:)   = pm25_APEC3_min
pm25_APEC3_combmatrix(21,:)   = pm25_APEC3_mean
pm25_APEC3_combmatrix(22,:)   = pm25_APEC3_max



timearr = ispan(0,119,1)

;;;;;;;;;;;;;;;;;;;;;START THE GRAPHICS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wks = gsn_open_wks("x11","envelopeplot_pulses_percentage_panel") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC3 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 1
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0/)          ; make second line thicker
s1      = (/"grey","black","black","black","deeppink","red","brown","maroon","darkseagreen","green" /)          ; change line color
res@trXMaxF=max(timearr)
res@trYMinF     =  0
res@trYMaxF     =  40
;res@tiMainString       = "PM2.5 absolute benefit due to APEC3 controls in October"
; res@tiYAxisString      = "PM 2.5 in ug/m^3"
  res@tiMainFontHeightF  = 0.03
  res@tiYAxisFontHeightF = 0.04
  res@tmXBLabelFontHeightF = 0.04
  res@tmYLLabelFontHeightF = 0.04
  res@tmYUseLeft           = False   ; Make right axis independent of left
  res@tmYLOn               = True   ; Turn off left tickmarks
  res@tmYROn               = False    ; Turn on right tickmarks
  res@tmXTOn               = False   ; Turn off top tickmarks
  res@tmYLLabelsOn         = True   ; Turn off left labels
  res@tmYRLabelsOn         = True    ; Turn on right labels
  res@tmXBMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  res@xyLabelMode           = "Custom"           ; label a line
  s                         =  (/"18-22","19-23","20-24","21-25","22-26","23-27","24-28","25-29","26-30","27-31","2-6","3-7","4-8","5-9","6-10","7-11","8-12","9-13","10-14","11-15","","",""/); text to use
 res@xyLineLabelFontHeightF = 0.020              ; font height
 res@xyLineLabelFontColor   = "black"              ; label color
 ;res@tiYAxisString = "PM2.5 (~F33~m~F21~gm~S~-3~N~)"
 res@tiYAxisString = "PM2.5 (%)"


res@tmXBMode = "Explicit"
res@tmXBMinorValues = ispan(0,119,1)
res@tmXBValues = (/0,24,48,72,96,120/)
res@tmXBLabels = (/"Day 1","Day 2","Day 3","Day 4","Day 5","Day 6"/)


res@gsnDraw = False
res@gsnFrame = False
plot1 = new(23,graphic)
plot2 = new(23,graphic)
plot3 = new(23,graphic)

tt = fspan(.5,0.9,23)    ; variable spacings between each legend on the lines which increase for every next line
do gg = 0,19
    res@xyLineDashSegLenF = tt(gg)
    res@xyExplicitLabels = s(gg)
    res@xyLineColors = s1(0)
    plot1(gg) = gsn_csm_xy(wks,timearr,pm25_Beijing_combmatrix(gg,:),res)
    plot2(gg) = gsn_csm_xy(wks,timearr,pm25_APEC2_combmatrix(gg,:),res)
    plot3(gg) = gsn_csm_xy(wks,timearr,pm25_APEC3_combmatrix(gg,:),res)
    if (gg.ge.1) then
       overlay(plot1(0),plot1(gg))
       overlay(plot2(0),plot2(gg))
       overlay(plot3(0),plot3(gg))
    end if
end do

do gg = 20,22
    res@xyLineDashSegLenF = tt(gg)
    res@xyExplicitLabels = s(gg)
    res@xyLineColors = s1(gg-19)
    plot1(gg) = gsn_csm_xy(wks,timearr,pm25_Beijing_combmatrix(gg,:),res)
    plot2(gg) = gsn_csm_xy(wks,timearr,pm25_APEC2_combmatrix(gg,:),res)
    plot3(gg) = gsn_csm_xy(wks,timearr,pm25_APEC3_combmatrix(gg,:),res)
    if (gg.ge.1) then
       overlay(plot1(0),plot1(gg))
       overlay(plot2(0),plot2(gg))
       overlay(plot3(0),plot3(gg))
    end if
end do

;draw(plot1)
;frame(wks)
;draw(plot2)
;frame(wks)
;draw(plot3)
;frame(wks)


;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
;  resP@gsnPanelMainString = "12 Beijing sites mean time-series"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  resP@gsnPanelXWhiteSpacePercent = 0.0
  gsn_panel(wks,(/plot1(0),plot2(0),plot3(0)/),(/3,1/),resP)               ; now draw as one plot


end
