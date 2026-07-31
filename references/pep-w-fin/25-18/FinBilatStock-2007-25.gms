*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:                      *
*                         Andre Lemelin, Veronique Robichaud                   *
*                         and Bernard Decaluwe                                 *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

* This file is included in the main program file PEP-w-t-fin_v4.1-25-18.gms


TABLE FinStock(*,*)
                    01-Oceania     02-ChinaHK       03-Japan      04-RoAsIC
01-Oceania                4689          39518          51084          29122
02-ChinaHK              107931          81949         221542         126297
03-Japan                140129         222511              0         163975
04-RoAsIC                48946          77722         100469          39071
05-AsiaDev                1846           2931           3789           2160
06-India                  5800           9210          11906           6787
07-CSAsDev                2594           4120           5325           3036
08-USA                  587684         933185        1206303         687690
09-Mexico                 5803           9214          11911           6790
10-RoNA                  27590          43810          56632          32285
11-CAmCar                 1754           2786           3601           2053
12-Brazil                 6923          10992          14209           8101
13-RoLAm                 14365          22810          29485          16809
14-France               187262         297353         384380         219128
15-Germany              184197         292487         378090         215542
16-Italy                 69863         110935         143403          81751
17-UK                   381916         606445         783935         446906
18-REuroZ               524052         832143        1075690         613230
19-Russia                19303          30651          39621          22587
20-RoEEurp               14284          22682          29320          16715
21-RoEurope             150942         239681         309829         176627
22-Turkey                 2969           4714           6094           3474
23-MENA                  25714          40831          52781          30089
24-SAfrica                5013           7960          10290           5866
25-RoAfrica               3380           5368           6939           3956


+                   05-AsiaDev       06-India     07-CSAsDev         08-USA
01-Oceania                3271           5055           2494         375401
02-ChinaHK               14186          21921          10814        1628045
03-Japan                 18418          28461          14040        2113735
04-RoAsIC                 6433           9941           4904         738311
05-AsiaDev                  18            375            185          27847
06-India                   762              0            581          87491
07-CSAsDev                 341            527            154          39134
08-USA                   77244         119360          58882              0
09-Mexico                  763           1179            581          87530
10-RoNA                   3626           5604           2764         416172
11-CAmCar                  231            356            176          26465
12-Brazil                  910           1406            694         104420
13-RoLAm                  1888           2917           1439         216678
14-France                24613          38033          18762        2824689
15-Germany               24210          37411          18455        2778465
16-Italy                  9183          14189           7000        1053823
17-UK                    50198          77568          38266        5760891
18-REuroZ                68880         106437          52507        7904901
19-Russia                 2537           3920           1934         291164
20-RoEEurp                1877           2901           1431         215466
21-RoEurope              19839          30657          15123        2276833
22-Turkey                  390            603            297          44783
23-MENA                   3380           5223           2576         387871
24-SAfrica                 659           1018            502          75617
25-RoAfrica                444            687            339          50989


+                    09-Mexico        10-RoNA      11-CAmCar      12-Brazil
01-Oceania                8811          17680           1681          13563
02-ChinaHK               38210          76673           7291          58820
03-Japan                 49609          99547           9465          76367
04-RoAsIC                17328          34771           3306          26674
05-AsiaDev                 654           1311            125           1006
06-India                  2053           4120            392           3161
07-CSAsDev                 918           1843            175           1414
08-USA                  208056         417486          39697         320275
09-Mexico                    0           4122            392           3162
10-RoNA                   9768              0           1864          15036
11-CAmCar                  621           1246             96            956
12-Brazil                 2451           4918            468              0
13-RoLAm                  5085          10204            970           7828
14-France                66296         133029          12649         102053
15-Germany               65211         130852          12442         100383
16-Italy                 24733          49630           4719          38074
17-UK                   135208         271310          25798         208136
18-REuroZ               185528         372283          35399         285597
19-Russia                 6834          13712           1304          10519
20-RoEEurp                5057          10147            965           7785
21-RoEurope              53437         107228          10196          82260
22-Turkey                 1051           2109            201           1618
23-MENA                   9103          18267           1737          14013
24-SAfrica                1775           3561            339           2732
25-RoAfrica               1197           2401            228           1842


