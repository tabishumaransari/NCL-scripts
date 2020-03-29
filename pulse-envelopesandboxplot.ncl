load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/boxplot2.ncl"
begin
;;;;;;;;;;;;;;;;;;;;;;;;BOXPLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;BOXPLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Beijing controls
;	Max benefit:20.8671	12.7592	2.01625	0.572916	0.472915
;	75p benefit:14.0821	2.71875	0.0658339	0.0670802	0.0554178
;	Mean benefit:10.7138	2.35135	0.129958	0.0465206	0.0299584
;	25p benefit:5.99167	0.537917	-0.0212503	-0.0145837	-0.0295835
;	Min benefit:2.73458	-0.000833054	-0.384164	-0.285832	-0.3375
;	APEC2 controls
;	Max benefit:5.27083	25.4367	   15.3008	6.23542	        2.135
;	75p benefit:2.18625	5.62625	   1.2725	0.232083	0.15125
;	Mean benefit:1.47615	4.60469	   2.15867	0.732583	0.282209
;	25p benefit:0.0837516	0.0491668 -0.00791695	-0.00749985	-0.013333
;	Min benefit:-0.157914	-0.302083 -0.317917	-0.145	       -0.400834
;	APEC3 controls
;	Max benefit:0.998333	8.54708	 9.555	  7.35667     4.20375
;	75p benefit:0.376667	2.47375	 1.70583  1.00583     0.415834
;	Mean benefit:0.258188	1.89225	 1.55977  1.06806     0.588104
;	25p benefit:0.0429179	0.240834  0.039167 0.00583341 0.00291628
;	Min benefit:-0.0662518	-0.133333 -0.138333 -0.11375 -0.17375

  Beijing = new((/5,5/),"float",-999.)
  Beijing(0,:) = (/2.73458,5.99167,10.7138,14.0821,20.8671/)
  Beijing(1,:) = (/0,0.537917,2.35135,2.71875,12.7592/)
  Beijing(2,:) = (/0,0,0.129958,0.0658339,2.01625/)
  Beijing(3,:) = (/0,0,0.0465206,0.0670802,0.572916/)
  Beijing(4,:) = (/0,0,0.0299584,0.0554178,0.472915/)

  
  APEC2 = new((/5,5/),"float",-999.)
  APEC2(0,:) = (/0,0.0837516,1.47615,2.18625,5.27083/)
  APEC2(1,:) = (/0,0.0491668,4.60469,5.62625,25.4367/)
  APEC2(2,:) = (/0,0,2.15867,1.2725,15.3008/)
  APEC2(3,:) = (/0,0,0.732583,0.232083,6.23542/)
  APEC2(4,:) = (/0,0,0.282209,0.15125,2.135/)

  APEC3 = new((/5,5/),"float",-999.)
  APEC3(0,:) = (/0,0.0429179,0.258188,0.376667,0.998333/)
  APEC3(1,:) = (/0,0.240834,1.89225,2.47375,8.54708/)
  APEC3(2,:) = (/0,0.039167,1.55977,1.70583,9.555/)
  APEC3(3,:) = (/0,0.00583341,1.06806,1.00583,7.35667/)
  APEC3(4,:) = (/0,0.00291628,0.588104,0.415834,4.20375/)

  x = (/1, 2, 3, 4, 5/)		


