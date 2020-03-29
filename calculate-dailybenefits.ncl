begin
ncol = 24
data = readAsciiTable("12stmean_ts.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25_baseline_16to25    = (/data(96:335,1)/)
pm25_octcontrols_16to25 = (/data(96:335,3)/)
pm25contbenefits = pm25_baseline_16to25 - pm25_octcontrols_16to25

;CALCULATING DAILY AVERAGE BENEFITS
day=16
do sp = 0, 216, 24
 dailyavg = avg(pm25contbenefits(sp:sp+23))
 print("Daily avg benefit due to continuous controls on "+day+" Oct is:"+dailyavg)
 day = day+1
end do

pm25_baseline_2to11    = (/data(527:766,1)/)
pm25_novcontrols_2to11 = (/data(527:766,2)/)
pm25contbenefits = pm25_baseline_2to11 - pm25_novcontrols_2to11

;CALCULATING DAILY AVERAGE BENEFITS
day=3
do sp = 0, 216, 24
 dailyavg = avg(pm25contbenefits(sp:sp+23))
 print("Daily avg benefit due to continuous controls on "+day+" Nov is:"+dailyavg)
 day = day+1
end do

delete(data)

;CALCULATING LOCAL CONTRIBUTIONS IN OCTOBER
ncol = 20
data = readAsciiTable("pm25_pulseruns_Beijing_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25_18to22benefits = (/data(:,0)/) - (/data(:,1)/)
pm25_19to23benefits = (/data(:,2)/) - (/data(:,3)/)
pm25_20to24benefits = (/data(:,4)/) - (/data(:,5)/)
pm25_21to25benefits = (/data(:,6)/) - (/data(:,7)/)
pm25_22to26benefits = (/data(:,8)/) - (/data(:,9)/)
pm25_23to27benefits = (/data(:,10)/) - (/data(:,11)/)
pm25_24to28benefits = (/data(:,12)/) - (/data(:,13)/)
pm25_25to29benefits = (/data(:,14)/) - (/data(:,15)/)
pm25_26to30benefits = (/data(:,16)/) - (/data(:,17)/)
pm25_27to31benefits = (/data(:,18)/) - (/data(:,19)/)

benefit_22A = avg(pm25_22to26benefits(0:23))
benefit_22B = avg(pm25_21to25benefits(24:47))
benefit_23A = avg(pm25_23to27benefits(0:23))
benefit_23B = avg(pm25_22to26benefits(24:47))
benefit_24A = avg(pm25_24to28benefits(0:23))
benefit_24B = avg(pm25_23to27benefits(24:47))
benefit_25A = avg(pm25_25to29benefits(0:23))
benefit_25B = avg(pm25_24to28benefits(24:47))

;CALCULATING LOCAL CONTRIBUTIONS IN NOVEMBER
data = readAsciiTable("pm25_pulseruns_Beijing_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25_2to6benefits   = (/data(:,0)/) - (/data(:,1)/)
pm25_3to7benefits   = (/data(:,2)/) - (/data(:,3)/)
pm25_4to8benefits   = (/data(:,4)/) - (/data(:,5)/)
pm25_5to9benefits   = (/data(:,6)/) - (/data(:,7)/)
pm25_6to10benefits  = (/data(:,8)/) - (/data(:,9)/)
pm25_7to11benefits  = (/data(:,10)/) - (/data(:,11)/)
pm25_8to12benefits  = (/data(:,12)/) - (/data(:,13)/)
pm25_9to13benefits  = (/data(:,14)/) - (/data(:,15)/)
pm25_10to14benefits = (/data(:,16)/) - (/data(:,17)/)
pm25_11to15benefits = (/data(:,18)/) - (/data(:,19)/)

benefit_9A = avg(pm25_9to13benefits(0:23))
benefit_9B = avg(pm25_8to12benefits(24:47))
benefit_10A = avg(pm25_10to14benefits(0:23))
benefit_10B = avg(pm25_9to13benefits(24:47))
benefit_11A = avg(pm25_11to15benefits(0:23))
benefit_11B = avg(pm25_10to14benefits(24:47))

;CALCULATING REGIONAL CONTRIBUTIONS IN OCTOBER
data = readAsciiTable("pm25_pulseruns_APEC2_Oct.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25_18to22benefits = (/data(:,0)/) - (/data(:,1)/)
pm25_19to23benefits = (/data(:,2)/) - (/data(:,3)/)
pm25_20to24benefits = (/data(:,4)/) - (/data(:,5)/)
pm25_21to25benefits = (/data(:,6)/) - (/data(:,7)/)
pm25_22to26benefits = (/data(:,8)/) - (/data(:,9)/)
pm25_23to27benefits = (/data(:,10)/) - (/data(:,11)/)
pm25_24to28benefits = (/data(:,12)/) - (/data(:,13)/)
pm25_25to29benefits = (/data(:,14)/) - (/data(:,15)/)
pm25_26to30benefits = (/data(:,16)/) - (/data(:,17)/)
pm25_27to31benefits = (/data(:,18)/) - (/data(:,19)/)

benefit_22C = avg(pm25_22to26benefits(0:23))
benefit_22D = avg(pm25_21to25benefits(24:47))
benefit_22E = avg(pm25_20to24benefits(48:71))
benefit_22F = avg(pm25_19to23benefits(72:95))
benefit_22G = avg(pm25_18to22benefits(96:119))
benefit_23C = avg(pm25_23to27benefits(0:23))
benefit_23D = avg(pm25_22to26benefits(24:47))
benefit_23E = avg(pm25_21to25benefits(48:71))
benefit_23F = avg(pm25_20to24benefits(72:95))
benefit_23G = avg(pm25_19to23benefits(96:119))
benefit_24C = avg(pm25_24to28benefits(0:23))
benefit_24D = avg(pm25_23to27benefits(24:47))
benefit_24E = avg(pm25_22to26benefits(48:71))
benefit_24F = avg(pm25_21to25benefits(72:95))
benefit_24G = avg(pm25_20to24benefits(96:119))
benefit_25C = avg(pm25_25to29benefits(0:23))
benefit_25D = avg(pm25_24to28benefits(24:47))
benefit_25E = avg(pm25_23to27benefits(48:71))
benefit_25F = avg(pm25_22to26benefits(72:95))
benefit_25G = avg(pm25_21to25benefits(96:119))


;CALCULATING REGIONAL CONTRIBUTIONS IN NOVEMBER
data = readAsciiTable("pm25_pulseruns_APEC2_Nov.txt", ncol, "float", 1); THIS WILL IGNORE THE 1ST ROW WHICH IS HEADER
data@_FillValue = -999
print("table read-in successfully")

pm25_2to6benefits   = (/data(:,0)/) - (/data(:,1)/)
pm25_3to7benefits   = (/data(:,2)/) - (/data(:,3)/)
pm25_4to8benefits   = (/data(:,4)/) - (/data(:,5)/)
pm25_5to9benefits   = (/data(:,6)/) - (/data(:,7)/)
pm25_6to10benefits  = (/data(:,8)/) - (/data(:,9)/)
pm25_7to11benefits  = (/data(:,10)/) - (/data(:,11)/)
pm25_8to12benefits  = (/data(:,12)/) - (/data(:,13)/)
pm25_9to13benefits  = (/data(:,14)/) - (/data(:,15)/)
pm25_10to14benefits = (/data(:,16)/) - (/data(:,17)/)
pm25_11to15benefits = (/data(:,18)/) - (/data(:,19)/)

benefit_9C  = avg(pm25_9to13benefits(0:23))
benefit_9D  = avg(pm25_8to12benefits(24:47))
benefit_9E  = avg(pm25_7to11benefits(48:71))
benefit_9F  = avg(pm25_6to10benefits(72:95))
benefit_9G  = avg(pm25_5to9benefits(96:119))
benefit_10C = avg(pm25_10to14benefits(0:23))
benefit_10D = avg(pm25_9to13benefits(24:47))
benefit_10E = avg(pm25_8to12benefits(48:71))
benefit_10F = avg(pm25_7to11benefits(72:95))
benefit_10G = avg(pm25_6to10benefits(96:119))
benefit_11C = avg(pm25_11to15benefits(0:23))
benefit_11D = avg(pm25_10to14benefits(24:47))
benefit_11E = avg(pm25_9to13benefits(48:71))
benefit_11F = avg(pm25_8to12benefits(72:95))
benefit_11G = avg(pm25_7to11benefits(96:119))


print(benefit_22A+" "+benefit_23A+" "+benefit_24A+" "+benefit_25A+" "+benefit_9A+" "+benefit_10A+" "+benefit_11A)
print(benefit_22B+" "+benefit_23B+" "+benefit_24B+" "+benefit_25B+" "+benefit_9B+" "+benefit_10B+" "+benefit_11B)
print(benefit_22C+" "+benefit_23C+" "+benefit_24C+" "+benefit_25C+" "+benefit_9C+" "+benefit_10C+" "+benefit_11C)
print(benefit_22D+" "+benefit_23D+" "+benefit_24D+" "+benefit_25D+" "+benefit_9D+" "+benefit_10D+" "+benefit_11D)
print(benefit_22E+" "+benefit_23E+" "+benefit_24E+" "+benefit_25E+" "+benefit_9E+" "+benefit_10E+" "+benefit_11E)
print(benefit_22F+" "+benefit_23F+" "+benefit_24F+" "+benefit_25F+" "+benefit_9F+" "+benefit_10F+" "+benefit_11F)
print(benefit_22G+" "+benefit_23G+" "+benefit_24G+" "+benefit_25G+" "+benefit_9G+" "+benefit_10G+" "+benefit_11G)


end
