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

; This file still has to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;*********************************************
begin
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
;**********************************************
; create plot
;**********************************************
  wks = gsn_open_wks("pdf","pulse-boxplot")               ; send graphics to PNG file

  res            = True                         ; plot mods desired
  res@tmXBLabels = (/"Day1","Day2","Day3","Day4","Day5"/) ; labels for each box
  res@tiMainString = "Beijing"
  res@trYMaxF     =  26
  res@trYMinF     =  -2
;***********************************************
; the function boxplot will accept three different
; resource lists. In this default example, we set
; two of them to False.
;**********************************************
  plot1 = boxplot(wks,x,Beijing,False,res,False)	
  res@tiMainString = "APEC2"
  plot2 = boxplot(wks,x,APEC2,False,res,False)	
  res@tiMainString = "APEC3"
  plot3 = boxplot(wks,x,APEC3,False,res,False)	

gsn_panel(wks,(/plot1,plot2,plot3/),(/1,3/),False)             ; now draw as one plot




end
