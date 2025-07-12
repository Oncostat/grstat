# calc_best_response

    Code
      db = grstat_example(N = 500)
      data_br = calc_best_response(db$recist)
    Condition
      Warning:
      Target Lesions Length Sum is missing at baseline. (2 patients: #72 and #193)
    Code
      as.data.frame(data_br)
    Output
          subjid       best_response       date target_sum target_sum_diff_first
      1        1   Complete response 2023-05-01        0.0          -1.000000000
      2        2 Progressive disease 2023-04-27       30.8           0.770114943
      3        3      Stable disease 2023-04-29       79.0           0.122159091
      4        4   Complete response 2023-05-26        0.0          -1.000000000
      5        5   Complete response 2023-07-30        0.0          -1.000000000
      6        6      Stable disease 2023-06-25       57.1          -0.176046176
      7        7 Progressive disease 2023-07-21      128.3           0.240812379
      8        8    Partial response 2023-07-29       23.4          -0.305637982
      9        9   Complete response 2023-08-28        0.0          -1.000000000
      10      10   Complete response 2023-11-23        0.0          -1.000000000
      11      11   Complete response 2023-10-04        0.0          -1.000000000
      12      12 Progressive disease 2023-11-16       56.1           0.621387283
      13      13    Partial response 2023-11-05       27.3          -0.478011472
      14      14   Complete response 2023-11-28        0.0          -1.000000000
      15      15   Complete response 2024-02-24        0.0          -1.000000000
      16      16 Progressive disease 2024-01-10      189.0           2.058252427
      17      17 Progressive disease 2024-02-01      105.2           0.368010403
      18      18 Progressive disease 2024-03-13       81.9           0.713389121
      19      19   Complete response 2024-03-03        0.0          -1.000000000
      20      20 Progressive disease 2024-04-05        0.0          -1.000000000
      21      21   Complete response 2024-06-01        0.0          -1.000000000
      22      22 Progressive disease 2024-06-14        0.0          -1.000000000
      23      23   Complete response 2024-05-26        0.0          -1.000000000
      24      24   Complete response 2024-06-25        0.0          -1.000000000
      25      25 Progressive disease 2024-06-21       67.1           0.204667864
      26      26   Complete response 2024-08-07        0.0          -1.000000000
      27      27 Progressive disease 2024-08-26       89.7           1.354330709
      28      28   Complete response 2024-08-18        0.0          -1.000000000
      29      29   Complete response 2024-10-16        0.0          -1.000000000
      30      30   Complete response 2024-11-01        0.0          -1.000000000
      31      31   Complete response 2025-02-20        0.0          -1.000000000
      32      32   Complete response 2024-12-27        0.0          -1.000000000
      33      33   Complete response 2025-01-01        0.0          -1.000000000
      34      34 Progressive disease 2025-01-07      103.4           0.559577677
      35      35   Complete response 2025-01-15        0.0          -1.000000000
      36      36      Stable disease 2025-02-12       66.4           0.045669291
      37      37 Progressive disease 2025-03-06      302.4           1.918918919
      38      38    Partial response 2025-05-30       26.4          -0.735735736
      39      39   Complete response 2025-04-10        0.0          -1.000000000
      40      40   Complete response 2025-05-18        0.0          -1.000000000
      41      41   Complete response 2025-05-23        0.0          -1.000000000
      42      42   Complete response 2025-06-18        0.0          -1.000000000
      43      43   Complete response 2025-06-30        0.0          -1.000000000
      44      44      Stable disease 2025-07-23       29.3          -0.226912929
      45      45   Complete response 2025-11-04        0.0          -1.000000000
      46      46   Complete response 2025-09-09        0.0          -1.000000000
      47      47   Complete response 2025-11-20        0.0          -1.000000000
      48      48 Progressive disease 2025-09-26       90.9           0.293029872
      49      49   Complete response 2025-11-12        0.0          -1.000000000
      50      50    Partial response 2025-12-21       36.0          -0.404958678
      51      51    Partial response 2025-12-11       12.3          -0.614420063
      52      52   Complete response 2026-01-04        0.0          -1.000000000
      53      53 Progressive disease 2026-02-17       78.4           0.496183206
      54      54 Progressive disease 2026-03-12      122.6           0.645637584
      55      55   Complete response 2026-03-10        0.0          -1.000000000
      56      56   Complete response 2026-05-31        0.0          -1.000000000
      57      57    Partial response 2026-04-14       34.3          -0.308467742
      58      58   Complete response 2026-05-01        0.0          -1.000000000
      59      59 Progressive disease 2026-06-16      106.3           0.851916376
      60      60 Progressive disease 2026-07-13      175.4           0.757515030
      61      61      Stable disease 2026-07-07       35.0          -0.187935035
      62      62 Progressive disease 2026-08-21       76.1           0.225442834
      63      63      Stable disease 2026-09-03       69.0           0.031390135
      64      64   Complete response 2026-11-10        0.0          -1.000000000
      65      65   Complete response 2026-09-16        0.0          -1.000000000
      66      66    Partial response 2026-10-26        5.1          -0.725806452
      67      67 Progressive disease 2026-10-20       13.6          -0.609195402
      68      68   Complete response 2027-02-04        0.0          -1.000000000
      69      69   Complete response 2027-02-15        0.0          -1.000000000
      70      70 Progressive disease 2026-12-22       60.2           0.440191388
      71      71 Progressive disease 2027-02-02       68.3           1.246710526
      72      72      Stable disease 2027-05-04       72.6          -0.362038664
      73      73    Partial response 2027-05-09       14.6          -0.734061931
      74      74 Progressive disease 2027-04-05       33.2           0.551401869
      75      75   Complete response 2027-04-13        0.0          -1.000000000
      76      76 Progressive disease 2027-05-16       31.4          -0.158176944
      77      77   Complete response 2027-06-04        0.0          -1.000000000
      78      78 Progressive disease 2027-07-06       66.8          -0.332667333
      79      79   Complete response 2027-07-10        0.0          -1.000000000
      80      80   Complete response 2027-08-08        0.0          -1.000000000
      81      81 Progressive disease 2027-09-03       30.4           0.670329670
      82      82   Complete response 2027-09-11        0.0          -1.000000000
      83      83 Progressive disease 2027-10-10      228.2           1.432835821
      84      84    Partial response 2027-12-28       13.6          -0.800586510
      85      85    Partial response 2027-10-16       26.1          -0.541300527
      86      86   Complete response 2028-02-02        0.0          -1.000000000
      87      87   Complete response 2028-04-08        0.0          -1.000000000
      88      88 Progressive disease 2027-12-15      128.9           1.004665630
      89      89 Progressive disease 2028-01-10       14.3           0.415841584
      90      90   Complete response 2028-02-02        0.0          -1.000000000
      91      91    Partial response 2028-03-11       26.4          -0.335012594
      92      92 Progressive disease 2028-03-28      107.1           1.043893130
      93      93   Complete response 2028-04-14        0.0          -1.000000000
      94      94    Partial response 2028-07-07       15.3          -0.545994065
      95      95   Complete response 2028-06-02        0.0          -1.000000000
      96      96    Partial response 2028-06-21       51.8          -0.401847575
      97      97   Complete response 2028-06-21        0.0          -1.000000000
      98      98   Complete response 2028-08-19        0.0          -1.000000000
      99      99   Complete response 2028-07-31        0.0          -1.000000000
      100    100   Complete response 2028-08-21        0.0          -1.000000000
      101    101    Partial response 2028-10-04       32.2          -0.488076312
      102    102   Complete response 2028-10-29        0.0          -1.000000000
      103    103    Partial response 2028-10-19       19.3          -0.750645995
      104    104   Complete response 2028-11-28        0.0          -1.000000000
      105    105   Complete response 2028-11-22        0.0          -1.000000000
      106    106 Progressive disease 2028-12-29       46.1           0.897119342
      107    107   Complete response 2029-04-20        0.0          -1.000000000
      108    108 Progressive disease 2029-01-26       15.9          -0.308695652
      109    109 Progressive disease 2029-02-28      117.7           1.064912281
      110    110   Complete response 2029-05-10        0.0          -1.000000000
      111    111 Progressive disease 2029-03-25      203.6           0.710924370
      112    112   Complete response 2029-07-04        0.0          -1.000000000
      113    113   Complete response 2029-06-03        0.0          -1.000000000
      114    114 Progressive disease 2029-06-09      146.8           1.027624309
      115    115 Progressive disease 2029-06-03      131.2           1.040435459
      116    116 Progressive disease 2029-07-17      154.6           1.585284281
      117    117   Complete response 2029-07-06        0.0          -1.000000000
      118    118   Complete response 2029-12-07        0.0          -1.000000000
      119    119   Complete response 2029-08-22        0.0          -1.000000000
      120    120    Partial response 2029-10-12        8.9          -0.406666667
      121    121   Complete response 2029-11-04        0.0          -1.000000000
      122    122   Complete response 2030-01-21        0.0          -1.000000000
      123    123    Partial response 2029-11-21       23.3          -0.336182336
      124    124    Partial response 2029-12-20       26.9          -0.402222222
      125    125    Partial response 2030-02-10       70.2          -0.357731016
      126    126 Progressive disease 2030-02-04      146.1           1.034818942
      127    127   Complete response 2030-04-14        0.0          -1.000000000
      128    128   Complete response 2030-03-23        0.0          -1.000000000
      129    129 Progressive disease 2030-03-25       94.9           1.688385269
      130    130   Complete response 2030-04-09        0.0          -1.000000000
      131    131   Complete response 2030-04-19        0.0          -1.000000000
      132    132 Progressive disease 2030-06-21      101.5           0.201183432
      133    133   Complete response 2030-05-30        0.0          -1.000000000
      134    134    Partial response 2030-09-10        2.0          -0.974160207
      135    135   Complete response 2030-08-31        0.0          -1.000000000
      136    136   Complete response 2030-09-03        0.0          -1.000000000
      137    137 Progressive disease 2030-09-14       92.7           0.620629371
      138    138   Complete response 2030-09-11        0.0          -1.000000000
      139    139   Complete response 2030-11-05        0.0          -1.000000000
      140    140      Stable disease 2030-11-07       34.5          -0.290123457
      141    141 Progressive disease 2030-12-02      117.3           0.209278351
      142    142 Progressive disease 2030-11-18      179.2           1.146107784
      143    143   Complete response 2031-02-28        0.0          -1.000000000
      144    144   Complete response 2031-02-11        0.0          -1.000000000
      145    145 Progressive disease 2031-03-01       24.6           1.435643564
      146    146      Stable disease 2031-02-12      127.3           0.048599671
      147    147   Complete response 2031-04-03        0.0          -1.000000000
      148    148   Complete response 2031-06-26        0.0          -1.000000000
      149    149   Complete response 2031-08-07        0.0          -1.000000000
      150    150   Complete response 2031-06-22        0.0          -1.000000000
      151    151      Stable disease 2031-06-22       84.8          -0.256792287
      152    152   Complete response 2031-07-03        0.0          -1.000000000
      153    153   Complete response 2031-07-28        0.0          -1.000000000
      154    154    Partial response 2031-10-04       33.7          -0.525352113
      155    155   Complete response 2031-11-28        0.0          -1.000000000
      156    156 Progressive disease 2031-09-08      128.1           0.717158177
      157    157    Partial response 2031-10-10        0.0          -1.000000000
      158    158      Stable disease 2031-11-16       35.4           0.038123167
      159    159   Complete response 2032-01-09        0.0          -1.000000000
      160    160 Progressive disease 2031-12-21       93.3           1.015118790
      161    161   Complete response 2031-12-21        0.0          -1.000000000
      162    162 Progressive disease 2032-02-04      162.5           0.612103175
      163    163 Progressive disease 2032-02-05       30.6           0.348017621
      164    164   Complete response 2032-03-10        0.0          -1.000000000
      165    165   Complete response 2032-05-24        0.0          -1.000000000
      166    166   Complete response 2032-06-10        0.0          -1.000000000
      167    167   Complete response 2032-04-13        0.0          -1.000000000
      168    168    Partial response 2032-04-28       14.5          -0.690831557
      169    169 Progressive disease 2032-06-18        0.0          -1.000000000
      170    170   Complete response 2032-08-17        0.0          -1.000000000
      171    171   Complete response 2032-08-13        0.0          -1.000000000
      172    172      Stable disease 2032-10-01       27.1          -0.209912536
      173    173    Partial response 2032-08-17       72.9          -0.316135084
      174    174    Partial response 2032-09-02       32.6          -0.660770031
      175    175 Progressive disease 2032-10-04        0.0          -1.000000000
      176    176 Progressive disease 2032-11-10       93.0           0.570945946
      177    177   Complete response 2032-11-05        0.0          -1.000000000
      178    178   Complete response 2032-12-09        0.0          -1.000000000
      179    179   Complete response 2033-04-08        0.0          -1.000000000
      180    180   Complete response 2033-03-06        0.0          -1.000000000
      181    181   Complete response 2033-04-23        0.0          -1.000000000
      182    182 Progressive disease 2033-03-09       34.8           0.456066946
      183    183      Stable disease 2033-03-20       56.1           0.036968577
      184    184    Partial response 2033-04-09       23.6          -0.338935574
      185    185 Progressive disease 2033-04-29        0.0          -1.000000000
      186    186   Complete response 2033-07-08        0.0          -1.000000000
      187    187      Stable disease 2033-05-13       60.5          -0.067796610
      188    188      Stable disease 2033-06-16       58.8          -0.132743363
      189    189      Stable disease 2033-11-12       88.6          -0.041125541
      190    190   Complete response 2033-09-14        0.0          -1.000000000
      191    191   Complete response 2033-08-24        0.0          -1.000000000
      192    192 Progressive disease 2033-10-11       14.5          -0.393305439
      193    193    Partial response 2033-12-01       18.5          -0.459064327
      194    194 Progressive disease 2033-10-01      112.0           0.637426901
      195    195   Complete response 2034-01-14        0.0          -1.000000000
      196    196 Progressive disease 2033-12-09       53.7           0.487534626
      197    197      Stable disease 2033-12-06       25.7          -0.033834586
      198    198      Stable disease 2034-02-09       22.7           0.194736842
      199    199      Stable disease 2034-02-11       94.4           0.106682298
      200    200   Complete response 2034-02-15        0.0          -1.000000000
      201    201   Complete response 2034-04-05        0.0          -1.000000000
      202    202   Complete response 2034-04-16        0.0          -1.000000000
      203    203   Complete response 2034-04-08        0.0          -1.000000000
      204    204    Partial response 2034-05-27       13.6          -0.786833856
      205    205 Progressive disease 2034-05-27       52.5          -0.491771539
      206    206 Progressive disease 2034-06-24       32.5           1.850877193
      207    207   Complete response 2034-06-29        0.0          -1.000000000
      208    208   Complete response 2034-08-20        0.0          -1.000000000
      209    209   Complete response 2034-09-14        0.0          -1.000000000
      210    210 Progressive disease 2034-08-10      254.4           0.917106255
      211    211   Complete response 2034-09-30        0.0          -1.000000000
      212    212   Complete response 2034-10-08        0.0          -1.000000000
      213    213   Complete response 2034-11-06        0.0          -1.000000000
      214    214    Partial response 2034-12-14       15.5          -0.708097928
      215    215   Complete response 2034-12-31        0.0          -1.000000000
      216    216 Progressive disease 2034-12-26        0.0          -1.000000000
      217    217   Complete response 2035-01-24        0.0          -1.000000000
      218    218 Progressive disease 2035-02-04       72.3           1.120234604
      219    219    Partial response 2035-04-23       47.9          -0.345628415
      220    220    Partial response 2035-05-11       54.8          -0.413276231
      221    221 Progressive disease 2035-03-28       32.1           0.258823529
      222    222   Complete response 2035-06-21        0.0          -1.000000000
      223    223    Partial response 2035-07-16        0.0          -1.000000000
      224    224   Complete response 2035-05-25        0.0          -1.000000000
      225    225   Complete response 2035-06-12        0.0          -1.000000000
      226    226 Progressive disease 2035-07-24       62.2           0.264227642
      227    227 Progressive disease 2035-08-09       53.0           0.656250000
      228    228 Progressive disease 2035-08-04      190.8           0.669291339
      229    229    Partial response 2035-11-25       19.7          -0.586134454
      230    230    Partial response 2035-10-20       39.7          -0.631383473
      231    231   Complete response 2035-11-11        0.0          -1.000000000
      232    232 Progressive disease 2035-11-22       36.4          -0.276341948
      233    233   Complete response 2036-04-29        0.0          -1.000000000
      234    234    Partial response 2035-12-15        7.0          -0.832935561
      235    235   Complete response 2036-04-21        0.0          -1.000000000
      236    236   Complete response 2036-03-25        0.0          -1.000000000
      237    237    Partial response 2036-02-20       29.3          -0.518092105
      238    238   Complete response 2036-04-14        0.0          -1.000000000
      239    239   Complete response 2036-03-21        0.0          -1.000000000
      240    240 Progressive disease 2036-05-02      109.8           0.626666667
      241    241    Partial response 2036-05-10       26.1          -0.570723684
      242    242   Complete response 2036-06-01        0.0          -1.000000000
      243    243      Stable disease 2036-06-23       50.4          -0.129533679
      244    244   Complete response 2036-08-09        0.0          -1.000000000
      245    245   Complete response 2036-10-03        0.0          -1.000000000
      246    246    Partial response 2036-09-07       43.5          -0.608460846
      247    247   Complete response 2036-10-10        0.0          -1.000000000
      248    248   Complete response 2036-10-15        0.0          -1.000000000
      249    249   Complete response 2036-11-04        0.0          -1.000000000
      250    250 Progressive disease 2036-12-08      100.9           0.169177289
      251    251 Progressive disease 2036-11-12      183.8           1.374677003
      252    252      Stable disease 2037-01-13       20.0          -0.298245614
      253    253   Complete response 2037-02-06        0.0          -1.000000000
      254    254   Complete response 2037-04-11        0.0          -1.000000000
      255    255   Complete response 2037-03-15        0.0          -1.000000000
      256    256 Progressive disease 2037-03-29      120.6           0.552123552
      257    257 Progressive disease 2037-04-12       60.0           0.496259352
      258    258   Complete response 2037-04-10        0.0          -1.000000000
      259    259   Complete response 2037-06-01        0.0          -1.000000000
      260    260   Complete response 2037-07-05        0.0          -1.000000000
      261    261    Partial response 2037-06-11       29.9          -0.432637571
      262    262 Progressive disease 2037-07-02      112.2           0.220892274
      263    263   Complete response 2037-07-29        0.0          -1.000000000
      264    264   Complete response 2037-07-23        0.0          -1.000000000
      265    265    Partial response 2037-09-18       11.5          -0.786245353
      266    266   Complete response 2037-10-19        0.0          -1.000000000
      267    267    Partial response 2037-11-15       13.5          -0.635135135
      268    268   Complete response 2037-12-12        0.0          -1.000000000
      269    269   Complete response 2038-02-01        0.0          -1.000000000
      270    270   Complete response 2038-03-27        0.0          -1.000000000
      271    271      Stable disease 2037-12-12       57.7           0.107485605
      272    272 Progressive disease 2038-02-02       86.1           0.681640625
      273    273 Progressive disease 2038-02-10      118.6           0.350797267
      274    274 Progressive disease 2038-02-08      136.9           0.694306931
      275    275 Progressive disease 2038-03-20       96.4          -0.356904603
      276    276   Complete response 2038-05-10        0.0          -1.000000000
      277    277    Partial response 2038-07-25        9.1          -0.841186736
      278    278   Complete response 2038-06-23        0.0          -1.000000000
      279    279      Stable disease 2038-06-16       37.4          -0.148063781
      280    280   Complete response 2038-06-21        0.0          -1.000000000
      281    281   Complete response 2038-09-27        0.0          -1.000000000
      282    282   Complete response 2038-10-15        0.0          -1.000000000
      283    283   Complete response 2038-10-07        0.0          -1.000000000
      284    284 Progressive disease 2038-10-18       46.5          -0.135687732
      285    285 Progressive disease 2038-09-19      130.9           0.469135802
      286    286    Partial response 2038-11-11        6.5          -0.580645161
      287    287   Complete response 2038-11-29        0.0          -1.000000000
      288    288    Partial response 2039-03-09        2.8          -0.936507937
      289    289   Complete response 2039-02-10        0.0          -1.000000000
      290    290   Complete response 2039-02-23        0.0          -1.000000000
      291    291   Complete response 2039-03-28        0.0          -1.000000000
      292    292    Partial response 2039-06-21       17.4          -0.543307087
      293    293   Complete response 2039-04-11        0.0          -1.000000000
      294    294   Complete response 2039-08-21        0.0          -1.000000000
      295    295   Complete response 2039-06-15        0.0          -1.000000000
      296    296 Progressive disease 2039-04-27      159.4           0.639917695
      297    297   Complete response 2039-09-16        0.0          -1.000000000
      298    298    Partial response 2039-06-19        5.6          -0.813953488
      299    299   Complete response 2039-08-12        0.0          -1.000000000
      300    300    Partial response 2039-08-22       15.1          -0.659909910
      301    301   Complete response 2039-08-17        0.0          -1.000000000
      302    302    Partial response 2039-09-10       13.1          -0.552901024
      303    303 Progressive disease 2039-10-14      115.1           0.490932642
      304    304   Complete response 2039-10-13        0.0          -1.000000000
      305    305   Complete response 2039-12-31        0.0          -1.000000000
      306    306 Progressive disease 2039-12-01      130.4           0.528722157
      307    307   Complete response 2040-01-09        0.0          -1.000000000
      308    308 Progressive disease 2039-12-20      104.9           0.358808290
      309    309 Progressive disease 2040-01-18      113.3           0.533152909
      310    310 Progressive disease 2040-03-27       13.3          -0.611111111
      311    311    Partial response 2040-04-06       20.6          -0.666666667
      312    312 Progressive disease 2040-04-29       67.0           0.740259740
      313    313   Complete response 2040-04-22        0.0          -1.000000000
      314    314   Complete response 2040-05-05        0.0          -1.000000000
      315    315    Partial response 2040-06-24       39.4          -0.325342466
      316    316   Complete response 2040-06-24        0.0          -1.000000000
      317    317   Complete response 2040-08-16        0.0          -1.000000000
      318    318   Complete response 2040-07-24        0.0          -1.000000000
      319    319 Progressive disease 2040-08-25       59.7           0.431654676
      320    320   Complete response 2040-11-10        0.0          -1.000000000
      321    321 Progressive disease 2040-09-14       75.6           0.702702703
      322    322   Complete response 2040-10-11        0.0          -1.000000000
      323    323   Complete response 2040-12-17        0.0          -1.000000000
      324    324      Stable disease 2040-12-18       69.2          -0.201845444
      325    325    Partial response 2041-01-20       56.2          -0.322891566
      326    326   Complete response 2041-03-11        0.0          -1.000000000
      327    327    Partial response 2041-02-22       10.9          -0.468292683
      328    328   Complete response 2041-04-19        0.0          -1.000000000
      329    329 Progressive disease 2041-03-25       34.1           0.937500000
      330    330   Complete response 2041-06-12        0.0          -1.000000000
      331    331 Progressive disease 2041-04-05       83.3           0.226804124
      332    332   Complete response 2041-04-23        0.0          -1.000000000
      333    333 Progressive disease 2041-06-08       93.7           0.246010638
      334    334      Stable disease 2041-06-23       19.6          -0.212851406
      335    335   Complete response 2041-08-20        0.0          -1.000000000
      336    336   Complete response 2041-09-17        0.0          -1.000000000
      337    337   Complete response 2041-08-01        0.0          -1.000000000
      338    338   Complete response 2041-08-16        0.0          -1.000000000
      339    339   Complete response 2041-10-08        0.0          -1.000000000
      340    340   Complete response 2041-12-09        0.0          -1.000000000
      341    341    Partial response 2041-11-07        0.0          -1.000000000
      342    342   Complete response 2041-12-07        0.0          -1.000000000
      343    343 Progressive disease 2042-01-02       39.6           0.559055118
      344    344 Progressive disease 2042-01-25      108.7           0.955035971
      345    345   Complete response 2042-01-25        0.0          -1.000000000
      346    346   Complete response 2042-01-30        0.0          -1.000000000
      347    347   Complete response 2042-03-24        0.0          -1.000000000
      348    348   Complete response 2042-03-22        0.0          -1.000000000
      349    349 Progressive disease 2042-04-05        9.7          -0.779545455
      350    350   Complete response 2042-05-19        0.0          -1.000000000
      351    351   Complete response 2042-06-03        0.0          -1.000000000
      352    352 Progressive disease 2042-06-28        0.0          -1.000000000
      353    353   Complete response 2042-07-20        0.0          -1.000000000
      354    354      Stable disease 2042-07-10       61.9          -0.254216867
      355    355   Complete response 2042-08-21        0.0          -1.000000000
      356    356      Stable disease 2042-09-01       19.2          -0.072463768
      357    357   Complete response 2042-10-02        0.0          -1.000000000
      358    358   Complete response 2042-10-31        0.0          -1.000000000
      359    359    Partial response 2042-10-28       37.3          -0.331541219
      360    360   Complete response 2042-12-21        0.0          -1.000000000
      361    361 Progressive disease 2042-12-07        0.0          -1.000000000
      362    362   Complete response 2043-01-08        0.0          -1.000000000
      363    363 Progressive disease 2043-02-17       55.0           1.806122449
      364    364 Progressive disease 2043-01-22      166.6           1.260515604
      365    365 Progressive disease 2043-03-19      114.8           0.208421053
      366    366 Progressive disease 2043-02-24       89.8           0.213513514
      367    367   Complete response 2043-04-06        0.0          -1.000000000
      368    368   Complete response 2043-05-26        0.0          -1.000000000
      369    369   Complete response 2043-06-11        0.0          -1.000000000
      370    370   Complete response 2043-05-21        0.0          -1.000000000
      371    371   Complete response 2043-08-10        0.0          -1.000000000
      372    372 Progressive disease 2043-06-30       23.6           0.289617486
      373    373 Progressive disease 2043-07-27      181.0           1.114485981
      374    374   Complete response 2043-08-16        0.0          -1.000000000
      375    375   Complete response 2043-09-27        0.0          -1.000000000
      376    376 Progressive disease 2043-09-12       38.2           1.808823529
      377    377   Complete response 2044-01-17        0.0          -1.000000000
      378    378    Partial response 2043-11-22       32.4          -0.659663866
      379    379    Partial response 2043-12-07        0.0          -1.000000000
      380    380   Complete response 2043-12-17        0.0          -1.000000000
      381    381 Progressive disease 2044-01-02       45.2           0.403726708
      382    382   Complete response 2044-02-23        0.0          -1.000000000
      383    383    Partial response 2044-02-19       46.4          -0.364383562
      384    384    Partial response 2044-05-01        5.5          -0.719387755
      385    385   Complete response 2044-06-09        0.0          -1.000000000
      386    386   Complete response 2044-05-28        0.0          -1.000000000
      387    387 Progressive disease 2044-05-29       16.0           0.290322581
      388    388   Complete response 2044-07-11        0.0          -1.000000000
      389    389   Complete response 2044-06-16        0.0          -1.000000000
      390    390 Progressive disease 2044-07-18       58.6           0.498721228
      391    391    Partial response 2044-07-23        7.9          -0.701886792
      392    392 Progressive disease 2044-08-11        0.0          -1.000000000
      393    393 Progressive disease 2044-10-12        0.0          -1.000000000
      394    394   Complete response 2044-09-22        0.0          -1.000000000
      395    395   Complete response 2044-11-11        0.0          -1.000000000
      396    396   Complete response 2044-12-01        0.0          -1.000000000
      397    397   Complete response 2044-11-25        0.0          -1.000000000
      398    398   Complete response 2045-01-24        0.0          -1.000000000
      399    399 Progressive disease 2044-12-22       87.4           0.832285115
      400    400   Complete response 2045-02-26        0.0          -1.000000000
      401    401      Stable disease 2045-03-17       81.2           0.037037037
      402    402   Complete response 2045-03-21        0.0          -1.000000000
      403    403      Stable disease 2045-04-07       51.5           0.107526882
      404    404   Complete response 2045-06-15        0.0          -1.000000000
      405    405      Stable disease 2045-06-24      106.9          -0.128769356
      406    406    Partial response 2045-06-20       13.3          -0.811614731
      407    407   Complete response 2045-06-29        0.0          -1.000000000
      408    408   Complete response 2045-08-25        0.0          -1.000000000
      409    409   Complete response 2045-08-20        0.0          -1.000000000
      410    410   Complete response 2045-08-18        0.0          -1.000000000
      411    411      Stable disease 2045-09-05      100.4          -0.011811024
      412    412    Partial response 2045-09-14       24.5          -0.422169811
      413    413 Progressive disease 2045-11-08        0.0          -1.000000000
      414    414 Progressive disease 2045-10-24      127.3           0.587281796
      415    415   Complete response 2045-11-28        0.0          -1.000000000
      416    416   Complete response 2045-12-12        0.0          -1.000000000
      417    417   Complete response 2046-01-11        0.0          -1.000000000
      418    418   Complete response 2046-01-29        0.0          -1.000000000
      419    419   Complete response 2046-01-27        0.0          -1.000000000
      420    420   Complete response 2046-05-16        0.0          -1.000000000
      421    421   Complete response 2046-07-28        0.0          -1.000000000
      422    422   Complete response 2046-06-17        0.0          -1.000000000
      423    423      Stable disease 2046-05-27       13.5          -0.262295082
      424    424    Partial response 2046-07-22       30.4          -0.396825397
      425    425 Progressive disease 2046-06-07      159.5           0.822857143
      426    426 Progressive disease 2046-06-16      142.6           0.807351077
      427    427    Partial response 2046-08-12       11.0          -0.731051345
      428    428   Complete response 2046-07-27        0.0          -1.000000000
      429    429   Complete response 2046-12-23        0.0          -1.000000000
      430    430 Progressive disease 2046-09-02       79.8           0.789237668
      431    431   Complete response 2046-12-04        0.0          -1.000000000
      432    432 Progressive disease 2046-10-25       58.2           0.742514970
      433    433 Progressive disease 2046-11-16      118.8           0.973421927
      434    434 Progressive disease 2046-12-29       73.1           1.094555874
      435    435   Complete response 2047-02-08        0.0          -1.000000000
      436    436   Complete response 2047-01-28        0.0          -1.000000000
      437    437   Complete response 2047-02-03        0.0          -1.000000000
      438    438   Complete response 2047-02-17        0.0          -1.000000000
      439    439   Complete response 2047-07-12        0.0          -1.000000000
      440    440   Complete response 2047-05-31        0.0          -1.000000000
      441    441 Progressive disease 2047-04-09       76.5           0.197183099
      442    442   Complete response 2047-05-09        0.0          -1.000000000
      443    443    Partial response 2047-06-07       53.6          -0.353437877
      444    444   Complete response 2047-07-05        0.0          -1.000000000
      445    445   Complete response 2047-07-18        0.0          -1.000000000
      446    446   Complete response 2047-09-25        0.0          -1.000000000
      447    447   Complete response 2047-09-05        0.0          -1.000000000
      448    448   Complete response 2047-08-29        0.0          -1.000000000
      449    449 Progressive disease 2047-09-12      128.9           0.568126521
      450    450 Progressive disease 2047-11-14       88.8           0.241958042
      451    451   Complete response 2047-11-21        0.0          -1.000000000
      452    452   Complete response 2047-12-27        0.0          -1.000000000
      453    453   Complete response 2047-12-30        0.0          -1.000000000
      454    454   Complete response 2048-01-02        0.0          -1.000000000
      455    455    Partial response 2048-03-03        8.6          -0.786600496
      456    456   Complete response 2048-02-01        0.0          -1.000000000
      457    457   Complete response 2048-05-05        0.0          -1.000000000
      458    458   Complete response 2048-04-22        0.0          -1.000000000
      459    459 Progressive disease 2048-05-19       87.0           0.394230769
      460    460   Complete response 2048-05-26        0.0          -1.000000000
      461    461 Progressive disease 2048-05-14      105.4           0.540935673
      462    462 Progressive disease 2048-07-04       51.1           0.928301887
      463    463   Complete response 2048-07-17        0.0          -1.000000000
      464    464      Stable disease 2048-07-28       64.6           0.062500000
      465    465      Stable disease 2048-11-22       87.8          -0.004535147
      466    466 Progressive disease 2048-09-25      128.7           0.400435256
      467    467    Partial response 2048-10-07       47.1          -0.568285976
      468    468   Complete response 2048-11-01        0.0          -1.000000000
      469    469      Stable disease 2048-11-02       44.5          -0.049145299
      470    470 Progressive disease 2049-02-03        0.0          -1.000000000
      471    471    Partial response 2049-01-06       13.4          -0.319796954
      472    472   Complete response 2049-02-25        0.0          -1.000000000
      473    473 Progressive disease 2049-01-23       32.5           0.719576720
      474    474   Complete response 2049-03-19        0.0          -1.000000000
      475    475      Stable disease 2049-02-11       58.2           0.112810707
      476    476 Progressive disease 2049-04-07       57.5           0.239224138
      477    477 Progressive disease 2049-04-30       28.6           0.466666667
      478    478   Complete response 2049-07-12        0.0          -1.000000000
      479    479   Complete response 2049-06-12        0.0          -1.000000000
      480    480 Progressive disease 2049-07-05      117.7           0.923202614
      481    481 Progressive disease 2049-07-26       34.1           0.550000000
      482    482      Stable disease 2049-07-25       69.7           0.120578778
      483    483    Partial response 2049-08-08       16.0          -0.831756046
      484    484   Complete response 2049-09-28        0.0          -1.000000000
      485    485 Progressive disease 2049-09-16       40.2           0.601593625
      486    486 Progressive disease 2049-11-05       57.6           0.604456825
      487    487 Progressive disease 2049-10-23      120.4           0.300215983
      488    488   Complete response 2049-12-11        0.0          -1.000000000
      489    489 Progressive disease 2049-12-26      255.5           2.692196532
      490    490 Progressive disease 2050-01-11       66.4           0.045669291
      491    491 Progressive disease 2050-02-01       36.6           0.391634981
      492    492 Progressive disease 2050-03-03      129.5           0.602722772
      493    493    Partial response 2050-03-29       53.7          -0.394588501
      494    494 Progressive disease 2050-04-02      126.2           0.500594530
      495    495   Complete response 2050-07-21        0.0          -1.000000000
      496    496 Progressive disease 2050-05-25       97.3           0.231645570
      497    497 Progressive disease 2050-05-12       19.9          -0.019704433
      498    498   Complete response 2050-09-11        0.0          -1.000000000
      499    499   Complete response 2050-07-15        0.0          -1.000000000
      500    500   Complete response 2050-09-20        0.0          -1.000000000
          target_sum_diff_min
      1                   NaN
      2            0.77011494
      3            0.12215909
      4                   NaN
      5                   NaN
      6                   Inf
      7            0.24081238
      8            0.00000000
      9                   NaN
      10                  NaN
      11                  NaN
      12           0.62138728
      13           0.00000000
      14                  NaN
      15                  NaN
      16           2.05825243
      17           0.36801040
      18           0.71338912
      19                  NaN
      20                  NaN
      21                  NaN
      22                  NaN
      23                  NaN
      24                  NaN
      25           0.20466786
      26                  NaN
      27           1.35433071
      28                  NaN
      29                  NaN
      30                  NaN
      31                  NaN
      32                  NaN
      33                  NaN
      34           0.55957768
      35                  NaN
      36           0.04566929
      37           1.91891892
      38           0.00000000
      39                  NaN
      40                  NaN
      41                  NaN
      42                  NaN
      43                  NaN
      44           0.00000000
      45                  NaN
      46                  NaN
      47                  NaN
      48           0.29302987
      49                  NaN
      50           0.00000000
      51           0.00000000
      52                  NaN
      53           0.49618321
      54           0.64563758
      55                  NaN
      56                  NaN
      57           0.00000000
      58                  NaN
      59           0.85191638
      60           0.75751503
      61           0.00000000
      62           0.22544283
      63           0.31428571
      64                  NaN
      65                  NaN
      66           0.00000000
      67           0.00000000
      68                  NaN
      69                  NaN
      70           0.44019139
      71           1.24671053
      72           0.00000000
      73           0.62222222
      74           0.55140187
      75                  NaN
      76           0.00000000
      77                  NaN
      78           0.00000000
      79                  NaN
      80                  NaN
      81           0.67032967
      82                  NaN
      83           1.43283582
      84           0.00000000
      85           0.00000000
      86                  NaN
      87                  NaN
      88           1.00466563
      89           0.41584158
      90                  NaN
      91           0.00000000
      92           1.04389313
      93                  NaN
      94           0.00000000
      95                  NaN
      96           0.00000000
      97                  NaN
      98                  NaN
      99                  NaN
      100                 NaN
      101          0.00000000
      102                 NaN
      103          0.00000000
      104                 NaN
      105                 NaN
      106          0.89711934
      107                 NaN
      108          0.00000000
      109          1.06491228
      110                 NaN
      111          0.71092437
      112                 NaN
      113                 NaN
      114          1.02762431
      115          1.04043546
      116          1.58528428
      117                 NaN
      118                 NaN
      119                 NaN
      120          0.00000000
      121                 NaN
      122                 NaN
      123          0.00000000
      124          0.00000000
      125          0.00000000
      126          1.03481894
      127                 NaN
      128                 NaN
      129          1.68838527
      130                 NaN
      131                 NaN
      132          0.20118343
      133                 NaN
      134                 Inf
      135                 NaN
      136                 NaN
      137          0.62062937
      138                 NaN
      139                 NaN
      140          0.00000000
      141          0.20927835
      142          1.14610778
      143                 NaN
      144                 NaN
      145          1.43564356
      146          0.04859967
      147                 NaN
      148                 NaN
      149                 NaN
      150                 NaN
      151          0.00000000
      152                 NaN
      153                 NaN
      154          0.00000000
      155                 NaN
      156          0.71715818
      157                 NaN
      158          0.03812317
      159                 NaN
      160          1.01511879
      161                 NaN
      162          0.61210317
      163          0.34801762
      164                 NaN
      165                 NaN
      166                 NaN
      167                 NaN
      168          0.00000000
      169                 NaN
      170                 NaN
      171                 NaN
      172          0.00000000
      173          0.00000000
      174          0.00000000
      175                 NaN
      176          0.57094595
      177                 NaN
      178                 NaN
      179                 NaN
      180                 NaN
      181                 NaN
      182          0.45606695
      183          0.03696858
      184          0.00000000
      185                 NaN
      186                 NaN
      187          0.00000000
      188                 Inf
      189          0.00000000
      190                 NaN
      191                 NaN
      192          0.00000000
      193          0.00000000
      194          0.63742690
      195                 NaN
      196          0.48753463
      197          0.00000000
      198          0.19473684
      199          0.10668230
      200                 NaN
      201                 NaN
      202                 NaN
      203                 NaN
      204          0.00000000
      205          0.00000000
      206          1.85087719
      207                 NaN
      208                 NaN
      209                 NaN
      210          0.91710625
      211                 NaN
      212                 NaN
      213                 NaN
      214          0.00000000
      215                 NaN
      216                 NaN
      217                 NaN
      218          1.12023460
      219          0.00000000
      220          0.00000000
      221          0.25882353
      222                 NaN
      223                 NaN
      224                 NaN
      225                 NaN
      226          0.26422764
      227          0.65625000
      228          0.66929134
      229          4.96969697
      230          0.00000000
      231                 NaN
      232          0.00000000
      233                 NaN
      234          0.00000000
      235                 NaN
      236                 NaN
      237          0.00000000
      238                 NaN
      239                 NaN
      240          0.62666667
      241          0.00000000
      242                 NaN
      243          0.00000000
      244                 NaN
      245                 NaN
      246          0.00000000
      247                 NaN
      248                 NaN
      249                 NaN
      250          0.16917729
      251          1.37467700
      252          0.00000000
      253                 NaN
      254                 NaN
      255                 NaN
      256          0.55212355
      257          0.49625935
      258                 NaN
      259                 NaN
      260                 NaN
      261          0.00000000
      262          0.22089227
      263                 NaN
      264                 NaN
      265          0.00000000
      266                 NaN
      267          0.00000000
      268                 NaN
      269                 NaN
      270                 NaN
      271          0.10748560
      272          0.68164062
      273          0.35079727
      274          0.69430693
      275          0.00000000
      276                 NaN
      277          0.00000000
      278                 NaN
      279          0.00000000
      280                 NaN
      281                 NaN
      282                 NaN
      283                 NaN
      284          0.00000000
      285          0.46913580
      286          0.00000000
      287                 NaN
      288          0.00000000
      289                 NaN
      290                 NaN
      291                 NaN
      292          3.14285714
      293                 NaN
      294                 NaN
      295                 NaN
      296          0.63991770
      297                 NaN
      298          0.00000000
      299                 NaN
      300          0.00000000
      301                 NaN
      302          0.00000000
      303          0.49093264
      304                 NaN
      305                 NaN
      306          0.52872216
      307                 NaN
      308          0.35880829
      309          0.53315291
      310          0.00000000
      311          0.00000000
      312          0.74025974
      313                 NaN
      314                 NaN
      315          0.00000000
      316                 NaN
      317                 NaN
      318                 NaN
      319          0.43165468
      320                 NaN
      321          0.70270270
      322                 NaN
      323                 NaN
      324          0.00000000
      325          0.00000000
      326                 NaN
      327          0.00000000
      328                 NaN
      329          0.93750000
      330                 NaN
      331          0.22680412
      332                 NaN
      333          0.24601064
      334          0.00000000
      335                 NaN
      336                 NaN
      337                 NaN
      338                 NaN
      339                 NaN
      340                 NaN
      341                 NaN
      342                 NaN
      343          0.55905512
      344          0.95503597
      345                 NaN
      346                 NaN
      347                 NaN
      348                 NaN
      349          0.00000000
      350                 NaN
      351                 NaN
      352                 NaN
      353                 NaN
      354                 Inf
      355                 NaN
      356          0.00000000
      357                 NaN
      358                 NaN
      359          0.00000000
      360                 NaN
      361                 NaN
      362                 NaN
      363          1.80612245
      364          1.26051560
      365          0.20842105
      366          0.21351351
      367                 NaN
      368                 NaN
      369                 NaN
      370                 NaN
      371                 NaN
      372          0.28961749
      373          1.11448598
      374                 NaN
      375                 NaN
      376          1.80882353
      377                 NaN
      378          0.00000000
      379                 NaN
      380                 NaN
      381          0.40372671
      382                 NaN
      383          0.00000000
      384          0.00000000
      385                 NaN
      386                 NaN
      387          0.29032258
      388                 NaN
      389                 NaN
      390          0.49872123
      391          0.00000000
      392                 NaN
      393                 NaN
      394                 NaN
      395                 NaN
      396                 NaN
      397                 NaN
      398                 NaN
      399          0.83228512
      400                 NaN
      401          0.03703704
      402                 NaN
      403          0.10752688
      404                 NaN
      405          0.00000000
      406          0.00000000
      407                 NaN
      408                 NaN
      409                 NaN
      410                 NaN
      411          0.00000000
      412          5.62162162
      413                 NaN
      414          0.58728180
      415                 NaN
      416                 NaN
      417                 NaN
      418                 NaN
      419                 NaN
      420                 NaN
      421                 NaN
      422                 NaN
      423          0.00000000
      424          0.00000000
      425          0.82285714
      426          0.80735108
      427          0.00000000
      428                 NaN
      429                 NaN
      430          0.78923767
      431                 NaN
      432          0.74251497
      433          0.97342193
      434          1.09455587
      435                 NaN
      436                 NaN
      437                 NaN
      438                 NaN
      439                 NaN
      440                 NaN
      441          0.19718310
      442                 NaN
      443          0.00000000
      444                 NaN
      445                 NaN
      446                 NaN
      447                 NaN
      448                 NaN
      449          0.56812652
      450          0.24195804
      451                 NaN
      452                 NaN
      453                 NaN
      454                 NaN
      455          0.00000000
      456                 NaN
      457                 NaN
      458                 NaN
      459          0.39423077
      460                 NaN
      461          0.54093567
      462          0.92830189
      463                 NaN
      464          0.06250000
      465          0.00000000
      466          0.40043526
      467          0.00000000
      468                 NaN
      469          0.00000000
      470                 NaN
      471          0.00000000
      472                 NaN
      473          0.71957672
      474                 NaN
      475          0.11281071
      476          0.23922414
      477          0.46666667
      478                 NaN
      479                 NaN
      480          0.92320261
      481          0.55000000
      482          1.21269841
      483          0.92771084
      484                 NaN
      485          0.60159363
      486          0.60445682
      487          0.30021598
      488                 NaN
      489          2.69219653
      490          0.04566929
      491          0.39163498
      492          0.60272277
      493                 Inf
      494          0.50059453
      495                 NaN
      496          0.23164557
      497          0.00000000
      498                 NaN
      499                 NaN
      500                 NaN

