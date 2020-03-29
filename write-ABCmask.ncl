begin
a= addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","w")
ABCmask_d01 = a->BAPEC2mask_d01 
ABCmask_d02 = a->BAPEC2mask_d02 
ABCmask_d03 = a->BAPEC2mask_d03 

ABCmask_d02 = where(ABCmask_d02.eq.2,3,ABCmask_d02)
ABCmask_d02 = where(ABCmask_d02.eq.1,2,ABCmask_d02)
ABCmask_d02 = where(ABCmask_d02.eq.0,1,ABCmask_d02)

ABCmask_d03 = where(ABCmask_d03.eq.2,3,ABCmask_d03)
ABCmask_d03 = where(ABCmask_d03.eq.1,2,ABCmask_d03)
ABCmask_d03 = where(ABCmask_d03.eq.0,1,ABCmask_d03)

a->ABCmask_d02 = ABCmask_d02
a->ABCmask_d03 = ABCmask_d03
print("success!!!")
end
