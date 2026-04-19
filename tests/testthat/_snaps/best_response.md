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
      1        1   Complete response 2023-05-01        0.0           -1.00000000
      2        2 Progressive disease 2023-04-27       30.8            0.77011494
      3        3      Stable disease 2023-04-29       79.0            0.12215909
      4        4   Complete response 2023-05-26        0.0           -1.00000000
      5        5   Complete response 2023-07-30        0.0           -1.00000000
      6        6      Stable disease 2023-06-25       57.1           -0.17604618
      7        7 Progressive disease 2023-07-21      128.3            0.24081238
      8        8    Partial response 2023-07-29       23.4           -0.30563798
      9        9   Complete response 2023-08-28        0.0           -1.00000000
      10      10   Complete response 2023-11-23        0.0           -1.00000000
      11      11   Complete response 2023-10-04        0.0           -1.00000000
      12      12 Progressive disease 2023-11-16       56.1            0.62138728
      13      13    Partial response 2023-11-05       27.3           -0.47801147
      14      14   Complete response 2023-11-28        0.0           -1.00000000
      15      15   Complete response 2024-02-24        0.0           -1.00000000
      16      16 Progressive disease 2024-01-10      189.0            2.05825243
      17      17 Progressive disease 2024-02-01      105.2            0.36801040
      18      18 Progressive disease 2024-03-13       81.9            0.71338912
      19      19   Complete response 2024-03-03        0.0           -1.00000000
      20      20 Progressive disease 2024-04-05        0.0           -1.00000000
      21      21   Complete response 2024-06-01        0.0           -1.00000000
      22      22 Progressive disease 2024-06-14        0.0           -1.00000000
      23      23   Complete response 2024-05-26        0.0           -1.00000000
      24      24   Complete response 2024-06-25        0.0           -1.00000000
      25      25 Progressive disease 2024-06-21       67.1            0.20466786
      26      26   Complete response 2024-08-07        0.0           -1.00000000
      27      27 Progressive disease 2024-08-26       89.7            1.35433071
      28      28   Complete response 2024-08-18        0.0           -1.00000000
      29      29   Complete response 2024-10-16        0.0           -1.00000000
      30      30   Complete response 2024-11-01        0.0           -1.00000000
      31      31   Complete response 2025-02-20        0.0           -1.00000000
      32      32   Complete response 2024-12-27        0.0           -1.00000000
      33      33   Complete response 2025-01-01        0.0           -1.00000000
      34      34 Progressive disease 2025-01-07      103.4            0.55957768
      35      35   Complete response 2025-01-15        0.0           -1.00000000
      36      36      Stable disease 2025-02-12       66.4            0.04566929
      37      37 Progressive disease 2025-03-06      302.4            1.91891892
      38      38    Partial response 2025-05-30       26.4           -0.73573574
      39      39   Complete response 2025-04-10        0.0           -1.00000000
      40      40   Complete response 2025-05-18        0.0           -1.00000000
      41      41   Complete response 2025-05-23        0.0           -1.00000000
      42      42   Complete response 2025-06-18        0.0           -1.00000000
      43      43   Complete response 2025-06-30        0.0           -1.00000000
      44      44      Stable disease 2025-07-23       29.3           -0.22691293
      45      45   Complete response 2025-11-04        0.0           -1.00000000
      46      46   Complete response 2025-09-09        0.0           -1.00000000
      47      47   Complete response 2025-11-20        0.0           -1.00000000
      48      48 Progressive disease 2025-09-26       90.9            0.29302987
      49      49   Complete response 2025-11-12        0.0           -1.00000000
      50      50    Partial response 2025-12-21       36.0           -0.40495868
      51      51    Partial response 2025-12-11       12.3           -0.61442006
      52      52   Complete response 2026-01-04        0.0           -1.00000000
      53      53 Progressive disease 2026-02-17       78.4            0.49618321
      54      54 Progressive disease 2026-03-12      122.6            0.64563758
      55      55   Complete response 2026-03-10        0.0           -1.00000000
      56      56   Complete response 2026-05-31        0.0           -1.00000000
      57      57    Partial response 2026-04-14       34.3           -0.30846774
      58      58   Complete response 2026-05-01        0.0           -1.00000000
      59      59 Progressive disease 2026-06-16      106.3            0.85191638
      60      60 Progressive disease 2026-07-13      175.4            0.75751503
      61      61      Stable disease 2026-07-07       35.0           -0.18793503
      62      62 Progressive disease 2026-08-21       76.1            0.22544283
      63      63      Stable disease 2026-09-03       69.0            0.03139013
      64      64   Complete response 2026-11-10        0.0           -1.00000000
      65      65   Complete response 2026-09-16        0.0           -1.00000000
      66      66    Partial response 2026-10-26        5.1           -0.72580645
      67      67 Progressive disease 2026-10-20       13.6           -0.60919540
      68      68   Complete response 2027-02-04        0.0           -1.00000000
      69      69   Complete response 2027-02-15        0.0           -1.00000000
      70      70 Progressive disease 2026-12-22       60.2            0.44019139
      71      71 Progressive disease 2027-02-02       68.3            1.24671053
      72      72      Stable disease 2027-01-29      113.8            0.00000000
      73      73    Partial response 2027-04-01       28.9           -0.47358834
      74      74 Progressive disease 2027-04-05       33.2            0.55140187
      75      75   Complete response 2027-04-13        0.0           -1.00000000
      76      76 Progressive disease 2027-05-16       31.4           -0.15817694
      77      77   Complete response 2027-06-04        0.0           -1.00000000
      78      78 Progressive disease 2027-07-06       66.8           -0.33266733
      79      79   Complete response 2027-07-10        0.0           -1.00000000
      80      80   Complete response 2027-08-08        0.0           -1.00000000
      81      81 Progressive disease 2027-09-03       30.4            0.67032967
      82      82   Complete response 2027-09-11        0.0           -1.00000000
      83      83 Progressive disease 2027-10-10      228.2            1.43283582
      84      84    Partial response 2027-11-24       24.4           -0.64222874
      85      85    Partial response 2027-10-16       26.1           -0.54130053
      86      86   Complete response 2028-02-02        0.0           -1.00000000
      87      87   Complete response 2028-04-08        0.0           -1.00000000
      88      88 Progressive disease 2027-12-15      128.9            1.00466563
      89      89 Progressive disease 2028-01-10       14.3            0.41584158
      90      90   Complete response 2028-02-02        0.0           -1.00000000
      91      91    Partial response 2028-03-11       26.4           -0.33501259
      92      92 Progressive disease 2028-03-28      107.1            1.04389313
      93      93   Complete response 2028-04-14        0.0           -1.00000000
      94      94    Partial response 2028-05-20       18.9           -0.43916914
      95      95   Complete response 2028-06-02        0.0           -1.00000000
      96      96    Partial response 2028-06-21       51.8           -0.40184758
      97      97   Complete response 2028-06-21        0.0           -1.00000000
      98      98   Complete response 2028-08-19        0.0           -1.00000000
      99      99   Complete response 2028-07-31        0.0           -1.00000000
      100    100   Complete response 2028-08-21        0.0           -1.00000000
      101    101    Partial response 2028-10-04       32.2           -0.48807631
      102    102   Complete response 2028-10-29        0.0           -1.00000000
      103    103    Partial response 2028-10-19       19.3           -0.75064599
      104    104   Complete response 2028-11-28        0.0           -1.00000000
      105    105   Complete response 2028-11-22        0.0           -1.00000000
      106    106 Progressive disease 2028-12-29       46.1            0.89711934
      107    107   Complete response 2029-04-20        0.0           -1.00000000
      108    108 Progressive disease 2029-01-26       15.9           -0.30869565
      109    109 Progressive disease 2029-02-28      117.7            1.06491228
      110    110   Complete response 2029-05-10        0.0           -1.00000000
      111    111 Progressive disease 2029-03-25      203.6            0.71092437
      112    112   Complete response 2029-07-04        0.0           -1.00000000
      113    113   Complete response 2029-06-03        0.0           -1.00000000
      114    114 Progressive disease 2029-06-09      146.8            1.02762431
      115    115 Progressive disease 2029-06-03      131.2            1.04043546
      116    116 Progressive disease 2029-07-17      154.6            1.58528428
      117    117   Complete response 2029-07-06        0.0           -1.00000000
      118    118   Complete response 2029-12-07        0.0           -1.00000000
      119    119   Complete response 2029-08-22        0.0           -1.00000000
      120    120    Partial response 2029-10-12        8.9           -0.40666667
      121    121   Complete response 2029-11-04        0.0           -1.00000000
      122    122   Complete response 2030-01-21        0.0           -1.00000000
      123    123    Partial response 2029-11-21       23.3           -0.33618234
      124    124    Partial response 2029-12-20       26.9           -0.40222222
      125    125    Partial response 2030-02-10       70.2           -0.35773102
      126    126 Progressive disease 2030-02-04      146.1            1.03481894
      127    127   Complete response 2030-04-14        0.0           -1.00000000
      128    128   Complete response 2030-03-23        0.0           -1.00000000
      129    129 Progressive disease 2030-03-25       94.9            1.68838527
      130    130   Complete response 2030-04-09        0.0           -1.00000000
      131    131   Complete response 2030-04-19        0.0           -1.00000000
      132    132 Progressive disease 2030-06-21      101.5            0.20118343
      133    133   Complete response 2030-05-30        0.0           -1.00000000
      134    134    Partial response 2030-07-26       27.4           -0.64599483
      135    135   Complete response 2030-08-31        0.0           -1.00000000
      136    136   Complete response 2030-09-03        0.0           -1.00000000
      137    137 Progressive disease 2030-09-14       92.7            0.62062937
      138    138   Complete response 2030-09-11        0.0           -1.00000000
      139    139   Complete response 2030-11-05        0.0           -1.00000000
      140    140      Stable disease 2030-11-07       34.5           -0.29012346
      141    141 Progressive disease 2030-12-02      117.3            0.20927835
      142    142 Progressive disease 2030-11-18      179.2            1.14610778
      143    143   Complete response 2031-02-28        0.0           -1.00000000
      144    144   Complete response 2031-02-11        0.0           -1.00000000
      145    145 Progressive disease 2031-03-01       24.6            1.43564356
      146    146      Stable disease 2031-02-12      127.3            0.04859967
      147    147   Complete response 2031-04-03        0.0           -1.00000000
      148    148   Complete response 2031-06-26        0.0           -1.00000000
      149    149   Complete response 2031-08-07        0.0           -1.00000000
      150    150   Complete response 2031-06-22        0.0           -1.00000000
      151    151      Stable disease 2031-06-22       84.8           -0.25679229
      152    152   Complete response 2031-07-03        0.0           -1.00000000
      153    153   Complete response 2031-07-28        0.0           -1.00000000
      154    154    Partial response 2031-08-22       34.2           -0.51830986
      155    155   Complete response 2031-11-28        0.0           -1.00000000
      156    156 Progressive disease 2031-09-08      128.1            0.71715818
      157    157    Partial response 2031-10-10        0.0           -1.00000000
      158    158      Stable disease 2031-11-16       35.4            0.03812317
      159    159   Complete response 2032-01-09        0.0           -1.00000000
      160    160 Progressive disease 2031-12-21       93.3            1.01511879
      161    161   Complete response 2031-12-21        0.0           -1.00000000
      162    162 Progressive disease 2032-02-04      162.5            0.61210317
      163    163 Progressive disease 2032-02-05       30.6            0.34801762
      164    164   Complete response 2032-03-10        0.0           -1.00000000
      165    165   Complete response 2032-05-24        0.0           -1.00000000
      166    166   Complete response 2032-06-10        0.0           -1.00000000
      167    167   Complete response 2032-04-13        0.0           -1.00000000
      168    168    Partial response 2032-04-28       14.5           -0.69083156
      169    169 Progressive disease 2032-06-18        0.0           -1.00000000
      170    170   Complete response 2032-08-17        0.0           -1.00000000
      171    171   Complete response 2032-08-13        0.0           -1.00000000
      172    172      Stable disease 2032-08-20       39.1            0.13994169
      173    173    Partial response 2032-08-17       72.9           -0.31613508
      174    174    Partial response 2032-09-02       32.6           -0.66077003
      175    175 Progressive disease 2032-10-04        0.0           -1.00000000
      176    176 Progressive disease 2032-11-10       93.0            0.57094595
      177    177   Complete response 2032-11-05        0.0           -1.00000000
      178    178   Complete response 2032-12-09        0.0           -1.00000000
      179    179   Complete response 2033-04-08        0.0           -1.00000000
      180    180   Complete response 2033-03-06        0.0           -1.00000000
      181    181   Complete response 2033-04-23        0.0           -1.00000000
      182    182 Progressive disease 2033-03-09       34.8            0.45606695
      183    183      Stable disease 2033-03-20       56.1            0.03696858
      184    184    Partial response 2033-04-09       23.6           -0.33893557
      185    185 Progressive disease 2033-04-29        0.0           -1.00000000
      186    186   Complete response 2033-07-08        0.0           -1.00000000
      187    187      Stable disease 2033-05-13       60.5           -0.06779661
      188    188      Stable disease 2033-06-16       58.8           -0.13274336
      189    189      Stable disease 2033-07-05      107.0            0.15800866
      190    190   Complete response 2033-09-14        0.0           -1.00000000
      191    191   Complete response 2033-08-24        0.0           -1.00000000
      192    192 Progressive disease 2033-10-11       14.5           -0.39330544
      193    193    Partial response 2033-12-01       18.5            0.00000000
      194    194 Progressive disease 2033-10-01      112.0            0.63742690
      195    195   Complete response 2034-01-14        0.0           -1.00000000
      196    196 Progressive disease 2033-12-09       53.7            0.48753463
      197    197      Stable disease 2033-12-06       25.7           -0.03383459
      198    198      Stable disease 2034-02-09       22.7            0.19473684
      199    199      Stable disease 2034-02-11       94.4            0.10668230
      200    200   Complete response 2034-02-15        0.0           -1.00000000
      201    201   Complete response 2034-04-05        0.0           -1.00000000
      202    202   Complete response 2034-04-16        0.0           -1.00000000
      203    203   Complete response 2034-04-08        0.0           -1.00000000
      204    204    Partial response 2034-05-27       13.6           -0.78683386
      205    205 Progressive disease 2034-05-27       52.5           -0.49177154
      206    206 Progressive disease 2034-06-24       32.5            1.85087719
      207    207   Complete response 2034-06-29        0.0           -1.00000000
      208    208   Complete response 2034-08-20        0.0           -1.00000000
      209    209   Complete response 2034-09-14        0.0           -1.00000000
      210    210 Progressive disease 2034-08-10      254.4            0.91710625
      211    211   Complete response 2034-09-30        0.0           -1.00000000
      212    212   Complete response 2034-10-08        0.0           -1.00000000
      213    213   Complete response 2034-11-06        0.0           -1.00000000
      214    214    Partial response 2034-12-14       15.5           -0.70809793
      215    215   Complete response 2034-12-31        0.0           -1.00000000
      216    216 Progressive disease 2034-12-26        0.0           -1.00000000
      217    217   Complete response 2035-01-24        0.0           -1.00000000
      218    218 Progressive disease 2035-02-04       72.3            1.12023460
      219    219    Partial response 2035-04-23       47.9           -0.34562842
      220    220    Partial response 2035-05-11       54.8           -0.41327623
      221    221 Progressive disease 2035-03-28       32.1            0.25882353
      222    222   Complete response 2035-06-21        0.0           -1.00000000
      223    223    Partial response 2035-05-01       20.9           -0.76032110
      224    224   Complete response 2035-05-25        0.0           -1.00000000
      225    225   Complete response 2035-06-12        0.0           -1.00000000
      226    226 Progressive disease 2035-07-24       62.2            0.26422764
      227    227 Progressive disease 2035-08-09       53.0            0.65625000
      228    228 Progressive disease 2035-08-04      190.8            0.66929134
      229    229    Partial response 2035-09-03       28.6           -0.39915966
      230    230    Partial response 2035-10-20       39.7           -0.63138347
      231    231   Complete response 2035-11-11        0.0           -1.00000000
      232    232 Progressive disease 2035-11-22       36.4           -0.27634195
      233    233   Complete response 2036-04-29        0.0           -1.00000000
      234    234    Partial response 2035-12-15        7.0           -0.83293556
      235    235   Complete response 2036-04-21        0.0           -1.00000000
      236    236   Complete response 2036-03-25        0.0           -1.00000000
      237    237    Partial response 2036-02-20       29.3           -0.51809211
      238    238   Complete response 2036-04-14        0.0           -1.00000000
      239    239   Complete response 2036-03-21        0.0           -1.00000000
      240    240 Progressive disease 2036-05-02      109.8            0.62666667
      241    241    Partial response 2036-05-10       26.1           -0.57072368
      242    242   Complete response 2036-06-01        0.0           -1.00000000
      243    243      Stable disease 2036-06-23       50.4           -0.12953368
      244    244   Complete response 2036-08-09        0.0           -1.00000000
      245    245   Complete response 2036-10-03        0.0           -1.00000000
      246    246    Partial response 2036-09-07       43.5           -0.60846085
      247    247   Complete response 2036-10-10        0.0           -1.00000000
      248    248   Complete response 2036-10-15        0.0           -1.00000000
      249    249   Complete response 2036-11-04        0.0           -1.00000000
      250    250 Progressive disease 2036-12-08      100.9            0.16917729
      251    251 Progressive disease 2036-11-12      183.8            1.37467700
      252    252      Stable disease 2037-01-13       20.0           -0.29824561
      253    253   Complete response 2037-02-06        0.0           -1.00000000
      254    254   Complete response 2037-04-11        0.0           -1.00000000
      255    255   Complete response 2037-03-15        0.0           -1.00000000
      256    256 Progressive disease 2037-03-29      120.6            0.55212355
      257    257 Progressive disease 2037-04-12       60.0            0.49625935
      258    258   Complete response 2037-04-10        0.0           -1.00000000
      259    259   Complete response 2037-06-01        0.0           -1.00000000
      260    260   Complete response 2037-07-05        0.0           -1.00000000
      261    261    Partial response 2037-06-11       29.9           -0.43263757
      262    262 Progressive disease 2037-07-02      112.2            0.22089227
      263    263   Complete response 2037-07-29        0.0           -1.00000000
      264    264   Complete response 2037-07-23        0.0           -1.00000000
      265    265    Partial response 2037-09-18       11.5           -0.78624535
      266    266   Complete response 2037-10-19        0.0           -1.00000000
      267    267    Partial response 2037-10-03       24.0           -0.35135135
      268    268   Complete response 2037-12-12        0.0           -1.00000000
      269    269   Complete response 2038-02-01        0.0           -1.00000000
      270    270   Complete response 2038-03-27        0.0           -1.00000000
      271    271      Stable disease 2037-12-12       57.7            0.10748560
      272    272 Progressive disease 2038-02-02       86.1            0.68164062
      273    273 Progressive disease 2038-02-10      118.6            0.35079727
      274    274 Progressive disease 2038-02-08      136.9            0.69430693
      275    275 Progressive disease 2038-03-20       96.4           -0.35690460
      276    276   Complete response 2038-05-10        0.0           -1.00000000
      277    277    Partial response 2038-04-21       14.6           -0.74520070
      278    278   Complete response 2038-06-23        0.0           -1.00000000
      279    279      Stable disease 2038-06-16       37.4           -0.14806378
      280    280   Complete response 2038-06-21        0.0           -1.00000000
      281    281   Complete response 2038-09-27        0.0           -1.00000000
      282    282   Complete response 2038-10-15        0.0           -1.00000000
      283    283   Complete response 2038-10-07        0.0           -1.00000000
      284    284 Progressive disease 2038-10-18       46.5           -0.13568773
      285    285 Progressive disease 2038-09-19      130.9            0.46913580
      286    286    Partial response 2038-11-11        6.5           -0.58064516
      287    287   Complete response 2038-11-29        0.0           -1.00000000
      288    288    Partial response 2039-01-19       14.6           -0.66893424
      289    289   Complete response 2039-02-10        0.0           -1.00000000
      290    290   Complete response 2039-02-23        0.0           -1.00000000
      291    291   Complete response 2039-03-28        0.0           -1.00000000
      292    292    Partial response 2039-05-16       17.5           -0.54068241
      293    293   Complete response 2039-04-11        0.0           -1.00000000
      294    294   Complete response 2039-08-21        0.0           -1.00000000
      295    295   Complete response 2039-06-15        0.0           -1.00000000
      296    296 Progressive disease 2039-04-27      159.4            0.63991770
      297    297   Complete response 2039-09-16        0.0           -1.00000000
      298    298    Partial response 2039-06-19        5.6           -0.81395349
      299    299   Complete response 2039-08-12        0.0           -1.00000000
      300    300    Partial response 2039-08-22       15.1           -0.65990991
      301    301   Complete response 2039-08-17        0.0           -1.00000000
      302    302    Partial response 2039-09-10       13.1           -0.55290102
      303    303 Progressive disease 2039-10-14      115.1            0.49093264
      304    304   Complete response 2039-10-13        0.0           -1.00000000
      305    305   Complete response 2039-12-31        0.0           -1.00000000
      306    306 Progressive disease 2039-12-01      130.4            0.52872216
      307    307   Complete response 2040-01-09        0.0           -1.00000000
      308    308 Progressive disease 2039-12-20      104.9            0.35880829
      309    309 Progressive disease 2040-01-18      113.3            0.53315291
      310    310 Progressive disease 2040-03-27       13.3           -0.61111111
      311    311    Partial response 2040-04-06       20.6           -0.66666667
      312    312 Progressive disease 2040-04-29       67.0            0.74025974
      313    313   Complete response 2040-04-22        0.0           -1.00000000
      314    314   Complete response 2040-05-05        0.0           -1.00000000
      315    315    Partial response 2040-06-24       39.4           -0.32534247
      316    316   Complete response 2040-06-24        0.0           -1.00000000
      317    317   Complete response 2040-08-16        0.0           -1.00000000
      318    318   Complete response 2040-07-24        0.0           -1.00000000
      319    319 Progressive disease 2040-08-25       59.7            0.43165468
      320    320   Complete response 2040-11-10        0.0           -1.00000000
      321    321 Progressive disease 2040-09-14       75.6            0.70270270
      322    322   Complete response 2040-10-11        0.0           -1.00000000
      323    323   Complete response 2040-12-17        0.0           -1.00000000
      324    324      Stable disease 2040-12-18       69.2           -0.20184544
      325    325    Partial response 2041-01-20       56.2           -0.32289157
      326    326   Complete response 2041-03-11        0.0           -1.00000000
      327    327    Partial response 2041-02-22       10.9           -0.46829268
      328    328   Complete response 2041-04-19        0.0           -1.00000000
      329    329 Progressive disease 2041-03-25       34.1            0.93750000
      330    330   Complete response 2041-06-12        0.0           -1.00000000
      331    331 Progressive disease 2041-04-05       83.3            0.22680412
      332    332   Complete response 2041-04-23        0.0           -1.00000000
      333    333 Progressive disease 2041-06-08       93.7            0.24601064
      334    334      Stable disease 2041-06-23       19.6           -0.21285141
      335    335   Complete response 2041-08-20        0.0           -1.00000000
      336    336   Complete response 2041-09-17        0.0           -1.00000000
      337    337   Complete response 2041-08-01        0.0           -1.00000000
      338    338   Complete response 2041-08-16        0.0           -1.00000000
      339    339   Complete response 2041-10-08        0.0           -1.00000000
      340    340   Complete response 2041-12-09        0.0           -1.00000000
      341    341    Partial response 2041-11-07        0.0           -1.00000000
      342    342   Complete response 2041-12-07        0.0           -1.00000000
      343    343 Progressive disease 2042-01-02       39.6            0.55905512
      344    344 Progressive disease 2042-01-25      108.7            0.95503597
      345    345   Complete response 2042-01-25        0.0           -1.00000000
      346    346   Complete response 2042-01-30        0.0           -1.00000000
      347    347   Complete response 2042-03-24        0.0           -1.00000000
      348    348   Complete response 2042-03-22        0.0           -1.00000000
      349    349 Progressive disease 2042-04-05        9.7           -0.77954545
      350    350   Complete response 2042-05-19        0.0           -1.00000000
      351    351   Complete response 2042-06-03        0.0           -1.00000000
      352    352 Progressive disease 2042-06-28        0.0           -1.00000000
      353    353   Complete response 2042-07-20        0.0           -1.00000000
      354    354      Stable disease 2042-07-10       61.9           -0.25421687
      355    355   Complete response 2042-08-21        0.0           -1.00000000
      356    356      Stable disease 2042-09-01       19.2           -0.07246377
      357    357   Complete response 2042-10-02        0.0           -1.00000000
      358    358   Complete response 2042-10-31        0.0           -1.00000000
      359    359    Partial response 2042-10-28       37.3           -0.33154122
      360    360   Complete response 2042-12-21        0.0           -1.00000000
      361    361 Progressive disease 2042-12-07        0.0           -1.00000000
      362    362   Complete response 2043-01-08        0.0           -1.00000000
      363    363 Progressive disease 2043-02-17       55.0            1.80612245
      364    364 Progressive disease 2043-01-22      166.6            1.26051560
      365    365 Progressive disease 2043-03-19      114.8            0.20842105
      366    366 Progressive disease 2043-02-24       89.8            0.21351351
      367    367   Complete response 2043-04-06        0.0           -1.00000000
      368    368   Complete response 2043-05-26        0.0           -1.00000000
      369    369   Complete response 2043-06-11        0.0           -1.00000000
      370    370   Complete response 2043-05-21        0.0           -1.00000000
      371    371   Complete response 2043-08-10        0.0           -1.00000000
      372    372 Progressive disease 2043-06-30       23.6            0.28961749
      373    373 Progressive disease 2043-07-27      181.0            1.11448598
      374    374   Complete response 2043-08-16        0.0           -1.00000000
      375    375   Complete response 2043-09-27        0.0           -1.00000000
      376    376 Progressive disease 2043-09-12       38.2            1.80882353
      377    377   Complete response 2044-01-17        0.0           -1.00000000
      378    378    Partial response 2043-11-22       32.4           -0.65966387
      379    379    Partial response 2043-12-07        0.0           -1.00000000
      380    380   Complete response 2043-12-17        0.0           -1.00000000
      381    381 Progressive disease 2044-01-02       45.2            0.40372671
      382    382   Complete response 2044-02-23        0.0           -1.00000000
      383    383    Partial response 2044-02-19       46.4           -0.36438356
      384    384    Partial response 2044-05-01        5.5           -0.71938776
      385    385   Complete response 2044-06-09        0.0           -1.00000000
      386    386   Complete response 2044-05-28        0.0           -1.00000000
      387    387 Progressive disease 2044-05-29       16.0            0.29032258
      388    388   Complete response 2044-07-11        0.0           -1.00000000
      389    389   Complete response 2044-06-16        0.0           -1.00000000
      390    390 Progressive disease 2044-07-18       58.6            0.49872123
      391    391    Partial response 2044-07-23        7.9           -0.70188679
      392    392 Progressive disease 2044-08-11        0.0           -1.00000000
      393    393 Progressive disease 2044-10-12        0.0           -1.00000000
      394    394   Complete response 2044-09-22        0.0           -1.00000000
      395    395   Complete response 2044-11-11        0.0           -1.00000000
      396    396   Complete response 2044-12-01        0.0           -1.00000000
      397    397   Complete response 2044-11-25        0.0           -1.00000000
      398    398   Complete response 2045-01-24        0.0           -1.00000000
      399    399 Progressive disease 2044-12-22       87.4            0.83228512
      400    400   Complete response 2045-02-26        0.0           -1.00000000
      401    401      Stable disease 2045-03-17       81.2            0.03703704
      402    402   Complete response 2045-03-21        0.0           -1.00000000
      403    403      Stable disease 2045-04-07       51.5            0.10752688
      404    404   Complete response 2045-06-15        0.0           -1.00000000
      405    405      Stable disease 2045-05-22      113.1           -0.07823961
      406    406    Partial response 2045-05-11       40.2           -0.43059490
      407    407   Complete response 2045-06-29        0.0           -1.00000000
      408    408   Complete response 2045-08-25        0.0           -1.00000000
      409    409   Complete response 2045-08-20        0.0           -1.00000000
      410    410   Complete response 2045-08-18        0.0           -1.00000000
      411    411      Stable disease 2045-09-05      100.4           -0.01181102
      412    412    Partial response 2045-09-14       24.5           -0.42216981
      413    413 Progressive disease 2045-11-08        0.0           -1.00000000
      414    414 Progressive disease 2045-10-24      127.3            0.58728180
      415    415   Complete response 2045-11-28        0.0           -1.00000000
      416    416   Complete response 2045-12-12        0.0           -1.00000000
      417    417   Complete response 2046-01-11        0.0           -1.00000000
      418    418   Complete response 2046-01-29        0.0           -1.00000000
      419    419   Complete response 2046-01-27        0.0           -1.00000000
      420    420   Complete response 2046-05-16        0.0           -1.00000000
      421    421   Complete response 2046-07-28        0.0           -1.00000000
      422    422   Complete response 2046-06-17        0.0           -1.00000000
      423    423      Stable disease 2046-05-27       13.5           -0.26229508
      424    424    Partial response 2046-07-22       30.4           -0.39682540
      425    425 Progressive disease 2046-06-07      159.5            0.82285714
      426    426 Progressive disease 2046-06-16      142.6            0.80735108
      427    427    Partial response 2046-08-12       11.0           -0.73105134
      428    428   Complete response 2046-07-27        0.0           -1.00000000
      429    429   Complete response 2046-12-23        0.0           -1.00000000
      430    430 Progressive disease 2046-09-02       79.8            0.78923767
      431    431   Complete response 2046-12-04        0.0           -1.00000000
      432    432 Progressive disease 2046-10-25       58.2            0.74251497
      433    433 Progressive disease 2046-11-16      118.8            0.97342193
      434    434 Progressive disease 2046-12-29       73.1            1.09455587
      435    435   Complete response 2047-02-08        0.0           -1.00000000
      436    436   Complete response 2047-01-28        0.0           -1.00000000
      437    437   Complete response 2047-02-03        0.0           -1.00000000
      438    438   Complete response 2047-02-17        0.0           -1.00000000
      439    439   Complete response 2047-07-12        0.0           -1.00000000
      440    440   Complete response 2047-05-31        0.0           -1.00000000
      441    441 Progressive disease 2047-04-09       76.5            0.19718310
      442    442   Complete response 2047-05-09        0.0           -1.00000000
      443    443    Partial response 2047-06-07       53.6           -0.35343788
      444    444   Complete response 2047-07-05        0.0           -1.00000000
      445    445   Complete response 2047-07-18        0.0           -1.00000000
      446    446   Complete response 2047-09-25        0.0           -1.00000000
      447    447   Complete response 2047-09-05        0.0           -1.00000000
      448    448   Complete response 2047-08-29        0.0           -1.00000000
      449    449 Progressive disease 2047-09-12      128.9            0.56812652
      450    450 Progressive disease 2047-11-14       88.8            0.24195804
      451    451   Complete response 2047-11-21        0.0           -1.00000000
      452    452   Complete response 2047-12-27        0.0           -1.00000000
      453    453   Complete response 2047-12-30        0.0           -1.00000000
      454    454   Complete response 2048-01-02        0.0           -1.00000000
      455    455    Partial response 2048-03-03        8.6           -0.78660050
      456    456   Complete response 2048-02-01        0.0           -1.00000000
      457    457   Complete response 2048-05-05        0.0           -1.00000000
      458    458   Complete response 2048-04-22        0.0           -1.00000000
      459    459 Progressive disease 2048-05-19       87.0            0.39423077
      460    460   Complete response 2048-05-26        0.0           -1.00000000
      461    461 Progressive disease 2048-05-14      105.4            0.54093567
      462    462 Progressive disease 2048-07-04       51.1            0.92830189
      463    463   Complete response 2048-07-17        0.0           -1.00000000
      464    464      Stable disease 2048-07-28       64.6            0.06250000
      465    465      Stable disease 2048-08-26       97.3            0.10317460
      466    466 Progressive disease 2048-09-25      128.7            0.40043526
      467    467    Partial response 2048-10-07       47.1           -0.56828598
      468    468   Complete response 2048-11-01        0.0           -1.00000000
      469    469      Stable disease 2048-11-02       44.5           -0.04914530
      470    470 Progressive disease 2049-02-03        0.0           -1.00000000
      471    471    Partial response 2049-01-06       13.4           -0.31979695
      472    472   Complete response 2049-02-25        0.0           -1.00000000
      473    473 Progressive disease 2049-01-23       32.5            0.71957672
      474    474   Complete response 2049-03-19        0.0           -1.00000000
      475    475      Stable disease 2049-02-11       58.2            0.11281071
      476    476 Progressive disease 2049-04-07       57.5            0.23922414
      477    477 Progressive disease 2049-04-30       28.6            0.46666667
      478    478   Complete response 2049-07-12        0.0           -1.00000000
      479    479   Complete response 2049-06-12        0.0           -1.00000000
      480    480 Progressive disease 2049-07-05      117.7            0.92320261
      481    481 Progressive disease 2049-07-26       34.1            0.55000000
      482    482      Stable disease 2049-07-25       69.7            0.12057878
      483    483    Partial response 2049-08-08       16.0           -0.83175605
      484    484   Complete response 2049-09-28        0.0           -1.00000000
      485    485 Progressive disease 2049-09-16       40.2            0.60159363
      486    486 Progressive disease 2049-11-05       57.6            0.60445682
      487    487 Progressive disease 2049-10-23      120.4            0.30021598
      488    488   Complete response 2049-12-11        0.0           -1.00000000
      489    489 Progressive disease 2049-12-26      255.5            2.69219653
      490    490 Progressive disease 2050-01-11       66.4            0.04566929
      491    491 Progressive disease 2050-02-01       36.6            0.39163498
      492    492 Progressive disease 2050-03-03      129.5            0.60272277
      493    493    Partial response 2050-03-29       53.7           -0.39458850
      494    494 Progressive disease 2050-04-02      126.2            0.50059453
      495    495   Complete response 2050-07-21        0.0           -1.00000000
      496    496 Progressive disease 2050-05-25       97.3            0.23164557
      497    497 Progressive disease 2050-05-12       19.9           -0.01970443
      498    498   Complete response 2050-09-11        0.0           -1.00000000
      499    499   Complete response 2050-07-15        0.0           -1.00000000
      500    500   Complete response 2050-09-20        0.0           -1.00000000
          target_sum_diff_min six_months_confirmation
      1                   NaN                   FALSE
      2            0.77011494                   FALSE
      3            0.12215909                   FALSE
      4                   NaN                   FALSE
      5                   NaN                   FALSE
      6                   Inf                   FALSE
      7            0.24081238                   FALSE
      8            0.00000000                   FALSE
      9                   NaN                   FALSE
      10                  NaN                   FALSE
      11                  NaN                   FALSE
      12           0.62138728                   FALSE
      13           0.00000000                   FALSE
      14                  NaN                   FALSE
      15                  NaN                   FALSE
      16           2.05825243                   FALSE
      17           0.36801040                   FALSE
      18           0.71338912                   FALSE
      19                  NaN                   FALSE
      20                  NaN                   FALSE
      21                  NaN                   FALSE
      22                  NaN                   FALSE
      23                  NaN                   FALSE
      24                  NaN                   FALSE
      25           0.20466786                   FALSE
      26                  NaN                   FALSE
      27           1.35433071                   FALSE
      28                  NaN                   FALSE
      29                  NaN                   FALSE
      30                  NaN                   FALSE
      31                  NaN                   FALSE
      32                  NaN                   FALSE
      33                  NaN                   FALSE
      34           0.55957768                   FALSE
      35                  NaN                   FALSE
      36           0.04566929                   FALSE
      37           1.91891892                   FALSE
      38           0.00000000                   FALSE
      39                  NaN                   FALSE
      40                  NaN                   FALSE
      41                  NaN                   FALSE
      42                  NaN                   FALSE
      43                  NaN                   FALSE
      44           0.00000000                   FALSE
      45                  NaN                   FALSE
      46                  NaN                   FALSE
      47                  NaN                   FALSE
      48           0.29302987                   FALSE
      49                  NaN                   FALSE
      50           0.00000000                   FALSE
      51           0.00000000                   FALSE
      52                  NaN                   FALSE
      53           0.49618321                   FALSE
      54           0.64563758                   FALSE
      55                  NaN                   FALSE
      56                  NaN                   FALSE
      57           0.00000000                   FALSE
      58                  NaN                   FALSE
      59           0.85191638                   FALSE
      60           0.75751503                   FALSE
      61           0.00000000                   FALSE
      62           0.22544283                   FALSE
      63           0.31428571                   FALSE
      64                  NaN                   FALSE
      65                  NaN                   FALSE
      66           0.00000000                   FALSE
      67           0.00000000                   FALSE
      68                  NaN                   FALSE
      69                  NaN                   FALSE
      70           0.44019139                   FALSE
      71           1.24671053                   FALSE
      72           0.56749311                   FALSE
      73           2.21111111                   FALSE
      74           0.55140187                   FALSE
      75                  NaN                   FALSE
      76           0.00000000                   FALSE
      77                  NaN                   FALSE
      78           0.00000000                   FALSE
      79                  NaN                   FALSE
      80                  NaN                   FALSE
      81           0.67032967                   FALSE
      82                  NaN                   FALSE
      83           1.43283582                   FALSE
      84           0.79411765                   FALSE
      85           0.00000000                   FALSE
      86                  NaN                   FALSE
      87                  NaN                   FALSE
      88           1.00466563                   FALSE
      89           0.41584158                   FALSE
      90                  NaN                   FALSE
      91           0.00000000                   FALSE
      92           1.04389313                   FALSE
      93                  NaN                   FALSE
      94           0.23529412                   FALSE
      95                  NaN                   FALSE
      96           0.00000000                   FALSE
      97                  NaN                   FALSE
      98                  NaN                   FALSE
      99                  NaN                   FALSE
      100                 NaN                   FALSE
      101          0.00000000                   FALSE
      102                 NaN                   FALSE
      103          0.00000000                   FALSE
      104                 NaN                   FALSE
      105                 NaN                   FALSE
      106          0.89711934                   FALSE
      107                 NaN                   FALSE
      108          0.00000000                   FALSE
      109          1.06491228                   FALSE
      110                 NaN                   FALSE
      111          0.71092437                   FALSE
      112                 NaN                   FALSE
      113                 NaN                   FALSE
      114          1.02762431                   FALSE
      115          1.04043546                   FALSE
      116          1.58528428                   FALSE
      117                 NaN                   FALSE
      118                 NaN                   FALSE
      119                 NaN                   FALSE
      120          0.00000000                   FALSE
      121                 NaN                   FALSE
      122                 NaN                   FALSE
      123          0.00000000                   FALSE
      124          0.00000000                   FALSE
      125          0.00000000                   FALSE
      126          1.03481894                   FALSE
      127                 NaN                   FALSE
      128                 NaN                   FALSE
      129          1.68838527                   FALSE
      130                 NaN                   FALSE
      131                 NaN                   FALSE
      132          0.20118343                   FALSE
      133                 NaN                   FALSE
      134                 Inf                   FALSE
      135                 NaN                   FALSE
      136                 NaN                   FALSE
      137          0.62062937                   FALSE
      138                 NaN                   FALSE
      139                 NaN                   FALSE
      140          0.00000000                   FALSE
      141          0.20927835                   FALSE
      142          1.14610778                   FALSE
      143                 NaN                   FALSE
      144                 NaN                   FALSE
      145          1.43564356                   FALSE
      146          0.04859967                   FALSE
      147                 NaN                   FALSE
      148                 NaN                   FALSE
      149                 NaN                   FALSE
      150                 NaN                   FALSE
      151          0.00000000                   FALSE
      152                 NaN                   FALSE
      153                 NaN                   FALSE
      154          0.01483680                   FALSE
      155                 NaN                   FALSE
      156          0.71715818                   FALSE
      157                 NaN                   FALSE
      158          0.03812317                   FALSE
      159                 NaN                   FALSE
      160          1.01511879                   FALSE
      161                 NaN                   FALSE
      162          0.61210317                   FALSE
      163          0.34801762                   FALSE
      164                 NaN                   FALSE
      165                 NaN                   FALSE
      166                 NaN                   FALSE
      167                 NaN                   FALSE
      168          0.00000000                   FALSE
      169                 NaN                   FALSE
      170                 NaN                   FALSE
      171                 NaN                   FALSE
      172          0.44280443                   FALSE
      173          0.00000000                   FALSE
      174          0.00000000                   FALSE
      175                 NaN                   FALSE
      176          0.57094595                   FALSE
      177                 NaN                   FALSE
      178                 NaN                   FALSE
      179                 NaN                   FALSE
      180                 NaN                   FALSE
      181                 NaN                   FALSE
      182          0.45606695                   FALSE
      183          0.03696858                   FALSE
      184          0.00000000                   FALSE
      185                 NaN                   FALSE
      186                 NaN                   FALSE
      187          0.00000000                   FALSE
      188                 Inf                   FALSE
      189          0.20767494                   FALSE
      190                 NaN                   FALSE
      191                 NaN                   FALSE
      192          0.00000000                   FALSE
      193          0.00000000                   FALSE
      194          0.63742690                   FALSE
      195                 NaN                   FALSE
      196          0.48753463                   FALSE
      197          0.00000000                   FALSE
      198          0.19473684                   FALSE
      199          0.10668230                   FALSE
      200                 NaN                   FALSE
      201                 NaN                   FALSE
      202                 NaN                   FALSE
      203                 NaN                   FALSE
      204          0.00000000                   FALSE
      205          0.00000000                   FALSE
      206          1.85087719                   FALSE
      207                 NaN                   FALSE
      208                 NaN                   FALSE
      209                 NaN                   FALSE
      210          0.91710625                   FALSE
      211                 NaN                   FALSE
      212                 NaN                   FALSE
      213                 NaN                   FALSE
      214          0.00000000                   FALSE
      215                 NaN                   FALSE
      216                 NaN                   FALSE
      217                 NaN                   FALSE
      218          1.12023460                   FALSE
      219          0.00000000                   FALSE
      220          0.00000000                   FALSE
      221          0.25882353                   FALSE
      222                 NaN                   FALSE
      223                 Inf                   FALSE
      224                 NaN                   FALSE
      225                 NaN                   FALSE
      226          0.26422764                   FALSE
      227          0.65625000                   FALSE
      228          0.66929134                   FALSE
      229          7.66666667                   FALSE
      230          0.00000000                   FALSE
      231                 NaN                   FALSE
      232          0.00000000                   FALSE
      233                 NaN                   FALSE
      234          0.00000000                   FALSE
      235                 NaN                   FALSE
      236                 NaN                   FALSE
      237          0.00000000                   FALSE
      238                 NaN                   FALSE
      239                 NaN                   FALSE
      240          0.62666667                   FALSE
      241          0.00000000                   FALSE
      242                 NaN                   FALSE
      243          0.00000000                   FALSE
      244                 NaN                   FALSE
      245                 NaN                   FALSE
      246          0.00000000                   FALSE
      247                 NaN                   FALSE
      248                 NaN                   FALSE
      249                 NaN                   FALSE
      250          0.16917729                   FALSE
      251          1.37467700                   FALSE
      252          0.00000000                   FALSE
      253                 NaN                   FALSE
      254                 NaN                   FALSE
      255                 NaN                   FALSE
      256          0.55212355                   FALSE
      257          0.49625935                   FALSE
      258                 NaN                   FALSE
      259                 NaN                   FALSE
      260                 NaN                   FALSE
      261          0.00000000                   FALSE
      262          0.22089227                   FALSE
      263                 NaN                   FALSE
      264                 NaN                   FALSE
      265          0.00000000                   FALSE
      266                 NaN                   FALSE
      267          0.77777778                   FALSE
      268                 NaN                   FALSE
      269                 NaN                   FALSE
      270                 NaN                   FALSE
      271          0.10748560                   FALSE
      272          0.68164062                   FALSE
      273          0.35079727                   FALSE
      274          0.69430693                   FALSE
      275          0.00000000                   FALSE
      276                 NaN                   FALSE
      277          0.60439560                   FALSE
      278                 NaN                   FALSE
      279          0.00000000                   FALSE
      280                 NaN                   FALSE
      281                 NaN                   FALSE
      282                 NaN                   FALSE
      283                 NaN                   FALSE
      284          0.00000000                   FALSE
      285          0.46913580                   FALSE
      286          0.00000000                   FALSE
      287                 NaN                   FALSE
      288          4.21428571                   FALSE
      289                 NaN                   FALSE
      290                 NaN                   FALSE
      291                 NaN                   FALSE
      292          3.16666667                   FALSE
      293                 NaN                   FALSE
      294                 NaN                   FALSE
      295                 NaN                   FALSE
      296          0.63991770                   FALSE
      297                 NaN                   FALSE
      298          0.00000000                   FALSE
      299                 NaN                   FALSE
      300          0.00000000                   FALSE
      301                 NaN                   FALSE
      302          0.00000000                   FALSE
      303          0.49093264                   FALSE
      304                 NaN                   FALSE
      305                 NaN                   FALSE
      306          0.52872216                   FALSE
      307                 NaN                   FALSE
      308          0.35880829                   FALSE
      309          0.53315291                   FALSE
      310          0.00000000                   FALSE
      311          0.00000000                   FALSE
      312          0.74025974                   FALSE
      313                 NaN                   FALSE
      314                 NaN                   FALSE
      315          0.00000000                   FALSE
      316                 NaN                   FALSE
      317                 NaN                   FALSE
      318                 NaN                   FALSE
      319          0.43165468                   FALSE
      320                 NaN                   FALSE
      321          0.70270270                   FALSE
      322                 NaN                   FALSE
      323                 NaN                   FALSE
      324          0.00000000                   FALSE
      325          0.00000000                   FALSE
      326                 NaN                   FALSE
      327          0.00000000                   FALSE
      328                 NaN                   FALSE
      329          0.93750000                   FALSE
      330                 NaN                   FALSE
      331          0.22680412                   FALSE
      332                 NaN                   FALSE
      333          0.24601064                   FALSE
      334          0.00000000                   FALSE
      335                 NaN                   FALSE
      336                 NaN                   FALSE
      337                 NaN                   FALSE
      338                 NaN                   FALSE
      339                 NaN                   FALSE
      340                 NaN                   FALSE
      341                 NaN                   FALSE
      342                 NaN                   FALSE
      343          0.55905512                   FALSE
      344          0.95503597                   FALSE
      345                 NaN                   FALSE
      346                 NaN                   FALSE
      347                 NaN                   FALSE
      348                 NaN                   FALSE
      349          0.00000000                   FALSE
      350                 NaN                   FALSE
      351                 NaN                   FALSE
      352                 NaN                   FALSE
      353                 NaN                   FALSE
      354                 Inf                   FALSE
      355                 NaN                   FALSE
      356          0.00000000                   FALSE
      357                 NaN                   FALSE
      358                 NaN                   FALSE
      359          0.00000000                   FALSE
      360                 NaN                   FALSE
      361                 NaN                   FALSE
      362                 NaN                   FALSE
      363          1.80612245                   FALSE
      364          1.26051560                   FALSE
      365          0.20842105                   FALSE
      366          0.21351351                   FALSE
      367                 NaN                   FALSE
      368                 NaN                   FALSE
      369                 NaN                   FALSE
      370                 NaN                   FALSE
      371                 NaN                   FALSE
      372          0.28961749                   FALSE
      373          1.11448598                   FALSE
      374                 NaN                   FALSE
      375                 NaN                   FALSE
      376          1.80882353                   FALSE
      377                 NaN                   FALSE
      378          0.00000000                   FALSE
      379                 NaN                   FALSE
      380                 NaN                   FALSE
      381          0.40372671                   FALSE
      382                 NaN                   FALSE
      383          0.00000000                   FALSE
      384          0.00000000                   FALSE
      385                 NaN                   FALSE
      386                 NaN                   FALSE
      387          0.29032258                   FALSE
      388                 NaN                   FALSE
      389                 NaN                   FALSE
      390          0.49872123                   FALSE
      391          0.00000000                   FALSE
      392                 NaN                   FALSE
      393                 NaN                   FALSE
      394                 NaN                   FALSE
      395                 NaN                   FALSE
      396                 NaN                   FALSE
      397                 NaN                   FALSE
      398                 NaN                   FALSE
      399          0.83228512                   FALSE
      400                 NaN                   FALSE
      401          0.03703704                   FALSE
      402                 NaN                   FALSE
      403          0.10752688                   FALSE
      404                 NaN                   FALSE
      405          0.05799813                   FALSE
      406          2.02255639                   FALSE
      407                 NaN                   FALSE
      408                 NaN                   FALSE
      409                 NaN                   FALSE
      410                 NaN                   FALSE
      411          0.00000000                   FALSE
      412          5.62162162                   FALSE
      413                 NaN                   FALSE
      414          0.58728180                   FALSE
      415                 NaN                   FALSE
      416                 NaN                   FALSE
      417                 NaN                   FALSE
      418                 NaN                   FALSE
      419                 NaN                   FALSE
      420                 NaN                   FALSE
      421                 NaN                   FALSE
      422                 NaN                   FALSE
      423          0.00000000                   FALSE
      424          0.00000000                   FALSE
      425          0.82285714                   FALSE
      426          0.80735108                   FALSE
      427          0.00000000                   FALSE
      428                 NaN                   FALSE
      429                 NaN                   FALSE
      430          0.78923767                   FALSE
      431                 NaN                   FALSE
      432          0.74251497                   FALSE
      433          0.97342193                   FALSE
      434          1.09455587                   FALSE
      435                 NaN                   FALSE
      436                 NaN                   FALSE
      437                 NaN                   FALSE
      438                 NaN                   FALSE
      439                 NaN                   FALSE
      440                 NaN                   FALSE
      441          0.19718310                   FALSE
      442                 NaN                   FALSE
      443          0.00000000                   FALSE
      444                 NaN                   FALSE
      445                 NaN                   FALSE
      446                 NaN                   FALSE
      447                 NaN                   FALSE
      448                 NaN                   FALSE
      449          0.56812652                   FALSE
      450          0.24195804                   FALSE
      451                 NaN                   FALSE
      452                 NaN                   FALSE
      453                 NaN                   FALSE
      454                 NaN                   FALSE
      455          0.00000000                   FALSE
      456                 NaN                   FALSE
      457                 NaN                   FALSE
      458                 NaN                   FALSE
      459          0.39423077                   FALSE
      460                 NaN                   FALSE
      461          0.54093567                   FALSE
      462          0.92830189                   FALSE
      463                 NaN                   FALSE
      464          0.06250000                   FALSE
      465          0.10820046                   FALSE
      466          0.40043526                   FALSE
      467          0.00000000                   FALSE
      468                 NaN                   FALSE
      469          0.00000000                   FALSE
      470                 NaN                   FALSE
      471          0.00000000                   FALSE
      472                 NaN                   FALSE
      473          0.71957672                   FALSE
      474                 NaN                   FALSE
      475          0.11281071                   FALSE
      476          0.23922414                   FALSE
      477          0.46666667                   FALSE
      478                 NaN                   FALSE
      479                 NaN                   FALSE
      480          0.92320261                   FALSE
      481          0.55000000                   FALSE
      482          1.21269841                   FALSE
      483          0.92771084                   FALSE
      484                 NaN                   FALSE
      485          0.60159363                   FALSE
      486          0.60445682                   FALSE
      487          0.30021598                   FALSE
      488                 NaN                   FALSE
      489          2.69219653                   FALSE
      490          0.04566929                   FALSE
      491          0.39163498                   FALSE
      492          0.60272277                   FALSE
      493                 Inf                   FALSE
      494          0.50059453                   FALSE
      495                 NaN                   FALSE
      496          0.23164557                   FALSE
      497          0.00000000                   FALSE
      498                 NaN                   FALSE
      499                 NaN                   FALSE
      500                 NaN                   FALSE

