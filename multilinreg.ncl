load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
Background   = (/4.01,20.22, 28.25, 58.37, 65.60, 0.00, 2.37,17.06,36.61,45.09, 19.56/) ;white
Interactions = (/8.34, 5.77, 19.55, 44.76, 24.49, 0.89, 2.35, 4.79, 6.77, 7.60, 15.59/) ;grey



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

 
       Y       = Interactions
       X       = new ( (/13,11/) , typeof(Y))
       X(0,:)  = 1.0
       X(1,:)  = AI
       X(2,:)  = AP
       X(3,:)  = AT
       X(4,:)  = AR
       X(5,:)  = BI
       X(6,:)  = BP
       X(7,:)  = BT
       X(8,:)  = BR
       X(9,:)  = CI
       X(10,:) = CP
       X(11,:) = CT
       X(12,:) = CR
       
       b       = reg_multlin(Y,X,False)

       Ystd      = stddev(Y)   
       Xstd      = dim_stddev(X)  
       XstdYstd  = Xstd/Ystd    ; array operation
       B         = b*XstdYstd   ; standard regression coefficients 
       B(0)      = 0.0          ; this corresponds to the constant term

       print (B)

