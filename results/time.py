import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

drat_elab_times = [1360200,604850,141410,1687280,6360,3460,659460,2415270,131440,419050,4560500,683240,443360,3016000,2873700,1271780,513600,931910,146560,1207440,163250,3543700,3662490,369620,6456070,3101130,975680,623770,390180,214860,587570,2734030,3387560,234140,2100220,2892000,2203590,2592410,5684140,186640,74890,2331340,236420,712550,2263530,18875330,5187050,5291770,148040,215330,1901760,1559060,3157860,914730,652800,777920,677420,597530,80450,3400,718790,855940,3527540,4199770,348620,1796370,897730,2346210,13510,873590,11304700,39300,1500190,3460060,328800,1124840,722120,662050,324540,307200,323680,646900,17410,1508140,189560,2296180,2896680,2379530,2082130,1600120,33430,54460,46830,3220,136950,2838750]
frat_elab_times = [846880,513490,76740,332720,3860,1830,101200,1811960,207320,102490,265760,65720,66970,177920,140600,459870,127800,148320,19130,75920,52580,886080,294820,577040,314430,201600,542570,278690,71540,97290,110420,1838200,110840,37110,155830,417390,553500,12028200,737190,60300,40400,340630,156870,58840,138580,749620,365920,352650,47390,27950,257800,158630,189140,125150,95750,111290,96710,116220,36290,2520,49260,89710,181130,211000,138700,329490,183810,188150,6780,810420,829180,15840,213440,196050,38670,82190,66960,64780,39950,35320,38530,55590,6970,413310,32080,129350,116350,100780,2326170,113180,97180,208980,75370,3140,311610,463030]
drat_total_times = [3402750,1532960,367420,2990310,31070,19280,1191660,3429410,275960,946760,6847710,1073790,706810,5873980,5467380,2062130,1075930,5158800,229950,1762490,484470,5481920,5420200,2239970,9104150,4753380,2046200,1311390,751780,330870,826990,3348860,5407320,1370870,4042780,4196550,3707980,6129090,7650190,1446730,130090,3476310,415590,1013730,3113520,24157620,7414480,7528910,226870,367540,2958090,3328540,5881320,1356230,1013910,1157640,1027320,3033470,436990,14730,1093920,1194520,4950670,5988760,3073310,2929410,3181030,3935330,48060,2277620,14233070,148040,3007890,5971800,542040,1701370,1149510,1047350,553010,512830,557780,1012320,52250,2590730,372720,4125460,6215490,5545060,3707970,2711760,323990,354050,672540,176860,274060,9200160]
frat_total_times = [3224996,2354506,420457,1832943,32110,17294,685335,2940799,362950,668169,2620213,465667,345988,3121336,2733108,1450601,426583,4353634,100685,665186,448092,2850217,2175029,3265341,3158900,1952091,1571369,1014042,444393,232756,373593,2550500,2220835,1381744,883130,1906088,2067621,16309812,2698860,1380392,132634,1515184,372863,370058,1032156,6133480,2746759,2692626,137582,191251,1379650,2000764,2503835,601976,475753,513462,467863,2652847,446406,16333,449626,458215,1650244,2071594,2889163,1583557,2663433,1809598,45816,2331255,3802622,149331,1788852,2371693,237368,596066,508981,459801,284560,227674,314949,371596,44166,1790296,197363,2112794,3759866,3566252,3866602,1400712,794965,664992,477673,49950,598843,8274426]

frat_elab_min  = [x / 60000 for x in frat_elab_times]
frat_total_min = [x / 60000 for x in frat_total_times]
drat_elab_min  = [x / 60000 for x in drat_elab_times]
drat_total_min = [x / 60000 for x in drat_total_times]

frat_elab_x = np.sort(frat_elab_min)
n = frat_elab_x.size
frat_elab_y = np.arange(1, n+1) 

frat_total_x = np.sort(frat_total_min)
frat_total_y = np.arange(1, n+1) 

drat_elab_x = np.sort(drat_elab_min)
drat_elab_y = np.arange(1, n+1) 

drat_total_x = np.sort(drat_total_min)
drat_total_y = np.arange(1, n+1) 

plt.plot(frat_total_x, frat_total_y, '-x', color='green', label="FRAT total", markersize=4)
plt.plot(drat_total_x, drat_total_y, '-x', color='blue', label="DRAT total", markersize=4)

plt.plot(frat_elab_x, frat_elab_y, '-x', color='palegreen', label="FRAT elab", markersize=4)
plt.plot(drat_elab_x, drat_elab_y, '-x', color='lightskyblue', label="DRAT elab", markersize=4)

plt.xlabel('Time (minutes)', fontsize=12)
plt.ylabel('Number of instances solved', fontsize=12)
plt.legend(loc='lower right')
plt.savefig('time.eps', format='eps')