;;;;;;;;;;;;;;;;;;;;;;;;;;;;ENVELOPE PLOTS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
pm25_Beijing_Oct_matrix(0,:) = pm25_Beijing_Oct18B - pm25_Beijing_Oct18P
pm25_Beijing_Oct_matrix(1,:) = pm25_Beijing_Oct19B - pm25_Beijing_Oct19P
pm25_Beijing_Oct_matrix(2,:) = pm25_Beijing_Oct20B - pm25_Beijing_Oct20P
pm25_Beijing_Oct_matrix(3,:) = pm25_Beijing_Oct21B - pm25_Beijing_Oct21P
pm25_Beijing_Oct_matrix(4,:) = pm25_Beijing_Oct22B - pm25_Beijing_Oct22P
pm25_Beijing_Oct_matrix(5,:) = pm25_Beijing_Oct23B - pm25_Beijing_Oct23P
pm25_Beijing_Oct_matrix(6,:) = pm25_Beijing_Oct24B - pm25_Beijing_Oct24P
pm25_Beijing_Oct_matrix(7,:) = pm25_Beijing_Oct25B - pm25_Beijing_Oct25P
pm25_Beijing_Oct_matrix(8,:) = pm25_Beijing_Oct26B - pm25_Beijing_Oct26P
pm25_Beijing_Oct_matrix(9,:) = pm25_Beijing_Oct27B - pm25_Beijing_Oct27P

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
pm25_APEC2_Oct_matrix(0,:) = pm25_APEC2_Oct18B - pm25_APEC2_Oct18P
pm25_APEC2_Oct_matrix(1,:) = pm25_APEC2_Oct19B - pm25_APEC2_Oct19P
pm25_APEC2_Oct_matrix(2,:) = pm25_APEC2_Oct20B - pm25_APEC2_Oct20P
pm25_APEC2_Oct_matrix(3,:) = pm25_APEC2_Oct21B - pm25_APEC2_Oct21P
pm25_APEC2_Oct_matrix(4,:) = pm25_APEC2_Oct22B - pm25_APEC2_Oct22P
pm25_APEC2_Oct_matrix(5,:) = pm25_APEC2_Oct23B - pm25_APEC2_Oct23P
pm25_APEC2_Oct_matrix(6,:) = pm25_APEC2_Oct24B - pm25_APEC2_Oct24P
pm25_APEC2_Oct_matrix(7,:) = pm25_APEC2_Oct25B - pm25_APEC2_Oct25P
pm25_APEC2_Oct_matrix(8,:) = pm25_APEC2_Oct26B - pm25_APEC2_Oct26P
pm25_APEC2_Oct_matrix(9,:) = pm25_APEC2_Oct27B - pm25_APEC2_Oct27P

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
pm25_APEC3_Oct_matrix(0,:) = pm25_APEC3_Oct18B - pm25_APEC3_Oct18P
pm25_APEC3_Oct_matrix(1,:) = pm25_APEC3_Oct19B - pm25_APEC3_Oct19P
pm25_APEC3_Oct_matrix(2,:) = pm25_APEC3_Oct20B - pm25_APEC3_Oct20P
pm25_APEC3_Oct_matrix(3,:) = pm25_APEC3_Oct21B - pm25_APEC3_Oct21P
pm25_APEC3_Oct_matrix(4,:) = pm25_APEC3_Oct22B - pm25_APEC3_Oct22P
pm25_APEC3_Oct_matrix(5,:) = pm25_APEC3_Oct23B - pm25_APEC3_Oct23P
pm25_APEC3_Oct_matrix(6,:) = pm25_APEC3_Oct24B - pm25_APEC3_Oct24P
pm25_APEC3_Oct_matrix(7,:) = pm25_APEC3_Oct25B - pm25_APEC3_Oct25P
pm25_APEC3_Oct_matrix(8,:) = pm25_APEC3_Oct26B - pm25_APEC3_Oct26P
pm25_APEC3_Oct_matrix(9,:) = pm25_APEC3_Oct27B - pm25_APEC3_Oct27P

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
pm25_Beijing_Nov_matrix(0,:) = pm25_Beijing_Nov2B - pm25_Beijing_Nov2P
pm25_Beijing_Nov_matrix(1,:) = pm25_Beijing_Nov3B - pm25_Beijing_Nov3P
pm25_Beijing_Nov_matrix(2,:) = pm25_Beijing_Nov4B - pm25_Beijing_Nov4P
pm25_Beijing_Nov_matrix(3,:) = pm25_Beijing_Nov5B - pm25_Beijing_Nov5P
pm25_Beijing_Nov_matrix(4,:) = pm25_Beijing_Nov6B - pm25_Beijing_Nov6P
pm25_Beijing_Nov_matrix(5,:) = pm25_Beijing_Nov7B - pm25_Beijing_Nov7P
pm25_Beijing_Nov_matrix(6,:) = pm25_Beijing_Nov8B - pm25_Beijing_Nov8P
pm25_Beijing_Nov_matrix(7,:) = pm25_Beijing_Nov9B - pm25_Beijing_Nov9P
pm25_Beijing_Nov_matrix(8,:) = pm25_Beijing_Nov10B - pm25_Beijing_Nov10P
pm25_Beijing_Nov_matrix(9,:) = pm25_Beijing_Nov11B - pm25_Beijing_Nov11P

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
pm25_APEC2_Nov_matrix(0,:) = pm25_APEC2_Nov2B - pm25_APEC2_Nov2P
pm25_APEC2_Nov_matrix(1,:) = pm25_APEC2_Nov3B - pm25_APEC2_Nov3P
pm25_APEC2_Nov_matrix(2,:) = pm25_APEC2_Nov4B - pm25_APEC2_Nov4P
pm25_APEC2_Nov_matrix(3,:) = pm25_APEC2_Nov5B - pm25_APEC2_Nov5P
pm25_APEC2_Nov_matrix(4,:) = pm25_APEC2_Nov6B - pm25_APEC2_Nov6P
pm25_APEC2_Nov_matrix(5,:) = pm25_APEC2_Nov7B - pm25_APEC2_Nov7P
pm25_APEC2_Nov_matrix(6,:) = pm25_APEC2_Nov8B - pm25_APEC2_Nov8P
pm25_APEC2_Nov_matrix(7,:) = pm25_APEC2_Nov9B - pm25_APEC2_Nov9P
pm25_APEC2_Nov_matrix(8,:) = pm25_APEC2_Nov10B - pm25_APEC2_Nov10P
pm25_APEC2_Nov_matrix(9,:) = pm25_APEC2_Nov11B - pm25_APEC2_Nov11P

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
pm25_APEC3_Nov_matrix(0,:) = pm25_APEC3_Nov2B - pm25_APEC3_Nov2P
pm25_APEC3_Nov_matrix(1,:) = pm25_APEC3_Nov3B - pm25_APEC3_Nov3P
pm25_APEC3_Nov_matrix(2,:) = pm25_APEC3_Nov4B - pm25_APEC3_Nov4P
pm25_APEC3_Nov_matrix(3,:) = pm25_APEC3_Nov5B - pm25_APEC3_Nov5P
pm25_APEC3_Nov_matrix(4,:) = pm25_APEC3_Nov6B - pm25_APEC3_Nov6P
pm25_APEC3_Nov_matrix(5,:) = pm25_APEC3_Nov7B - pm25_APEC3_Nov7P
pm25_APEC3_Nov_matrix(6,:) = pm25_APEC3_Nov8B - pm25_APEC3_Nov8P
pm25_APEC3_Nov_matrix(7,:) = pm25_APEC3_Nov9B - pm25_APEC3_Nov9P
pm25_APEC3_Nov_matrix(8,:) = pm25_APEC3_Nov10B - pm25_APEC3_Nov10P
pm25_APEC3_Nov_matrix(9,:) = pm25_APEC3_Nov11B - pm25_APEC3_Nov11P


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
pm25_Beijing_25p             = pm25_Beijing_stats(6,:)
pm25_Beijing_75p             = pm25_Beijing_stats(10,:)

