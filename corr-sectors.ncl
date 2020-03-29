load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;Background   = (/4.01,20.22, 28.25, 58.37, 65.60, 0.00, 2.37,17.06,36.61,45.09, 19.56/) ;white
;Interactions = (/8.34, 5.77, 19.55, 44.76, 24.49, 0.89, 2.35, 4.79, 6.77, 7.60, 15.59/) ;grey

Background   = (/10.04257,20.97728,13.72567,17.11931,24.57757,0       ,4.462436,17.43129,20.71053,17.31367,9.783914/)
Interactions = (/20.88655,5.986098,9.567855,13.12764,9.175377,3.852814,4.424778,4.894247,3.829835,2.918251,7.79812/)


AI    = (/ 6.19,  8.53, 11.15, 13.35, 25.88, 4.49,  7.31, 10.52, 12.76, 15.72, 14.35/)
AP    = (/ 0.15,  0.00,  0.00,  0.47,  0.81, 0.00,  0.19,  0.00,  0.00,  0.00,  0.00/)
AT    = (/ 2.31,  3.52,  4.40, 10.39, 14.95, 1.58,  2.90,  4.75,  3.09,  4.16,  6.41/)
AR    = (/10.35, 20.84, 30.19, 28.88, 31.36, 8.13, 12.67, 26.59, 42.07, 47.80, 33.49/)

BI    =  (/3.85, 17.33,  39.47, 61.14, 33.74, 2.46, 10.22, 13.57, 31.51, 45.17, 31.26/)
BP    =  (/0.20,  0.00,   2.75,  7.30,  2.48, 0.04,  0.38,  0.96,  0.00,  0.00,  0.60/)
BT    =  (/0.10,  0.00,   9.50, 20.61,  7.40, 0.17,  0.34,  0.00,  0.00,  0.00,  0.39/)
BR    =  (/4.00, 17.23,  43.32, 51.01, 27.46, 1.76,  7.74, 14.94, 27.94, 49.59, 22.13/)

CI    =  (/0.14,  1.00,   6.15, 18.05, 13.15, 1.20,  1.56,  1.03,  6.77, 24.35, 22.43/)
CP    =  (/0.04,  0.11,   1.25,  4.17,  3.81, 0.70,  1.05,  1.01,  1.62,  0.00,  7.25/)
CT    =  (/0.02,  0.00,   0.80,  2.75,  1.26, 0.11,  0.37,  0.28,  0.86,  0.00,  4.68/)
CR    =  (/0.23,  1.84,   7.75, 19.71, 14.52, 1.57,  3.66,  2.37,  6.77, 20.95, 21.78/)

 
rAI = escorc(AI,Interactions)       
rAP = escorc(AP,Interactions)       
rAT = escorc(AT,Interactions)       
rAR = escorc(AR,Interactions)       

rBI = escorc(BI,Interactions)
rBP = escorc(BP,Interactions)
rBT = escorc(BT,Interactions)
rBR = escorc(BR,Interactions)

rCI = escorc(CI,Interactions)
rCP = escorc(CP,Interactions)
rCT = escorc(CT,Interactions)
rCR = escorc(CR,Interactions)

print("AI="+rAI+" AP="+rAP+" AT="+rAT+" AR="+rAR)
print("BI="+rBI+" BP="+rBP+" BT="+rBT+" BR="+rBR)
print("CI="+rCI+" CP="+rCP+" CT="+rCT+" CR="+rCR)

Back_ep1 = avg(Background(0:4))
Back_ep2 = avg(Background(5:10))

Int_ep1 = avg(Interactions(0:4))
Int_ep2 = avg(Interactions(5:10))
print(Back_ep1)
print(Back_ep2)
print(Int_ep1)
print(Int_ep2)