+                     13-RoLAm      14-France     15-Germany       16-Italy
01-Oceania                7770         103629          99261          49219
02-ChinaHK               33696         449420         430478         213452
03-Japan                 43749         583494         558902         277131
04-RoAsIC                15281         203810         195220          96800
05-AsiaDev                 576           7687           7363           3651
06-India                  1811          24152          23134          11471
07-CSAsDev                 810          10803          10348           5131
08-USA                  183476        2447101        2343963        1162253
09-Mexico                 1812          24162          23144          11476
10-RoNA                   8614         114884         110042          54564
11-CAmCar                  548           7306           6998           3470
12-Brazil                 2161          28825          27610          13691
13-RoLAm                  3641          59814          57293          28409
14-France                58463              0         746888         370344
15-Germany               57507         766992              0         364284
16-Italy                 21811         290907         278646              0
17-UK                   119235        1590288        1523262         755309
18-REuroZ               163610        2182139        2090169        1036409
19-Russia                 6026          80376          76988          38174
20-RoEEurp                4460          59479          56972          28250
21-RoEurope              47124         628517         602027         298515
22-Turkey                  927          12362          11841           5872
23-MENA                   8028         107071         102559          50854
24-SAfrica                1565          20874          19994           9914
25-RoAfrica               1055          14076          13482           6685


+                        17-UK      18-REuroZ      19-Russia     20-RoEEurp
01-Oceania              223309         319103          15349          16314
02-ChinaHK              968448        1383889          66565          70752
03-Japan               1257362        1796741          86423          91859
04-RoAsIC               439187         627588          30187          32086
05-AsiaDev               16565          23670           1139           1210
06-India                 52044          74370           3577           3802
07-CSAsDev               23279          33265           1600           1701
08-USA                 5273216        7535304         362447         385245
09-Mexico                52067          74403           3579           3804
10-RoNA                 247561         353759          17016          18086
11-CAmCar                15743          22496           1082           1150
12-Brazil                62115          88761           4269           4538
13-RoLAm                128892         184183           8859           9416
14-France              1680275        2401074         115491         122756
15-Germany             1652779        2361782         113601         120747
16-Italy                626870         895783          43087          45797
17-UK                        0        4896939         235542         250358
18-REuroZ              4702255        5510512         323203         343533
19-Russia               173200         247499              0          12653
20-RoEEurp              128171         183153           8810           7766
21-RoEurope            1354382        1935380          93091          98947
22-Turkey                26639          38067           1831           1946
23-MENA                 230726         329702          15859          16856
24-SAfrica               44981          64277           3092           3286
25-RoAfrica              30331          43342           2085           2216


+                  21-RoEurope      22-Turkey        23-MENA     24-SAfrica
01-Oceania               70876           5719           9766           3947
02-ChinaHK              307375          24801          42355          17117
03-Japan                399073          32200          54991          22223
04-RoAsIC               139393          11247          19208           7762
05-AsiaDev                5257            424            724            293
06-India                 16518           1333           2276            920
07-CSAsDev                7388            596           1018            411
08-USA                 1673662         135041         230624          93200
09-Mexico                16526           1333           2277            920
10-RoNA                  78573           6340          10827           4375
11-CAmCar                 4997            403            689            278
12-Brazil                19715           1591           2717           1098
13-RoLAm                 40909           3301           5637           2278
14-France               533301          43030          73487          29698
15-Germany              524574          42326          72284          29212
16-Italy                198962          16053          27416          11079
17-UK                  1087656          87758         149875          60568
18-REuroZ              1492445         120419         205653          83109
19-Russia                54972           4435           7575           3061
20-RoEEurp               40680           3282           5606           2265
21-RoEurope             296250          34684          59234          23938
22-Turkey                 8455              0           1165            471
23-MENA                  73230           5909           8637           4078
24-SAfrica               14277           1152           1967              0
25-RoAfrica               9627            777           1327            536


+                  25-RoAfrica
01-Oceania                2384
02-ChinaHK               10339
03-Japan                 13424
04-RoAsIC                 4689
05-AsiaDev                 177
06-India                   556
07-CSAsDev                 249
08-USA                   56298
09-Mexico                  556
10-RoNA                   2643
11-CAmCar                  168
12-Brazil                  663
13-RoLAm                  1376
14-France                17939
15-Germany               17646
16-Italy                  6693
17-UK                    36586
18-REuroZ                50203
19-Russia                 1849
20-RoEEurp                1368
21-RoEurope              14460
22-Turkey                  284
23-MENA                   2463
24-SAfrica                 480
25-RoAfrica                272
;