pm25_APEC2_mean              = pm25_APEC2_stats(0,:)
pm25_APEC2_min               = pm25_APEC2_stats(2,:)
pm25_APEC2_max               = pm25_APEC2_stats(14,:)
pm25_APEC2_25p               = pm25_APEC2_stats(6,:)
pm25_APEC2_75p               = pm25_APEC2_stats(10,:)

pm25_APEC3_mean              = pm25_APEC3_stats(0,:)
pm25_APEC3_min               = pm25_APEC3_stats(2,:)
pm25_APEC3_max               = pm25_APEC3_stats(14,:)
pm25_APEC3_25p               = pm25_APEC3_stats(6,:)
pm25_APEC3_75p               = pm25_APEC3_stats(10,:)

;;;;;;;;DAILY MEAN ANALYSIS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
day1_Beijing_min = avg(pm25_Beijing_min(0:23))
day1_Beijing_mean = avg(pm25_Beijing_mean(0:23))
day1_Beijing_max = avg(pm25_Beijing_max(0:23))
day1_Beijing_25p = avg(pm25_Beijing_25p(0:23))
day1_Beijing_75p = avg(pm25_Beijing_75p(0:23))

day2_Beijing_min = avg(pm25_Beijing_min(24:47))
day2_Beijing_mean = avg(pm25_Beijing_mean(24:47))
day2_Beijing_max = avg(pm25_Beijing_max(24:47))
day2_Beijing_25p = avg(pm25_Beijing_25p(24:47))
day2_Beijing_75p = avg(pm25_Beijing_75p(24:47))

