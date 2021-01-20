import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

drat_mems = [6429576,2350824,586740,1298568,127564,109304,1147512,1741836,798872,1416420,4529796,1270992,1962852,1626968,2425996,4518488,2462660,3011976,359512,1190784,823740,2241424,5952412,2674908,4452216,2863072,3787004,2417808,961016,1529660,1813384,1530404,1700308,677580,3487588,2703952,9499304,21545744,3305972,1311192,491876,4857920,1401228,1105724,2330216,9815944,3567712,3624304,736404,520228,5391492,2168532,3007944,1799448,1219540,1588004,1396720,1609060,877560,130920,858792,1826132,2709932,2999500,3469628,6561056,2461316,2671284,182440,8666116,16788356,254924,3348684,2119596,664860,1374472,1196524,1194684,761396,652264,720828,1004572,160732,3854756,589060,1249840,1201420,1083380,11371892,1631572,432560,602948,550360,123008,1587860,6057448]
frat_mems = [1198392,521500,76944,551840,23592,18448,93804,1391524,537356,22836,57896,30164,73128,165736,70404,215816,145036,2997084,27272,53620,318436,1302628,173924,2615712,69600,62904,421412,318004,169164,34844,37572,687388,955280,1027928,121128,266884,179996,2757880,517720,101780,36800,262624,959388,35272,59052,113304,119664,121076,23344,33844,113640,78900,99184,40728,40816,37672,38700,217516,624524,137516,43724,47064,61204,65152,284828,180488,419204,103556,31056,413708,98184,197116,70832,102772,35216,47328,43000,43188,37276,35368,38884,40468,28260,281304,45900,180388,780372,633632,1637144,61396,216396,193036,180272,37728,49432,216852]

drat_gb = [x / 1000000 for x in drat_mems]
frat_gb = [x / 1000000 for x in frat_mems]

frat_x = np.sort(frat_gb)
n = frat_x.size
frat_y = np.arange(1, n+1) 

drat_x = np.sort(drat_gb)
drat_y = np.arange(1, n+1) 

plt.plot(frat_x, frat_y, '-x', color='green', label="FRAT", markersize=4)
plt.plot(drat_x, drat_y, '-x', color='blue',  label="DRAT", markersize=4)
plt.xlabel('Peak memory usage (GB) ', fontsize=12)
plt.ylabel('Number of instances solved', fontsize=12)
plt.legend(loc='lower right')
plt.savefig('mem.eps', format='eps')