# validation best response

    Code
      as.data.frame(verif)
    Output
          subjid         seq best_response_unconfirmed best_response_conf_inf_12 best_response_conf_inf_28
      1        1 CR-CR-CR-CR         Complete response         Complete response         Complete response
      2        2 CR-CR-CR-PD         Complete response         Complete response         Complete response
      3        3 CR-CR-CR-NE         Complete response         Complete response         Complete response
      4        4 CR-CR-PD-NA         Complete response       Progressive disease            Stable disease
      5        5 CR-CR-NE-CR         Complete response         Complete response         Complete response
      6        6 CR-CR-NE-PD         Complete response            Stable disease            Stable disease
      7        7 CR-CR-NE-NE         Complete response            Stable disease            Stable disease
      8        8 CR-PD-NA-NA         Complete response       Progressive disease            Stable disease
      9        9 CR-NE-CR-CR         Complete response         Complete response         Complete response
      10      10 CR-NE-CR-PD         Complete response         Complete response         Complete response
      11      11 CR-NE-CR-NE         Complete response         Complete response         Complete response
      12      12 CR-NE-PD-NA         Complete response       Progressive disease            Stable disease
      13      13 CR-NE-NE-CR         Complete response            Stable disease            Stable disease
      14      14 CR-NE-NE-PD         Complete response            Stable disease            Stable disease
      15      15 CR-NE-NE-NE         Complete response            Stable disease            Stable disease
      16      16 PR-CR-CR-CR         Complete response         Complete response         Complete response
      17      17 PR-CR-CR-PD         Complete response          Partial response          Partial response
      18      18 PR-CR-CR-NE         Complete response          Partial response          Partial response
      19      19 PR-CR-PD-NA         Complete response       Progressive disease            Stable disease
      20      20 PR-CR-NE-CR         Complete response         Complete response         Complete response
      21      21 PR-CR-NE-PD         Complete response            Stable disease            Stable disease
      22      22 PR-CR-NE-NE         Complete response            Stable disease            Stable disease
      23      23 PR-PR-CR-CR         Complete response          Partial response          Partial response
      24      24 PR-PR-CR-PD         Complete response          Partial response          Partial response
      25      25 PR-PR-CR-NE         Complete response          Partial response          Partial response
      26      26 PR-PR-PR-CR         Complete response          Partial response          Partial response
      27      27 PR-PR-PR-PR          Partial response          Partial response          Partial response
      28      28 PR-PR-PR-SD          Partial response          Partial response          Partial response
      29      29 PR-PR-PR-PD          Partial response          Partial response          Partial response
      30      30 PR-PR-PR-NE          Partial response          Partial response          Partial response
      31      31 PR-PR-SD-CR         Complete response            Stable disease            Stable disease
      32      32 PR-PR-SD-PR          Partial response            Stable disease            Stable disease
      33      33 PR-PR-SD-SD          Partial response            Stable disease            Stable disease
      34      34 PR-PR-SD-PD          Partial response            Stable disease            Stable disease
      35      35 PR-PR-SD-NE          Partial response            Stable disease            Stable disease
      36      36 PR-PR-PD-NA          Partial response       Progressive disease            Stable disease
      37      37 PR-PR-NE-CR         Complete response          Partial response          Partial response
      38      38 PR-PR-NE-PR          Partial response          Partial response          Partial response
      39      39 PR-PR-NE-SD          Partial response            Stable disease            Stable disease
      40      40 PR-PR-NE-PD          Partial response            Stable disease            Stable disease
      41      41 PR-PR-NE-NE          Partial response            Stable disease            Stable disease
      42      42 PR-SD-CR-CR         Complete response            Stable disease            Stable disease
      43      43 PR-SD-CR-PD         Complete response            Stable disease            Stable disease
      44      44 PR-SD-CR-NE         Complete response            Stable disease            Stable disease
      45      45 PR-SD-PR-CR         Complete response            Stable disease            Stable disease
      46      46 PR-SD-PR-PR          Partial response            Stable disease            Stable disease
      47      47 PR-SD-PR-SD          Partial response            Stable disease            Stable disease
      48      48 PR-SD-PR-PD          Partial response            Stable disease            Stable disease
      49      49 PR-SD-PR-NE          Partial response            Stable disease            Stable disease
      50      50 PR-SD-SD-CR         Complete response            Stable disease            Stable disease
      51      51 PR-SD-SD-PR          Partial response            Stable disease            Stable disease
      52      52 PR-SD-SD-SD          Partial response            Stable disease            Stable disease
      53      53 PR-SD-SD-PD          Partial response            Stable disease            Stable disease
      54      54 PR-SD-SD-NE          Partial response            Stable disease            Stable disease
      55      55 PR-SD-PD-NA          Partial response       Progressive disease            Stable disease
      56      56 PR-SD-NE-CR         Complete response            Stable disease            Stable disease
      57      57 PR-SD-NE-PR          Partial response            Stable disease            Stable disease
      58      58 PR-SD-NE-SD          Partial response            Stable disease            Stable disease
      59      59 PR-SD-NE-PD          Partial response            Stable disease            Stable disease
      60      60 PR-SD-NE-NE          Partial response            Stable disease            Stable disease
      61      61 PR-PD-NA-NA          Partial response       Progressive disease            Stable disease
      62      62 PR-NE-CR-CR         Complete response          Partial response          Partial response
      63      63 PR-NE-CR-PD         Complete response          Partial response          Partial response
      64      64 PR-NE-CR-NE         Complete response          Partial response          Partial response
      65      65 PR-NE-PR-CR         Complete response          Partial response          Partial response
      66      66 PR-NE-PR-PR          Partial response          Partial response          Partial response
      67      67 PR-NE-PR-SD          Partial response          Partial response          Partial response
      68      68 PR-NE-PR-PD          Partial response          Partial response          Partial response
      69      69 PR-NE-PR-NE          Partial response          Partial response          Partial response
      70      70 PR-NE-SD-CR         Complete response            Stable disease            Stable disease
      71      71 PR-NE-SD-PR          Partial response            Stable disease            Stable disease
      72      72 PR-NE-SD-SD          Partial response            Stable disease            Stable disease
      73      73 PR-NE-SD-PD          Partial response            Stable disease            Stable disease
      74      74 PR-NE-SD-NE          Partial response            Stable disease            Stable disease
      75      75 PR-NE-PD-NA          Partial response       Progressive disease            Stable disease
      76      76 PR-NE-NE-CR         Complete response            Stable disease            Stable disease
      77      77 PR-NE-NE-PR          Partial response            Stable disease            Stable disease
      78      78 PR-NE-NE-SD          Partial response            Stable disease            Stable disease
      79      79 PR-NE-NE-PD          Partial response            Stable disease            Stable disease
      80      80 PR-NE-NE-NE          Partial response            Stable disease            Stable disease
      81      81 SD-CR-CR-CR         Complete response         Complete response         Complete response
      82      82 SD-CR-CR-PD         Complete response            Stable disease            Stable disease
      83      83 SD-CR-CR-NE         Complete response            Stable disease            Stable disease
      84      84 SD-CR-PD-NA         Complete response       Progressive disease            Stable disease
      85      85 SD-CR-NE-CR         Complete response         Complete response         Complete response
      86      86 SD-CR-NE-PD         Complete response            Stable disease            Stable disease
      87      87 SD-CR-NE-NE         Complete response            Stable disease            Stable disease
      88      88 SD-PR-CR-CR         Complete response          Partial response          Partial response
      89      89 SD-PR-CR-PD         Complete response            Stable disease            Stable disease
      90      90 SD-PR-CR-NE         Complete response            Stable disease            Stable disease
      91      91 SD-PR-PR-CR         Complete response          Partial response          Partial response
      92      92 SD-PR-PR-PR          Partial response          Partial response          Partial response
      93      93 SD-PR-PR-SD          Partial response            Stable disease            Stable disease
      94      94 SD-PR-PR-PD          Partial response            Stable disease            Stable disease
      95      95 SD-PR-PR-NE          Partial response            Stable disease            Stable disease
      96      96 SD-PR-SD-CR         Complete response            Stable disease            Stable disease
      97      97 SD-PR-SD-PR          Partial response            Stable disease            Stable disease
      98      98 SD-PR-SD-SD          Partial response            Stable disease            Stable disease
      99      99 SD-PR-SD-PD          Partial response            Stable disease            Stable disease
      100    100 SD-PR-SD-NE          Partial response            Stable disease            Stable disease
      101    101 SD-PR-PD-NA          Partial response       Progressive disease            Stable disease
      102    102 SD-PR-NE-CR         Complete response          Partial response          Partial response
      103    103 SD-PR-NE-PR          Partial response          Partial response          Partial response
      104    104 SD-PR-NE-SD          Partial response            Stable disease            Stable disease
      105    105 SD-PR-NE-PD          Partial response            Stable disease            Stable disease
      106    106 SD-PR-NE-NE          Partial response            Stable disease            Stable disease
      107    107 SD-SD-CR-CR         Complete response            Stable disease            Stable disease
      108    108 SD-SD-CR-PD         Complete response            Stable disease            Stable disease
      109    109 SD-SD-CR-NE         Complete response            Stable disease            Stable disease
      110    110 SD-SD-PR-CR         Complete response            Stable disease            Stable disease
      111    111 SD-SD-PR-PR          Partial response            Stable disease            Stable disease
      112    112 SD-SD-PR-SD          Partial response            Stable disease            Stable disease
      113    113 SD-SD-PR-PD          Partial response            Stable disease            Stable disease
      114    114 SD-SD-PR-NE          Partial response            Stable disease            Stable disease
      115    115 SD-SD-SD-CR         Complete response            Stable disease            Stable disease
      116    116 SD-SD-SD-PR          Partial response            Stable disease            Stable disease
      117    117 SD-SD-SD-SD            Stable disease            Stable disease            Stable disease
      118    118 SD-SD-SD-PD            Stable disease            Stable disease            Stable disease
      119    119 SD-SD-SD-NE            Stable disease            Stable disease            Stable disease
      120    120 SD-SD-PD-NA            Stable disease       Progressive disease            Stable disease
      121    121 SD-SD-NE-CR         Complete response            Stable disease            Stable disease
      122    122 SD-SD-NE-PR          Partial response            Stable disease            Stable disease
      123    123 SD-SD-NE-SD            Stable disease            Stable disease            Stable disease
      124    124 SD-SD-NE-PD            Stable disease            Stable disease            Stable disease
      125    125 SD-SD-NE-NE            Stable disease            Stable disease            Stable disease
      126    126 SD-PD-NA-NA            Stable disease       Progressive disease            Stable disease
      127    127 SD-NE-CR-CR         Complete response            Stable disease            Stable disease
      128    128 SD-NE-CR-PD         Complete response            Stable disease            Stable disease
      129    129 SD-NE-CR-NE         Complete response            Stable disease            Stable disease
      130    130 SD-NE-PR-CR         Complete response            Stable disease            Stable disease
      131    131 SD-NE-PR-PR          Partial response            Stable disease            Stable disease
      132    132 SD-NE-PR-SD          Partial response            Stable disease            Stable disease
      133    133 SD-NE-PR-PD          Partial response            Stable disease            Stable disease
      134    134 SD-NE-PR-NE          Partial response            Stable disease            Stable disease
      135    135 SD-NE-SD-CR         Complete response            Stable disease            Stable disease
      136    136 SD-NE-SD-PR          Partial response            Stable disease            Stable disease
      137    137 SD-NE-SD-SD            Stable disease            Stable disease            Stable disease
      138    138 SD-NE-SD-PD            Stable disease            Stable disease            Stable disease
      139    139 SD-NE-SD-NE            Stable disease            Stable disease            Stable disease
      140    140 SD-NE-PD-NA            Stable disease       Progressive disease            Stable disease
      141    141 SD-NE-NE-CR         Complete response            Stable disease            Stable disease
      142    142 SD-NE-NE-PR          Partial response            Stable disease            Stable disease
      143    143 SD-NE-NE-SD            Stable disease            Stable disease            Stable disease
      144    144 SD-NE-NE-PD            Stable disease            Stable disease            Stable disease
      145    145 SD-NE-NE-NE            Stable disease            Stable disease            Stable disease
      146    146 PD-NA-NA-NA       Progressive disease       Progressive disease       Progressive disease
      147    147 NE-CR-CR-CR         Complete response         Complete response         Complete response
      148    148 NE-CR-CR-PD         Complete response            Stable disease            Stable disease
      149    149 NE-CR-CR-NE         Complete response            Stable disease            Stable disease
      150    150 NE-CR-PD-NA         Complete response       Progressive disease            Stable disease
      151    151 NE-CR-NE-CR         Complete response         Complete response         Complete response
      152    152 NE-CR-NE-PD         Complete response            Stable disease            Stable disease
      153    153 NE-CR-NE-NE         Complete response            Stable disease            Stable disease
      154    154 NE-PR-CR-CR         Complete response          Partial response          Partial response
      155    155 NE-PR-CR-PD         Complete response            Stable disease            Stable disease
      156    156 NE-PR-CR-NE         Complete response            Stable disease            Stable disease
      157    157 NE-PR-PR-CR         Complete response          Partial response          Partial response
      158    158 NE-PR-PR-PR          Partial response          Partial response          Partial response
      159    159 NE-PR-PR-SD          Partial response            Stable disease            Stable disease
      160    160 NE-PR-PR-PD          Partial response            Stable disease            Stable disease
      161    161 NE-PR-PR-NE          Partial response            Stable disease            Stable disease
      162    162 NE-PR-SD-CR         Complete response            Stable disease            Stable disease
      163    163 NE-PR-SD-PR          Partial response            Stable disease            Stable disease
      164    164 NE-PR-SD-SD          Partial response            Stable disease            Stable disease
      165    165 NE-PR-SD-PD          Partial response            Stable disease            Stable disease
      166    166 NE-PR-SD-NE          Partial response            Stable disease            Stable disease
      167    167 NE-PR-PD-NA          Partial response       Progressive disease            Stable disease
      168    168 NE-PR-NE-CR         Complete response          Partial response          Partial response
      169    169 NE-PR-NE-PR          Partial response          Partial response          Partial response
      170    170 NE-PR-NE-SD          Partial response            Stable disease            Stable disease
      171    171 NE-PR-NE-PD          Partial response            Stable disease            Stable disease
      172    172 NE-PR-NE-NE          Partial response            Stable disease            Stable disease
      173    173 NE-SD-CR-CR         Complete response            Stable disease            Stable disease
      174    174 NE-SD-CR-PD         Complete response            Stable disease            Stable disease
      175    175 NE-SD-CR-NE         Complete response            Stable disease            Stable disease
      176    176 NE-SD-PR-CR         Complete response            Stable disease            Stable disease
      177    177 NE-SD-PR-PR          Partial response            Stable disease            Stable disease
      178    178 NE-SD-PR-SD          Partial response            Stable disease            Stable disease
      179    179 NE-SD-PR-PD          Partial response            Stable disease            Stable disease
      180    180 NE-SD-PR-NE          Partial response            Stable disease            Stable disease
      181    181 NE-SD-SD-CR         Complete response            Stable disease            Stable disease
      182    182 NE-SD-SD-PR          Partial response            Stable disease            Stable disease
      183    183 NE-SD-SD-SD            Stable disease            Stable disease            Stable disease
      184    184 NE-SD-SD-PD            Stable disease            Stable disease            Stable disease
      185    185 NE-SD-SD-NE            Stable disease            Stable disease            Stable disease
      186    186 NE-SD-PD-NA            Stable disease       Progressive disease            Stable disease
      187    187 NE-SD-NE-CR         Complete response            Stable disease            Stable disease
      188    188 NE-SD-NE-PR          Partial response            Stable disease            Stable disease
      189    189 NE-SD-NE-SD            Stable disease            Stable disease            Stable disease
      190    190 NE-SD-NE-PD            Stable disease            Stable disease            Stable disease
      191    191 NE-SD-NE-NE            Stable disease            Stable disease            Stable disease
      192    192 NE-PD-NA-NA       Progressive disease       Progressive disease       Progressive disease
      193    193 NE-NE-CR-CR         Complete response            Stable disease            Stable disease
      194    194 NE-NE-CR-PD         Complete response            Stable disease            Stable disease
      195    195 NE-NE-CR-NE         Complete response            Stable disease            Stable disease
      196    196 NE-NE-PR-CR         Complete response            Stable disease            Stable disease
      197    197 NE-NE-PR-PR          Partial response            Stable disease            Stable disease
      198    198 NE-NE-PR-SD          Partial response            Stable disease            Stable disease
      199    199 NE-NE-PR-PD          Partial response            Stable disease            Stable disease
      200    200 NE-NE-PR-NE          Partial response            Stable disease            Stable disease
      201    201 NE-NE-SD-CR         Complete response            Stable disease            Stable disease
      202    202 NE-NE-SD-PR          Partial response            Stable disease            Stable disease
      203    203 NE-NE-SD-SD            Stable disease            Stable disease            Stable disease
      204    204 NE-NE-SD-PD            Stable disease            Stable disease            Stable disease
      205    205 NE-NE-SD-NE            Stable disease            Stable disease            Stable disease
      206    206 NE-NE-PD-NA       Progressive disease       Progressive disease       Progressive disease
      207    207 NE-NE-NE-CR         Complete response            Stable disease            Stable disease
      208    208 NE-NE-NE-PR          Partial response            Stable disease            Stable disease
      209    209 NE-NE-NE-SD            Stable disease            Stable disease            Stable disease
      210    210 NE-NE-NE-PD       Progressive disease       Progressive disease       Progressive disease
      211    211 NE-NE-NE-NE             Not evaluable             Not evaluable             Not evaluable
      212    212 CR-CR-NA-NA         Complete response             Not evaluable            Stable disease
          best_response_conf_sup_28
      1           Complete response
      2           Complete response
      3           Complete response
      4           Complete response
      5           Complete response
      6           Complete response
      7           Complete response
      8              Stable disease
      9           Complete response
      10          Complete response
      11          Complete response
      12             Stable disease
      13             Stable disease
      14             Stable disease
      15             Stable disease
      16          Complete response
      17          Complete response
      18          Complete response
      19           Partial response
      20          Complete response
      21           Partial response
      22           Partial response
      23          Complete response
      24           Partial response
      25           Partial response
      26           Partial response
      27           Partial response
      28           Partial response
      29           Partial response
      30           Partial response
      31           Partial response
      32           Partial response
      33           Partial response
      34           Partial response
      35           Partial response
      36           Partial response
      37           Partial response
      38           Partial response
      39           Partial response
      40           Partial response
      41           Partial response
      42          Complete response
      43             Stable disease
      44             Stable disease
      45           Partial response
      46           Partial response
      47             Stable disease
      48             Stable disease
      49             Stable disease
      50             Stable disease
      51             Stable disease
      52             Stable disease
      53             Stable disease
      54             Stable disease
      55             Stable disease
      56             Stable disease
      57             Stable disease
      58             Stable disease
      59             Stable disease
      60             Stable disease
      61             Stable disease
      62          Complete response
      63           Partial response
      64           Partial response
      65           Partial response
      66           Partial response
      67           Partial response
      68           Partial response
      69           Partial response
      70             Stable disease
      71             Stable disease
      72             Stable disease
      73             Stable disease
      74             Stable disease
      75             Stable disease
      76             Stable disease
      77             Stable disease
      78             Stable disease
      79             Stable disease
      80             Stable disease
      81          Complete response
      82          Complete response
      83          Complete response
      84             Stable disease
      85          Complete response
      86             Stable disease
      87             Stable disease
      88          Complete response
      89           Partial response
      90           Partial response
      91           Partial response
      92           Partial response
      93           Partial response
      94           Partial response
      95           Partial response
      96             Stable disease
      97             Stable disease
      98             Stable disease
      99             Stable disease
      100            Stable disease
      101            Stable disease
      102          Partial response
      103          Partial response
      104            Stable disease
      105            Stable disease
      106            Stable disease
      107         Complete response
      108            Stable disease
      109            Stable disease
      110          Partial response
      111          Partial response
      112            Stable disease
      113            Stable disease
      114            Stable disease
      115            Stable disease
      116            Stable disease
      117            Stable disease
      118            Stable disease
      119            Stable disease
      120            Stable disease
      121            Stable disease
      122            Stable disease
      123            Stable disease
      124            Stable disease
      125            Stable disease
      126            Stable disease
      127         Complete response
      128            Stable disease
      129            Stable disease
      130          Partial response
      131          Partial response
      132            Stable disease
      133            Stable disease
      134            Stable disease
      135            Stable disease
      136            Stable disease
      137            Stable disease
      138            Stable disease
      139            Stable disease
      140            Stable disease
      141            Stable disease
      142            Stable disease
      143            Stable disease
      144            Stable disease
      145            Stable disease
      146       Progressive disease
      147         Complete response
      148         Complete response
      149         Complete response
      150            Stable disease
      151         Complete response
      152            Stable disease
      153            Stable disease
      154         Complete response
      155          Partial response
      156          Partial response
      157          Partial response
      158          Partial response
      159          Partial response
      160          Partial response
      161          Partial response
      162            Stable disease
      163            Stable disease
      164            Stable disease
      165            Stable disease
      166            Stable disease
      167            Stable disease
      168          Partial response
      169          Partial response
      170            Stable disease
      171            Stable disease
      172            Stable disease
      173         Complete response
      174            Stable disease
      175            Stable disease
      176          Partial response
      177          Partial response
      178            Stable disease
      179            Stable disease
      180            Stable disease
      181            Stable disease
      182            Stable disease
      183            Stable disease
      184            Stable disease
      185            Stable disease
      186            Stable disease
      187            Stable disease
      188            Stable disease
      189            Stable disease
      190            Stable disease
      191            Stable disease
      192       Progressive disease
      193         Complete response
      194            Stable disease
      195            Stable disease
      196          Partial response
      197          Partial response
      198            Stable disease
      199            Stable disease
      200            Stable disease
      201            Stable disease
      202            Stable disease
      203            Stable disease
      204            Stable disease
      205            Stable disease
      206       Progressive disease
      207            Stable disease
      208            Stable disease
      209            Stable disease
      210       Progressive disease
      211             Not evaluable
      212         Complete response

# Non excluion patient

    Code
      as.data.frame(non_excl_unconf)
    Output
        subjid     best_response       date target_sum target_sum_diff_first target_sum_diff_min six_months_confirmation
      1    145 Complete response 2026-05-14         NA                     0                  NA                   FALSE
    Code
      as.data.frame(non_excl_conf)
    Output
        subjid best_response       date target_sum target_sum_diff_first target_sum_diff_min six_months_confirmation
      1    145 Not evaluable 2026-05-14         NA                     0                  NA                   FALSE

# Missing values don't exclude patients

    Code
      as.data.frame(non_excl_unconf)
    Output
        subjid     best_response       date target_sum target_sum_diff_first target_sum_diff_min six_months_confirmation
      1    145 Complete response 2026-01-29         NA                     0                  NA                   FALSE
    Code
      as.data.frame(non_excl_conf)
    Output
        subjid best_response       date target_sum target_sum_diff_first target_sum_diff_min six_months_confirmation
      1    145 Not evaluable 2026-01-29         NA                     0                  NA                   FALSE