day3_Beijing_min = avg(pm25_Beijing_min(48:71))
day3_Beijing_mean = avg(pm25_Beijing_mean(48:71))
day3_Beijing_max = avg(pm25_Beijing_max(48:71))
day3_Beijing_25p = avg(pm25_Beijing_25p(48:71))
day3_Beijing_75p = avg(pm25_Beijing_75p(48:71))

day4_Beijing_min = avg(pm25_Beijing_min(72:95))
day4_Beijing_mean = avg(pm25_Beijing_mean(72:95))
day4_Beijing_max = avg(pm25_Beijing_max(72:95))
day4_Beijing_25p = avg(pm25_Beijing_25p(72:95))
day4_Beijing_75p = avg(pm25_Beijing_75p(72:95))

day5_Beijing_min = avg(pm25_Beijing_min(96:119))
day5_Beijing_mean = avg(pm25_Beijing_mean(96:119))
day5_Beijing_max = avg(pm25_Beijing_max(96:119))
day5_Beijing_25p = avg(pm25_Beijing_25p(96:119))
day5_Beijing_75p = avg(pm25_Beijing_75p(96:119))



day1_APEC2_min = avg(pm25_APEC2_min(0:23))
day1_APEC2_mean = avg(pm25_APEC2_mean(0:23))
day1_APEC2_max = avg(pm25_APEC2_max(0:23))
day1_APEC2_25p = avg(pm25_APEC2_25p(0:23))
day1_APEC2_75p = avg(pm25_APEC2_75p(0:23))

day2_APEC2_min = avg(pm25_APEC2_min(24:47))
day2_APEC2_mean = avg(pm25_APEC2_mean(24:47))
day2_APEC2_max = avg(pm25_APEC2_max(24:47))
day2_APEC2_25p = avg(pm25_APEC2_25p(24:47))
day2_APEC2_75p = avg(pm25_APEC2_75p(24:47))

day3_APEC2_min = avg(pm25_APEC2_min(48:71))
day3_APEC2_mean = avg(pm25_APEC2_mean(48:71))
day3_APEC2_max = avg(pm25_APEC2_max(48:71))
day3_APEC2_25p = avg(pm25_APEC2_25p(48:71))
day3_APEC2_75p = avg(pm25_APEC2_75p(48:71))

day4_APEC2_min = avg(pm25_APEC2_min(72:95))
day4_APEC2_mean = avg(pm25_APEC2_mean(72:95))
day4_APEC2_max = avg(pm25_APEC2_max(72:95))
day4_APEC2_25p = avg(pm25_APEC2_25p(72:95))
day4_APEC2_75p = avg(pm25_APEC2_75p(72:95))

