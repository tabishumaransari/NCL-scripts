begin
a= addfile("/data3/tabish/wrfchemi-management/BTHmask.nc","w")
BAPEC1mask_d01 = a->Bmask_d01 + a->APEC1mask_d01
BAPEC1mask_d02 = a->Bmask_d02 + a->APEC1mask_d02
BAPEC1mask_d03 = a->Bmask_d03 + a->APEC1mask_d03

BAPEC2mask_d01 = a->Bmask_d01 + a->APEC2mask_d01
BAPEC2mask_d02 = a->Bmask_d02 + a->APEC2mask_d02
BAPEC2mask_d03 = a->Bmask_d03 + a->APEC2mask_d03

a->BAPEC1mask_d01 = BAPEC1mask_d01
a->BAPEC1mask_d02 = BAPEC1mask_d02
a->BAPEC1mask_d03 = BAPEC1mask_d03

a->BAPEC2mask_d01 = BAPEC2mask_d01
a->BAPEC2mask_d02 = BAPEC2mask_d02
a->BAPEC2mask_d03 = BAPEC2mask_d03
print("Success!")
end
