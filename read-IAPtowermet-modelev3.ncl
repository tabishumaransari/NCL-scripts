; These files still have to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
load "/data1/tabish/nclscripts/cd_inv_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
ncol = 8
data = readAsciiTable("IAPtowermet_modlev3_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999.0
print("table read-in successfully")


Tsim = (/data(:,0)/)
Tobs = (/data(:,1)/)

RHsim = (/data(:,2)/)
RHobs = (/data(:,3)/)

WSsim = (/data(:,4)/)
WSobs = (/data(:,5)/)

WDsim = (/data(:,6)/)
WDobs = (/data(:,7)/)

Tsimavg = avg(Tsim)
Tobsavg = avg(Tobs)

RHsimavg = avg(RHsim)
RHobsavg = avg(RHobs)

WSsimavg = avg(WSsim)
WSobsavg = avg(WSobs)

WDsimavg = avg(WDsim)
WDobsavg = avg(WDobs)

print("RH bias="+(RHsimavg-RHobsavg))
print("WS bias="+(WSsimavg-WSobsavg))

end