day5_APEC2_min = avg(pm25_APEC2_min(96:119))
day5_APEC2_mean = avg(pm25_APEC2_mean(96:119))
day5_APEC2_max = avg(pm25_APEC2_max(96:119))
day5_APEC2_25p = avg(pm25_APEC2_25p(96:119))
day5_APEC2_75p = avg(pm25_APEC2_75p(96:119))

day1_APEC3_min = avg(pm25_APEC3_min(0:23))
day1_APEC3_mean = avg(pm25_APEC3_mean(0:23))
day1_APEC3_max = avg(pm25_APEC3_max(0:23))
day1_APEC3_25p = avg(pm25_APEC3_25p(0:23))
day1_APEC3_75p = avg(pm25_APEC3_75p(0:23))

day2_APEC3_min = avg(pm25_APEC3_min(24:47))
day2_APEC3_mean = avg(pm25_APEC3_mean(24:47))
day2_APEC3_max = avg(pm25_APEC3_max(24:47))
day2_APEC3_25p = avg(pm25_APEC3_25p(24:47))
day2_APEC3_75p = avg(pm25_APEC3_75p(24:47))

day3_APEC3_min = avg(pm25_APEC3_min(48:71))
day3_APEC3_mean = avg(pm25_APEC3_mean(48:71))
day3_APEC3_max = avg(pm25_APEC3_max(48:71))
day3_APEC3_25p = avg(pm25_APEC3_25p(48:71))
day3_APEC3_75p = avg(pm25_APEC3_75p(48:71))

day4_APEC3_min = avg(pm25_APEC3_min(72:95))
day4_APEC3_mean = avg(pm25_APEC3_mean(72:95))
day4_APEC3_max = avg(pm25_APEC3_max(72:95))
day4_APEC3_25p = avg(pm25_APEC3_25p(72:95))
day4_APEC3_75p = avg(pm25_APEC3_75p(72:95))

day5_APEC3_min = avg(pm25_APEC3_min(96:119))
day5_APEC3_mean = avg(pm25_APEC3_mean(96:119))
day5_APEC3_max = avg(pm25_APEC3_max(96:119))
day5_APEC3_25p = avg(pm25_APEC3_25p(96:119))
day5_APEC3_75p = avg(pm25_APEC3_75p(96:119))

