# calc_best_response

    Code
      db = grstat_example(N = 500)
      data_br = calc_best_response(db$recist)
      as.data.frame(data_br)
    Output
          subjid       best_response       date target_sum target_sum_diff_first
      1        1 Progressive disease 2031-08-29      191.3          1.0992276623
      2        2      Stable disease 2036-02-25       30.8         -0.0683339215
      3        3   Complete response 2032-01-31        0.0         -1.0000000000
      4        4      Stable disease 2024-06-09       58.6         -0.1505507856
      5        5    Partial response 2033-09-17       27.2         -0.5621945299
      6        6 Progressive disease 2033-06-09       58.5          0.2495657354
      7        7 Progressive disease 2028-09-05      134.0          0.4054126859
      8        8      Stable disease 2032-02-24       49.6          0.0517336580
      9        9    Partial response 2025-06-10        2.1         -0.9810045365
      10      10 Progressive disease 2032-08-22       64.9          0.3487514388
      11      11 Progressive disease 2025-08-31      122.8          0.3775141514
      12      12    Partial response 2024-08-08       21.4         -0.8195605804
      13      13    Partial response 2023-06-09      104.9         -0.3576722069
      14      14      Stable disease 2030-12-13       37.2         -0.1065496467
      15      15   Complete response 2027-06-02        0.0         -1.0000000000
      16      16    Partial response 2036-03-20       39.5         -0.4281868719
      17      17    Partial response 2037-08-03        6.8         -0.8360355809
      18      18 Progressive disease 2028-10-22      107.5          0.3978812659
      19      19      Stable disease 2034-07-09      150.6         -0.0598250879
      20      20      Stable disease 2029-02-16       73.7         -0.1774865720
      21      21    Partial response 2024-02-14       22.1         -0.4583445140
      22      22    Partial response 2036-02-10       58.3         -0.5492139045
      23      23      Stable disease 2029-11-23       33.4         -0.2551705325
      24      24    Partial response 2031-05-12       12.4         -0.8565482944
      25      25      Stable disease 2029-05-17      103.5         -0.0314049749
      26      26   Complete response 2028-09-07        0.0         -1.0000000000
      27      27      Stable disease 2035-07-23       46.9          0.1092211906
      28      28      Stable disease 2030-12-13      136.8          0.0953445298
      29      29      Stable disease 2033-05-06       74.1          0.1613888401
      30      30    Partial response 2033-05-21        1.4         -0.9545456814
      31      31   Complete response 2028-03-09        0.0         -1.0000000000
      32      32   Complete response 2034-12-21        0.0         -1.0000000000
      33      33      Stable disease 2030-10-07       69.0         -0.1487062780
      34      34      Stable disease 2036-02-23       35.0          0.1029802649
      35      35   Complete response 2036-08-15        0.0         -1.0000000000
      36      36   Complete response 2036-04-14        0.0         -1.0000000000
      37      37 Progressive disease 2030-02-26       45.3          0.7116151575
      38      38 Progressive disease 2034-03-30       32.9          0.3443511738
      39      39   Complete response 2031-10-13        0.0         -1.0000000000
      40      40      Stable disease 2025-07-21       36.3         -0.2894012085
      41      41 Progressive disease 2030-02-16       68.2          0.2139560516
      42      42      Stable disease 2029-11-06       44.1          0.1259110389
      43      43   Complete response 2032-02-09        0.0         -1.0000000000
      44      44 Progressive disease 2035-10-26       41.9          0.4858759237
      45      45      Stable disease 2024-04-23      127.9         -0.1426966730
      46      46   Complete response 2033-12-20        0.0         -1.0000000000
      47      47      Stable disease 2032-11-11       28.0          0.0912688675
      48      48   Complete response 2028-06-13        0.0         -1.0000000000
      49      49      Stable disease 2035-09-19       41.1          0.1091137492
      50      50 Progressive disease 2024-05-19       86.1          0.2358360326
      51      51      Stable disease 2035-05-17       70.3          0.1783882333
      52      52   Complete response 2026-10-13        0.0         -1.0000000000
      53      53 Progressive disease 2029-01-19      122.4          0.2583294212
      54      54      Stable disease 2024-06-17       56.0         -0.1917673325
      55      55 Progressive disease 2028-04-25       77.6          0.4726864284
      56      56      Stable disease 2035-08-21       58.0         -0.0050864512
      57      57      Stable disease 2029-08-18       61.3         -0.1289973964
      58      58 Progressive disease 2024-12-13       71.6          0.3587630365
      59      59      Stable disease 2028-04-08      104.4          0.0883085767
      60      60      Stable disease 2023-06-27       62.9          0.0743599061
      61      61   Complete response 2034-12-16        0.0         -1.0000000000
      62      62 Progressive disease 2028-07-24       90.0          0.6199603028
      63      63    Partial response 2033-05-20       27.7         -0.5893541125
      64      64    Partial response 2034-09-10       46.2         -0.4977829881
      65      65   Complete response 2035-10-23        0.0         -1.0000000000
      66      66   Complete response 2030-07-29        0.0         -1.0000000000
      67      67      Stable disease 2032-09-08       49.8         -0.1710423258
      68      68   Complete response 2033-12-15        0.0         -1.0000000000
      69      69    Partial response 2031-11-08       35.7         -0.5400779966
      70      70      Stable disease 2023-04-03       67.8         -0.0534209151
      71      71 Progressive disease 2032-03-28       24.4          0.3043641997
      72      72 Progressive disease 2034-07-03       57.8          0.2221317901
      73      73   Complete response 2031-02-09        0.0         -1.0000000000
      74      74 Progressive disease 2025-07-24       29.6          0.3835461321
      75      75 Progressive disease 2028-03-12       40.5          0.2012409063
      76      76    Partial response 2025-04-08        6.1         -0.9095356740
      77      77    Partial response 2023-10-15       40.1         -0.4510260634
      78      78   Complete response 2035-03-30        0.0         -1.0000000000
      79      79   Complete response 2029-06-21        0.0         -1.0000000000
      80      80      Stable disease 2031-02-22       20.2          0.1877760412
      81      81    Partial response 2030-10-11       17.3         -0.8186225574
      82      82   Complete response 2025-04-05        0.0         -1.0000000000
      83      83      Stable disease 2030-08-21       56.5          0.0730590472
      84      84      Stable disease 2035-03-20       54.8          0.1817194758
      85      85      Stable disease 2025-10-16       14.5          0.0232790230
      86      86 Progressive disease 2026-02-13       97.9          0.4321259987
      87      87      Stable disease 2029-09-28       47.7          0.0969096791
      88      88    Partial response 2026-09-16       27.9         -0.3732773383
      89      89 Progressive disease 2030-11-05      103.7          0.3294805345
      90      90 Progressive disease 2025-05-04       93.7          0.2551371996
      91      91      Stable disease 2035-01-21       86.1         -0.0617183501
      92      92   Complete response 2033-12-18        0.0         -1.0000000000
      93      93 Progressive disease 2027-11-01       83.8          0.2055740076
      94      94 Progressive disease 2030-04-13      112.8          0.2296514261
      95      95      Stable disease 2028-09-23       12.8         -0.2324451948
      96      96 Progressive disease 2030-01-02       30.8          0.2739790154
      97      97   Complete response 2024-07-26        0.0         -1.0000000000
      98      98 Progressive disease 2036-01-05      247.9          0.5561172189
      99      99   Complete response 2035-11-11        0.0         -1.0000000000
      100    100   Complete response 2037-02-02        0.0         -1.0000000000
      101    101   Complete response 2036-07-27        0.0         -1.0000000000
      102    102 Progressive disease 2024-09-01      151.8          0.8661823663
      103    103 Progressive disease 2023-08-28       26.7          0.3414563897
      104    104      Stable disease 2027-08-01      106.7          0.0118111930
      105    105    Partial response 2030-12-24       15.2         -0.4932792449
      106    106      Stable disease 2033-03-06       63.6          0.1962664215
      107    107 Progressive disease 2035-04-05       56.0          0.5000405730
      108    108 Progressive disease 2031-05-12       66.2          0.4288953555
      109    109   Complete response 2023-05-07        0.0         -1.0000000000
      110    110      Stable disease 2029-07-26       47.5         -0.1133896063
      111    111      Stable disease 2030-11-29       53.2          0.0802639468
      112    112   Complete response 2035-07-24        0.0         -1.0000000000
      113    113      Stable disease 2035-03-15       29.6         -0.1647135007
      114    114   Complete response 2026-02-23        0.0         -1.0000000000
      115    115      Stable disease 2026-04-29      128.7          0.1060299555
      116    116 Progressive disease 2030-06-03       54.5          0.4144826551
      117    117    Partial response 2028-11-17       12.3         -0.6447190899
      118    118      Stable disease 2027-12-22      124.4         -0.0507927369
      119    119      Stable disease 2033-10-05      137.8          0.0428320912
      120    120    Partial response 2033-10-08        4.7         -0.9131522373
      121    121      Stable disease 2028-08-03       79.6         -0.0817431584
      122    122 Progressive disease 2030-05-22      124.6          0.3628334209
      123    123      Stable disease 2024-09-28       59.3          0.1034391063
      124    124      Stable disease 2027-10-29       19.4         -0.0348655302
      125    125   Complete response 2024-07-03        0.0         -1.0000000000
      126    126    Partial response 2029-06-13        0.0         -1.0000000000
      127    127   Complete response 2023-06-22        0.0         -1.0000000000
      128    128   Complete response 2027-08-10        0.0         -1.0000000000
      129    129      Stable disease 2031-07-16        9.6         -0.2758849350
      130    130   Complete response 2034-05-29        0.0         -1.0000000000
      131    131 Progressive disease 2034-06-12       82.6          0.2323094623
      132    132 Progressive disease 2029-05-04       58.9          0.6726454325
      133    133 Progressive disease 2026-06-04       60.5          0.2099543479
      134    134      Stable disease 2035-02-09       86.2          0.0300323829
      135    135    Partial response 2033-08-08        2.2         -0.9763937536
      136    136 Progressive disease 2033-12-27       23.7          0.3870529013
      137    137      Stable disease 2028-04-06       36.8         -0.2082686561
      138    138      Stable disease 2036-03-31       80.8         -0.0609559527
      139    139    Partial response 2030-08-14       20.0         -0.4430228001
      140    140    Partial response 2028-02-19       32.5         -0.3288717478
      141    141      Stable disease 2030-07-10       33.4         -0.2956080261
      142    142 Progressive disease 2033-01-27       28.2          0.2066943571
      143    143    Partial response 2030-08-31       18.6         -0.4926278258
      144    144      Stable disease 2030-04-12       35.4         -0.2792668599
      145    145   Complete response 2036-04-20        0.0         -1.0000000000
      146    146      Stable disease 2027-03-26       87.9          0.0539368590
      147    147    Partial response 2032-09-13       11.4         -0.6795071360
      148    148    Partial response 2025-06-28       17.4         -0.5297923693
      149    149    Partial response 2027-04-26       29.1         -0.5895967851
      150    150   Complete response 2033-04-08        0.0         -1.0000000000
      151    151      Stable disease 2029-05-30       54.9          0.1254832718
      152    152   Complete response 2033-10-12        0.0         -1.0000000000
      153    153   Complete response 2028-07-03        0.0         -1.0000000000
      154    154 Progressive disease 2028-05-03       64.2          0.5362295711
      155    155      Stable disease 2026-11-14       25.5         -0.2909702470
      156    156 Progressive disease 2032-07-29       16.2          0.2604620136
      157    157 Progressive disease 2033-01-03       70.2          0.4105693321
      158    158   Complete response 2035-04-16        0.0         -1.0000000000
      159    159 Progressive disease 2034-11-19       43.9          0.2913576366
      160    160   Complete response 2031-02-12        0.0         -1.0000000000
      161    161 Progressive disease 2025-12-31       66.8          0.4932638635
      162    162 Progressive disease 2027-08-03       25.7          0.4400559770
      163    163    Partial response 2031-02-18       26.5         -0.5172708334
      164    164      Stable disease 2035-08-07       33.8         -0.1359442778
      165    165 Progressive disease 2032-08-03       98.8          0.4593708546
      166    166   Complete response 2034-04-12        0.0         -1.0000000000
      167    167      Stable disease 2032-05-02       21.7          0.0732360097
      168    168      Stable disease 2034-09-22       49.8         -0.2174672489
      169    169    Partial response 2033-05-17        6.9         -0.8686888377
      170    170   Complete response 2037-04-11        0.0         -1.0000000000
      171    171      Stable disease 2023-07-16       38.2         -0.1138259449
      172    172      Stable disease 2031-06-17       78.2          0.0412980948
      173    173 Progressive disease 2029-09-26      104.2          0.2673527607
      174    174      Stable disease 2036-09-01       97.2         -0.0346010854
      175    175   Complete response 2026-08-10        0.0         -1.0000000000
      176    176 Progressive disease 2025-04-21       60.0          0.3193563555
      177    177    Partial response 2034-05-01       30.8         -0.6904140274
      178    178 Progressive disease 2034-03-03       83.6          0.2065187631
      179    179 Progressive disease 2031-07-27       93.6          0.4512569331
      180    180    Partial response 2035-09-13       34.8         -0.3013357305
      181    181 Progressive disease 2027-09-03       70.3          0.2888753407
      182    182    Partial response 2037-05-11        5.0         -0.8460436176
      183    183 Progressive disease 2036-10-15       75.5          0.2364036138
      184    184    Partial response 2030-01-31        2.2         -0.9626102341
      185    185    Partial response 2031-06-16       20.7         -0.5026694733
      186    186 Progressive disease 2028-11-29      223.3          0.4147873509
      187    187      Stable disease 2032-01-30       78.8          0.1095081042
      188    188 Progressive disease 2025-07-04       89.7          0.3463233036
      189    189      Stable disease 2025-01-09       29.2          0.1721822423
      190    190 Progressive disease 2032-06-04      146.7          0.4259021506
      191    191    Partial response 2028-01-16        3.0         -0.9465705006
      192    192   Complete response 2025-08-15        0.0         -1.0000000000
      193    193      Stable disease 2036-06-13       58.7          0.0194803928
      194    194    Partial response 2028-04-16        1.0         -0.9105539700
      195    195   Complete response 2026-09-11        0.0         -1.0000000000
      196    196    Partial response 2027-10-04        3.3         -0.9600354815
      197    197    Partial response 2033-08-23       30.4         -0.5105713934
      198    198    Partial response 2027-11-16       14.2         -0.7899241283
      199    199      Stable disease 2035-05-10       77.2         -0.2609388709
      200    200   Complete response 2035-06-28        0.0         -1.0000000000
      201    201 Progressive disease 2030-07-03      232.4          0.4048020299
      202    202    Partial response 2024-03-12        2.8         -0.9533436879
      203    203 Progressive disease 2023-04-27      115.3          0.3542439909
      204    204      Stable disease 2033-05-06       79.6         -0.2879262719
      205    205 Progressive disease 2032-12-14      118.8          0.5981369666
      206    206 Progressive disease 2023-10-01       20.9          0.3506236397
      207    207   Complete response 2024-12-24        0.0         -1.0000000000
      208    208   Complete response 2025-01-12        0.0         -1.0000000000
      209    209 Progressive disease 2030-01-09       37.6          0.2276473374
      210    210   Complete response 2025-10-26        0.0         -1.0000000000
      211    211   Complete response 2032-04-13        0.0         -1.0000000000
      212    212      Stable disease 2024-10-18      131.7          0.1853207608
      213    213      Stable disease 2033-01-09       51.5         -0.0325593984
      214    214 Progressive disease 2030-03-11       63.6          0.3396028718
      215    215 Progressive disease 2026-08-17      114.7          0.7681901415
      216    216 Progressive disease 2035-03-01       64.1          0.2538521334
      217    217 Progressive disease 2032-06-08       41.4         -0.1007303417
      218    218    Partial response 2026-08-10        8.0         -0.9151676280
      219    219 Progressive disease 2027-08-16       63.5          0.4601361997
      220    220      Stable disease 2026-12-23       10.2         -0.1124209285
      221    221   Complete response 2023-04-20        0.0         -1.0000000000
      222    222      Stable disease 2030-05-15       28.6         -0.2751164630
      223    223 Progressive disease 2024-01-19       63.5          0.8488261608
      224    224   Complete response 2032-09-10        0.0         -1.0000000000
      225    225 Progressive disease 2026-02-26       77.7          0.2362576302
      226    226   Complete response 2029-02-19        0.0         -1.0000000000
      227    227   Complete response 2023-10-22        0.0         -1.0000000000
      228    228      Stable disease 2027-08-10       51.0          0.1869010340
      229    229    Partial response 2027-09-03        5.6         -0.8148447998
      230    230 Progressive disease 2028-11-16      105.4          0.2044737200
      231    231    Partial response 2026-02-03       23.1         -0.4479902712
      232    232      Stable disease 2028-06-04       86.8          0.1065985931
      233    233   Complete response 2029-03-16        0.0         -1.0000000000
      234    234      Stable disease 2029-11-29       25.9         -0.2808854915
      235    235      Stable disease 2029-07-18       35.0         -0.1650655436
      236    236 Progressive disease 2024-01-30       56.4          0.4736992595
      237    237    Partial response 2025-07-08       48.1         -0.4682803844
      238    238    Partial response 2032-12-16       12.6         -0.7445103121
      239    239      Stable disease 2032-04-30       54.9         -0.0423323222
      240    240 Progressive disease 2026-06-29       35.1          0.6153639975
      241    241   Complete response 2023-12-31        0.0         -1.0000000000
      242    242      Stable disease 2030-01-24       79.0         -0.0117843745
      243    243    Partial response 2036-03-09        6.7         -0.9236505954
      244    244   Complete response 2032-01-14        0.0         -1.0000000000
      245    245 Progressive disease 2026-05-18      156.9          0.4611579774
      246    246   Complete response 2030-03-27        0.0         -1.0000000000
      247    247 Progressive disease 2034-03-19       97.9          0.2160556376
      248    248    Partial response 2030-11-14       24.2         -0.5081148456
      249    249   Complete response 2032-03-06        0.0         -1.0000000000
      250    250    Partial response 2025-04-04        6.8         -0.6739929266
      251    251 Progressive disease 2026-08-08       22.1          0.2912413766
      252    252    Partial response 2032-08-17       19.9         -0.6133783789
      253    253    Partial response 2030-06-08        6.1         -0.5656855811
      254    254      Stable disease 2029-03-04       54.8         -0.0161680564
      255    255    Partial response 2030-01-20       54.9         -0.3826686899
      256    256    Partial response 2024-08-12       10.7         -0.4363611823
      257    257 Progressive disease 2026-04-23       45.5          0.6339413136
      258    258    Partial response 2028-12-23        7.3         -0.8579681378
      259    259 Progressive disease 2029-09-16       24.8          0.2736160510
      260    260 Progressive disease 2032-10-03       55.4          0.4389056802
      261    261    Partial response 2025-06-14       21.4         -0.7190961914
      262    262 Progressive disease 2031-10-19       97.3          0.2303007976
      263    263   Complete response 2031-09-23        0.0         -1.0000000000
      264    264 Progressive disease 2026-06-12      136.6          0.3127600891
      265    265    Partial response 2031-04-24       22.5         -0.5349327310
      266    266 Progressive disease 2032-12-26      107.1          0.3070029565
      267    267      Stable disease 2034-08-22       81.4          0.0941470361
      268    268    Partial response 2033-06-27       12.0         -0.7289697816
      269    269 Progressive disease 2029-04-27      101.1          0.2001437980
      270    270      Stable disease 2023-09-19       46.7         -0.0989600271
      271    271 Progressive disease 2033-09-02      101.0          0.5026955325
      272    272    Partial response 2034-12-12        3.4         -0.9338188015
      273    273      Stable disease 2023-10-29       57.2          0.0452762465
      274    274 Progressive disease 2031-04-08       86.6          0.3757614088
      275    275      Stable disease 2027-02-27       41.6          0.0917629970
      276    276    Partial response 2030-09-11       52.5         -0.4120897644
      277    277      Stable disease 2027-11-17       73.8          0.1511141116
      278    278 Progressive disease 2028-09-05       18.2          0.4308297718
      279    279    Partial response 2026-03-11       10.2         -0.8884603039
      280    280      Stable disease 2034-10-02       75.6         -0.1222954521
      281    281      Stable disease 2030-10-09       80.8          0.0813383379
      282    282      Stable disease 2031-11-02      133.1          0.1977848448
      283    283   Complete response 2024-02-19        0.0         -1.0000000000
      284    284    Partial response 2032-06-20       29.9         -0.5670770934
      285    285    Partial response 2035-04-03       23.7         -0.5381166796
      286    286   Complete response 2032-11-20        0.0         -1.0000000000
      287    287   Complete response 2034-02-12        0.0         -1.0000000000
      288    288    Partial response 2032-10-31        9.1         -0.6424163420
      289    289   Complete response 2035-08-21        0.0         -1.0000000000
      290    290    Partial response 2024-09-29       20.6         -0.6461141332
      291    291      Stable disease 2036-03-15       31.5          0.0724464923
      292    292 Progressive disease 2029-09-01       79.9          0.2606255511
      293    293 Progressive disease 2029-06-22       36.6          0.4280999501
      294    294      Stable disease 2024-10-15      124.8          0.0725181754
      295    295 Progressive disease 2027-10-18       57.3          0.2378798799
      296    296   Complete response 2036-11-06        0.0         -1.0000000000
      297    297 Progressive disease 2033-09-23       63.8          0.4173949156
      298    298   Complete response 2030-04-12        0.0         -1.0000000000
      299    299    Partial response 2027-05-14       13.3         -0.7486782676
      300    300    Partial response 2026-01-22       11.0         -0.8535810757
      301    301      Stable disease 2026-01-12       38.3         -0.2318703908
      302    302   Complete response 2033-03-30        0.0         -1.0000000000
      303    303   Complete response 2029-05-31        0.0         -1.0000000000
      304    304    Partial response 2025-12-01       20.0         -0.7224233275
      305    305    Partial response 2028-07-13       13.3         -0.7083705621
      306    306   Complete response 2031-02-20        0.0         -1.0000000000
      307    307   Complete response 2036-09-05        0.0         -1.0000000000
      308    308   Complete response 2027-08-14        0.0         -1.0000000000
      309    309      Stable disease 2036-06-25       13.8          0.0945314224
      310    310 Progressive disease 2034-02-01       60.3          0.2307284293
      311    311      Stable disease 2036-05-02       37.7         -0.2124690517
      312    312      Stable disease 2035-10-31       20.6         -0.2435475817
      313    313 Progressive disease 2034-02-11       26.3          0.3864566465
      314    314      Stable disease 2032-10-05       36.5          0.1744626874
      315    315      Stable disease 2035-03-14       73.1          0.0812932603
      316    316   Complete response 2034-04-12        0.0         -1.0000000000
      317    317      Stable disease 2036-03-11       26.0         -0.0171382999
      318    318    Partial response 2031-03-04       19.5         -0.6448248495
      319    319   Complete response 2028-02-27        0.0         -1.0000000000
      320    320 Progressive disease 2028-12-15      119.4          0.4672592294
      321    321 Progressive disease 2035-05-29       47.5          0.3394567652
      322    322   Complete response 2036-01-05        0.0         -1.0000000000
      323    323   Complete response 2025-11-05        0.0         -1.0000000000
      324    324    Partial response 2029-04-22       20.8         -0.5839399204
      325    325 Progressive disease 2028-10-05      129.5          0.2418314667
      326    326 Progressive disease 2025-09-29       31.4          0.2440491027
      327    327      Stable disease 2034-03-16       71.6         -0.1512979041
      328    328 Progressive disease 2030-02-01       67.0          0.3150871049
      329    329    Partial response 2034-02-20       13.9         -0.4427478732
      330    330    Partial response 2024-09-16        2.7         -0.9436761812
      331    331      Stable disease 2034-07-12       56.1         -0.2251718395
      332    332   Complete response 2037-01-28        0.0         -1.0000000000
      333    333    Partial response 2036-04-07        1.5         -0.9441081264
      334    334 Progressive disease 2025-04-11       87.5          0.6030654803
      335    335   Complete response 2032-05-13        0.0         -1.0000000000
      336    336    Partial response 2028-06-22       22.7         -0.5250673428
      337    337   Complete response 2033-11-25        0.0         -1.0000000000
      338    338    Partial response 2026-07-06        6.0         -0.4444301884
      339    339   Complete response 2026-12-09        0.0         -1.0000000000
      340    340    Partial response 2025-10-19       11.8         -0.6548370978
      341    341      Stable disease 2025-11-08       56.6          0.1467427995
      342    342 Progressive disease 2034-04-08       95.2          0.3577704995
      343    343    Partial response 2029-12-14        8.3         -0.7754419462
      344    344    Partial response 2031-07-08        7.9         -0.5236259375
      345    345    Partial response 2033-04-28       35.4         -0.4810387072
      346    346    Partial response 2028-04-30       36.1         -0.3804033320
      347    347 Progressive disease 2036-05-02      110.4          0.3031098089
      348    348   Complete response 2023-08-10        0.0         -1.0000000000
      349    349   Complete response 2036-04-06        0.0         -1.0000000000
      350    350    Partial response 2031-07-29       49.0         -0.4591662627
      351    351 Progressive disease 2030-08-11      104.3          0.4541608753
      352    352   Complete response 2033-08-05        0.0         -1.0000000000
      353    353 Progressive disease 2024-03-03       89.8          0.2476406219
      354    354    Partial response 2029-10-11       11.0         -0.5386330618
      355    355   Complete response 2036-02-02        0.0         -1.0000000000
      356    356    Partial response 2036-03-22       34.1         -0.6017566077
      357    357      Stable disease 2032-07-05       48.0          0.1623502929
      358    358    Partial response 2025-11-28       27.4         -0.6339657567
      359    359    Partial response 2026-07-24       21.2         -0.4862246248
      360    360 Progressive disease 2024-11-24      286.2          0.6102813493
      361    361    Partial response 2031-11-22       14.9         -0.3927173959
      362    362   Complete response 2028-03-17        0.0         -1.0000000000
      363    363    Partial response 2037-01-16       19.5         -0.4502595220
      364    364      Stable disease 2031-04-12       46.3          0.1600909550
      365    365    Partial response 2023-12-28       24.5         -0.4603436657
      366    366      Stable disease 2030-05-01       36.9         -0.1358836566
      367    367      Stable disease 2025-08-27      111.7          0.0462126138
      368    368      Stable disease 2024-08-22       86.6         -0.0242467199
      369    369   Complete response 2030-04-05        0.0         -1.0000000000
      370    370   Complete response 2036-07-24        0.0         -1.0000000000
      371    371 Progressive disease 2024-04-05      175.7          0.7773818064
      372    372      Stable disease 2026-01-22       37.9         -0.2802292811
      373    373    Partial response 2034-06-27        2.6         -0.9701747717
      374    374   Complete response 2029-10-18        0.0         -1.0000000000
      375    375 Progressive disease 2023-11-12      128.8          0.3791523765
      376    376   Complete response 2033-02-22        0.0         -1.0000000000
      377    377   Complete response 2029-11-02        0.0         -1.0000000000
      378    378   Complete response 2031-04-30        0.0         -1.0000000000
      379    379      Stable disease 2031-01-14       61.6          0.1404011653
      380    380   Complete response 2032-01-10        0.0         -1.0000000000
      381    381 Progressive disease 2030-12-30       85.1         -0.3062400121
      382    382      Stable disease 2031-09-23       17.1         -0.0336325779
      383    383   Complete response 2035-03-04        0.0         -1.0000000000
      384    384 Progressive disease 2031-06-19      126.6          0.3812568785
      385    385   Complete response 2025-07-25        0.0         -1.0000000000
      386    386    Partial response 2024-05-04       14.9         -0.6571146326
      387    387   Complete response 2034-03-08        0.0         -1.0000000000
      388    388    Partial response 2030-10-27       19.3         -0.7159048327
      389    389   Complete response 2036-08-15        0.0         -1.0000000000
      390    390 Progressive disease 2027-01-02       96.8          0.3705497464
      391    391   Complete response 2035-09-27        0.0         -1.0000000000
      392    392      Stable disease 2034-05-14       39.0         -0.0474772096
      393    393      Stable disease 2029-05-10       73.5          0.1316316984
      394    394 Progressive disease 2024-12-12       42.7          0.2740984965
      395    395   Complete response 2024-02-25        0.0         -1.0000000000
      396    396   Complete response 2036-11-30        0.0         -1.0000000000
      397    397      Stable disease 2025-06-10       47.3         -0.2522967686
      398    398      Stable disease 2023-05-14       56.2         -0.0180059413
      399    399      Stable disease 2027-04-21       44.1          0.0417707468
      400    400      Stable disease 2036-08-20       77.3         -0.0080967413
      401    401      Stable disease 2027-12-01       67.4         -0.2515051318
      402    402    Partial response 2025-06-03        4.8         -0.7993465980
      403    403      Stable disease 2036-09-15       44.0         -0.1483531733
      404    404   Complete response 2032-12-11        0.0         -1.0000000000
      405    405      Stable disease 2025-12-01       34.8          0.0658718563
      406    406 Progressive disease 2031-05-23       27.9          0.3923656220
      407    407 Progressive disease 2027-03-21       64.4          0.2898828007
      408    408 Progressive disease 2032-11-25       95.1          0.3650974430
      409    409 Progressive disease 2023-10-21      123.6          0.3106372755
      410    410      Stable disease 2035-06-19       83.3         -0.0281357618
      411    411   Complete response 2032-12-29        0.0         -1.0000000000
      412    412   Complete response 2029-04-26        0.0         -1.0000000000
      413    413   Complete response 2024-07-19        0.0         -1.0000000000
      414    414      Stable disease 2028-08-23       26.6         -0.0321640537
      415    415      Stable disease 2027-10-26       22.3         -0.1641505983
      416    416   Complete response 2025-05-27        0.0         -1.0000000000
      417    417   Complete response 2035-05-05        0.0         -1.0000000000
      418    418   Complete response 2027-06-16        0.0         -1.0000000000
      419    419 Progressive disease 2034-09-22       38.4          0.2370212666
      420    420    Partial response 2029-10-04       59.9         -0.3735275270
      421    421      Stable disease 2023-11-14       60.6         -0.1797362751
      422    422    Partial response 2027-04-17       42.2         -0.7562294750
      423    423      Stable disease 2025-04-06       50.4         -0.0481921221
      424    424      Stable disease 2027-01-17       35.9          0.1153616202
      425    425 Progressive disease 2027-07-27      120.3          0.5695036684
      426    426 Progressive disease 2027-05-13       77.5          0.5021676046
      427    427   Complete response 2032-11-20        0.0         -1.0000000000
      428    428      Stable disease 2031-01-29       65.5          0.0371815971
      429    429      Stable disease 2034-01-16       44.3         -0.1883212772
      430    430      Stable disease 2033-07-18       38.0         -0.1567075408
      431    431      Stable disease 2032-02-08      109.4         -0.0108205619
      432    432      Stable disease 2034-08-30       39.8          0.1665251797
      433    433 Progressive disease 2024-11-02       55.9          0.5581277474
      434    434    Partial response 2030-04-18       88.7         -0.3660227139
      435    435   Complete response 2036-03-06        0.0         -1.0000000000
      436    436 Progressive disease 2036-08-14      101.3          0.3205460817
      437    437   Complete response 2029-03-26        0.0         -1.0000000000
      438    438   Complete response 2028-01-22        0.0         -1.0000000000
      439    439      Stable disease 2024-09-21       11.1         -0.2371389461
      440    440    Partial response 2027-06-16       12.3         -0.8681079967
      441    441      Stable disease 2036-01-11       83.6         -0.0786545367
      442    442    Partial response 2025-03-25        2.7         -0.9550262987
      443    443    Partial response 2035-04-30       44.3         -0.5230412137
      444    444      Stable disease 2033-03-25       19.2         -0.1993482853
      445    445      Stable disease 2034-06-09       89.8          0.1436641957
      446    446    Partial response 2024-09-24       11.1         -0.6579316455
      447    447      Stable disease 2026-08-31       42.7         -0.2839021878
      448    448      Stable disease 2029-09-10       35.4         -0.1369667739
      449    449   Complete response 2025-05-15        0.0         -1.0000000000
      450    450      Stable disease 2026-10-28       71.4          0.0755692103
      451    451    Partial response 2025-10-06        1.4         -0.8713869540
      452    452      Stable disease 2034-01-13       32.1         -0.2442180215
      453    453   Complete response 2034-12-03        0.0         -1.0000000000
      454    454    Partial response 2026-01-28       22.7         -0.4009918041
      455    455 Progressive disease 2023-05-30       79.4          0.4941724482
      456    456    Partial response 2025-04-05       16.1         -0.6018160788
      457    457 Progressive disease 2031-12-19      121.3          0.2308433130
      458    458    Partial response 2027-12-08        1.5         -0.9789991434
      459    459   Complete response 2035-10-07        0.0         -1.0000000000
      460    460 Progressive disease 2026-10-03       21.4         -0.1815714947
      461    461      Stable disease 2028-05-18       63.7         -0.1441735392
      462    462      Stable disease 2027-07-19      114.5          0.0138043469
      463    463      Stable disease 2034-11-21       45.9         -0.2224213915
      464    464   Complete response 2035-01-17        0.0         -1.0000000000
      465    465   Complete response 2031-03-06        0.0         -1.0000000000
      466    466 Progressive disease 2027-11-12       72.7          0.4855664129
      467    467 Progressive disease 2030-07-20      124.4          0.3934670238
      468    468   Complete response 2028-12-07        0.0         -1.0000000000
      469    469   Complete response 2025-09-26        0.0         -1.0000000000
      470    470      Stable disease 2028-12-19       29.0          0.0003664538
      471    471 Progressive disease 2029-01-21       63.3          0.2729168842
      472    472      Stable disease 2029-12-29      185.2          0.0647322080
      473    473      Stable disease 2026-07-05       65.7         -0.0725040575
      474    474    Partial response 2027-05-26       57.1         -0.4719735142
      475    475      Stable disease 2033-10-19       39.6         -0.2707006768
      476    476      Stable disease 2024-02-15       28.1         -0.2656155311
      477    477      Stable disease 2032-07-02       36.1          0.0236756199
      478    478   Complete response 2024-05-22        0.0         -1.0000000000
      479    479    Partial response 2026-05-17       25.4         -0.5727059653
      480    480 Progressive disease 2026-12-04       84.4          0.3637142733
      481    481   Complete response 2031-08-28        0.0         -1.0000000000
      482    482 Progressive disease 2027-04-10      173.3          0.5665099932
      483    483    Partial response 2034-08-10       31.4         -0.7735408631
      484    484    Partial response 2026-02-09       75.6         -0.4960491883
      485    485 Progressive disease 2035-04-22      108.4          0.4878684490
      486    486 Progressive disease 2023-04-24       55.9          0.3093925915
      487    487 Progressive disease 2033-10-05       74.4          0.2807646419
      488    488   Complete response 2032-10-27        0.0         -1.0000000000
      489    489    Partial response 2036-10-27       13.1         -0.6139378435
      490    490    Partial response 2027-12-30       44.9         -0.3285836653
      491    491    Partial response 2027-06-12        6.5         -0.8544239975
      492    492    Partial response 2026-12-17        2.1         -0.9548832641
      493    493    Partial response 2034-04-05       32.5         -0.3206259850
      494    494   Complete response 2033-06-26        0.0         -1.0000000000
      495    495      Stable disease 2028-06-19       32.2          0.0205021747
      496    496   Complete response 2025-10-26        0.0         -1.0000000000
      497    497      Stable disease 2029-01-13       90.1          0.1707686511
      498    498   Complete response 2023-07-16        0.0         -1.0000000000
      499    499      Stable disease 2033-06-02       44.5         -0.1703606668
      500    500    Partial response 2024-04-19       19.1         -0.6154105548
          target_sum_diff_min
      1          1.0992276623
      2          0.0000000000
      3                   NaN
      4          0.0000000000
      5          0.0000000000
      6          0.2495657354
      7          0.4054126859
      8          0.0517336580
      9          0.0000000000
      10         0.3487514388
      11         0.3775141514
      12         0.0000000000
      13         0.0000000000
      14         0.0000000000
      15                  NaN
      16         1.2701149425
      17         0.0000000000
      18         0.3978812659
      19         0.0000000000
      20         0.0000000000
      21         0.0000000000
      22         0.0000000000
      23         0.0000000000
      24         0.0000000000
      25         0.0000000000
      26                  NaN
      27         0.1092211906
      28         0.0953445298
      29         0.1613888401
      30         0.0000000000
      31                  NaN
      32                  NaN
      33         0.0000000000
      34         0.1029802649
      35                  NaN
      36                  NaN
      37         0.7116151575
      38         0.3443511738
      39                  NaN
      40         0.0000000000
      41         0.2139560516
      42         0.1259110389
      43                  NaN
      44         0.4858759237
      45         0.0000000000
      46                  NaN
      47         0.0912688675
      48                  NaN
      49         0.1091137492
      50         0.2358360326
      51         0.1783882333
      52                  NaN
      53         0.2583294212
      54         0.0000000000
      55         0.4726864284
      56         0.0000000000
      57         0.0000000000
      58         0.3587630365
      59         0.0883085767
      60         0.0743599061
      61                  NaN
      62         0.6199603028
      63         0.0000000000
      64         0.0000000000
      65                  NaN
      66                  NaN
      67         0.0000000000
      68                  NaN
      69         0.0000000000
      70         0.0000000000
      71         0.3043641997
      72         0.2221317901
      73                  NaN
      74         0.3835461321
      75         0.2012409063
      76         0.0000000000
      77         0.0000000000
      78                  NaN
      79                  NaN
      80         0.1877760412
      81         0.0000000000
      82                  NaN
      83         0.0730590472
      84         0.1817194758
      85         0.0232790230
      86         0.4321259987
      87         0.0969096791
      88         0.0000000000
      89         0.3294805345
      90         0.2551371996
      91         0.0000000000
      92                  NaN
      93         0.2055740076
      94         0.2296514261
      95         0.0000000000
      96         0.2739790154
      97                  NaN
      98         0.5561172189
      99                  NaN
      100                 NaN
      101                 NaN
      102        0.8661823663
      103        0.3414563897
      104        0.0118111930
      105        0.0000000000
      106        0.1962664215
      107        0.5000405730
      108        0.4288953555
      109                 NaN
      110        0.0000000000
      111        0.0802639468
      112                 NaN
      113        0.0000000000
      114                 NaN
      115        0.1060299555
      116        0.4144826551
      117        0.0000000000
      118        0.0000000000
      119        0.0428320912
      120        0.0000000000
      121        0.0000000000
      122        0.3628334209
      123        0.6657303371
      124        0.0000000000
      125                 NaN
      126                 NaN
      127                 NaN
      128                 NaN
      129        0.0000000000
      130                 NaN
      131        0.2323094623
      132        0.6726454325
      133        0.2099543479
      134        0.0300323829
      135        0.2941176471
      136        0.3870529013
      137        0.0000000000
      138        0.0000000000
      139        0.0000000000
      140        0.0000000000
      141        0.0000000000
      142        0.2066943571
      143        0.0000000000
      144        0.0000000000
      145                 NaN
      146        0.0539368590
      147        0.0000000000
      148        0.0000000000
      149        0.0000000000
      150                 NaN
      151        0.1254832718
      152                 NaN
      153                 NaN
      154        0.5362295711
      155        0.0000000000
      156        0.2604620136
      157        0.4105693321
      158                 NaN
      159        0.2913576366
      160                 NaN
      161        0.4932638635
      162        0.4400559770
      163        0.0000000000
      164        0.0000000000
      165        0.4593708546
      166                 NaN
      167        0.0732360097
      168        0.5611285266
      169        0.0000000000
      170                 NaN
      171        0.0000000000
      172        0.0846047157
      173        0.2673527607
      174        0.0000000000
      175                 NaN
      176        0.3193563555
      177        0.0000000000
      178        0.2065187631
      179        0.4512569331
      180        0.0000000000
      181        0.2888753407
      182        0.0000000000
      183        0.2364036138
      184        0.0000000000
      185        0.0000000000
      186        0.4147873509
      187        0.1095081042
      188        0.3463233036
      189        0.1721822423
      190        0.4259021506
      191        0.0000000000
      192                 NaN
      193        0.0194803928
      194        0.0000000000
      195                 NaN
      196        0.0000000000
      197        0.0000000000
      198        0.0000000000
      199        0.0000000000
      200                 NaN
      201        0.4048020299
      202        0.0000000000
      203        0.3542439909
      204        0.0000000000
      205        0.5981369666
      206        0.3506236397
      207                 NaN
      208                 NaN
      209        0.2276473374
      210                 NaN
      211                 NaN
      212        0.1853207608
      213        0.0000000000
      214        0.3396028718
      215        0.7681901415
      216        0.2538521334
      217        0.0000000000
      218        0.8604651163
      219        0.4601361997
      220        0.0000000000
      221                 NaN
      222        0.0000000000
      223        0.8488261608
      224                 NaN
      225        0.2362576302
      226                 NaN
      227                 NaN
      228        0.1869010340
      229        0.0000000000
      230        0.2044737200
      231        0.0000000000
      232        0.1065985931
      233                 NaN
      234        0.0000000000
      235        0.0000000000
      236        0.4736992595
      237        0.0000000000
      238        0.0000000000
      239        0.0000000000
      240        0.6153639975
      241                 NaN
      242        0.0000000000
      243        0.0000000000
      244                 NaN
      245        0.4611579774
      246                 NaN
      247        0.2160556376
      248        0.0000000000
      249                 NaN
      250        0.0000000000
      251        0.2912413766
      252        0.3092105263
      253        0.0000000000
      254        0.0000000000
      255        0.8547297297
      256        0.0000000000
      257        0.6339413136
      258        0.0000000000
      259        0.2736160510
      260        0.4389056802
      261        0.0000000000
      262        0.2303007976
      263                 NaN
      264        0.3127600891
      265        0.0000000000
      266        0.3070029565
      267        0.0941470361
      268        0.1111111111
      269        0.2001437980
      270        0.0000000000
      271        0.5026955325
      272        0.0000000000
      273        0.0452762465
      274        0.3757614088
      275        0.0917629970
      276        0.0000000000
      277        0.1511141116
      278        0.4308297718
      279        0.0000000000
      280        0.0000000000
      281        0.0813383379
      282        0.1977848448
      283                 NaN
      284        0.0000000000
      285        0.0000000000
      286                 NaN
      287                 NaN
      288        0.0000000000
      289                 NaN
      290        0.0000000000
      291        0.0724464923
      292        0.2606255511
      293        0.4280999501
      294        0.0725181754
      295        0.2378798799
      296                 NaN
      297        0.4173949156
      298                 NaN
      299        0.0000000000
      300        0.0000000000
      301        0.0000000000
      302                 NaN
      303                 NaN
      304        0.0000000000
      305        0.0000000000
      306                 NaN
      307                 NaN
      308                 NaN
      309        0.0945314224
      310        0.2307284293
      311        0.0000000000
      312        0.0000000000
      313        0.3864566465
      314        0.1744626874
      315        0.0812932603
      316                 NaN
      317        0.0000000000
      318        0.0000000000
      319                 NaN
      320        0.4672592294
      321        0.3394567652
      322                 NaN
      323                 NaN
      324        0.0000000000
      325        0.2418314667
      326        0.2440491027
      327        0.0000000000
      328        0.3150871049
      329        0.0000000000
      330        0.0000000000
      331        0.0000000000
      332                 NaN
      333        0.0000000000
      334        0.6030654803
      335                 NaN
      336        0.0000000000
      337                 NaN
      338        0.0000000000
      339                 NaN
      340        0.0000000000
      341        0.1467427995
      342        0.3577704995
      343        0.0000000000
      344        0.0000000000
      345        0.0000000000
      346        0.0000000000
      347        0.3031098089
      348                 NaN
      349                 NaN
      350        0.0000000000
      351        0.4541608753
      352                 NaN
      353        0.2476406219
      354        0.0000000000
      355                 NaN
      356        0.0000000000
      357        0.1623502929
      358        0.0000000000
      359        0.0000000000
      360        0.6102813493
      361        0.0000000000
      362                 NaN
      363        0.0000000000
      364        0.1600909550
      365        0.0000000000
      366        0.0000000000
      367        0.0462126138
      368        0.9373601790
      369                 NaN
      370                 NaN
      371        0.7773818064
      372        0.0000000000
      373        0.0000000000
      374                 NaN
      375        0.3791523765
      376                 NaN
      377                 NaN
      378                 NaN
      379        0.1404011653
      380                 NaN
      381        0.0000000000
      382        0.0000000000
      383                 NaN
      384        0.3812568785
      385                 NaN
      386        0.0000000000
      387                 NaN
      388        0.0000000000
      389                 NaN
      390        0.3705497464
      391                 NaN
      392        0.0000000000
      393        0.1316316984
      394        0.2740984965
      395                 NaN
      396                 NaN
      397        0.0000000000
      398        0.0000000000
      399        0.0417707468
      400        0.0000000000
      401        0.0000000000
      402        0.0000000000
      403        0.0000000000
      404                 NaN
      405        0.0658718563
      406        0.3923656220
      407        0.2898828007
      408        0.3650974430
      409        0.3106372755
      410        0.0000000000
      411                 NaN
      412                 NaN
      413                 NaN
      414        0.0000000000
      415        0.0000000000
      416                 NaN
      417                 NaN
      418                 NaN
      419        0.2370212666
      420        0.0000000000
      421        0.0000000000
      422        0.0000000000
      423        0.0000000000
      424        0.1153616202
      425        0.5695036684
      426        0.5021676046
      427                 NaN
      428        0.0371815971
      429        0.0000000000
      430        0.0000000000
      431        0.0000000000
      432        0.1665251797
      433        0.5581277474
      434        0.0000000000
      435                 NaN
      436        0.3205460817
      437                 NaN
      438                 NaN
      439        0.0000000000
      440        0.0000000000
      441        0.0000000000
      442        0.0000000000
      443        0.0000000000
      444        0.0000000000
      445        0.1436641957
      446        0.0000000000
      447        0.0000000000
      448        0.0000000000
      449                 NaN
      450        0.0755692103
      451        0.0000000000
      452        0.0000000000
      453                 NaN
      454        0.0000000000
      455        0.4941724482
      456        0.0000000000
      457        0.2308433130
      458        0.0000000000
      459                 NaN
      460        0.0000000000
      461        0.0000000000
      462        0.0138043469
      463        0.0000000000
      464                 NaN
      465                 NaN
      466        0.4855664129
      467        0.3934670238
      468                 NaN
      469                 NaN
      470        0.0003664538
      471        0.2729168842
      472        0.0647322080
      473        0.0000000000
      474        0.0000000000
      475        0.7292576419
      476        0.0000000000
      477        0.0236756199
      478                 NaN
      479        0.0000000000
      480        0.3637142733
      481                 NaN
      482        0.5665099932
      483        0.0000000000
      484        0.0000000000
      485        0.4878684490
      486        0.3093925915
      487        0.2807646419
      488                 NaN
      489        0.0000000000
      490        0.0000000000
      491        0.0000000000
      492        0.2352941176
      493        0.0000000000
      494                 NaN
      495        0.0205021747
      496                 NaN
      497        0.1707686511
      498                 NaN
      499        0.0000000000
      500        0.0000000000

