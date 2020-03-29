;THIS SCRIPTS CALCULATES RATIOS OF VARIOUS NMVOCs OVER ROI REGION FROM EDGAR SPECIATED EMISSIONS
;THESE RATIOS WILL THEN BE USED TO SPECIATE THE LUMPED NMVOCs FROM MAPEIRE INVENTORY
begin

a = addfile("/media/tabish/DataDisk/Dublin-study/mapeire-sita/wrfchemi_00z_d02.nc","r")
c = addfile("/media/tabish/DataDisk/Dublin-study/mapeire-sita/ROImask.nc","r")
d02mask = c->ROImask_d02
bigalk   = a->E_BIGALK
bigene   = a->E_BIGENE
c2h4     = a->E_C2H4
c2h5oh   = a->E_C2H5OH
c2h6     = a->E_C2H6
ch2o     = a->E_CH2O
ch3cho   = a->E_CH3CHO
ch3coch3 = a->E_CH3COCH3
ch3oh    = a->E_CH3OH
mek      = a->E_MEK
toluene  = a->E_TOLUENE
c3h6     = a->E_C3H6
c3h8     = a->E_C3H8
c2h2     = a->E_C2H2
benzene  = a->E_BENZENE
xylene   = a->E_XYLENE

bigalk@_FillValue = -999
bigene@_FillValue = -999
c2h4@_FillValue = -999
c2h5oh@_FillValue = -999
c2h6@_FillValue = -999
ch2o@_FillValue = -999
ch3cho@_FillValue = -999
ch3coch3@_FillValue = -999
ch3oh@_FillValue = -999
mek@_FillValue = -999
toluene@_FillValue = -999
c3h6@_FillValue = -999
c3h8@_FillValue = -999
c2h2@_FillValue = -999
benzene@_FillValue = -999
xylene@_FillValue = -999

bigalk = where(d02mask.eq.1,bigalk,bigalk@_FillValue)
bigene = where(d02mask.eq.1,bigene,bigene@_FillValue)
c2h4 = where(d02mask.eq.1,c2h4,c2h4@_FillValue)
c2h5oh = where(d02mask.eq.1,c2h5oh,c2h5oh@_FillValue)
c2h6 = where(d02mask.eq.1,c2h6,c2h6@_FillValue)
ch2o = where(d02mask.eq.1,ch2o,ch2o@_FillValue)
ch3cho = where(d02mask.eq.1,ch3cho,ch3cho@_FillValue)
ch3coch3 = where(d02mask.eq.1,ch3coch3,ch3coch3@_FillValue)
ch3oh = where(d02mask.eq.1,ch3oh,ch3oh@_FillValue)
mek = where(d02mask.eq.1,mek,mek@_FillValue)
toluene = where(d02mask.eq.1,toluene,toluene@_FillValue)
c3h6 = where(d02mask.eq.1,c3h6,c3h6@_FillValue)
c3h8 = where(d02mask.eq.1,c3h8,c3h8@_FillValue)
c2h2 = where(d02mask.eq.1,c2h2,c2h2@_FillValue)
benzene = where(d02mask.eq.1,benzene,benzene@_FillValue)
xylene = where(d02mask.eq.1,xylene,xylene@_FillValue)

nmvoc = bigalk+bigene+c2h4+c2h5oh+c2h6+ch2o+ch3cho+ch3coch3+ch3oh+mek+toluene+c3h6+c3h8+c2h2+benzene+xylene

Rbigalk = decimalPlaces(sum(bigalk)/sum(nmvoc),2,True)
Rbigene = decimalPlaces(sum(bigene)/sum(nmvoc),2,True)
Rc2h4 = decimalPlaces(sum(c2h4)/sum(nmvoc),2,True)
Rc2h5oh = decimalPlaces(sum(c2h5oh)/sum(nmvoc),2,True)
Rc2h6 = decimalPlaces(sum(c2h6)/sum(nmvoc),2,True)
Rch2o = decimalPlaces(sum(ch2o)/sum(nmvoc),2,True)
Rch3cho = decimalPlaces(sum(ch3cho)/sum(nmvoc),2,True)
Rch3coch3 = decimalPlaces(sum(ch3coch3)/sum(nmvoc),2,True)
Rch3oh = decimalPlaces(sum(ch3oh)/sum(nmvoc),2,True)
Rmek = decimalPlaces(sum(mek)/sum(nmvoc),2,True)
Rtoluene = decimalPlaces(sum(toluene)/sum(nmvoc),2,True)
Rc3h6 = decimalPlaces(sum(c3h6)/sum(nmvoc),2,True)
Rc3h8 = decimalPlaces(sum(c3h8)/sum(nmvoc),2,True)
Rc2h2 = decimalPlaces(sum(c2h2)/sum(nmvoc),2,True)
Rbenzene = decimalPlaces(sum(benzene)/sum(nmvoc),2,True)
Rxylene = decimalPlaces(sum(xylene)/sum(nmvoc),2,True)

print("bigalk="+Rbigalk)
print("bigene="+Rbigene)
print("c2h4="+Rc2h4)
print("c2h5oh="+Rc2h5oh)
print("c2h6="+Rc2h6)
print("ch2o="+Rch2o)
print("ch3cho="+Rch3cho)
print("ch3coch3="+Rch3coch3)
print("ch3oh="+Rch3oh)
print("mek="+Rmek)
print("toluene="+Rtoluene)
print("c3h6="+Rc3h6)
print("c3h8="+Rc3h8)
print("c2h2="+Rc2h2)
print("benzene="+Rbenzene)
print("xylene="+Rxylene)

print(Rbigalk+Rbigene+Rc2h4+Rc2h5oh+Rc2h6+Rch2o+Rch3cho+Rch3coch3+Rch3oh+Rmek+Rtoluene+Rc3h6+Rc3h8+Rc2h2+Rbenzene+Rxylene)




end