print("Beijing controls")
print("Max benefit:"+day1_Beijing_max+"	"+day2_Beijing_max+"	"+day3_Beijing_max+"	"+day4_Beijing_max+"	"+day5_Beijing_max)
print("75p benefit:"+day1_Beijing_75p+"	"+day2_Beijing_75p+"	"+day3_Beijing_75p+"	"+day4_Beijing_75p+"	"+day5_Beijing_75p)
print("Mean benefit:"+day1_Beijing_mean+"	"+day2_Beijing_mean+"	"+day3_Beijing_mean+"	"+day4_Beijing_mean+"	"+day5_Beijing_mean)
print("25p benefit:"+day1_Beijing_25p+"	"+day2_Beijing_25p+"	"+day3_Beijing_25p+"	"+day4_Beijing_25p+"	"+day5_Beijing_25p)
print("Min benefit:"+day1_Beijing_min+"	"+day2_Beijing_min+"	"+day3_Beijing_min+"	"+day4_Beijing_min+"	"+day5_Beijing_min)
print("APEC2 controls")
print("Max benefit:"+day1_APEC2_max+"	"+day2_APEC2_max+"	"+day3_APEC2_max+"	"+day4_APEC2_max+"	"+day5_APEC2_max)
print("75p benefit:"+day1_APEC2_75p+"	"+day2_APEC2_75p+"	"+day3_APEC2_75p+"	"+day4_APEC2_75p+"	"+day5_APEC2_75p)
print("Mean benefit:"+day1_APEC2_mean+"	"+day2_APEC2_mean+"	"+day3_APEC2_mean+"	"+day4_APEC2_mean+"	"+day5_APEC2_mean)
print("25p benefit:"+day1_APEC2_25p+"	"+day2_APEC2_25p+"	"+day3_APEC2_25p+"	"+day4_APEC2_25p+"	"+day5_APEC2_25p)
print("Min benefit:"+day1_APEC2_min+"	"+day2_APEC2_min+"	"+day3_APEC2_min+"	"+day4_APEC2_min+"	"+day5_APEC2_min)
print("APEC3 controls")
print("Max benefit:"+day1_APEC3_max+"	"+day2_APEC3_max+"	"+day3_APEC3_max+"	"+day4_APEC3_max+"	"+day5_APEC3_max)
print("75p benefit:"+day1_APEC3_75p+"	"+day2_APEC3_75p+"	"+day3_APEC3_75p+"	"+day4_APEC3_75p+"	"+day5_APEC3_75p)
print("Mean benefit:"+day1_APEC3_mean+"	"+day2_APEC3_mean+"	"+day3_APEC3_mean+"	"+day4_APEC3_mean+"	"+day5_APEC3_mean)
print("25p benefit:"+day1_APEC3_25p+"	"+day2_APEC3_25p+"	"+day3_APEC3_25p+"	"+day4_APEC3_25p+"	"+day5_APEC3_25p)
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
wks = gsn_open_wks("pdf","envelope-and-boxplot_pulses") ; send graphics to PNG file
;---Plotting options for time series plot
res             = True
;res@gsnMaximize = True
res@gsnPaperOrientation = "landscape"
res@vpKeepAspect=False
;res@tiMainString     = "12 APEC3 sites mean time-series"          ; add title
res@vpWidthF    = 2
res@vpHeightF   = 0.8
res@xyMarkLineMode = "Lines"
res@xyMarkers      = (/0,0,0,0,0,0,0,0,0,0/)
res@tmXTOn      = False
res@tmYLFormat  = "f"      ; remove trailing ".0"
res@xyDashPatterns  = (/0,0,0,0,0,0,0,0,0,0/)                         ; Make curves all solid
;res@xyLineThicknesses = (/  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 4.0, 4.0, 4.0/)          ; make second line thicker
res@xyLineThicknessF = 1.0
s1      = (/"grey","black","red","black","deeppink","red","brown","maroon","darkseagreen","green" /)          ; change line color
s2      = (/"grey","black","green3","black","deeppink","red","brown","maroon","darkseagreen","green" /)          ; change line color
s3      = (/"grey","black","blue","black","deeppink","red","brown","maroon","darkseagreen","green" /)          ; change line color
res@trXMaxF=max(timearr)
res@trYMinF     =  0
res@trYMaxF     =  45
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
;  res@tmXBMinorOn          = True   ; Turn off minor ticks on Y axis
  res@tmYRLabelFontHeightF = 0.04   ; Increase font height
  res@tmXBLabelDeltaF      = -0.5     ; Increase space b/w ticks and labels
  res@tmYRLabelJust        = "CenterRight"   ; right-justify labels
  res@xyLabelMode           = "Custom"           ; label a line
  s                         =  (/"18-22","19-23","20-24","21-25","22-26","23-27","24-28","25-29","26-30","27-31","2-6","3-7","4-8","5-9","6-10","7-11","8-12","9-13","10-14","11-15","","",""/); text to use
 res@xyLineLabelFontHeightF = 0.025              ; font height
 res@xyLineLabelFontColor   = "black"              ; label color
 res@tiYAxisString = "PM~B~2.5~N~ (~F33~m~F21~gm~S~-3~N~)"

;DRAW TICKMARKS INWARDS
res@tmXBMajorOutwardLengthF=0.0
res@tmXBMinorOutwardLengthF=0.0
res@tmYLMajorOutwardLengthF=0.0
res@tmYLMinorOutwardLengthF=0.0

res@tmXBMajorLengthF=0.0
res@tmXBMinorLengthF=0.04
res@tmXBMinorThicknessF=2.0
res@tmYLMajorLengthF=0.04
res@tmYLMinorLengthF=0.02

res@tmXBMode = "Explicit"
;res@tmXBMinorValues = ispan(0,119,1)
res@tmXBValues = (/12,36,60,84,108/)
res@tmXBLabels = (/"Day 1","Day 2","Day 3","Day 4","Day 5"/)
res@tmXBMinorValues = (/0,24,48,72,96,120/)





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
    if(gg.eq.21) then 
     res@xyLineThicknessF = 2.0
    end if
    if(gg.eq.22) then 
     res@xyLineThicknessF = 1.0
    end if
    plot1(gg) = gsn_csm_xy(wks,timearr,pm25_Beijing_combmatrix(gg,:),res)
    res@xyLineColors = s2(gg-19)
    plot2(gg) = gsn_csm_xy(wks,timearr,pm25_APEC2_combmatrix(gg,:),res)
    res@xyLineColors = s3(gg-19)
    plot3(gg) = gsn_csm_xy(wks,timearr,pm25_APEC3_combmatrix(gg,:),res)
    if (gg.ge.1) then
       overlay(plot1(0),plot1(gg))
       overlay(plot2(0),plot2(gg))
       overlay(plot3(0),plot3(gg))
    end if
end do

txres = True
txres@txFontHeightF = 0.01
gsn_text_ndc(plot1(0),"Beijing sources",0.44,0.81,txres)
gsn_text_ndc(plot2(0),"Near-neighbourhood sources",0.40,0.59,txres)
gsn_text_ndc(plot3(0),"Far-neighbourhood sources",0.40,0.37,txres)
;gsn_text_ndc(xy1,"APEC2",0.70,0.75,txres)



;**********************************************
; create box plot
;**********************************************
  res1            = True                         ; plot mods desired
  res1@tmXBLabels = (/"Day1","Day2","Day3","Day4","Day5"/) ; labels for each box
  ;res1@tiYAxisFontHeightF = 0.9
  ;res1@tiXAxisFontHeightF = 0.9
  res1@tmXBLabelFontHeightF = 0.025
  res1@tmYLLabelFontHeightF = 0.03
  res1@tmXBLabelDeltaF      = -0.5  
  res1@tmXBMajorLengthF=0.0  
  res1@tmYRBorderOn    = True         ; Habilita a borda do eixo y direito (YR). 
  res1@tmXTBorderOn    = True         ; Habilita a borda do eixo x superior (XB). 
  res1@trYMaxF     =  26
  res1@trYMinF     =  0
;***********************************************
; the function boxplot will accept three different
; resource lists. In this default example, we set
; two of them to False.
;**********************************************
  plot4 = boxplot(wks,x,Beijing,False,res1,False)	
  plot5 = boxplot(wks,x,APEC2,False,res1,False)	
  plot6 = boxplot(wks,x,APEC3,False,res1,False)	

;************************************************
; create panel
;************************************************
  resP                    = True                 ; modify the panel plot
;  resP@gsnPanelMainString = "12 Beijing sites mean time-series"     ; set main title
  resP@gsnPanelYWhiteSpacePercent = 0.0
  resP@gsnPanelXWhiteSpacePercent = 0.0
 ; resP@gsnPanelBottom   = 0.05                   ; add space at bottom
  resP@gsnPanelDebug = True
 ; resP@gsnPanelXF          = (/0.12,0.52/)

;---Retrieve the height used for the first plot and apply to second plot
  getvalues plot1(0)
    "vpHeightF" : vph
    "vpWidthF"  : vpw
  end getvalues


setvalues (/plot4,plot5,plot6/)
  "vpHeightF" : vph
  "vpWidthF" : vpw/2
end setvalues



  gsn_panel(wks,(/plot1(0),plot4,plot2(0),plot5,plot3(0),plot6/),(/3,2/),resP)               ; now draw as one plot


end
