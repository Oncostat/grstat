# rando: snapshots

    Code
      strat = list(age = c("<=18m", ">18m"), gender = c("Male", "Female"), group = c(
        "A", "B", "C"))
      randomisation_list(n = 200, arms = c("Control", "Treatment"), strata = strat,
      block.sizes = c(4, 8))
    Message
      Randomisation list for 200 patients randomized in arms "Control" and "Treatment" across 12 strata with blocks of length 4 and 8.
    Output
      # A tibble: 2,424 x 8
           id                      age    gender group stratum.block.id block.size
           <chr>                   <chr>  <chr>  <chr> <fct>                 <dbl>
         1 inf18m__Male__A - 001   inf18m Male   A     1                         4
         2 inf18m__Male__A - 002   inf18m Male   A     1                         4
         3 inf18m__Male__A - 003   inf18m Male   A     1                         4
         4 inf18m__Male__A - 004   inf18m Male   A     1                         4
         5 inf18m__Male__A - 005   inf18m Male   A     2                         8
         6 inf18m__Male__A - 006   inf18m Male   A     2                         8
         7 inf18m__Male__A - 007   inf18m Male   A     2                         8
         8 inf18m__Male__A - 008   inf18m Male   A     2                         8
         9 inf18m__Male__A - 009   inf18m Male   A     2                         8
        10 inf18m__Male__A - 010   inf18m Male   A     2                         8
        11 inf18m__Male__A - 011   inf18m Male   A     2                         8
        12 inf18m__Male__A - 012   inf18m Male   A     2                         8
        13 inf18m__Male__A - 013   inf18m Male   A     3                         8
        14 inf18m__Male__A - 014   inf18m Male   A     3                         8
        15 inf18m__Male__A - 015   inf18m Male   A     3                         8
        16 inf18m__Male__A - 016   inf18m Male   A     3                         8
        17 inf18m__Male__A - 017   inf18m Male   A     3                         8
        18 inf18m__Male__A - 018   inf18m Male   A     3                         8
        19 inf18m__Male__A - 019   inf18m Male   A     3                         8
        20 inf18m__Male__A - 020   inf18m Male   A     3                         8
        21 inf18m__Male__A - 021   inf18m Male   A     4                         8
        22 inf18m__Male__A - 022   inf18m Male   A     4                         8
        23 inf18m__Male__A - 023   inf18m Male   A     4                         8
        24 inf18m__Male__A - 024   inf18m Male   A     4                         8
        25 inf18m__Male__A - 025   inf18m Male   A     4                         8
        26 inf18m__Male__A - 026   inf18m Male   A     4                         8
        27 inf18m__Male__A - 027   inf18m Male   A     4                         8
        28 inf18m__Male__A - 028   inf18m Male   A     4                         8
        29 inf18m__Male__A - 029   inf18m Male   A     5                         4
        30 inf18m__Male__A - 030   inf18m Male   A     5                         4
        31 inf18m__Male__A - 031   inf18m Male   A     5                         4
        32 inf18m__Male__A - 032   inf18m Male   A     5                         4
        33 inf18m__Male__A - 033   inf18m Male   A     6                         8
        34 inf18m__Male__A - 034   inf18m Male   A     6                         8
        35 inf18m__Male__A - 035   inf18m Male   A     6                         8
        36 inf18m__Male__A - 036   inf18m Male   A     6                         8
        37 inf18m__Male__A - 037   inf18m Male   A     6                         8
        38 inf18m__Male__A - 038   inf18m Male   A     6                         8
        39 inf18m__Male__A - 039   inf18m Male   A     6                         8
        40 inf18m__Male__A - 040   inf18m Male   A     6                         8
        41 inf18m__Male__A - 041   inf18m Male   A     7                         8
        42 inf18m__Male__A - 042   inf18m Male   A     7                         8
        43 inf18m__Male__A - 043   inf18m Male   A     7                         8
        44 inf18m__Male__A - 044   inf18m Male   A     7                         8
        45 inf18m__Male__A - 045   inf18m Male   A     7                         8
        46 inf18m__Male__A - 046   inf18m Male   A     7                         8
        47 inf18m__Male__A - 047   inf18m Male   A     7                         8
        48 inf18m__Male__A - 048   inf18m Male   A     7                         8
        49 inf18m__Male__A - 049   inf18m Male   A     8                         4
        50 inf18m__Male__A - 050   inf18m Male   A     8                         4
        51 inf18m__Male__A - 051   inf18m Male   A     8                         4
        52 inf18m__Male__A - 052   inf18m Male   A     8                         4
        53 inf18m__Male__A - 053   inf18m Male   A     9                         4
        54 inf18m__Male__A - 054   inf18m Male   A     9                         4
        55 inf18m__Male__A - 055   inf18m Male   A     9                         4
        56 inf18m__Male__A - 056   inf18m Male   A     9                         4
        57 inf18m__Male__A - 057   inf18m Male   A     10                        8
        58 inf18m__Male__A - 058   inf18m Male   A     10                        8
        59 inf18m__Male__A - 059   inf18m Male   A     10                        8
        60 inf18m__Male__A - 060   inf18m Male   A     10                        8
        61 inf18m__Male__A - 061   inf18m Male   A     10                        8
        62 inf18m__Male__A - 062   inf18m Male   A     10                        8
        63 inf18m__Male__A - 063   inf18m Male   A     10                        8
        64 inf18m__Male__A - 064   inf18m Male   A     10                        8
        65 inf18m__Male__A - 065   inf18m Male   A     11                        4
        66 inf18m__Male__A - 066   inf18m Male   A     11                        4
        67 inf18m__Male__A - 067   inf18m Male   A     11                        4
        68 inf18m__Male__A - 068   inf18m Male   A     11                        4
        69 inf18m__Male__A - 069   inf18m Male   A     12                        4
        70 inf18m__Male__A - 070   inf18m Male   A     12                        4
        71 inf18m__Male__A - 071   inf18m Male   A     12                        4
        72 inf18m__Male__A - 072   inf18m Male   A     12                        4
        73 inf18m__Male__A - 073   inf18m Male   A     13                        4
        74 inf18m__Male__A - 074   inf18m Male   A     13                        4
        75 inf18m__Male__A - 075   inf18m Male   A     13                        4
        76 inf18m__Male__A - 076   inf18m Male   A     13                        4
        77 inf18m__Male__A - 077   inf18m Male   A     14                        8
        78 inf18m__Male__A - 078   inf18m Male   A     14                        8
        79 inf18m__Male__A - 079   inf18m Male   A     14                        8
        80 inf18m__Male__A - 080   inf18m Male   A     14                        8
        81 inf18m__Male__A - 081   inf18m Male   A     14                        8
        82 inf18m__Male__A - 082   inf18m Male   A     14                        8
        83 inf18m__Male__A - 083   inf18m Male   A     14                        8
        84 inf18m__Male__A - 084   inf18m Male   A     14                        8
        85 inf18m__Male__A - 085   inf18m Male   A     15                        8
        86 inf18m__Male__A - 086   inf18m Male   A     15                        8
        87 inf18m__Male__A - 087   inf18m Male   A     15                        8
        88 inf18m__Male__A - 088   inf18m Male   A     15                        8
        89 inf18m__Male__A - 089   inf18m Male   A     15                        8
        90 inf18m__Male__A - 090   inf18m Male   A     15                        8
        91 inf18m__Male__A - 091   inf18m Male   A     15                        8
        92 inf18m__Male__A - 092   inf18m Male   A     15                        8
        93 inf18m__Male__A - 093   inf18m Male   A     16                        8
        94 inf18m__Male__A - 094   inf18m Male   A     16                        8
        95 inf18m__Male__A - 095   inf18m Male   A     16                        8
        96 inf18m__Male__A - 096   inf18m Male   A     16                        8
        97 inf18m__Male__A - 097   inf18m Male   A     16                        8
        98 inf18m__Male__A - 098   inf18m Male   A     16                        8
        99 inf18m__Male__A - 099   inf18m Male   A     16                        8
       100 inf18m__Male__A - 100   inf18m Male   A     16                        8
       101 inf18m__Male__A - 101   inf18m Male   A     17                        4
       102 inf18m__Male__A - 102   inf18m Male   A     17                        4
       103 inf18m__Male__A - 103   inf18m Male   A     17                        4
       104 inf18m__Male__A - 104   inf18m Male   A     17                        4
       105 inf18m__Male__A - 105   inf18m Male   A     18                        4
       106 inf18m__Male__A - 106   inf18m Male   A     18                        4
       107 inf18m__Male__A - 107   inf18m Male   A     18                        4
       108 inf18m__Male__A - 108   inf18m Male   A     18                        4
       109 inf18m__Male__A - 109   inf18m Male   A     19                        8
       110 inf18m__Male__A - 110   inf18m Male   A     19                        8
       111 inf18m__Male__A - 111   inf18m Male   A     19                        8
       112 inf18m__Male__A - 112   inf18m Male   A     19                        8
       113 inf18m__Male__A - 113   inf18m Male   A     19                        8
       114 inf18m__Male__A - 114   inf18m Male   A     19                        8
       115 inf18m__Male__A - 115   inf18m Male   A     19                        8
       116 inf18m__Male__A - 116   inf18m Male   A     19                        8
       117 inf18m__Male__A - 117   inf18m Male   A     20                        8
       118 inf18m__Male__A - 118   inf18m Male   A     20                        8
       119 inf18m__Male__A - 119   inf18m Male   A     20                        8
       120 inf18m__Male__A - 120   inf18m Male   A     20                        8
       121 inf18m__Male__A - 121   inf18m Male   A     20                        8
       122 inf18m__Male__A - 122   inf18m Male   A     20                        8
       123 inf18m__Male__A - 123   inf18m Male   A     20                        8
       124 inf18m__Male__A - 124   inf18m Male   A     20                        8
       125 inf18m__Male__A - 125   inf18m Male   A     21                        8
       126 inf18m__Male__A - 126   inf18m Male   A     21                        8
       127 inf18m__Male__A - 127   inf18m Male   A     21                        8
       128 inf18m__Male__A - 128   inf18m Male   A     21                        8
       129 inf18m__Male__A - 129   inf18m Male   A     21                        8
       130 inf18m__Male__A - 130   inf18m Male   A     21                        8
       131 inf18m__Male__A - 131   inf18m Male   A     21                        8
       132 inf18m__Male__A - 132   inf18m Male   A     21                        8
       133 inf18m__Male__A - 133   inf18m Male   A     22                        8
       134 inf18m__Male__A - 134   inf18m Male   A     22                        8
       135 inf18m__Male__A - 135   inf18m Male   A     22                        8
       136 inf18m__Male__A - 136   inf18m Male   A     22                        8
       137 inf18m__Male__A - 137   inf18m Male   A     22                        8
       138 inf18m__Male__A - 138   inf18m Male   A     22                        8
       139 inf18m__Male__A - 139   inf18m Male   A     22                        8
       140 inf18m__Male__A - 140   inf18m Male   A     22                        8
       141 inf18m__Male__A - 141   inf18m Male   A     23                        4
       142 inf18m__Male__A - 142   inf18m Male   A     23                        4
       143 inf18m__Male__A - 143   inf18m Male   A     23                        4
       144 inf18m__Male__A - 144   inf18m Male   A     23                        4
       145 inf18m__Male__A - 145   inf18m Male   A     24                        8
       146 inf18m__Male__A - 146   inf18m Male   A     24                        8
       147 inf18m__Male__A - 147   inf18m Male   A     24                        8
       148 inf18m__Male__A - 148   inf18m Male   A     24                        8
       149 inf18m__Male__A - 149   inf18m Male   A     24                        8
       150 inf18m__Male__A - 150   inf18m Male   A     24                        8
       151 inf18m__Male__A - 151   inf18m Male   A     24                        8
       152 inf18m__Male__A - 152   inf18m Male   A     24                        8
       153 inf18m__Male__A - 153   inf18m Male   A     25                        8
       154 inf18m__Male__A - 154   inf18m Male   A     25                        8
       155 inf18m__Male__A - 155   inf18m Male   A     25                        8
       156 inf18m__Male__A - 156   inf18m Male   A     25                        8
       157 inf18m__Male__A - 157   inf18m Male   A     25                        8
       158 inf18m__Male__A - 158   inf18m Male   A     25                        8
       159 inf18m__Male__A - 159   inf18m Male   A     25                        8
       160 inf18m__Male__A - 160   inf18m Male   A     25                        8
       161 inf18m__Male__A - 161   inf18m Male   A     26                        8
       162 inf18m__Male__A - 162   inf18m Male   A     26                        8
       163 inf18m__Male__A - 163   inf18m Male   A     26                        8
       164 inf18m__Male__A - 164   inf18m Male   A     26                        8
       165 inf18m__Male__A - 165   inf18m Male   A     26                        8
       166 inf18m__Male__A - 166   inf18m Male   A     26                        8
       167 inf18m__Male__A - 167   inf18m Male   A     26                        8
       168 inf18m__Male__A - 168   inf18m Male   A     26                        8
       169 inf18m__Male__A - 169   inf18m Male   A     27                        8
       170 inf18m__Male__A - 170   inf18m Male   A     27                        8
       171 inf18m__Male__A - 171   inf18m Male   A     27                        8
       172 inf18m__Male__A - 172   inf18m Male   A     27                        8
       173 inf18m__Male__A - 173   inf18m Male   A     27                        8
       174 inf18m__Male__A - 174   inf18m Male   A     27                        8
       175 inf18m__Male__A - 175   inf18m Male   A     27                        8
       176 inf18m__Male__A - 176   inf18m Male   A     27                        8
       177 inf18m__Male__A - 177   inf18m Male   A     28                        8
       178 inf18m__Male__A - 178   inf18m Male   A     28                        8
       179 inf18m__Male__A - 179   inf18m Male   A     28                        8
       180 inf18m__Male__A - 180   inf18m Male   A     28                        8
       181 inf18m__Male__A - 181   inf18m Male   A     28                        8
       182 inf18m__Male__A - 182   inf18m Male   A     28                        8
       183 inf18m__Male__A - 183   inf18m Male   A     28                        8
       184 inf18m__Male__A - 184   inf18m Male   A     28                        8
       185 inf18m__Male__A - 185   inf18m Male   A     29                        4
       186 inf18m__Male__A - 186   inf18m Male   A     29                        4
       187 inf18m__Male__A - 187   inf18m Male   A     29                        4
       188 inf18m__Male__A - 188   inf18m Male   A     29                        4
       189 inf18m__Male__A - 189   inf18m Male   A     30                        8
       190 inf18m__Male__A - 190   inf18m Male   A     30                        8
       191 inf18m__Male__A - 191   inf18m Male   A     30                        8
       192 inf18m__Male__A - 192   inf18m Male   A     30                        8
       193 inf18m__Male__A - 193   inf18m Male   A     30                        8
       194 inf18m__Male__A - 194   inf18m Male   A     30                        8
       195 inf18m__Male__A - 195   inf18m Male   A     30                        8
       196 inf18m__Male__A - 196   inf18m Male   A     30                        8
       197 inf18m__Male__A - 197   inf18m Male   A     31                        4
       198 inf18m__Male__A - 198   inf18m Male   A     31                        4
       199 inf18m__Male__A - 199   inf18m Male   A     31                        4
       200 inf18m__Male__A - 200   inf18m Male   A     31                        4
       201 sup18m__Male__A - 001   sup18m Male   A     1                         8
       202 sup18m__Male__A - 002   sup18m Male   A     1                         8
       203 sup18m__Male__A - 003   sup18m Male   A     1                         8
       204 sup18m__Male__A - 004   sup18m Male   A     1                         8
       205 sup18m__Male__A - 005   sup18m Male   A     1                         8
       206 sup18m__Male__A - 006   sup18m Male   A     1                         8
       207 sup18m__Male__A - 007   sup18m Male   A     1                         8
       208 sup18m__Male__A - 008   sup18m Male   A     1                         8
       209 sup18m__Male__A - 009   sup18m Male   A     2                         4
       210 sup18m__Male__A - 010   sup18m Male   A     2                         4
       211 sup18m__Male__A - 011   sup18m Male   A     2                         4
       212 sup18m__Male__A - 012   sup18m Male   A     2                         4
       213 sup18m__Male__A - 013   sup18m Male   A     3                         4
       214 sup18m__Male__A - 014   sup18m Male   A     3                         4
       215 sup18m__Male__A - 015   sup18m Male   A     3                         4
       216 sup18m__Male__A - 016   sup18m Male   A     3                         4
       217 sup18m__Male__A - 017   sup18m Male   A     4                         4
       218 sup18m__Male__A - 018   sup18m Male   A     4                         4
       219 sup18m__Male__A - 019   sup18m Male   A     4                         4
       220 sup18m__Male__A - 020   sup18m Male   A     4                         4
       221 sup18m__Male__A - 021   sup18m Male   A     5                         4
       222 sup18m__Male__A - 022   sup18m Male   A     5                         4
       223 sup18m__Male__A - 023   sup18m Male   A     5                         4
       224 sup18m__Male__A - 024   sup18m Male   A     5                         4
       225 sup18m__Male__A - 025   sup18m Male   A     6                         8
       226 sup18m__Male__A - 026   sup18m Male   A     6                         8
       227 sup18m__Male__A - 027   sup18m Male   A     6                         8
       228 sup18m__Male__A - 028   sup18m Male   A     6                         8
       229 sup18m__Male__A - 029   sup18m Male   A     6                         8
       230 sup18m__Male__A - 030   sup18m Male   A     6                         8
       231 sup18m__Male__A - 031   sup18m Male   A     6                         8
       232 sup18m__Male__A - 032   sup18m Male   A     6                         8
       233 sup18m__Male__A - 033   sup18m Male   A     7                         4
       234 sup18m__Male__A - 034   sup18m Male   A     7                         4
       235 sup18m__Male__A - 035   sup18m Male   A     7                         4
       236 sup18m__Male__A - 036   sup18m Male   A     7                         4
       237 sup18m__Male__A - 037   sup18m Male   A     8                         4
       238 sup18m__Male__A - 038   sup18m Male   A     8                         4
       239 sup18m__Male__A - 039   sup18m Male   A     8                         4
       240 sup18m__Male__A - 040   sup18m Male   A     8                         4
       241 sup18m__Male__A - 041   sup18m Male   A     9                         8
       242 sup18m__Male__A - 042   sup18m Male   A     9                         8
       243 sup18m__Male__A - 043   sup18m Male   A     9                         8
       244 sup18m__Male__A - 044   sup18m Male   A     9                         8
       245 sup18m__Male__A - 045   sup18m Male   A     9                         8
       246 sup18m__Male__A - 046   sup18m Male   A     9                         8
       247 sup18m__Male__A - 047   sup18m Male   A     9                         8
       248 sup18m__Male__A - 048   sup18m Male   A     9                         8
       249 sup18m__Male__A - 049   sup18m Male   A     10                        4
       250 sup18m__Male__A - 050   sup18m Male   A     10                        4
       251 sup18m__Male__A - 051   sup18m Male   A     10                        4
       252 sup18m__Male__A - 052   sup18m Male   A     10                        4
       253 sup18m__Male__A - 053   sup18m Male   A     11                        8
       254 sup18m__Male__A - 054   sup18m Male   A     11                        8
       255 sup18m__Male__A - 055   sup18m Male   A     11                        8
       256 sup18m__Male__A - 056   sup18m Male   A     11                        8
       257 sup18m__Male__A - 057   sup18m Male   A     11                        8
       258 sup18m__Male__A - 058   sup18m Male   A     11                        8
       259 sup18m__Male__A - 059   sup18m Male   A     11                        8
       260 sup18m__Male__A - 060   sup18m Male   A     11                        8
       261 sup18m__Male__A - 061   sup18m Male   A     12                        4
       262 sup18m__Male__A - 062   sup18m Male   A     12                        4
       263 sup18m__Male__A - 063   sup18m Male   A     12                        4
       264 sup18m__Male__A - 064   sup18m Male   A     12                        4
       265 sup18m__Male__A - 065   sup18m Male   A     13                        8
       266 sup18m__Male__A - 066   sup18m Male   A     13                        8
       267 sup18m__Male__A - 067   sup18m Male   A     13                        8
       268 sup18m__Male__A - 068   sup18m Male   A     13                        8
       269 sup18m__Male__A - 069   sup18m Male   A     13                        8
       270 sup18m__Male__A - 070   sup18m Male   A     13                        8
       271 sup18m__Male__A - 071   sup18m Male   A     13                        8
       272 sup18m__Male__A - 072   sup18m Male   A     13                        8
       273 sup18m__Male__A - 073   sup18m Male   A     14                        4
       274 sup18m__Male__A - 074   sup18m Male   A     14                        4
       275 sup18m__Male__A - 075   sup18m Male   A     14                        4
       276 sup18m__Male__A - 076   sup18m Male   A     14                        4
       277 sup18m__Male__A - 077   sup18m Male   A     15                        8
       278 sup18m__Male__A - 078   sup18m Male   A     15                        8
       279 sup18m__Male__A - 079   sup18m Male   A     15                        8
       280 sup18m__Male__A - 080   sup18m Male   A     15                        8
       281 sup18m__Male__A - 081   sup18m Male   A     15                        8
       282 sup18m__Male__A - 082   sup18m Male   A     15                        8
       283 sup18m__Male__A - 083   sup18m Male   A     15                        8
       284 sup18m__Male__A - 084   sup18m Male   A     15                        8
       285 sup18m__Male__A - 085   sup18m Male   A     16                        8
       286 sup18m__Male__A - 086   sup18m Male   A     16                        8
       287 sup18m__Male__A - 087   sup18m Male   A     16                        8
       288 sup18m__Male__A - 088   sup18m Male   A     16                        8
       289 sup18m__Male__A - 089   sup18m Male   A     16                        8
       290 sup18m__Male__A - 090   sup18m Male   A     16                        8
       291 sup18m__Male__A - 091   sup18m Male   A     16                        8
       292 sup18m__Male__A - 092   sup18m Male   A     16                        8
       293 sup18m__Male__A - 093   sup18m Male   A     17                        8
       294 sup18m__Male__A - 094   sup18m Male   A     17                        8
       295 sup18m__Male__A - 095   sup18m Male   A     17                        8
       296 sup18m__Male__A - 096   sup18m Male   A     17                        8
       297 sup18m__Male__A - 097   sup18m Male   A     17                        8
       298 sup18m__Male__A - 098   sup18m Male   A     17                        8
       299 sup18m__Male__A - 099   sup18m Male   A     17                        8
       300 sup18m__Male__A - 100   sup18m Male   A     17                        8
       301 sup18m__Male__A - 101   sup18m Male   A     18                        4
       302 sup18m__Male__A - 102   sup18m Male   A     18                        4
       303 sup18m__Male__A - 103   sup18m Male   A     18                        4
       304 sup18m__Male__A - 104   sup18m Male   A     18                        4
       305 sup18m__Male__A - 105   sup18m Male   A     19                        4
       306 sup18m__Male__A - 106   sup18m Male   A     19                        4
       307 sup18m__Male__A - 107   sup18m Male   A     19                        4
       308 sup18m__Male__A - 108   sup18m Male   A     19                        4
       309 sup18m__Male__A - 109   sup18m Male   A     20                        4
       310 sup18m__Male__A - 110   sup18m Male   A     20                        4
       311 sup18m__Male__A - 111   sup18m Male   A     20                        4
       312 sup18m__Male__A - 112   sup18m Male   A     20                        4
       313 sup18m__Male__A - 113   sup18m Male   A     21                        8
       314 sup18m__Male__A - 114   sup18m Male   A     21                        8
       315 sup18m__Male__A - 115   sup18m Male   A     21                        8
       316 sup18m__Male__A - 116   sup18m Male   A     21                        8
       317 sup18m__Male__A - 117   sup18m Male   A     21                        8
       318 sup18m__Male__A - 118   sup18m Male   A     21                        8
       319 sup18m__Male__A - 119   sup18m Male   A     21                        8
       320 sup18m__Male__A - 120   sup18m Male   A     21                        8
       321 sup18m__Male__A - 121   sup18m Male   A     22                        8
       322 sup18m__Male__A - 122   sup18m Male   A     22                        8
       323 sup18m__Male__A - 123   sup18m Male   A     22                        8
       324 sup18m__Male__A - 124   sup18m Male   A     22                        8
       325 sup18m__Male__A - 125   sup18m Male   A     22                        8
       326 sup18m__Male__A - 126   sup18m Male   A     22                        8
       327 sup18m__Male__A - 127   sup18m Male   A     22                        8
       328 sup18m__Male__A - 128   sup18m Male   A     22                        8
       329 sup18m__Male__A - 129   sup18m Male   A     23                        4
       330 sup18m__Male__A - 130   sup18m Male   A     23                        4
       331 sup18m__Male__A - 131   sup18m Male   A     23                        4
       332 sup18m__Male__A - 132   sup18m Male   A     23                        4
       333 sup18m__Male__A - 133   sup18m Male   A     24                        4
       334 sup18m__Male__A - 134   sup18m Male   A     24                        4
       335 sup18m__Male__A - 135   sup18m Male   A     24                        4
       336 sup18m__Male__A - 136   sup18m Male   A     24                        4
       337 sup18m__Male__A - 137   sup18m Male   A     25                        4
       338 sup18m__Male__A - 138   sup18m Male   A     25                        4
       339 sup18m__Male__A - 139   sup18m Male   A     25                        4
       340 sup18m__Male__A - 140   sup18m Male   A     25                        4
       341 sup18m__Male__A - 141   sup18m Male   A     26                        4
       342 sup18m__Male__A - 142   sup18m Male   A     26                        4
       343 sup18m__Male__A - 143   sup18m Male   A     26                        4
       344 sup18m__Male__A - 144   sup18m Male   A     26                        4
       345 sup18m__Male__A - 145   sup18m Male   A     27                        8
       346 sup18m__Male__A - 146   sup18m Male   A     27                        8
       347 sup18m__Male__A - 147   sup18m Male   A     27                        8
       348 sup18m__Male__A - 148   sup18m Male   A     27                        8
       349 sup18m__Male__A - 149   sup18m Male   A     27                        8
       350 sup18m__Male__A - 150   sup18m Male   A     27                        8
       351 sup18m__Male__A - 151   sup18m Male   A     27                        8
       352 sup18m__Male__A - 152   sup18m Male   A     27                        8
       353 sup18m__Male__A - 153   sup18m Male   A     28                        4
       354 sup18m__Male__A - 154   sup18m Male   A     28                        4
       355 sup18m__Male__A - 155   sup18m Male   A     28                        4
       356 sup18m__Male__A - 156   sup18m Male   A     28                        4
       357 sup18m__Male__A - 157   sup18m Male   A     29                        8
       358 sup18m__Male__A - 158   sup18m Male   A     29                        8
       359 sup18m__Male__A - 159   sup18m Male   A     29                        8
       360 sup18m__Male__A - 160   sup18m Male   A     29                        8
       361 sup18m__Male__A - 161   sup18m Male   A     29                        8
       362 sup18m__Male__A - 162   sup18m Male   A     29                        8
       363 sup18m__Male__A - 163   sup18m Male   A     29                        8
       364 sup18m__Male__A - 164   sup18m Male   A     29                        8
       365 sup18m__Male__A - 165   sup18m Male   A     30                        4
       366 sup18m__Male__A - 166   sup18m Male   A     30                        4
       367 sup18m__Male__A - 167   sup18m Male   A     30                        4
       368 sup18m__Male__A - 168   sup18m Male   A     30                        4
       369 sup18m__Male__A - 169   sup18m Male   A     31                        8
       370 sup18m__Male__A - 170   sup18m Male   A     31                        8
       371 sup18m__Male__A - 171   sup18m Male   A     31                        8
       372 sup18m__Male__A - 172   sup18m Male   A     31                        8
       373 sup18m__Male__A - 173   sup18m Male   A     31                        8
       374 sup18m__Male__A - 174   sup18m Male   A     31                        8
       375 sup18m__Male__A - 175   sup18m Male   A     31                        8
       376 sup18m__Male__A - 176   sup18m Male   A     31                        8
       377 sup18m__Male__A - 177   sup18m Male   A     32                        8
       378 sup18m__Male__A - 178   sup18m Male   A     32                        8
       379 sup18m__Male__A - 179   sup18m Male   A     32                        8
       380 sup18m__Male__A - 180   sup18m Male   A     32                        8
       381 sup18m__Male__A - 181   sup18m Male   A     32                        8
       382 sup18m__Male__A - 182   sup18m Male   A     32                        8
       383 sup18m__Male__A - 183   sup18m Male   A     32                        8
       384 sup18m__Male__A - 184   sup18m Male   A     32                        8
       385 sup18m__Male__A - 185   sup18m Male   A     33                        8
       386 sup18m__Male__A - 186   sup18m Male   A     33                        8
       387 sup18m__Male__A - 187   sup18m Male   A     33                        8
       388 sup18m__Male__A - 188   sup18m Male   A     33                        8
       389 sup18m__Male__A - 189   sup18m Male   A     33                        8
       390 sup18m__Male__A - 190   sup18m Male   A     33                        8
       391 sup18m__Male__A - 191   sup18m Male   A     33                        8
       392 sup18m__Male__A - 192   sup18m Male   A     33                        8
       393 sup18m__Male__A - 193   sup18m Male   A     34                        4
       394 sup18m__Male__A - 194   sup18m Male   A     34                        4
       395 sup18m__Male__A - 195   sup18m Male   A     34                        4
       396 sup18m__Male__A - 196   sup18m Male   A     34                        4
       397 sup18m__Male__A - 197   sup18m Male   A     35                        8
       398 sup18m__Male__A - 198   sup18m Male   A     35                        8
       399 sup18m__Male__A - 199   sup18m Male   A     35                        8
       400 sup18m__Male__A - 200   sup18m Male   A     35                        8
       401 sup18m__Male__A - 201   sup18m Male   A     35                        8
       402 sup18m__Male__A - 202   sup18m Male   A     35                        8
       403 sup18m__Male__A - 203   sup18m Male   A     35                        8
       404 sup18m__Male__A - 204   sup18m Male   A     35                        8
       405 inf18m__Female__A - 001 inf18m Female A     1                         4
       406 inf18m__Female__A - 002 inf18m Female A     1                         4
       407 inf18m__Female__A - 003 inf18m Female A     1                         4
       408 inf18m__Female__A - 004 inf18m Female A     1                         4
       409 inf18m__Female__A - 005 inf18m Female A     2                         4
       410 inf18m__Female__A - 006 inf18m Female A     2                         4
       411 inf18m__Female__A - 007 inf18m Female A     2                         4
       412 inf18m__Female__A - 008 inf18m Female A     2                         4
       413 inf18m__Female__A - 009 inf18m Female A     3                         4
       414 inf18m__Female__A - 010 inf18m Female A     3                         4
       415 inf18m__Female__A - 011 inf18m Female A     3                         4
       416 inf18m__Female__A - 012 inf18m Female A     3                         4
       417 inf18m__Female__A - 013 inf18m Female A     4                         8
       418 inf18m__Female__A - 014 inf18m Female A     4                         8
       419 inf18m__Female__A - 015 inf18m Female A     4                         8
       420 inf18m__Female__A - 016 inf18m Female A     4                         8
       421 inf18m__Female__A - 017 inf18m Female A     4                         8
       422 inf18m__Female__A - 018 inf18m Female A     4                         8
       423 inf18m__Female__A - 019 inf18m Female A     4                         8
       424 inf18m__Female__A - 020 inf18m Female A     4                         8
       425 inf18m__Female__A - 021 inf18m Female A     5                         8
       426 inf18m__Female__A - 022 inf18m Female A     5                         8
       427 inf18m__Female__A - 023 inf18m Female A     5                         8
       428 inf18m__Female__A - 024 inf18m Female A     5                         8
       429 inf18m__Female__A - 025 inf18m Female A     5                         8
       430 inf18m__Female__A - 026 inf18m Female A     5                         8
       431 inf18m__Female__A - 027 inf18m Female A     5                         8
       432 inf18m__Female__A - 028 inf18m Female A     5                         8
       433 inf18m__Female__A - 029 inf18m Female A     6                         8
       434 inf18m__Female__A - 030 inf18m Female A     6                         8
       435 inf18m__Female__A - 031 inf18m Female A     6                         8
       436 inf18m__Female__A - 032 inf18m Female A     6                         8
       437 inf18m__Female__A - 033 inf18m Female A     6                         8
       438 inf18m__Female__A - 034 inf18m Female A     6                         8
       439 inf18m__Female__A - 035 inf18m Female A     6                         8
       440 inf18m__Female__A - 036 inf18m Female A     6                         8
       441 inf18m__Female__A - 037 inf18m Female A     7                         8
       442 inf18m__Female__A - 038 inf18m Female A     7                         8
       443 inf18m__Female__A - 039 inf18m Female A     7                         8
       444 inf18m__Female__A - 040 inf18m Female A     7                         8
       445 inf18m__Female__A - 041 inf18m Female A     7                         8
       446 inf18m__Female__A - 042 inf18m Female A     7                         8
       447 inf18m__Female__A - 043 inf18m Female A     7                         8
       448 inf18m__Female__A - 044 inf18m Female A     7                         8
       449 inf18m__Female__A - 045 inf18m Female A     8                         4
       450 inf18m__Female__A - 046 inf18m Female A     8                         4
       451 inf18m__Female__A - 047 inf18m Female A     8                         4
       452 inf18m__Female__A - 048 inf18m Female A     8                         4
       453 inf18m__Female__A - 049 inf18m Female A     9                         8
       454 inf18m__Female__A - 050 inf18m Female A     9                         8
       455 inf18m__Female__A - 051 inf18m Female A     9                         8
       456 inf18m__Female__A - 052 inf18m Female A     9                         8
       457 inf18m__Female__A - 053 inf18m Female A     9                         8
       458 inf18m__Female__A - 054 inf18m Female A     9                         8
       459 inf18m__Female__A - 055 inf18m Female A     9                         8
       460 inf18m__Female__A - 056 inf18m Female A     9                         8
       461 inf18m__Female__A - 057 inf18m Female A     10                        4
       462 inf18m__Female__A - 058 inf18m Female A     10                        4
       463 inf18m__Female__A - 059 inf18m Female A     10                        4
       464 inf18m__Female__A - 060 inf18m Female A     10                        4
       465 inf18m__Female__A - 061 inf18m Female A     11                        4
       466 inf18m__Female__A - 062 inf18m Female A     11                        4
       467 inf18m__Female__A - 063 inf18m Female A     11                        4
       468 inf18m__Female__A - 064 inf18m Female A     11                        4
       469 inf18m__Female__A - 065 inf18m Female A     12                        8
       470 inf18m__Female__A - 066 inf18m Female A     12                        8
       471 inf18m__Female__A - 067 inf18m Female A     12                        8
       472 inf18m__Female__A - 068 inf18m Female A     12                        8
       473 inf18m__Female__A - 069 inf18m Female A     12                        8
       474 inf18m__Female__A - 070 inf18m Female A     12                        8
       475 inf18m__Female__A - 071 inf18m Female A     12                        8
       476 inf18m__Female__A - 072 inf18m Female A     12                        8
       477 inf18m__Female__A - 073 inf18m Female A     13                        4
       478 inf18m__Female__A - 074 inf18m Female A     13                        4
       479 inf18m__Female__A - 075 inf18m Female A     13                        4
       480 inf18m__Female__A - 076 inf18m Female A     13                        4
       481 inf18m__Female__A - 077 inf18m Female A     14                        8
       482 inf18m__Female__A - 078 inf18m Female A     14                        8
       483 inf18m__Female__A - 079 inf18m Female A     14                        8
       484 inf18m__Female__A - 080 inf18m Female A     14                        8
       485 inf18m__Female__A - 081 inf18m Female A     14                        8
       486 inf18m__Female__A - 082 inf18m Female A     14                        8
       487 inf18m__Female__A - 083 inf18m Female A     14                        8
       488 inf18m__Female__A - 084 inf18m Female A     14                        8
       489 inf18m__Female__A - 085 inf18m Female A     15                        4
       490 inf18m__Female__A - 086 inf18m Female A     15                        4
       491 inf18m__Female__A - 087 inf18m Female A     15                        4
       492 inf18m__Female__A - 088 inf18m Female A     15                        4
       493 inf18m__Female__A - 089 inf18m Female A     16                        4
       494 inf18m__Female__A - 090 inf18m Female A     16                        4
       495 inf18m__Female__A - 091 inf18m Female A     16                        4
       496 inf18m__Female__A - 092 inf18m Female A     16                        4
       497 inf18m__Female__A - 093 inf18m Female A     17                        4
       498 inf18m__Female__A - 094 inf18m Female A     17                        4
       499 inf18m__Female__A - 095 inf18m Female A     17                        4
       500 inf18m__Female__A - 096 inf18m Female A     17                        4
       501 inf18m__Female__A - 097 inf18m Female A     18                        4
       502 inf18m__Female__A - 098 inf18m Female A     18                        4
       503 inf18m__Female__A - 099 inf18m Female A     18                        4
       504 inf18m__Female__A - 100 inf18m Female A     18                        4
       505 inf18m__Female__A - 101 inf18m Female A     19                        4
       506 inf18m__Female__A - 102 inf18m Female A     19                        4
       507 inf18m__Female__A - 103 inf18m Female A     19                        4
       508 inf18m__Female__A - 104 inf18m Female A     19                        4
       509 inf18m__Female__A - 105 inf18m Female A     20                        8
       510 inf18m__Female__A - 106 inf18m Female A     20                        8
       511 inf18m__Female__A - 107 inf18m Female A     20                        8
       512 inf18m__Female__A - 108 inf18m Female A     20                        8
       513 inf18m__Female__A - 109 inf18m Female A     20                        8
       514 inf18m__Female__A - 110 inf18m Female A     20                        8
       515 inf18m__Female__A - 111 inf18m Female A     20                        8
       516 inf18m__Female__A - 112 inf18m Female A     20                        8
       517 inf18m__Female__A - 113 inf18m Female A     21                        8
       518 inf18m__Female__A - 114 inf18m Female A     21                        8
       519 inf18m__Female__A - 115 inf18m Female A     21                        8
       520 inf18m__Female__A - 116 inf18m Female A     21                        8
       521 inf18m__Female__A - 117 inf18m Female A     21                        8
       522 inf18m__Female__A - 118 inf18m Female A     21                        8
       523 inf18m__Female__A - 119 inf18m Female A     21                        8
       524 inf18m__Female__A - 120 inf18m Female A     21                        8
       525 inf18m__Female__A - 121 inf18m Female A     22                        4
       526 inf18m__Female__A - 122 inf18m Female A     22                        4
       527 inf18m__Female__A - 123 inf18m Female A     22                        4
       528 inf18m__Female__A - 124 inf18m Female A     22                        4
       529 inf18m__Female__A - 125 inf18m Female A     23                        8
       530 inf18m__Female__A - 126 inf18m Female A     23                        8
       531 inf18m__Female__A - 127 inf18m Female A     23                        8
       532 inf18m__Female__A - 128 inf18m Female A     23                        8
       533 inf18m__Female__A - 129 inf18m Female A     23                        8
       534 inf18m__Female__A - 130 inf18m Female A     23                        8
       535 inf18m__Female__A - 131 inf18m Female A     23                        8
       536 inf18m__Female__A - 132 inf18m Female A     23                        8
       537 inf18m__Female__A - 133 inf18m Female A     24                        8
       538 inf18m__Female__A - 134 inf18m Female A     24                        8
       539 inf18m__Female__A - 135 inf18m Female A     24                        8
       540 inf18m__Female__A - 136 inf18m Female A     24                        8
       541 inf18m__Female__A - 137 inf18m Female A     24                        8
       542 inf18m__Female__A - 138 inf18m Female A     24                        8
       543 inf18m__Female__A - 139 inf18m Female A     24                        8
       544 inf18m__Female__A - 140 inf18m Female A     24                        8
       545 inf18m__Female__A - 141 inf18m Female A     25                        4
       546 inf18m__Female__A - 142 inf18m Female A     25                        4
       547 inf18m__Female__A - 143 inf18m Female A     25                        4
       548 inf18m__Female__A - 144 inf18m Female A     25                        4
       549 inf18m__Female__A - 145 inf18m Female A     26                        4
       550 inf18m__Female__A - 146 inf18m Female A     26                        4
       551 inf18m__Female__A - 147 inf18m Female A     26                        4
       552 inf18m__Female__A - 148 inf18m Female A     26                        4
       553 inf18m__Female__A - 149 inf18m Female A     27                        4
       554 inf18m__Female__A - 150 inf18m Female A     27                        4
       555 inf18m__Female__A - 151 inf18m Female A     27                        4
       556 inf18m__Female__A - 152 inf18m Female A     27                        4
       557 inf18m__Female__A - 153 inf18m Female A     28                        8
       558 inf18m__Female__A - 154 inf18m Female A     28                        8
       559 inf18m__Female__A - 155 inf18m Female A     28                        8
       560 inf18m__Female__A - 156 inf18m Female A     28                        8
       561 inf18m__Female__A - 157 inf18m Female A     28                        8
       562 inf18m__Female__A - 158 inf18m Female A     28                        8
       563 inf18m__Female__A - 159 inf18m Female A     28                        8
       564 inf18m__Female__A - 160 inf18m Female A     28                        8
       565 inf18m__Female__A - 161 inf18m Female A     29                        8
       566 inf18m__Female__A - 162 inf18m Female A     29                        8
       567 inf18m__Female__A - 163 inf18m Female A     29                        8
       568 inf18m__Female__A - 164 inf18m Female A     29                        8
       569 inf18m__Female__A - 165 inf18m Female A     29                        8
       570 inf18m__Female__A - 166 inf18m Female A     29                        8
       571 inf18m__Female__A - 167 inf18m Female A     29                        8
       572 inf18m__Female__A - 168 inf18m Female A     29                        8
       573 inf18m__Female__A - 169 inf18m Female A     30                        8
       574 inf18m__Female__A - 170 inf18m Female A     30                        8
       575 inf18m__Female__A - 171 inf18m Female A     30                        8
       576 inf18m__Female__A - 172 inf18m Female A     30                        8
       577 inf18m__Female__A - 173 inf18m Female A     30                        8
       578 inf18m__Female__A - 174 inf18m Female A     30                        8
       579 inf18m__Female__A - 175 inf18m Female A     30                        8
       580 inf18m__Female__A - 176 inf18m Female A     30                        8
       581 inf18m__Female__A - 177 inf18m Female A     31                        8
       582 inf18m__Female__A - 178 inf18m Female A     31                        8
       583 inf18m__Female__A - 179 inf18m Female A     31                        8
       584 inf18m__Female__A - 180 inf18m Female A     31                        8
       585 inf18m__Female__A - 181 inf18m Female A     31                        8
       586 inf18m__Female__A - 182 inf18m Female A     31                        8
       587 inf18m__Female__A - 183 inf18m Female A     31                        8
       588 inf18m__Female__A - 184 inf18m Female A     31                        8
       589 inf18m__Female__A - 185 inf18m Female A     32                        8
       590 inf18m__Female__A - 186 inf18m Female A     32                        8
       591 inf18m__Female__A - 187 inf18m Female A     32                        8
       592 inf18m__Female__A - 188 inf18m Female A     32                        8
       593 inf18m__Female__A - 189 inf18m Female A     32                        8
       594 inf18m__Female__A - 190 inf18m Female A     32                        8
       595 inf18m__Female__A - 191 inf18m Female A     32                        8
       596 inf18m__Female__A - 192 inf18m Female A     32                        8
       597 inf18m__Female__A - 193 inf18m Female A     33                        4
       598 inf18m__Female__A - 194 inf18m Female A     33                        4
       599 inf18m__Female__A - 195 inf18m Female A     33                        4
       600 inf18m__Female__A - 196 inf18m Female A     33                        4
       601 inf18m__Female__A - 197 inf18m Female A     34                        8
       602 inf18m__Female__A - 198 inf18m Female A     34                        8
       603 inf18m__Female__A - 199 inf18m Female A     34                        8
       604 inf18m__Female__A - 200 inf18m Female A     34                        8
       605 inf18m__Female__A - 201 inf18m Female A     34                        8
       606 inf18m__Female__A - 202 inf18m Female A     34                        8
       607 inf18m__Female__A - 203 inf18m Female A     34                        8
       608 inf18m__Female__A - 204 inf18m Female A     34                        8
       609 sup18m__Female__A - 001 sup18m Female A     1                         4
       610 sup18m__Female__A - 002 sup18m Female A     1                         4
       611 sup18m__Female__A - 003 sup18m Female A     1                         4
       612 sup18m__Female__A - 004 sup18m Female A     1                         4
       613 sup18m__Female__A - 005 sup18m Female A     2                         4
       614 sup18m__Female__A - 006 sup18m Female A     2                         4
       615 sup18m__Female__A - 007 sup18m Female A     2                         4
       616 sup18m__Female__A - 008 sup18m Female A     2                         4
       617 sup18m__Female__A - 009 sup18m Female A     3                         4
       618 sup18m__Female__A - 010 sup18m Female A     3                         4
       619 sup18m__Female__A - 011 sup18m Female A     3                         4
       620 sup18m__Female__A - 012 sup18m Female A     3                         4
       621 sup18m__Female__A - 013 sup18m Female A     4                         4
       622 sup18m__Female__A - 014 sup18m Female A     4                         4
       623 sup18m__Female__A - 015 sup18m Female A     4                         4
       624 sup18m__Female__A - 016 sup18m Female A     4                         4
       625 sup18m__Female__A - 017 sup18m Female A     5                         4
       626 sup18m__Female__A - 018 sup18m Female A     5                         4
       627 sup18m__Female__A - 019 sup18m Female A     5                         4
       628 sup18m__Female__A - 020 sup18m Female A     5                         4
       629 sup18m__Female__A - 021 sup18m Female A     6                         4
       630 sup18m__Female__A - 022 sup18m Female A     6                         4
       631 sup18m__Female__A - 023 sup18m Female A     6                         4
       632 sup18m__Female__A - 024 sup18m Female A     6                         4
       633 sup18m__Female__A - 025 sup18m Female A     7                         8
       634 sup18m__Female__A - 026 sup18m Female A     7                         8
       635 sup18m__Female__A - 027 sup18m Female A     7                         8
       636 sup18m__Female__A - 028 sup18m Female A     7                         8
       637 sup18m__Female__A - 029 sup18m Female A     7                         8
       638 sup18m__Female__A - 030 sup18m Female A     7                         8
       639 sup18m__Female__A - 031 sup18m Female A     7                         8
       640 sup18m__Female__A - 032 sup18m Female A     7                         8
       641 sup18m__Female__A - 033 sup18m Female A     8                         8
       642 sup18m__Female__A - 034 sup18m Female A     8                         8
       643 sup18m__Female__A - 035 sup18m Female A     8                         8
       644 sup18m__Female__A - 036 sup18m Female A     8                         8
       645 sup18m__Female__A - 037 sup18m Female A     8                         8
       646 sup18m__Female__A - 038 sup18m Female A     8                         8
       647 sup18m__Female__A - 039 sup18m Female A     8                         8
       648 sup18m__Female__A - 040 sup18m Female A     8                         8
       649 sup18m__Female__A - 041 sup18m Female A     9                         4
       650 sup18m__Female__A - 042 sup18m Female A     9                         4
       651 sup18m__Female__A - 043 sup18m Female A     9                         4
       652 sup18m__Female__A - 044 sup18m Female A     9                         4
       653 sup18m__Female__A - 045 sup18m Female A     10                        4
       654 sup18m__Female__A - 046 sup18m Female A     10                        4
       655 sup18m__Female__A - 047 sup18m Female A     10                        4
       656 sup18m__Female__A - 048 sup18m Female A     10                        4
       657 sup18m__Female__A - 049 sup18m Female A     11                        8
       658 sup18m__Female__A - 050 sup18m Female A     11                        8
       659 sup18m__Female__A - 051 sup18m Female A     11                        8
       660 sup18m__Female__A - 052 sup18m Female A     11                        8
       661 sup18m__Female__A - 053 sup18m Female A     11                        8
       662 sup18m__Female__A - 054 sup18m Female A     11                        8
       663 sup18m__Female__A - 055 sup18m Female A     11                        8
       664 sup18m__Female__A - 056 sup18m Female A     11                        8
       665 sup18m__Female__A - 057 sup18m Female A     12                        8
       666 sup18m__Female__A - 058 sup18m Female A     12                        8
       667 sup18m__Female__A - 059 sup18m Female A     12                        8
       668 sup18m__Female__A - 060 sup18m Female A     12                        8
       669 sup18m__Female__A - 061 sup18m Female A     12                        8
       670 sup18m__Female__A - 062 sup18m Female A     12                        8
       671 sup18m__Female__A - 063 sup18m Female A     12                        8
       672 sup18m__Female__A - 064 sup18m Female A     12                        8
       673 sup18m__Female__A - 065 sup18m Female A     13                        4
       674 sup18m__Female__A - 066 sup18m Female A     13                        4
       675 sup18m__Female__A - 067 sup18m Female A     13                        4
       676 sup18m__Female__A - 068 sup18m Female A     13                        4
       677 sup18m__Female__A - 069 sup18m Female A     14                        4
       678 sup18m__Female__A - 070 sup18m Female A     14                        4
       679 sup18m__Female__A - 071 sup18m Female A     14                        4
       680 sup18m__Female__A - 072 sup18m Female A     14                        4
       681 sup18m__Female__A - 073 sup18m Female A     15                        8
       682 sup18m__Female__A - 074 sup18m Female A     15                        8
       683 sup18m__Female__A - 075 sup18m Female A     15                        8
       684 sup18m__Female__A - 076 sup18m Female A     15                        8
       685 sup18m__Female__A - 077 sup18m Female A     15                        8
       686 sup18m__Female__A - 078 sup18m Female A     15                        8
       687 sup18m__Female__A - 079 sup18m Female A     15                        8
       688 sup18m__Female__A - 080 sup18m Female A     15                        8
       689 sup18m__Female__A - 081 sup18m Female A     16                        8
       690 sup18m__Female__A - 082 sup18m Female A     16                        8
       691 sup18m__Female__A - 083 sup18m Female A     16                        8
       692 sup18m__Female__A - 084 sup18m Female A     16                        8
       693 sup18m__Female__A - 085 sup18m Female A     16                        8
       694 sup18m__Female__A - 086 sup18m Female A     16                        8
       695 sup18m__Female__A - 087 sup18m Female A     16                        8
       696 sup18m__Female__A - 088 sup18m Female A     16                        8
       697 sup18m__Female__A - 089 sup18m Female A     17                        4
       698 sup18m__Female__A - 090 sup18m Female A     17                        4
       699 sup18m__Female__A - 091 sup18m Female A     17                        4
       700 sup18m__Female__A - 092 sup18m Female A     17                        4
       701 sup18m__Female__A - 093 sup18m Female A     18                        4
       702 sup18m__Female__A - 094 sup18m Female A     18                        4
       703 sup18m__Female__A - 095 sup18m Female A     18                        4
       704 sup18m__Female__A - 096 sup18m Female A     18                        4
       705 sup18m__Female__A - 097 sup18m Female A     19                        8
       706 sup18m__Female__A - 098 sup18m Female A     19                        8
       707 sup18m__Female__A - 099 sup18m Female A     19                        8
       708 sup18m__Female__A - 100 sup18m Female A     19                        8
       709 sup18m__Female__A - 101 sup18m Female A     19                        8
       710 sup18m__Female__A - 102 sup18m Female A     19                        8
       711 sup18m__Female__A - 103 sup18m Female A     19                        8
       712 sup18m__Female__A - 104 sup18m Female A     19                        8
       713 sup18m__Female__A - 105 sup18m Female A     20                        4
       714 sup18m__Female__A - 106 sup18m Female A     20                        4
       715 sup18m__Female__A - 107 sup18m Female A     20                        4
       716 sup18m__Female__A - 108 sup18m Female A     20                        4
       717 sup18m__Female__A - 109 sup18m Female A     21                        8
       718 sup18m__Female__A - 110 sup18m Female A     21                        8
       719 sup18m__Female__A - 111 sup18m Female A     21                        8
       720 sup18m__Female__A - 112 sup18m Female A     21                        8
       721 sup18m__Female__A - 113 sup18m Female A     21                        8
       722 sup18m__Female__A - 114 sup18m Female A     21                        8
       723 sup18m__Female__A - 115 sup18m Female A     21                        8
       724 sup18m__Female__A - 116 sup18m Female A     21                        8
       725 sup18m__Female__A - 117 sup18m Female A     22                        4
       726 sup18m__Female__A - 118 sup18m Female A     22                        4
       727 sup18m__Female__A - 119 sup18m Female A     22                        4
       728 sup18m__Female__A - 120 sup18m Female A     22                        4
       729 sup18m__Female__A - 121 sup18m Female A     23                        4
       730 sup18m__Female__A - 122 sup18m Female A     23                        4
       731 sup18m__Female__A - 123 sup18m Female A     23                        4
       732 sup18m__Female__A - 124 sup18m Female A     23                        4
       733 sup18m__Female__A - 125 sup18m Female A     24                        4
       734 sup18m__Female__A - 126 sup18m Female A     24                        4
       735 sup18m__Female__A - 127 sup18m Female A     24                        4
       736 sup18m__Female__A - 128 sup18m Female A     24                        4
       737 sup18m__Female__A - 129 sup18m Female A     25                        8
       738 sup18m__Female__A - 130 sup18m Female A     25                        8
       739 sup18m__Female__A - 131 sup18m Female A     25                        8
       740 sup18m__Female__A - 132 sup18m Female A     25                        8
       741 sup18m__Female__A - 133 sup18m Female A     25                        8
       742 sup18m__Female__A - 134 sup18m Female A     25                        8
       743 sup18m__Female__A - 135 sup18m Female A     25                        8
       744 sup18m__Female__A - 136 sup18m Female A     25                        8
       745 sup18m__Female__A - 137 sup18m Female A     26                        8
       746 sup18m__Female__A - 138 sup18m Female A     26                        8
       747 sup18m__Female__A - 139 sup18m Female A     26                        8
       748 sup18m__Female__A - 140 sup18m Female A     26                        8
       749 sup18m__Female__A - 141 sup18m Female A     26                        8
       750 sup18m__Female__A - 142 sup18m Female A     26                        8
       751 sup18m__Female__A - 143 sup18m Female A     26                        8
       752 sup18m__Female__A - 144 sup18m Female A     26                        8
       753 sup18m__Female__A - 145 sup18m Female A     27                        8
       754 sup18m__Female__A - 146 sup18m Female A     27                        8
       755 sup18m__Female__A - 147 sup18m Female A     27                        8
       756 sup18m__Female__A - 148 sup18m Female A     27                        8
       757 sup18m__Female__A - 149 sup18m Female A     27                        8
       758 sup18m__Female__A - 150 sup18m Female A     27                        8
       759 sup18m__Female__A - 151 sup18m Female A     27                        8
       760 sup18m__Female__A - 152 sup18m Female A     27                        8
       761 sup18m__Female__A - 153 sup18m Female A     28                        8
       762 sup18m__Female__A - 154 sup18m Female A     28                        8
       763 sup18m__Female__A - 155 sup18m Female A     28                        8
       764 sup18m__Female__A - 156 sup18m Female A     28                        8
       765 sup18m__Female__A - 157 sup18m Female A     28                        8
       766 sup18m__Female__A - 158 sup18m Female A     28                        8
       767 sup18m__Female__A - 159 sup18m Female A     28                        8
       768 sup18m__Female__A - 160 sup18m Female A     28                        8
       769 sup18m__Female__A - 161 sup18m Female A     29                        4
       770 sup18m__Female__A - 162 sup18m Female A     29                        4
       771 sup18m__Female__A - 163 sup18m Female A     29                        4
       772 sup18m__Female__A - 164 sup18m Female A     29                        4
       773 sup18m__Female__A - 165 sup18m Female A     30                        8
       774 sup18m__Female__A - 166 sup18m Female A     30                        8
       775 sup18m__Female__A - 167 sup18m Female A     30                        8
       776 sup18m__Female__A - 168 sup18m Female A     30                        8
       777 sup18m__Female__A - 169 sup18m Female A     30                        8
       778 sup18m__Female__A - 170 sup18m Female A     30                        8
       779 sup18m__Female__A - 171 sup18m Female A     30                        8
       780 sup18m__Female__A - 172 sup18m Female A     30                        8
       781 sup18m__Female__A - 173 sup18m Female A     31                        8
       782 sup18m__Female__A - 174 sup18m Female A     31                        8
       783 sup18m__Female__A - 175 sup18m Female A     31                        8
       784 sup18m__Female__A - 176 sup18m Female A     31                        8
       785 sup18m__Female__A - 177 sup18m Female A     31                        8
       786 sup18m__Female__A - 178 sup18m Female A     31                        8
       787 sup18m__Female__A - 179 sup18m Female A     31                        8
       788 sup18m__Female__A - 180 sup18m Female A     31                        8
       789 sup18m__Female__A - 181 sup18m Female A     32                        4
       790 sup18m__Female__A - 182 sup18m Female A     32                        4
       791 sup18m__Female__A - 183 sup18m Female A     32                        4
       792 sup18m__Female__A - 184 sup18m Female A     32                        4
       793 sup18m__Female__A - 185 sup18m Female A     33                        4
       794 sup18m__Female__A - 186 sup18m Female A     33                        4
       795 sup18m__Female__A - 187 sup18m Female A     33                        4
       796 sup18m__Female__A - 188 sup18m Female A     33                        4
       797 sup18m__Female__A - 189 sup18m Female A     34                        4
       798 sup18m__Female__A - 190 sup18m Female A     34                        4
       799 sup18m__Female__A - 191 sup18m Female A     34                        4
       800 sup18m__Female__A - 192 sup18m Female A     34                        4
       801 sup18m__Female__A - 193 sup18m Female A     35                        4
       802 sup18m__Female__A - 194 sup18m Female A     35                        4
       803 sup18m__Female__A - 195 sup18m Female A     35                        4
       804 sup18m__Female__A - 196 sup18m Female A     35                        4
       805 sup18m__Female__A - 197 sup18m Female A     36                        8
       806 sup18m__Female__A - 198 sup18m Female A     36                        8
       807 sup18m__Female__A - 199 sup18m Female A     36                        8
       808 sup18m__Female__A - 200 sup18m Female A     36                        8
       809 sup18m__Female__A - 201 sup18m Female A     36                        8
       810 sup18m__Female__A - 202 sup18m Female A     36                        8
       811 sup18m__Female__A - 203 sup18m Female A     36                        8
       812 sup18m__Female__A - 204 sup18m Female A     36                        8
       813 inf18m__Male__B - 001   inf18m Male   B     1                         8
       814 inf18m__Male__B - 002   inf18m Male   B     1                         8
       815 inf18m__Male__B - 003   inf18m Male   B     1                         8
       816 inf18m__Male__B - 004   inf18m Male   B     1                         8
       817 inf18m__Male__B - 005   inf18m Male   B     1                         8
       818 inf18m__Male__B - 006   inf18m Male   B     1                         8
       819 inf18m__Male__B - 007   inf18m Male   B     1                         8
       820 inf18m__Male__B - 008   inf18m Male   B     1                         8
       821 inf18m__Male__B - 009   inf18m Male   B     2                         8
       822 inf18m__Male__B - 010   inf18m Male   B     2                         8
       823 inf18m__Male__B - 011   inf18m Male   B     2                         8
       824 inf18m__Male__B - 012   inf18m Male   B     2                         8
       825 inf18m__Male__B - 013   inf18m Male   B     2                         8
       826 inf18m__Male__B - 014   inf18m Male   B     2                         8
       827 inf18m__Male__B - 015   inf18m Male   B     2                         8
       828 inf18m__Male__B - 016   inf18m Male   B     2                         8
       829 inf18m__Male__B - 017   inf18m Male   B     3                         4
       830 inf18m__Male__B - 018   inf18m Male   B     3                         4
       831 inf18m__Male__B - 019   inf18m Male   B     3                         4
       832 inf18m__Male__B - 020   inf18m Male   B     3                         4
       833 inf18m__Male__B - 021   inf18m Male   B     4                         4
       834 inf18m__Male__B - 022   inf18m Male   B     4                         4
       835 inf18m__Male__B - 023   inf18m Male   B     4                         4
       836 inf18m__Male__B - 024   inf18m Male   B     4                         4
       837 inf18m__Male__B - 025   inf18m Male   B     5                         4
       838 inf18m__Male__B - 026   inf18m Male   B     5                         4
       839 inf18m__Male__B - 027   inf18m Male   B     5                         4
       840 inf18m__Male__B - 028   inf18m Male   B     5                         4
       841 inf18m__Male__B - 029   inf18m Male   B     6                         4
       842 inf18m__Male__B - 030   inf18m Male   B     6                         4
       843 inf18m__Male__B - 031   inf18m Male   B     6                         4
       844 inf18m__Male__B - 032   inf18m Male   B     6                         4
       845 inf18m__Male__B - 033   inf18m Male   B     7                         8
       846 inf18m__Male__B - 034   inf18m Male   B     7                         8
       847 inf18m__Male__B - 035   inf18m Male   B     7                         8
       848 inf18m__Male__B - 036   inf18m Male   B     7                         8
       849 inf18m__Male__B - 037   inf18m Male   B     7                         8
       850 inf18m__Male__B - 038   inf18m Male   B     7                         8
       851 inf18m__Male__B - 039   inf18m Male   B     7                         8
       852 inf18m__Male__B - 040   inf18m Male   B     7                         8
       853 inf18m__Male__B - 041   inf18m Male   B     8                         8
       854 inf18m__Male__B - 042   inf18m Male   B     8                         8
       855 inf18m__Male__B - 043   inf18m Male   B     8                         8
       856 inf18m__Male__B - 044   inf18m Male   B     8                         8
       857 inf18m__Male__B - 045   inf18m Male   B     8                         8
       858 inf18m__Male__B - 046   inf18m Male   B     8                         8
       859 inf18m__Male__B - 047   inf18m Male   B     8                         8
       860 inf18m__Male__B - 048   inf18m Male   B     8                         8
       861 inf18m__Male__B - 049   inf18m Male   B     9                         4
       862 inf18m__Male__B - 050   inf18m Male   B     9                         4
       863 inf18m__Male__B - 051   inf18m Male   B     9                         4
       864 inf18m__Male__B - 052   inf18m Male   B     9                         4
       865 inf18m__Male__B - 053   inf18m Male   B     10                        8
       866 inf18m__Male__B - 054   inf18m Male   B     10                        8
       867 inf18m__Male__B - 055   inf18m Male   B     10                        8
       868 inf18m__Male__B - 056   inf18m Male   B     10                        8
       869 inf18m__Male__B - 057   inf18m Male   B     10                        8
       870 inf18m__Male__B - 058   inf18m Male   B     10                        8
       871 inf18m__Male__B - 059   inf18m Male   B     10                        8
       872 inf18m__Male__B - 060   inf18m Male   B     10                        8
       873 inf18m__Male__B - 061   inf18m Male   B     11                        8
       874 inf18m__Male__B - 062   inf18m Male   B     11                        8
       875 inf18m__Male__B - 063   inf18m Male   B     11                        8
       876 inf18m__Male__B - 064   inf18m Male   B     11                        8
       877 inf18m__Male__B - 065   inf18m Male   B     11                        8
       878 inf18m__Male__B - 066   inf18m Male   B     11                        8
       879 inf18m__Male__B - 067   inf18m Male   B     11                        8
       880 inf18m__Male__B - 068   inf18m Male   B     11                        8
       881 inf18m__Male__B - 069   inf18m Male   B     12                        4
       882 inf18m__Male__B - 070   inf18m Male   B     12                        4
       883 inf18m__Male__B - 071   inf18m Male   B     12                        4
       884 inf18m__Male__B - 072   inf18m Male   B     12                        4
       885 inf18m__Male__B - 073   inf18m Male   B     13                        8
       886 inf18m__Male__B - 074   inf18m Male   B     13                        8
       887 inf18m__Male__B - 075   inf18m Male   B     13                        8
       888 inf18m__Male__B - 076   inf18m Male   B     13                        8
       889 inf18m__Male__B - 077   inf18m Male   B     13                        8
       890 inf18m__Male__B - 078   inf18m Male   B     13                        8
       891 inf18m__Male__B - 079   inf18m Male   B     13                        8
       892 inf18m__Male__B - 080   inf18m Male   B     13                        8
       893 inf18m__Male__B - 081   inf18m Male   B     14                        8
       894 inf18m__Male__B - 082   inf18m Male   B     14                        8
       895 inf18m__Male__B - 083   inf18m Male   B     14                        8
       896 inf18m__Male__B - 084   inf18m Male   B     14                        8
       897 inf18m__Male__B - 085   inf18m Male   B     14                        8
       898 inf18m__Male__B - 086   inf18m Male   B     14                        8
       899 inf18m__Male__B - 087   inf18m Male   B     14                        8
       900 inf18m__Male__B - 088   inf18m Male   B     14                        8
       901 inf18m__Male__B - 089   inf18m Male   B     15                        8
       902 inf18m__Male__B - 090   inf18m Male   B     15                        8
       903 inf18m__Male__B - 091   inf18m Male   B     15                        8
       904 inf18m__Male__B - 092   inf18m Male   B     15                        8
       905 inf18m__Male__B - 093   inf18m Male   B     15                        8
       906 inf18m__Male__B - 094   inf18m Male   B     15                        8
       907 inf18m__Male__B - 095   inf18m Male   B     15                        8
       908 inf18m__Male__B - 096   inf18m Male   B     15                        8
       909 inf18m__Male__B - 097   inf18m Male   B     16                        4
       910 inf18m__Male__B - 098   inf18m Male   B     16                        4
       911 inf18m__Male__B - 099   inf18m Male   B     16                        4
       912 inf18m__Male__B - 100   inf18m Male   B     16                        4
       913 inf18m__Male__B - 101   inf18m Male   B     17                        4
       914 inf18m__Male__B - 102   inf18m Male   B     17                        4
       915 inf18m__Male__B - 103   inf18m Male   B     17                        4
       916 inf18m__Male__B - 104   inf18m Male   B     17                        4
       917 inf18m__Male__B - 105   inf18m Male   B     18                        4
       918 inf18m__Male__B - 106   inf18m Male   B     18                        4
       919 inf18m__Male__B - 107   inf18m Male   B     18                        4
       920 inf18m__Male__B - 108   inf18m Male   B     18                        4
       921 inf18m__Male__B - 109   inf18m Male   B     19                        8
       922 inf18m__Male__B - 110   inf18m Male   B     19                        8
       923 inf18m__Male__B - 111   inf18m Male   B     19                        8
       924 inf18m__Male__B - 112   inf18m Male   B     19                        8
       925 inf18m__Male__B - 113   inf18m Male   B     19                        8
       926 inf18m__Male__B - 114   inf18m Male   B     19                        8
       927 inf18m__Male__B - 115   inf18m Male   B     19                        8
       928 inf18m__Male__B - 116   inf18m Male   B     19                        8
       929 inf18m__Male__B - 117   inf18m Male   B     20                        4
       930 inf18m__Male__B - 118   inf18m Male   B     20                        4
       931 inf18m__Male__B - 119   inf18m Male   B     20                        4
       932 inf18m__Male__B - 120   inf18m Male   B     20                        4
       933 inf18m__Male__B - 121   inf18m Male   B     21                        8
       934 inf18m__Male__B - 122   inf18m Male   B     21                        8
       935 inf18m__Male__B - 123   inf18m Male   B     21                        8
       936 inf18m__Male__B - 124   inf18m Male   B     21                        8
       937 inf18m__Male__B - 125   inf18m Male   B     21                        8
       938 inf18m__Male__B - 126   inf18m Male   B     21                        8
       939 inf18m__Male__B - 127   inf18m Male   B     21                        8
       940 inf18m__Male__B - 128   inf18m Male   B     21                        8
       941 inf18m__Male__B - 129   inf18m Male   B     22                        4
       942 inf18m__Male__B - 130   inf18m Male   B     22                        4
       943 inf18m__Male__B - 131   inf18m Male   B     22                        4
       944 inf18m__Male__B - 132   inf18m Male   B     22                        4
       945 inf18m__Male__B - 133   inf18m Male   B     23                        8
       946 inf18m__Male__B - 134   inf18m Male   B     23                        8
       947 inf18m__Male__B - 135   inf18m Male   B     23                        8
       948 inf18m__Male__B - 136   inf18m Male   B     23                        8
       949 inf18m__Male__B - 137   inf18m Male   B     23                        8
       950 inf18m__Male__B - 138   inf18m Male   B     23                        8
       951 inf18m__Male__B - 139   inf18m Male   B     23                        8
       952 inf18m__Male__B - 140   inf18m Male   B     23                        8
       953 inf18m__Male__B - 141   inf18m Male   B     24                        8
       954 inf18m__Male__B - 142   inf18m Male   B     24                        8
       955 inf18m__Male__B - 143   inf18m Male   B     24                        8
       956 inf18m__Male__B - 144   inf18m Male   B     24                        8
       957 inf18m__Male__B - 145   inf18m Male   B     24                        8
       958 inf18m__Male__B - 146   inf18m Male   B     24                        8
       959 inf18m__Male__B - 147   inf18m Male   B     24                        8
       960 inf18m__Male__B - 148   inf18m Male   B     24                        8
       961 inf18m__Male__B - 149   inf18m Male   B     25                        8
       962 inf18m__Male__B - 150   inf18m Male   B     25                        8
       963 inf18m__Male__B - 151   inf18m Male   B     25                        8
       964 inf18m__Male__B - 152   inf18m Male   B     25                        8
       965 inf18m__Male__B - 153   inf18m Male   B     25                        8
       966 inf18m__Male__B - 154   inf18m Male   B     25                        8
       967 inf18m__Male__B - 155   inf18m Male   B     25                        8
       968 inf18m__Male__B - 156   inf18m Male   B     25                        8
       969 inf18m__Male__B - 157   inf18m Male   B     26                        8
       970 inf18m__Male__B - 158   inf18m Male   B     26                        8
       971 inf18m__Male__B - 159   inf18m Male   B     26                        8
       972 inf18m__Male__B - 160   inf18m Male   B     26                        8
       973 inf18m__Male__B - 161   inf18m Male   B     26                        8
       974 inf18m__Male__B - 162   inf18m Male   B     26                        8
       975 inf18m__Male__B - 163   inf18m Male   B     26                        8
       976 inf18m__Male__B - 164   inf18m Male   B     26                        8
       977 inf18m__Male__B - 165   inf18m Male   B     27                        4
       978 inf18m__Male__B - 166   inf18m Male   B     27                        4
       979 inf18m__Male__B - 167   inf18m Male   B     27                        4
       980 inf18m__Male__B - 168   inf18m Male   B     27                        4
       981 inf18m__Male__B - 169   inf18m Male   B     28                        4
       982 inf18m__Male__B - 170   inf18m Male   B     28                        4
       983 inf18m__Male__B - 171   inf18m Male   B     28                        4
       984 inf18m__Male__B - 172   inf18m Male   B     28                        4
       985 inf18m__Male__B - 173   inf18m Male   B     29                        8
       986 inf18m__Male__B - 174   inf18m Male   B     29                        8
       987 inf18m__Male__B - 175   inf18m Male   B     29                        8
       988 inf18m__Male__B - 176   inf18m Male   B     29                        8
       989 inf18m__Male__B - 177   inf18m Male   B     29                        8
       990 inf18m__Male__B - 178   inf18m Male   B     29                        8
       991 inf18m__Male__B - 179   inf18m Male   B     29                        8
       992 inf18m__Male__B - 180   inf18m Male   B     29                        8
       993 inf18m__Male__B - 181   inf18m Male   B     30                        4
       994 inf18m__Male__B - 182   inf18m Male   B     30                        4
       995 inf18m__Male__B - 183   inf18m Male   B     30                        4
       996 inf18m__Male__B - 184   inf18m Male   B     30                        4
       997 inf18m__Male__B - 185   inf18m Male   B     31                        8
       998 inf18m__Male__B - 186   inf18m Male   B     31                        8
       999 inf18m__Male__B - 187   inf18m Male   B     31                        8
      1000 inf18m__Male__B - 188   inf18m Male   B     31                        8
      1001 inf18m__Male__B - 189   inf18m Male   B     31                        8
      1002 inf18m__Male__B - 190   inf18m Male   B     31                        8
      1003 inf18m__Male__B - 191   inf18m Male   B     31                        8
      1004 inf18m__Male__B - 192   inf18m Male   B     31                        8
      1005 inf18m__Male__B - 193   inf18m Male   B     32                        8
      1006 inf18m__Male__B - 194   inf18m Male   B     32                        8
      1007 inf18m__Male__B - 195   inf18m Male   B     32                        8
      1008 inf18m__Male__B - 196   inf18m Male   B     32                        8
      1009 inf18m__Male__B - 197   inf18m Male   B     32                        8
      1010 inf18m__Male__B - 198   inf18m Male   B     32                        8
      1011 inf18m__Male__B - 199   inf18m Male   B     32                        8
      1012 inf18m__Male__B - 200   inf18m Male   B     32                        8
      1013 sup18m__Male__B - 001   sup18m Male   B     1                         8
      1014 sup18m__Male__B - 002   sup18m Male   B     1                         8
      1015 sup18m__Male__B - 003   sup18m Male   B     1                         8
      1016 sup18m__Male__B - 004   sup18m Male   B     1                         8
      1017 sup18m__Male__B - 005   sup18m Male   B     1                         8
      1018 sup18m__Male__B - 006   sup18m Male   B     1                         8
      1019 sup18m__Male__B - 007   sup18m Male   B     1                         8
      1020 sup18m__Male__B - 008   sup18m Male   B     1                         8
      1021 sup18m__Male__B - 009   sup18m Male   B     2                         4
      1022 sup18m__Male__B - 010   sup18m Male   B     2                         4
      1023 sup18m__Male__B - 011   sup18m Male   B     2                         4
      1024 sup18m__Male__B - 012   sup18m Male   B     2                         4
      1025 sup18m__Male__B - 013   sup18m Male   B     3                         8
      1026 sup18m__Male__B - 014   sup18m Male   B     3                         8
      1027 sup18m__Male__B - 015   sup18m Male   B     3                         8
      1028 sup18m__Male__B - 016   sup18m Male   B     3                         8
      1029 sup18m__Male__B - 017   sup18m Male   B     3                         8
      1030 sup18m__Male__B - 018   sup18m Male   B     3                         8
      1031 sup18m__Male__B - 019   sup18m Male   B     3                         8
      1032 sup18m__Male__B - 020   sup18m Male   B     3                         8
      1033 sup18m__Male__B - 021   sup18m Male   B     4                         4
      1034 sup18m__Male__B - 022   sup18m Male   B     4                         4
      1035 sup18m__Male__B - 023   sup18m Male   B     4                         4
      1036 sup18m__Male__B - 024   sup18m Male   B     4                         4
      1037 sup18m__Male__B - 025   sup18m Male   B     5                         4
      1038 sup18m__Male__B - 026   sup18m Male   B     5                         4
      1039 sup18m__Male__B - 027   sup18m Male   B     5                         4
      1040 sup18m__Male__B - 028   sup18m Male   B     5                         4
      1041 sup18m__Male__B - 029   sup18m Male   B     6                         4
      1042 sup18m__Male__B - 030   sup18m Male   B     6                         4
      1043 sup18m__Male__B - 031   sup18m Male   B     6                         4
      1044 sup18m__Male__B - 032   sup18m Male   B     6                         4
      1045 sup18m__Male__B - 033   sup18m Male   B     7                         8
      1046 sup18m__Male__B - 034   sup18m Male   B     7                         8
      1047 sup18m__Male__B - 035   sup18m Male   B     7                         8
      1048 sup18m__Male__B - 036   sup18m Male   B     7                         8
      1049 sup18m__Male__B - 037   sup18m Male   B     7                         8
      1050 sup18m__Male__B - 038   sup18m Male   B     7                         8
      1051 sup18m__Male__B - 039   sup18m Male   B     7                         8
      1052 sup18m__Male__B - 040   sup18m Male   B     7                         8
      1053 sup18m__Male__B - 041   sup18m Male   B     8                         8
      1054 sup18m__Male__B - 042   sup18m Male   B     8                         8
      1055 sup18m__Male__B - 043   sup18m Male   B     8                         8
      1056 sup18m__Male__B - 044   sup18m Male   B     8                         8
      1057 sup18m__Male__B - 045   sup18m Male   B     8                         8
      1058 sup18m__Male__B - 046   sup18m Male   B     8                         8
      1059 sup18m__Male__B - 047   sup18m Male   B     8                         8
      1060 sup18m__Male__B - 048   sup18m Male   B     8                         8
      1061 sup18m__Male__B - 049   sup18m Male   B     9                         8
      1062 sup18m__Male__B - 050   sup18m Male   B     9                         8
      1063 sup18m__Male__B - 051   sup18m Male   B     9                         8
      1064 sup18m__Male__B - 052   sup18m Male   B     9                         8
      1065 sup18m__Male__B - 053   sup18m Male   B     9                         8
      1066 sup18m__Male__B - 054   sup18m Male   B     9                         8
      1067 sup18m__Male__B - 055   sup18m Male   B     9                         8
      1068 sup18m__Male__B - 056   sup18m Male   B     9                         8
      1069 sup18m__Male__B - 057   sup18m Male   B     10                        8
      1070 sup18m__Male__B - 058   sup18m Male   B     10                        8
      1071 sup18m__Male__B - 059   sup18m Male   B     10                        8
      1072 sup18m__Male__B - 060   sup18m Male   B     10                        8
      1073 sup18m__Male__B - 061   sup18m Male   B     10                        8
      1074 sup18m__Male__B - 062   sup18m Male   B     10                        8
      1075 sup18m__Male__B - 063   sup18m Male   B     10                        8
      1076 sup18m__Male__B - 064   sup18m Male   B     10                        8
      1077 sup18m__Male__B - 065   sup18m Male   B     11                        4
      1078 sup18m__Male__B - 066   sup18m Male   B     11                        4
      1079 sup18m__Male__B - 067   sup18m Male   B     11                        4
      1080 sup18m__Male__B - 068   sup18m Male   B     11                        4
      1081 sup18m__Male__B - 069   sup18m Male   B     12                        4
      1082 sup18m__Male__B - 070   sup18m Male   B     12                        4
      1083 sup18m__Male__B - 071   sup18m Male   B     12                        4
      1084 sup18m__Male__B - 072   sup18m Male   B     12                        4
      1085 sup18m__Male__B - 073   sup18m Male   B     13                        8
      1086 sup18m__Male__B - 074   sup18m Male   B     13                        8
      1087 sup18m__Male__B - 075   sup18m Male   B     13                        8
      1088 sup18m__Male__B - 076   sup18m Male   B     13                        8
      1089 sup18m__Male__B - 077   sup18m Male   B     13                        8
      1090 sup18m__Male__B - 078   sup18m Male   B     13                        8
      1091 sup18m__Male__B - 079   sup18m Male   B     13                        8
      1092 sup18m__Male__B - 080   sup18m Male   B     13                        8
      1093 sup18m__Male__B - 081   sup18m Male   B     14                        8
      1094 sup18m__Male__B - 082   sup18m Male   B     14                        8
      1095 sup18m__Male__B - 083   sup18m Male   B     14                        8
      1096 sup18m__Male__B - 084   sup18m Male   B     14                        8
      1097 sup18m__Male__B - 085   sup18m Male   B     14                        8
      1098 sup18m__Male__B - 086   sup18m Male   B     14                        8
      1099 sup18m__Male__B - 087   sup18m Male   B     14                        8
      1100 sup18m__Male__B - 088   sup18m Male   B     14                        8
      1101 sup18m__Male__B - 089   sup18m Male   B     15                        8
      1102 sup18m__Male__B - 090   sup18m Male   B     15                        8
      1103 sup18m__Male__B - 091   sup18m Male   B     15                        8
      1104 sup18m__Male__B - 092   sup18m Male   B     15                        8
      1105 sup18m__Male__B - 093   sup18m Male   B     15                        8
      1106 sup18m__Male__B - 094   sup18m Male   B     15                        8
      1107 sup18m__Male__B - 095   sup18m Male   B     15                        8
      1108 sup18m__Male__B - 096   sup18m Male   B     15                        8
      1109 sup18m__Male__B - 097   sup18m Male   B     16                        8
      1110 sup18m__Male__B - 098   sup18m Male   B     16                        8
      1111 sup18m__Male__B - 099   sup18m Male   B     16                        8
      1112 sup18m__Male__B - 100   sup18m Male   B     16                        8
      1113 sup18m__Male__B - 101   sup18m Male   B     16                        8
      1114 sup18m__Male__B - 102   sup18m Male   B     16                        8
      1115 sup18m__Male__B - 103   sup18m Male   B     16                        8
      1116 sup18m__Male__B - 104   sup18m Male   B     16                        8
      1117 sup18m__Male__B - 105   sup18m Male   B     17                        8
      1118 sup18m__Male__B - 106   sup18m Male   B     17                        8
      1119 sup18m__Male__B - 107   sup18m Male   B     17                        8
      1120 sup18m__Male__B - 108   sup18m Male   B     17                        8
      1121 sup18m__Male__B - 109   sup18m Male   B     17                        8
      1122 sup18m__Male__B - 110   sup18m Male   B     17                        8
      1123 sup18m__Male__B - 111   sup18m Male   B     17                        8
      1124 sup18m__Male__B - 112   sup18m Male   B     17                        8
      1125 sup18m__Male__B - 113   sup18m Male   B     18                        8
      1126 sup18m__Male__B - 114   sup18m Male   B     18                        8
      1127 sup18m__Male__B - 115   sup18m Male   B     18                        8
      1128 sup18m__Male__B - 116   sup18m Male   B     18                        8
      1129 sup18m__Male__B - 117   sup18m Male   B     18                        8
      1130 sup18m__Male__B - 118   sup18m Male   B     18                        8
      1131 sup18m__Male__B - 119   sup18m Male   B     18                        8
      1132 sup18m__Male__B - 120   sup18m Male   B     18                        8
      1133 sup18m__Male__B - 121   sup18m Male   B     19                        8
      1134 sup18m__Male__B - 122   sup18m Male   B     19                        8
      1135 sup18m__Male__B - 123   sup18m Male   B     19                        8
      1136 sup18m__Male__B - 124   sup18m Male   B     19                        8
      1137 sup18m__Male__B - 125   sup18m Male   B     19                        8
      1138 sup18m__Male__B - 126   sup18m Male   B     19                        8
      1139 sup18m__Male__B - 127   sup18m Male   B     19                        8
      1140 sup18m__Male__B - 128   sup18m Male   B     19                        8
      1141 sup18m__Male__B - 129   sup18m Male   B     20                        8
      1142 sup18m__Male__B - 130   sup18m Male   B     20                        8
      1143 sup18m__Male__B - 131   sup18m Male   B     20                        8
      1144 sup18m__Male__B - 132   sup18m Male   B     20                        8
      1145 sup18m__Male__B - 133   sup18m Male   B     20                        8
      1146 sup18m__Male__B - 134   sup18m Male   B     20                        8
      1147 sup18m__Male__B - 135   sup18m Male   B     20                        8
      1148 sup18m__Male__B - 136   sup18m Male   B     20                        8
      1149 sup18m__Male__B - 137   sup18m Male   B     21                        8
      1150 sup18m__Male__B - 138   sup18m Male   B     21                        8
      1151 sup18m__Male__B - 139   sup18m Male   B     21                        8
      1152 sup18m__Male__B - 140   sup18m Male   B     21                        8
      1153 sup18m__Male__B - 141   sup18m Male   B     21                        8
      1154 sup18m__Male__B - 142   sup18m Male   B     21                        8
      1155 sup18m__Male__B - 143   sup18m Male   B     21                        8
      1156 sup18m__Male__B - 144   sup18m Male   B     21                        8
      1157 sup18m__Male__B - 145   sup18m Male   B     22                        4
      1158 sup18m__Male__B - 146   sup18m Male   B     22                        4
      1159 sup18m__Male__B - 147   sup18m Male   B     22                        4
      1160 sup18m__Male__B - 148   sup18m Male   B     22                        4
      1161 sup18m__Male__B - 149   sup18m Male   B     23                        4
      1162 sup18m__Male__B - 150   sup18m Male   B     23                        4
      1163 sup18m__Male__B - 151   sup18m Male   B     23                        4
      1164 sup18m__Male__B - 152   sup18m Male   B     23                        4
      1165 sup18m__Male__B - 153   sup18m Male   B     24                        8
      1166 sup18m__Male__B - 154   sup18m Male   B     24                        8
      1167 sup18m__Male__B - 155   sup18m Male   B     24                        8
      1168 sup18m__Male__B - 156   sup18m Male   B     24                        8
      1169 sup18m__Male__B - 157   sup18m Male   B     24                        8
      1170 sup18m__Male__B - 158   sup18m Male   B     24                        8
      1171 sup18m__Male__B - 159   sup18m Male   B     24                        8
      1172 sup18m__Male__B - 160   sup18m Male   B     24                        8
      1173 sup18m__Male__B - 161   sup18m Male   B     25                        4
      1174 sup18m__Male__B - 162   sup18m Male   B     25                        4
      1175 sup18m__Male__B - 163   sup18m Male   B     25                        4
      1176 sup18m__Male__B - 164   sup18m Male   B     25                        4
      1177 sup18m__Male__B - 165   sup18m Male   B     26                        4
      1178 sup18m__Male__B - 166   sup18m Male   B     26                        4
      1179 sup18m__Male__B - 167   sup18m Male   B     26                        4
      1180 sup18m__Male__B - 168   sup18m Male   B     26                        4
      1181 sup18m__Male__B - 169   sup18m Male   B     27                        4
      1182 sup18m__Male__B - 170   sup18m Male   B     27                        4
      1183 sup18m__Male__B - 171   sup18m Male   B     27                        4
      1184 sup18m__Male__B - 172   sup18m Male   B     27                        4
      1185 sup18m__Male__B - 173   sup18m Male   B     28                        4
      1186 sup18m__Male__B - 174   sup18m Male   B     28                        4
      1187 sup18m__Male__B - 175   sup18m Male   B     28                        4
      1188 sup18m__Male__B - 176   sup18m Male   B     28                        4
      1189 sup18m__Male__B - 177   sup18m Male   B     29                        8
      1190 sup18m__Male__B - 178   sup18m Male   B     29                        8
      1191 sup18m__Male__B - 179   sup18m Male   B     29                        8
      1192 sup18m__Male__B - 180   sup18m Male   B     29                        8
      1193 sup18m__Male__B - 181   sup18m Male   B     29                        8
      1194 sup18m__Male__B - 182   sup18m Male   B     29                        8
      1195 sup18m__Male__B - 183   sup18m Male   B     29                        8
      1196 sup18m__Male__B - 184   sup18m Male   B     29                        8
      1197 sup18m__Male__B - 185   sup18m Male   B     30                        4
      1198 sup18m__Male__B - 186   sup18m Male   B     30                        4
      1199 sup18m__Male__B - 187   sup18m Male   B     30                        4
      1200 sup18m__Male__B - 188   sup18m Male   B     30                        4
      1201 sup18m__Male__B - 189   sup18m Male   B     31                        8
      1202 sup18m__Male__B - 190   sup18m Male   B     31                        8
      1203 sup18m__Male__B - 191   sup18m Male   B     31                        8
      1204 sup18m__Male__B - 192   sup18m Male   B     31                        8
      1205 sup18m__Male__B - 193   sup18m Male   B     31                        8
      1206 sup18m__Male__B - 194   sup18m Male   B     31                        8
      1207 sup18m__Male__B - 195   sup18m Male   B     31                        8
      1208 sup18m__Male__B - 196   sup18m Male   B     31                        8
      1209 sup18m__Male__B - 197   sup18m Male   B     32                        8
      1210 sup18m__Male__B - 198   sup18m Male   B     32                        8
      1211 sup18m__Male__B - 199   sup18m Male   B     32                        8
      1212 sup18m__Male__B - 200   sup18m Male   B     32                        8
      1213 sup18m__Male__B - 201   sup18m Male   B     32                        8
      1214 sup18m__Male__B - 202   sup18m Male   B     32                        8
      1215 sup18m__Male__B - 203   sup18m Male   B     32                        8
      1216 sup18m__Male__B - 204   sup18m Male   B     32                        8
      1217 inf18m__Female__B - 001 inf18m Female B     1                         8
      1218 inf18m__Female__B - 002 inf18m Female B     1                         8
      1219 inf18m__Female__B - 003 inf18m Female B     1                         8
      1220 inf18m__Female__B - 004 inf18m Female B     1                         8
      1221 inf18m__Female__B - 005 inf18m Female B     1                         8
      1222 inf18m__Female__B - 006 inf18m Female B     1                         8
      1223 inf18m__Female__B - 007 inf18m Female B     1                         8
      1224 inf18m__Female__B - 008 inf18m Female B     1                         8
      1225 inf18m__Female__B - 009 inf18m Female B     2                         8
      1226 inf18m__Female__B - 010 inf18m Female B     2                         8
      1227 inf18m__Female__B - 011 inf18m Female B     2                         8
      1228 inf18m__Female__B - 012 inf18m Female B     2                         8
      1229 inf18m__Female__B - 013 inf18m Female B     2                         8
      1230 inf18m__Female__B - 014 inf18m Female B     2                         8
      1231 inf18m__Female__B - 015 inf18m Female B     2                         8
      1232 inf18m__Female__B - 016 inf18m Female B     2                         8
      1233 inf18m__Female__B - 017 inf18m Female B     3                         4
      1234 inf18m__Female__B - 018 inf18m Female B     3                         4
      1235 inf18m__Female__B - 019 inf18m Female B     3                         4
      1236 inf18m__Female__B - 020 inf18m Female B     3                         4
      1237 inf18m__Female__B - 021 inf18m Female B     4                         4
      1238 inf18m__Female__B - 022 inf18m Female B     4                         4
      1239 inf18m__Female__B - 023 inf18m Female B     4                         4
      1240 inf18m__Female__B - 024 inf18m Female B     4                         4
      1241 inf18m__Female__B - 025 inf18m Female B     5                         8
      1242 inf18m__Female__B - 026 inf18m Female B     5                         8
      1243 inf18m__Female__B - 027 inf18m Female B     5                         8
      1244 inf18m__Female__B - 028 inf18m Female B     5                         8
      1245 inf18m__Female__B - 029 inf18m Female B     5                         8
      1246 inf18m__Female__B - 030 inf18m Female B     5                         8
      1247 inf18m__Female__B - 031 inf18m Female B     5                         8
      1248 inf18m__Female__B - 032 inf18m Female B     5                         8
      1249 inf18m__Female__B - 033 inf18m Female B     6                         8
      1250 inf18m__Female__B - 034 inf18m Female B     6                         8
      1251 inf18m__Female__B - 035 inf18m Female B     6                         8
      1252 inf18m__Female__B - 036 inf18m Female B     6                         8
      1253 inf18m__Female__B - 037 inf18m Female B     6                         8
      1254 inf18m__Female__B - 038 inf18m Female B     6                         8
      1255 inf18m__Female__B - 039 inf18m Female B     6                         8
      1256 inf18m__Female__B - 040 inf18m Female B     6                         8
      1257 inf18m__Female__B - 041 inf18m Female B     7                         8
      1258 inf18m__Female__B - 042 inf18m Female B     7                         8
      1259 inf18m__Female__B - 043 inf18m Female B     7                         8
      1260 inf18m__Female__B - 044 inf18m Female B     7                         8
      1261 inf18m__Female__B - 045 inf18m Female B     7                         8
      1262 inf18m__Female__B - 046 inf18m Female B     7                         8
      1263 inf18m__Female__B - 047 inf18m Female B     7                         8
      1264 inf18m__Female__B - 048 inf18m Female B     7                         8
      1265 inf18m__Female__B - 049 inf18m Female B     8                         4
      1266 inf18m__Female__B - 050 inf18m Female B     8                         4
      1267 inf18m__Female__B - 051 inf18m Female B     8                         4
      1268 inf18m__Female__B - 052 inf18m Female B     8                         4
      1269 inf18m__Female__B - 053 inf18m Female B     9                         8
      1270 inf18m__Female__B - 054 inf18m Female B     9                         8
      1271 inf18m__Female__B - 055 inf18m Female B     9                         8
      1272 inf18m__Female__B - 056 inf18m Female B     9                         8
      1273 inf18m__Female__B - 057 inf18m Female B     9                         8
      1274 inf18m__Female__B - 058 inf18m Female B     9                         8
      1275 inf18m__Female__B - 059 inf18m Female B     9                         8
      1276 inf18m__Female__B - 060 inf18m Female B     9                         8
      1277 inf18m__Female__B - 061 inf18m Female B     10                        4
      1278 inf18m__Female__B - 062 inf18m Female B     10                        4
      1279 inf18m__Female__B - 063 inf18m Female B     10                        4
      1280 inf18m__Female__B - 064 inf18m Female B     10                        4
      1281 inf18m__Female__B - 065 inf18m Female B     11                        8
      1282 inf18m__Female__B - 066 inf18m Female B     11                        8
      1283 inf18m__Female__B - 067 inf18m Female B     11                        8
      1284 inf18m__Female__B - 068 inf18m Female B     11                        8
      1285 inf18m__Female__B - 069 inf18m Female B     11                        8
      1286 inf18m__Female__B - 070 inf18m Female B     11                        8
      1287 inf18m__Female__B - 071 inf18m Female B     11                        8
      1288 inf18m__Female__B - 072 inf18m Female B     11                        8
      1289 inf18m__Female__B - 073 inf18m Female B     12                        8
      1290 inf18m__Female__B - 074 inf18m Female B     12                        8
      1291 inf18m__Female__B - 075 inf18m Female B     12                        8
      1292 inf18m__Female__B - 076 inf18m Female B     12                        8
      1293 inf18m__Female__B - 077 inf18m Female B     12                        8
      1294 inf18m__Female__B - 078 inf18m Female B     12                        8
      1295 inf18m__Female__B - 079 inf18m Female B     12                        8
      1296 inf18m__Female__B - 080 inf18m Female B     12                        8
      1297 inf18m__Female__B - 081 inf18m Female B     13                        4
      1298 inf18m__Female__B - 082 inf18m Female B     13                        4
      1299 inf18m__Female__B - 083 inf18m Female B     13                        4
      1300 inf18m__Female__B - 084 inf18m Female B     13                        4
      1301 inf18m__Female__B - 085 inf18m Female B     14                        8
      1302 inf18m__Female__B - 086 inf18m Female B     14                        8
      1303 inf18m__Female__B - 087 inf18m Female B     14                        8
      1304 inf18m__Female__B - 088 inf18m Female B     14                        8
      1305 inf18m__Female__B - 089 inf18m Female B     14                        8
      1306 inf18m__Female__B - 090 inf18m Female B     14                        8
      1307 inf18m__Female__B - 091 inf18m Female B     14                        8
      1308 inf18m__Female__B - 092 inf18m Female B     14                        8
      1309 inf18m__Female__B - 093 inf18m Female B     15                        4
      1310 inf18m__Female__B - 094 inf18m Female B     15                        4
      1311 inf18m__Female__B - 095 inf18m Female B     15                        4
      1312 inf18m__Female__B - 096 inf18m Female B     15                        4
      1313 inf18m__Female__B - 097 inf18m Female B     16                        4
      1314 inf18m__Female__B - 098 inf18m Female B     16                        4
      1315 inf18m__Female__B - 099 inf18m Female B     16                        4
      1316 inf18m__Female__B - 100 inf18m Female B     16                        4
      1317 inf18m__Female__B - 101 inf18m Female B     17                        8
      1318 inf18m__Female__B - 102 inf18m Female B     17                        8
      1319 inf18m__Female__B - 103 inf18m Female B     17                        8
      1320 inf18m__Female__B - 104 inf18m Female B     17                        8
      1321 inf18m__Female__B - 105 inf18m Female B     17                        8
      1322 inf18m__Female__B - 106 inf18m Female B     17                        8
      1323 inf18m__Female__B - 107 inf18m Female B     17                        8
      1324 inf18m__Female__B - 108 inf18m Female B     17                        8
      1325 inf18m__Female__B - 109 inf18m Female B     18                        4
      1326 inf18m__Female__B - 110 inf18m Female B     18                        4
      1327 inf18m__Female__B - 111 inf18m Female B     18                        4
      1328 inf18m__Female__B - 112 inf18m Female B     18                        4
      1329 inf18m__Female__B - 113 inf18m Female B     19                        4
      1330 inf18m__Female__B - 114 inf18m Female B     19                        4
      1331 inf18m__Female__B - 115 inf18m Female B     19                        4
      1332 inf18m__Female__B - 116 inf18m Female B     19                        4
      1333 inf18m__Female__B - 117 inf18m Female B     20                        8
      1334 inf18m__Female__B - 118 inf18m Female B     20                        8
      1335 inf18m__Female__B - 119 inf18m Female B     20                        8
      1336 inf18m__Female__B - 120 inf18m Female B     20                        8
      1337 inf18m__Female__B - 121 inf18m Female B     20                        8
      1338 inf18m__Female__B - 122 inf18m Female B     20                        8
      1339 inf18m__Female__B - 123 inf18m Female B     20                        8
      1340 inf18m__Female__B - 124 inf18m Female B     20                        8
      1341 inf18m__Female__B - 125 inf18m Female B     21                        8
      1342 inf18m__Female__B - 126 inf18m Female B     21                        8
      1343 inf18m__Female__B - 127 inf18m Female B     21                        8
      1344 inf18m__Female__B - 128 inf18m Female B     21                        8
      1345 inf18m__Female__B - 129 inf18m Female B     21                        8
      1346 inf18m__Female__B - 130 inf18m Female B     21                        8
      1347 inf18m__Female__B - 131 inf18m Female B     21                        8
      1348 inf18m__Female__B - 132 inf18m Female B     21                        8
      1349 inf18m__Female__B - 133 inf18m Female B     22                        8
      1350 inf18m__Female__B - 134 inf18m Female B     22                        8
      1351 inf18m__Female__B - 135 inf18m Female B     22                        8
      1352 inf18m__Female__B - 136 inf18m Female B     22                        8
      1353 inf18m__Female__B - 137 inf18m Female B     22                        8
      1354 inf18m__Female__B - 138 inf18m Female B     22                        8
      1355 inf18m__Female__B - 139 inf18m Female B     22                        8
      1356 inf18m__Female__B - 140 inf18m Female B     22                        8
      1357 inf18m__Female__B - 141 inf18m Female B     23                        8
      1358 inf18m__Female__B - 142 inf18m Female B     23                        8
      1359 inf18m__Female__B - 143 inf18m Female B     23                        8
      1360 inf18m__Female__B - 144 inf18m Female B     23                        8
      1361 inf18m__Female__B - 145 inf18m Female B     23                        8
      1362 inf18m__Female__B - 146 inf18m Female B     23                        8
      1363 inf18m__Female__B - 147 inf18m Female B     23                        8
      1364 inf18m__Female__B - 148 inf18m Female B     23                        8
      1365 inf18m__Female__B - 149 inf18m Female B     24                        8
      1366 inf18m__Female__B - 150 inf18m Female B     24                        8
      1367 inf18m__Female__B - 151 inf18m Female B     24                        8
      1368 inf18m__Female__B - 152 inf18m Female B     24                        8
      1369 inf18m__Female__B - 153 inf18m Female B     24                        8
      1370 inf18m__Female__B - 154 inf18m Female B     24                        8
      1371 inf18m__Female__B - 155 inf18m Female B     24                        8
      1372 inf18m__Female__B - 156 inf18m Female B     24                        8
      1373 inf18m__Female__B - 157 inf18m Female B     25                        4
      1374 inf18m__Female__B - 158 inf18m Female B     25                        4
      1375 inf18m__Female__B - 159 inf18m Female B     25                        4
      1376 inf18m__Female__B - 160 inf18m Female B     25                        4
      1377 inf18m__Female__B - 161 inf18m Female B     26                        8
      1378 inf18m__Female__B - 162 inf18m Female B     26                        8
      1379 inf18m__Female__B - 163 inf18m Female B     26                        8
      1380 inf18m__Female__B - 164 inf18m Female B     26                        8
      1381 inf18m__Female__B - 165 inf18m Female B     26                        8
      1382 inf18m__Female__B - 166 inf18m Female B     26                        8
      1383 inf18m__Female__B - 167 inf18m Female B     26                        8
      1384 inf18m__Female__B - 168 inf18m Female B     26                        8
      1385 inf18m__Female__B - 169 inf18m Female B     27                        8
      1386 inf18m__Female__B - 170 inf18m Female B     27                        8
      1387 inf18m__Female__B - 171 inf18m Female B     27                        8
      1388 inf18m__Female__B - 172 inf18m Female B     27                        8
      1389 inf18m__Female__B - 173 inf18m Female B     27                        8
      1390 inf18m__Female__B - 174 inf18m Female B     27                        8
      1391 inf18m__Female__B - 175 inf18m Female B     27                        8
      1392 inf18m__Female__B - 176 inf18m Female B     27                        8
      1393 inf18m__Female__B - 177 inf18m Female B     28                        4
      1394 inf18m__Female__B - 178 inf18m Female B     28                        4
      1395 inf18m__Female__B - 179 inf18m Female B     28                        4
      1396 inf18m__Female__B - 180 inf18m Female B     28                        4
      1397 inf18m__Female__B - 181 inf18m Female B     29                        8
      1398 inf18m__Female__B - 182 inf18m Female B     29                        8
      1399 inf18m__Female__B - 183 inf18m Female B     29                        8
      1400 inf18m__Female__B - 184 inf18m Female B     29                        8
      1401 inf18m__Female__B - 185 inf18m Female B     29                        8
      1402 inf18m__Female__B - 186 inf18m Female B     29                        8
      1403 inf18m__Female__B - 187 inf18m Female B     29                        8
      1404 inf18m__Female__B - 188 inf18m Female B     29                        8
      1405 inf18m__Female__B - 189 inf18m Female B     30                        4
      1406 inf18m__Female__B - 190 inf18m Female B     30                        4
      1407 inf18m__Female__B - 191 inf18m Female B     30                        4
      1408 inf18m__Female__B - 192 inf18m Female B     30                        4
      1409 inf18m__Female__B - 193 inf18m Female B     31                        4
      1410 inf18m__Female__B - 194 inf18m Female B     31                        4
      1411 inf18m__Female__B - 195 inf18m Female B     31                        4
      1412 inf18m__Female__B - 196 inf18m Female B     31                        4
      1413 inf18m__Female__B - 197 inf18m Female B     32                        8
      1414 inf18m__Female__B - 198 inf18m Female B     32                        8
      1415 inf18m__Female__B - 199 inf18m Female B     32                        8
      1416 inf18m__Female__B - 200 inf18m Female B     32                        8
      1417 inf18m__Female__B - 201 inf18m Female B     32                        8
      1418 inf18m__Female__B - 202 inf18m Female B     32                        8
      1419 inf18m__Female__B - 203 inf18m Female B     32                        8
      1420 inf18m__Female__B - 204 inf18m Female B     32                        8
      1421 sup18m__Female__B - 001 sup18m Female B     1                         4
      1422 sup18m__Female__B - 002 sup18m Female B     1                         4
      1423 sup18m__Female__B - 003 sup18m Female B     1                         4
      1424 sup18m__Female__B - 004 sup18m Female B     1                         4
      1425 sup18m__Female__B - 005 sup18m Female B     2                         8
      1426 sup18m__Female__B - 006 sup18m Female B     2                         8
      1427 sup18m__Female__B - 007 sup18m Female B     2                         8
      1428 sup18m__Female__B - 008 sup18m Female B     2                         8
      1429 sup18m__Female__B - 009 sup18m Female B     2                         8
      1430 sup18m__Female__B - 010 sup18m Female B     2                         8
      1431 sup18m__Female__B - 011 sup18m Female B     2                         8
      1432 sup18m__Female__B - 012 sup18m Female B     2                         8
      1433 sup18m__Female__B - 013 sup18m Female B     3                         8
      1434 sup18m__Female__B - 014 sup18m Female B     3                         8
      1435 sup18m__Female__B - 015 sup18m Female B     3                         8
      1436 sup18m__Female__B - 016 sup18m Female B     3                         8
      1437 sup18m__Female__B - 017 sup18m Female B     3                         8
      1438 sup18m__Female__B - 018 sup18m Female B     3                         8
      1439 sup18m__Female__B - 019 sup18m Female B     3                         8
      1440 sup18m__Female__B - 020 sup18m Female B     3                         8
      1441 sup18m__Female__B - 021 sup18m Female B     4                         8
      1442 sup18m__Female__B - 022 sup18m Female B     4                         8
      1443 sup18m__Female__B - 023 sup18m Female B     4                         8
      1444 sup18m__Female__B - 024 sup18m Female B     4                         8
      1445 sup18m__Female__B - 025 sup18m Female B     4                         8
      1446 sup18m__Female__B - 026 sup18m Female B     4                         8
      1447 sup18m__Female__B - 027 sup18m Female B     4                         8
      1448 sup18m__Female__B - 028 sup18m Female B     4                         8
      1449 sup18m__Female__B - 029 sup18m Female B     5                         4
      1450 sup18m__Female__B - 030 sup18m Female B     5                         4
      1451 sup18m__Female__B - 031 sup18m Female B     5                         4
      1452 sup18m__Female__B - 032 sup18m Female B     5                         4
      1453 sup18m__Female__B - 033 sup18m Female B     6                         8
      1454 sup18m__Female__B - 034 sup18m Female B     6                         8
      1455 sup18m__Female__B - 035 sup18m Female B     6                         8
      1456 sup18m__Female__B - 036 sup18m Female B     6                         8
      1457 sup18m__Female__B - 037 sup18m Female B     6                         8
      1458 sup18m__Female__B - 038 sup18m Female B     6                         8
      1459 sup18m__Female__B - 039 sup18m Female B     6                         8
      1460 sup18m__Female__B - 040 sup18m Female B     6                         8
      1461 sup18m__Female__B - 041 sup18m Female B     7                         8
      1462 sup18m__Female__B - 042 sup18m Female B     7                         8
      1463 sup18m__Female__B - 043 sup18m Female B     7                         8
      1464 sup18m__Female__B - 044 sup18m Female B     7                         8
      1465 sup18m__Female__B - 045 sup18m Female B     7                         8
      1466 sup18m__Female__B - 046 sup18m Female B     7                         8
      1467 sup18m__Female__B - 047 sup18m Female B     7                         8
      1468 sup18m__Female__B - 048 sup18m Female B     7                         8
      1469 sup18m__Female__B - 049 sup18m Female B     8                         4
      1470 sup18m__Female__B - 050 sup18m Female B     8                         4
      1471 sup18m__Female__B - 051 sup18m Female B     8                         4
      1472 sup18m__Female__B - 052 sup18m Female B     8                         4
      1473 sup18m__Female__B - 053 sup18m Female B     9                         4
      1474 sup18m__Female__B - 054 sup18m Female B     9                         4
      1475 sup18m__Female__B - 055 sup18m Female B     9                         4
      1476 sup18m__Female__B - 056 sup18m Female B     9                         4
      1477 sup18m__Female__B - 057 sup18m Female B     10                        8
      1478 sup18m__Female__B - 058 sup18m Female B     10                        8
      1479 sup18m__Female__B - 059 sup18m Female B     10                        8
      1480 sup18m__Female__B - 060 sup18m Female B     10                        8
      1481 sup18m__Female__B - 061 sup18m Female B     10                        8
      1482 sup18m__Female__B - 062 sup18m Female B     10                        8
      1483 sup18m__Female__B - 063 sup18m Female B     10                        8
      1484 sup18m__Female__B - 064 sup18m Female B     10                        8
      1485 sup18m__Female__B - 065 sup18m Female B     11                        8
      1486 sup18m__Female__B - 066 sup18m Female B     11                        8
      1487 sup18m__Female__B - 067 sup18m Female B     11                        8
      1488 sup18m__Female__B - 068 sup18m Female B     11                        8
      1489 sup18m__Female__B - 069 sup18m Female B     11                        8
      1490 sup18m__Female__B - 070 sup18m Female B     11                        8
      1491 sup18m__Female__B - 071 sup18m Female B     11                        8
      1492 sup18m__Female__B - 072 sup18m Female B     11                        8
      1493 sup18m__Female__B - 073 sup18m Female B     12                        8
      1494 sup18m__Female__B - 074 sup18m Female B     12                        8
      1495 sup18m__Female__B - 075 sup18m Female B     12                        8
      1496 sup18m__Female__B - 076 sup18m Female B     12                        8
      1497 sup18m__Female__B - 077 sup18m Female B     12                        8
      1498 sup18m__Female__B - 078 sup18m Female B     12                        8
      1499 sup18m__Female__B - 079 sup18m Female B     12                        8
      1500 sup18m__Female__B - 080 sup18m Female B     12                        8
      1501 sup18m__Female__B - 081 sup18m Female B     13                        4
      1502 sup18m__Female__B - 082 sup18m Female B     13                        4
      1503 sup18m__Female__B - 083 sup18m Female B     13                        4
      1504 sup18m__Female__B - 084 sup18m Female B     13                        4
      1505 sup18m__Female__B - 085 sup18m Female B     14                        8
      1506 sup18m__Female__B - 086 sup18m Female B     14                        8
      1507 sup18m__Female__B - 087 sup18m Female B     14                        8
      1508 sup18m__Female__B - 088 sup18m Female B     14                        8
      1509 sup18m__Female__B - 089 sup18m Female B     14                        8
      1510 sup18m__Female__B - 090 sup18m Female B     14                        8
      1511 sup18m__Female__B - 091 sup18m Female B     14                        8
      1512 sup18m__Female__B - 092 sup18m Female B     14                        8
      1513 sup18m__Female__B - 093 sup18m Female B     15                        4
      1514 sup18m__Female__B - 094 sup18m Female B     15                        4
      1515 sup18m__Female__B - 095 sup18m Female B     15                        4
      1516 sup18m__Female__B - 096 sup18m Female B     15                        4
      1517 sup18m__Female__B - 097 sup18m Female B     16                        4
      1518 sup18m__Female__B - 098 sup18m Female B     16                        4
      1519 sup18m__Female__B - 099 sup18m Female B     16                        4
      1520 sup18m__Female__B - 100 sup18m Female B     16                        4
      1521 sup18m__Female__B - 101 sup18m Female B     17                        8
      1522 sup18m__Female__B - 102 sup18m Female B     17                        8
      1523 sup18m__Female__B - 103 sup18m Female B     17                        8
      1524 sup18m__Female__B - 104 sup18m Female B     17                        8
      1525 sup18m__Female__B - 105 sup18m Female B     17                        8
      1526 sup18m__Female__B - 106 sup18m Female B     17                        8
      1527 sup18m__Female__B - 107 sup18m Female B     17                        8
      1528 sup18m__Female__B - 108 sup18m Female B     17                        8
      1529 sup18m__Female__B - 109 sup18m Female B     18                        4
      1530 sup18m__Female__B - 110 sup18m Female B     18                        4
      1531 sup18m__Female__B - 111 sup18m Female B     18                        4
      1532 sup18m__Female__B - 112 sup18m Female B     18                        4
      1533 sup18m__Female__B - 113 sup18m Female B     19                        4
      1534 sup18m__Female__B - 114 sup18m Female B     19                        4
      1535 sup18m__Female__B - 115 sup18m Female B     19                        4
      1536 sup18m__Female__B - 116 sup18m Female B     19                        4
      1537 sup18m__Female__B - 117 sup18m Female B     20                        4
      1538 sup18m__Female__B - 118 sup18m Female B     20                        4
      1539 sup18m__Female__B - 119 sup18m Female B     20                        4
      1540 sup18m__Female__B - 120 sup18m Female B     20                        4
      1541 sup18m__Female__B - 121 sup18m Female B     21                        4
      1542 sup18m__Female__B - 122 sup18m Female B     21                        4
      1543 sup18m__Female__B - 123 sup18m Female B     21                        4
      1544 sup18m__Female__B - 124 sup18m Female B     21                        4
      1545 sup18m__Female__B - 125 sup18m Female B     22                        8
      1546 sup18m__Female__B - 126 sup18m Female B     22                        8
      1547 sup18m__Female__B - 127 sup18m Female B     22                        8
      1548 sup18m__Female__B - 128 sup18m Female B     22                        8
      1549 sup18m__Female__B - 129 sup18m Female B     22                        8
      1550 sup18m__Female__B - 130 sup18m Female B     22                        8
      1551 sup18m__Female__B - 131 sup18m Female B     22                        8
      1552 sup18m__Female__B - 132 sup18m Female B     22                        8
      1553 sup18m__Female__B - 133 sup18m Female B     23                        8
      1554 sup18m__Female__B - 134 sup18m Female B     23                        8
      1555 sup18m__Female__B - 135 sup18m Female B     23                        8
      1556 sup18m__Female__B - 136 sup18m Female B     23                        8
      1557 sup18m__Female__B - 137 sup18m Female B     23                        8
      1558 sup18m__Female__B - 138 sup18m Female B     23                        8
      1559 sup18m__Female__B - 139 sup18m Female B     23                        8
      1560 sup18m__Female__B - 140 sup18m Female B     23                        8
      1561 sup18m__Female__B - 141 sup18m Female B     24                        8
      1562 sup18m__Female__B - 142 sup18m Female B     24                        8
      1563 sup18m__Female__B - 143 sup18m Female B     24                        8
      1564 sup18m__Female__B - 144 sup18m Female B     24                        8
      1565 sup18m__Female__B - 145 sup18m Female B     24                        8
      1566 sup18m__Female__B - 146 sup18m Female B     24                        8
      1567 sup18m__Female__B - 147 sup18m Female B     24                        8
      1568 sup18m__Female__B - 148 sup18m Female B     24                        8
      1569 sup18m__Female__B - 149 sup18m Female B     25                        4
      1570 sup18m__Female__B - 150 sup18m Female B     25                        4
      1571 sup18m__Female__B - 151 sup18m Female B     25                        4
      1572 sup18m__Female__B - 152 sup18m Female B     25                        4
      1573 sup18m__Female__B - 153 sup18m Female B     26                        8
      1574 sup18m__Female__B - 154 sup18m Female B     26                        8
      1575 sup18m__Female__B - 155 sup18m Female B     26                        8
      1576 sup18m__Female__B - 156 sup18m Female B     26                        8
      1577 sup18m__Female__B - 157 sup18m Female B     26                        8
      1578 sup18m__Female__B - 158 sup18m Female B     26                        8
      1579 sup18m__Female__B - 159 sup18m Female B     26                        8
      1580 sup18m__Female__B - 160 sup18m Female B     26                        8
      1581 sup18m__Female__B - 161 sup18m Female B     27                        4
      1582 sup18m__Female__B - 162 sup18m Female B     27                        4
      1583 sup18m__Female__B - 163 sup18m Female B     27                        4
      1584 sup18m__Female__B - 164 sup18m Female B     27                        4
      1585 sup18m__Female__B - 165 sup18m Female B     28                        8
      1586 sup18m__Female__B - 166 sup18m Female B     28                        8
      1587 sup18m__Female__B - 167 sup18m Female B     28                        8
      1588 sup18m__Female__B - 168 sup18m Female B     28                        8
      1589 sup18m__Female__B - 169 sup18m Female B     28                        8
      1590 sup18m__Female__B - 170 sup18m Female B     28                        8
      1591 sup18m__Female__B - 171 sup18m Female B     28                        8
      1592 sup18m__Female__B - 172 sup18m Female B     28                        8
      1593 sup18m__Female__B - 173 sup18m Female B     29                        8
      1594 sup18m__Female__B - 174 sup18m Female B     29                        8
      1595 sup18m__Female__B - 175 sup18m Female B     29                        8
      1596 sup18m__Female__B - 176 sup18m Female B     29                        8
      1597 sup18m__Female__B - 177 sup18m Female B     29                        8
      1598 sup18m__Female__B - 178 sup18m Female B     29                        8
      1599 sup18m__Female__B - 179 sup18m Female B     29                        8
      1600 sup18m__Female__B - 180 sup18m Female B     29                        8
      1601 sup18m__Female__B - 181 sup18m Female B     30                        4
      1602 sup18m__Female__B - 182 sup18m Female B     30                        4
      1603 sup18m__Female__B - 183 sup18m Female B     30                        4
      1604 sup18m__Female__B - 184 sup18m Female B     30                        4
      1605 sup18m__Female__B - 185 sup18m Female B     31                        8
      1606 sup18m__Female__B - 186 sup18m Female B     31                        8
      1607 sup18m__Female__B - 187 sup18m Female B     31                        8
      1608 sup18m__Female__B - 188 sup18m Female B     31                        8
      1609 sup18m__Female__B - 189 sup18m Female B     31                        8
      1610 sup18m__Female__B - 190 sup18m Female B     31                        8
      1611 sup18m__Female__B - 191 sup18m Female B     31                        8
      1612 sup18m__Female__B - 192 sup18m Female B     31                        8
      1613 sup18m__Female__B - 193 sup18m Female B     32                        4
      1614 sup18m__Female__B - 194 sup18m Female B     32                        4
      1615 sup18m__Female__B - 195 sup18m Female B     32                        4
      1616 sup18m__Female__B - 196 sup18m Female B     32                        4
      1617 sup18m__Female__B - 197 sup18m Female B     33                        4
      1618 sup18m__Female__B - 198 sup18m Female B     33                        4
      1619 sup18m__Female__B - 199 sup18m Female B     33                        4
      1620 sup18m__Female__B - 200 sup18m Female B     33                        4
      1621 inf18m__Male__C - 001   inf18m Male   C     1                         8
      1622 inf18m__Male__C - 002   inf18m Male   C     1                         8
      1623 inf18m__Male__C - 003   inf18m Male   C     1                         8
      1624 inf18m__Male__C - 004   inf18m Male   C     1                         8
      1625 inf18m__Male__C - 005   inf18m Male   C     1                         8
      1626 inf18m__Male__C - 006   inf18m Male   C     1                         8
      1627 inf18m__Male__C - 007   inf18m Male   C     1                         8
      1628 inf18m__Male__C - 008   inf18m Male   C     1                         8
      1629 inf18m__Male__C - 009   inf18m Male   C     2                         8
      1630 inf18m__Male__C - 010   inf18m Male   C     2                         8
      1631 inf18m__Male__C - 011   inf18m Male   C     2                         8
      1632 inf18m__Male__C - 012   inf18m Male   C     2                         8
      1633 inf18m__Male__C - 013   inf18m Male   C     2                         8
      1634 inf18m__Male__C - 014   inf18m Male   C     2                         8
      1635 inf18m__Male__C - 015   inf18m Male   C     2                         8
      1636 inf18m__Male__C - 016   inf18m Male   C     2                         8
      1637 inf18m__Male__C - 017   inf18m Male   C     3                         4
      1638 inf18m__Male__C - 018   inf18m Male   C     3                         4
      1639 inf18m__Male__C - 019   inf18m Male   C     3                         4
      1640 inf18m__Male__C - 020   inf18m Male   C     3                         4
      1641 inf18m__Male__C - 021   inf18m Male   C     4                         8
      1642 inf18m__Male__C - 022   inf18m Male   C     4                         8
      1643 inf18m__Male__C - 023   inf18m Male   C     4                         8
      1644 inf18m__Male__C - 024   inf18m Male   C     4                         8
      1645 inf18m__Male__C - 025   inf18m Male   C     4                         8
      1646 inf18m__Male__C - 026   inf18m Male   C     4                         8
      1647 inf18m__Male__C - 027   inf18m Male   C     4                         8
      1648 inf18m__Male__C - 028   inf18m Male   C     4                         8
      1649 inf18m__Male__C - 029   inf18m Male   C     5                         4
      1650 inf18m__Male__C - 030   inf18m Male   C     5                         4
      1651 inf18m__Male__C - 031   inf18m Male   C     5                         4
      1652 inf18m__Male__C - 032   inf18m Male   C     5                         4
      1653 inf18m__Male__C - 033   inf18m Male   C     6                         8
      1654 inf18m__Male__C - 034   inf18m Male   C     6                         8
      1655 inf18m__Male__C - 035   inf18m Male   C     6                         8
      1656 inf18m__Male__C - 036   inf18m Male   C     6                         8
      1657 inf18m__Male__C - 037   inf18m Male   C     6                         8
      1658 inf18m__Male__C - 038   inf18m Male   C     6                         8
      1659 inf18m__Male__C - 039   inf18m Male   C     6                         8
      1660 inf18m__Male__C - 040   inf18m Male   C     6                         8
      1661 inf18m__Male__C - 041   inf18m Male   C     7                         8
      1662 inf18m__Male__C - 042   inf18m Male   C     7                         8
      1663 inf18m__Male__C - 043   inf18m Male   C     7                         8
      1664 inf18m__Male__C - 044   inf18m Male   C     7                         8
      1665 inf18m__Male__C - 045   inf18m Male   C     7                         8
      1666 inf18m__Male__C - 046   inf18m Male   C     7                         8
      1667 inf18m__Male__C - 047   inf18m Male   C     7                         8
      1668 inf18m__Male__C - 048   inf18m Male   C     7                         8
      1669 inf18m__Male__C - 049   inf18m Male   C     8                         4
      1670 inf18m__Male__C - 050   inf18m Male   C     8                         4
      1671 inf18m__Male__C - 051   inf18m Male   C     8                         4
      1672 inf18m__Male__C - 052   inf18m Male   C     8                         4
      1673 inf18m__Male__C - 053   inf18m Male   C     9                         8
      1674 inf18m__Male__C - 054   inf18m Male   C     9                         8
      1675 inf18m__Male__C - 055   inf18m Male   C     9                         8
      1676 inf18m__Male__C - 056   inf18m Male   C     9                         8
      1677 inf18m__Male__C - 057   inf18m Male   C     9                         8
      1678 inf18m__Male__C - 058   inf18m Male   C     9                         8
      1679 inf18m__Male__C - 059   inf18m Male   C     9                         8
      1680 inf18m__Male__C - 060   inf18m Male   C     9                         8
      1681 inf18m__Male__C - 061   inf18m Male   C     10                        8
      1682 inf18m__Male__C - 062   inf18m Male   C     10                        8
      1683 inf18m__Male__C - 063   inf18m Male   C     10                        8
      1684 inf18m__Male__C - 064   inf18m Male   C     10                        8
      1685 inf18m__Male__C - 065   inf18m Male   C     10                        8
      1686 inf18m__Male__C - 066   inf18m Male   C     10                        8
      1687 inf18m__Male__C - 067   inf18m Male   C     10                        8
      1688 inf18m__Male__C - 068   inf18m Male   C     10                        8
      1689 inf18m__Male__C - 069   inf18m Male   C     11                        8
      1690 inf18m__Male__C - 070   inf18m Male   C     11                        8
      1691 inf18m__Male__C - 071   inf18m Male   C     11                        8
      1692 inf18m__Male__C - 072   inf18m Male   C     11                        8
      1693 inf18m__Male__C - 073   inf18m Male   C     11                        8
      1694 inf18m__Male__C - 074   inf18m Male   C     11                        8
      1695 inf18m__Male__C - 075   inf18m Male   C     11                        8
      1696 inf18m__Male__C - 076   inf18m Male   C     11                        8
      1697 inf18m__Male__C - 077   inf18m Male   C     12                        4
      1698 inf18m__Male__C - 078   inf18m Male   C     12                        4
      1699 inf18m__Male__C - 079   inf18m Male   C     12                        4
      1700 inf18m__Male__C - 080   inf18m Male   C     12                        4
      1701 inf18m__Male__C - 081   inf18m Male   C     13                        4
      1702 inf18m__Male__C - 082   inf18m Male   C     13                        4
      1703 inf18m__Male__C - 083   inf18m Male   C     13                        4
      1704 inf18m__Male__C - 084   inf18m Male   C     13                        4
      1705 inf18m__Male__C - 085   inf18m Male   C     14                        4
      1706 inf18m__Male__C - 086   inf18m Male   C     14                        4
      1707 inf18m__Male__C - 087   inf18m Male   C     14                        4
      1708 inf18m__Male__C - 088   inf18m Male   C     14                        4
      1709 inf18m__Male__C - 089   inf18m Male   C     15                        4
      1710 inf18m__Male__C - 090   inf18m Male   C     15                        4
      1711 inf18m__Male__C - 091   inf18m Male   C     15                        4
      1712 inf18m__Male__C - 092   inf18m Male   C     15                        4
      1713 inf18m__Male__C - 093   inf18m Male   C     16                        4
      1714 inf18m__Male__C - 094   inf18m Male   C     16                        4
      1715 inf18m__Male__C - 095   inf18m Male   C     16                        4
      1716 inf18m__Male__C - 096   inf18m Male   C     16                        4
      1717 inf18m__Male__C - 097   inf18m Male   C     17                        4
      1718 inf18m__Male__C - 098   inf18m Male   C     17                        4
      1719 inf18m__Male__C - 099   inf18m Male   C     17                        4
      1720 inf18m__Male__C - 100   inf18m Male   C     17                        4
      1721 inf18m__Male__C - 101   inf18m Male   C     18                        4
      1722 inf18m__Male__C - 102   inf18m Male   C     18                        4
      1723 inf18m__Male__C - 103   inf18m Male   C     18                        4
      1724 inf18m__Male__C - 104   inf18m Male   C     18                        4
      1725 inf18m__Male__C - 105   inf18m Male   C     19                        4
      1726 inf18m__Male__C - 106   inf18m Male   C     19                        4
      1727 inf18m__Male__C - 107   inf18m Male   C     19                        4
      1728 inf18m__Male__C - 108   inf18m Male   C     19                        4
      1729 inf18m__Male__C - 109   inf18m Male   C     20                        8
      1730 inf18m__Male__C - 110   inf18m Male   C     20                        8
      1731 inf18m__Male__C - 111   inf18m Male   C     20                        8
      1732 inf18m__Male__C - 112   inf18m Male   C     20                        8
      1733 inf18m__Male__C - 113   inf18m Male   C     20                        8
      1734 inf18m__Male__C - 114   inf18m Male   C     20                        8
      1735 inf18m__Male__C - 115   inf18m Male   C     20                        8
      1736 inf18m__Male__C - 116   inf18m Male   C     20                        8
      1737 inf18m__Male__C - 117   inf18m Male   C     21                        4
      1738 inf18m__Male__C - 118   inf18m Male   C     21                        4
      1739 inf18m__Male__C - 119   inf18m Male   C     21                        4
      1740 inf18m__Male__C - 120   inf18m Male   C     21                        4
      1741 inf18m__Male__C - 121   inf18m Male   C     22                        8
      1742 inf18m__Male__C - 122   inf18m Male   C     22                        8
      1743 inf18m__Male__C - 123   inf18m Male   C     22                        8
      1744 inf18m__Male__C - 124   inf18m Male   C     22                        8
      1745 inf18m__Male__C - 125   inf18m Male   C     22                        8
      1746 inf18m__Male__C - 126   inf18m Male   C     22                        8
      1747 inf18m__Male__C - 127   inf18m Male   C     22                        8
      1748 inf18m__Male__C - 128   inf18m Male   C     22                        8
      1749 inf18m__Male__C - 129   inf18m Male   C     23                        4
      1750 inf18m__Male__C - 130   inf18m Male   C     23                        4
      1751 inf18m__Male__C - 131   inf18m Male   C     23                        4
      1752 inf18m__Male__C - 132   inf18m Male   C     23                        4
      1753 inf18m__Male__C - 133   inf18m Male   C     24                        4
      1754 inf18m__Male__C - 134   inf18m Male   C     24                        4
      1755 inf18m__Male__C - 135   inf18m Male   C     24                        4
      1756 inf18m__Male__C - 136   inf18m Male   C     24                        4
      1757 inf18m__Male__C - 137   inf18m Male   C     25                        8
      1758 inf18m__Male__C - 138   inf18m Male   C     25                        8
      1759 inf18m__Male__C - 139   inf18m Male   C     25                        8
      1760 inf18m__Male__C - 140   inf18m Male   C     25                        8
      1761 inf18m__Male__C - 141   inf18m Male   C     25                        8
      1762 inf18m__Male__C - 142   inf18m Male   C     25                        8
      1763 inf18m__Male__C - 143   inf18m Male   C     25                        8
      1764 inf18m__Male__C - 144   inf18m Male   C     25                        8
      1765 inf18m__Male__C - 145   inf18m Male   C     26                        8
      1766 inf18m__Male__C - 146   inf18m Male   C     26                        8
      1767 inf18m__Male__C - 147   inf18m Male   C     26                        8
      1768 inf18m__Male__C - 148   inf18m Male   C     26                        8
      1769 inf18m__Male__C - 149   inf18m Male   C     26                        8
      1770 inf18m__Male__C - 150   inf18m Male   C     26                        8
      1771 inf18m__Male__C - 151   inf18m Male   C     26                        8
      1772 inf18m__Male__C - 152   inf18m Male   C     26                        8
      1773 inf18m__Male__C - 153   inf18m Male   C     27                        4
      1774 inf18m__Male__C - 154   inf18m Male   C     27                        4
      1775 inf18m__Male__C - 155   inf18m Male   C     27                        4
      1776 inf18m__Male__C - 156   inf18m Male   C     27                        4
      1777 inf18m__Male__C - 157   inf18m Male   C     28                        8
      1778 inf18m__Male__C - 158   inf18m Male   C     28                        8
      1779 inf18m__Male__C - 159   inf18m Male   C     28                        8
      1780 inf18m__Male__C - 160   inf18m Male   C     28                        8
      1781 inf18m__Male__C - 161   inf18m Male   C     28                        8
      1782 inf18m__Male__C - 162   inf18m Male   C     28                        8
      1783 inf18m__Male__C - 163   inf18m Male   C     28                        8
      1784 inf18m__Male__C - 164   inf18m Male   C     28                        8
      1785 inf18m__Male__C - 165   inf18m Male   C     29                        4
      1786 inf18m__Male__C - 166   inf18m Male   C     29                        4
      1787 inf18m__Male__C - 167   inf18m Male   C     29                        4
      1788 inf18m__Male__C - 168   inf18m Male   C     29                        4
      1789 inf18m__Male__C - 169   inf18m Male   C     30                        8
      1790 inf18m__Male__C - 170   inf18m Male   C     30                        8
      1791 inf18m__Male__C - 171   inf18m Male   C     30                        8
      1792 inf18m__Male__C - 172   inf18m Male   C     30                        8
      1793 inf18m__Male__C - 173   inf18m Male   C     30                        8
      1794 inf18m__Male__C - 174   inf18m Male   C     30                        8
      1795 inf18m__Male__C - 175   inf18m Male   C     30                        8
      1796 inf18m__Male__C - 176   inf18m Male   C     30                        8
      1797 inf18m__Male__C - 177   inf18m Male   C     31                        8
      1798 inf18m__Male__C - 178   inf18m Male   C     31                        8
      1799 inf18m__Male__C - 179   inf18m Male   C     31                        8
      1800 inf18m__Male__C - 180   inf18m Male   C     31                        8
      1801 inf18m__Male__C - 181   inf18m Male   C     31                        8
      1802 inf18m__Male__C - 182   inf18m Male   C     31                        8
      1803 inf18m__Male__C - 183   inf18m Male   C     31                        8
      1804 inf18m__Male__C - 184   inf18m Male   C     31                        8
      1805 inf18m__Male__C - 185   inf18m Male   C     32                        8
      1806 inf18m__Male__C - 186   inf18m Male   C     32                        8
      1807 inf18m__Male__C - 187   inf18m Male   C     32                        8
      1808 inf18m__Male__C - 188   inf18m Male   C     32                        8
      1809 inf18m__Male__C - 189   inf18m Male   C     32                        8
      1810 inf18m__Male__C - 190   inf18m Male   C     32                        8
      1811 inf18m__Male__C - 191   inf18m Male   C     32                        8
      1812 inf18m__Male__C - 192   inf18m Male   C     32                        8
      1813 inf18m__Male__C - 193   inf18m Male   C     33                        8
      1814 inf18m__Male__C - 194   inf18m Male   C     33                        8
      1815 inf18m__Male__C - 195   inf18m Male   C     33                        8
      1816 inf18m__Male__C - 196   inf18m Male   C     33                        8
      1817 inf18m__Male__C - 197   inf18m Male   C     33                        8
      1818 inf18m__Male__C - 198   inf18m Male   C     33                        8
      1819 inf18m__Male__C - 199   inf18m Male   C     33                        8
      1820 inf18m__Male__C - 200   inf18m Male   C     33                        8
      1821 sup18m__Male__C - 001   sup18m Male   C     1                         4
      1822 sup18m__Male__C - 002   sup18m Male   C     1                         4
      1823 sup18m__Male__C - 003   sup18m Male   C     1                         4
      1824 sup18m__Male__C - 004   sup18m Male   C     1                         4
      1825 sup18m__Male__C - 005   sup18m Male   C     2                         8
      1826 sup18m__Male__C - 006   sup18m Male   C     2                         8
      1827 sup18m__Male__C - 007   sup18m Male   C     2                         8
      1828 sup18m__Male__C - 008   sup18m Male   C     2                         8
      1829 sup18m__Male__C - 009   sup18m Male   C     2                         8
      1830 sup18m__Male__C - 010   sup18m Male   C     2                         8
      1831 sup18m__Male__C - 011   sup18m Male   C     2                         8
      1832 sup18m__Male__C - 012   sup18m Male   C     2                         8
      1833 sup18m__Male__C - 013   sup18m Male   C     3                         4
      1834 sup18m__Male__C - 014   sup18m Male   C     3                         4
      1835 sup18m__Male__C - 015   sup18m Male   C     3                         4
      1836 sup18m__Male__C - 016   sup18m Male   C     3                         4
      1837 sup18m__Male__C - 017   sup18m Male   C     4                         4
      1838 sup18m__Male__C - 018   sup18m Male   C     4                         4
      1839 sup18m__Male__C - 019   sup18m Male   C     4                         4
      1840 sup18m__Male__C - 020   sup18m Male   C     4                         4
      1841 sup18m__Male__C - 021   sup18m Male   C     5                         4
      1842 sup18m__Male__C - 022   sup18m Male   C     5                         4
      1843 sup18m__Male__C - 023   sup18m Male   C     5                         4
      1844 sup18m__Male__C - 024   sup18m Male   C     5                         4
      1845 sup18m__Male__C - 025   sup18m Male   C     6                         4
      1846 sup18m__Male__C - 026   sup18m Male   C     6                         4
      1847 sup18m__Male__C - 027   sup18m Male   C     6                         4
      1848 sup18m__Male__C - 028   sup18m Male   C     6                         4
      1849 sup18m__Male__C - 029   sup18m Male   C     7                         8
      1850 sup18m__Male__C - 030   sup18m Male   C     7                         8
      1851 sup18m__Male__C - 031   sup18m Male   C     7                         8
      1852 sup18m__Male__C - 032   sup18m Male   C     7                         8
      1853 sup18m__Male__C - 033   sup18m Male   C     7                         8
      1854 sup18m__Male__C - 034   sup18m Male   C     7                         8
      1855 sup18m__Male__C - 035   sup18m Male   C     7                         8
      1856 sup18m__Male__C - 036   sup18m Male   C     7                         8
      1857 sup18m__Male__C - 037   sup18m Male   C     8                         8
      1858 sup18m__Male__C - 038   sup18m Male   C     8                         8
      1859 sup18m__Male__C - 039   sup18m Male   C     8                         8
      1860 sup18m__Male__C - 040   sup18m Male   C     8                         8
      1861 sup18m__Male__C - 041   sup18m Male   C     8                         8
      1862 sup18m__Male__C - 042   sup18m Male   C     8                         8
      1863 sup18m__Male__C - 043   sup18m Male   C     8                         8
      1864 sup18m__Male__C - 044   sup18m Male   C     8                         8
      1865 sup18m__Male__C - 045   sup18m Male   C     9                         8
      1866 sup18m__Male__C - 046   sup18m Male   C     9                         8
      1867 sup18m__Male__C - 047   sup18m Male   C     9                         8
      1868 sup18m__Male__C - 048   sup18m Male   C     9                         8
      1869 sup18m__Male__C - 049   sup18m Male   C     9                         8
      1870 sup18m__Male__C - 050   sup18m Male   C     9                         8
      1871 sup18m__Male__C - 051   sup18m Male   C     9                         8
      1872 sup18m__Male__C - 052   sup18m Male   C     9                         8
      1873 sup18m__Male__C - 053   sup18m Male   C     10                        4
      1874 sup18m__Male__C - 054   sup18m Male   C     10                        4
      1875 sup18m__Male__C - 055   sup18m Male   C     10                        4
      1876 sup18m__Male__C - 056   sup18m Male   C     10                        4
      1877 sup18m__Male__C - 057   sup18m Male   C     11                        8
      1878 sup18m__Male__C - 058   sup18m Male   C     11                        8
      1879 sup18m__Male__C - 059   sup18m Male   C     11                        8
      1880 sup18m__Male__C - 060   sup18m Male   C     11                        8
      1881 sup18m__Male__C - 061   sup18m Male   C     11                        8
      1882 sup18m__Male__C - 062   sup18m Male   C     11                        8
      1883 sup18m__Male__C - 063   sup18m Male   C     11                        8
      1884 sup18m__Male__C - 064   sup18m Male   C     11                        8
      1885 sup18m__Male__C - 065   sup18m Male   C     12                        8
      1886 sup18m__Male__C - 066   sup18m Male   C     12                        8
      1887 sup18m__Male__C - 067   sup18m Male   C     12                        8
      1888 sup18m__Male__C - 068   sup18m Male   C     12                        8
      1889 sup18m__Male__C - 069   sup18m Male   C     12                        8
      1890 sup18m__Male__C - 070   sup18m Male   C     12                        8
      1891 sup18m__Male__C - 071   sup18m Male   C     12                        8
      1892 sup18m__Male__C - 072   sup18m Male   C     12                        8
      1893 sup18m__Male__C - 073   sup18m Male   C     13                        4
      1894 sup18m__Male__C - 074   sup18m Male   C     13                        4
      1895 sup18m__Male__C - 075   sup18m Male   C     13                        4
      1896 sup18m__Male__C - 076   sup18m Male   C     13                        4
      1897 sup18m__Male__C - 077   sup18m Male   C     14                        4
      1898 sup18m__Male__C - 078   sup18m Male   C     14                        4
      1899 sup18m__Male__C - 079   sup18m Male   C     14                        4
      1900 sup18m__Male__C - 080   sup18m Male   C     14                        4
      1901 sup18m__Male__C - 081   sup18m Male   C     15                        4
      1902 sup18m__Male__C - 082   sup18m Male   C     15                        4
      1903 sup18m__Male__C - 083   sup18m Male   C     15                        4
      1904 sup18m__Male__C - 084   sup18m Male   C     15                        4
      1905 sup18m__Male__C - 085   sup18m Male   C     16                        4
      1906 sup18m__Male__C - 086   sup18m Male   C     16                        4
      1907 sup18m__Male__C - 087   sup18m Male   C     16                        4
      1908 sup18m__Male__C - 088   sup18m Male   C     16                        4
      1909 sup18m__Male__C - 089   sup18m Male   C     17                        8
      1910 sup18m__Male__C - 090   sup18m Male   C     17                        8
      1911 sup18m__Male__C - 091   sup18m Male   C     17                        8
      1912 sup18m__Male__C - 092   sup18m Male   C     17                        8
      1913 sup18m__Male__C - 093   sup18m Male   C     17                        8
      1914 sup18m__Male__C - 094   sup18m Male   C     17                        8
      1915 sup18m__Male__C - 095   sup18m Male   C     17                        8
      1916 sup18m__Male__C - 096   sup18m Male   C     17                        8
      1917 sup18m__Male__C - 097   sup18m Male   C     18                        4
      1918 sup18m__Male__C - 098   sup18m Male   C     18                        4
      1919 sup18m__Male__C - 099   sup18m Male   C     18                        4
      1920 sup18m__Male__C - 100   sup18m Male   C     18                        4
      1921 sup18m__Male__C - 101   sup18m Male   C     19                        8
      1922 sup18m__Male__C - 102   sup18m Male   C     19                        8
      1923 sup18m__Male__C - 103   sup18m Male   C     19                        8
      1924 sup18m__Male__C - 104   sup18m Male   C     19                        8
      1925 sup18m__Male__C - 105   sup18m Male   C     19                        8
      1926 sup18m__Male__C - 106   sup18m Male   C     19                        8
      1927 sup18m__Male__C - 107   sup18m Male   C     19                        8
      1928 sup18m__Male__C - 108   sup18m Male   C     19                        8
      1929 sup18m__Male__C - 109   sup18m Male   C     20                        8
      1930 sup18m__Male__C - 110   sup18m Male   C     20                        8
      1931 sup18m__Male__C - 111   sup18m Male   C     20                        8
      1932 sup18m__Male__C - 112   sup18m Male   C     20                        8
      1933 sup18m__Male__C - 113   sup18m Male   C     20                        8
      1934 sup18m__Male__C - 114   sup18m Male   C     20                        8
      1935 sup18m__Male__C - 115   sup18m Male   C     20                        8
      1936 sup18m__Male__C - 116   sup18m Male   C     20                        8
      1937 sup18m__Male__C - 117   sup18m Male   C     21                        4
      1938 sup18m__Male__C - 118   sup18m Male   C     21                        4
      1939 sup18m__Male__C - 119   sup18m Male   C     21                        4
      1940 sup18m__Male__C - 120   sup18m Male   C     21                        4
      1941 sup18m__Male__C - 121   sup18m Male   C     22                        8
      1942 sup18m__Male__C - 122   sup18m Male   C     22                        8
      1943 sup18m__Male__C - 123   sup18m Male   C     22                        8
      1944 sup18m__Male__C - 124   sup18m Male   C     22                        8
      1945 sup18m__Male__C - 125   sup18m Male   C     22                        8
      1946 sup18m__Male__C - 126   sup18m Male   C     22                        8
      1947 sup18m__Male__C - 127   sup18m Male   C     22                        8
      1948 sup18m__Male__C - 128   sup18m Male   C     22                        8
      1949 sup18m__Male__C - 129   sup18m Male   C     23                        8
      1950 sup18m__Male__C - 130   sup18m Male   C     23                        8
      1951 sup18m__Male__C - 131   sup18m Male   C     23                        8
      1952 sup18m__Male__C - 132   sup18m Male   C     23                        8
      1953 sup18m__Male__C - 133   sup18m Male   C     23                        8
      1954 sup18m__Male__C - 134   sup18m Male   C     23                        8
      1955 sup18m__Male__C - 135   sup18m Male   C     23                        8
      1956 sup18m__Male__C - 136   sup18m Male   C     23                        8
      1957 sup18m__Male__C - 137   sup18m Male   C     24                        4
      1958 sup18m__Male__C - 138   sup18m Male   C     24                        4
      1959 sup18m__Male__C - 139   sup18m Male   C     24                        4
      1960 sup18m__Male__C - 140   sup18m Male   C     24                        4
      1961 sup18m__Male__C - 141   sup18m Male   C     25                        8
      1962 sup18m__Male__C - 142   sup18m Male   C     25                        8
      1963 sup18m__Male__C - 143   sup18m Male   C     25                        8
      1964 sup18m__Male__C - 144   sup18m Male   C     25                        8
      1965 sup18m__Male__C - 145   sup18m Male   C     25                        8
      1966 sup18m__Male__C - 146   sup18m Male   C     25                        8
      1967 sup18m__Male__C - 147   sup18m Male   C     25                        8
      1968 sup18m__Male__C - 148   sup18m Male   C     25                        8
      1969 sup18m__Male__C - 149   sup18m Male   C     26                        8
      1970 sup18m__Male__C - 150   sup18m Male   C     26                        8
      1971 sup18m__Male__C - 151   sup18m Male   C     26                        8
      1972 sup18m__Male__C - 152   sup18m Male   C     26                        8
      1973 sup18m__Male__C - 153   sup18m Male   C     26                        8
      1974 sup18m__Male__C - 154   sup18m Male   C     26                        8
      1975 sup18m__Male__C - 155   sup18m Male   C     26                        8
      1976 sup18m__Male__C - 156   sup18m Male   C     26                        8
      1977 sup18m__Male__C - 157   sup18m Male   C     27                        8
      1978 sup18m__Male__C - 158   sup18m Male   C     27                        8
      1979 sup18m__Male__C - 159   sup18m Male   C     27                        8
      1980 sup18m__Male__C - 160   sup18m Male   C     27                        8
      1981 sup18m__Male__C - 161   sup18m Male   C     27                        8
      1982 sup18m__Male__C - 162   sup18m Male   C     27                        8
      1983 sup18m__Male__C - 163   sup18m Male   C     27                        8
      1984 sup18m__Male__C - 164   sup18m Male   C     27                        8
      1985 sup18m__Male__C - 165   sup18m Male   C     28                        4
      1986 sup18m__Male__C - 166   sup18m Male   C     28                        4
      1987 sup18m__Male__C - 167   sup18m Male   C     28                        4
      1988 sup18m__Male__C - 168   sup18m Male   C     28                        4
      1989 sup18m__Male__C - 169   sup18m Male   C     29                        8
      1990 sup18m__Male__C - 170   sup18m Male   C     29                        8
      1991 sup18m__Male__C - 171   sup18m Male   C     29                        8
      1992 sup18m__Male__C - 172   sup18m Male   C     29                        8
      1993 sup18m__Male__C - 173   sup18m Male   C     29                        8
      1994 sup18m__Male__C - 174   sup18m Male   C     29                        8
      1995 sup18m__Male__C - 175   sup18m Male   C     29                        8
      1996 sup18m__Male__C - 176   sup18m Male   C     29                        8
      1997 sup18m__Male__C - 177   sup18m Male   C     30                        8
      1998 sup18m__Male__C - 178   sup18m Male   C     30                        8
      1999 sup18m__Male__C - 179   sup18m Male   C     30                        8
      2000 sup18m__Male__C - 180   sup18m Male   C     30                        8
      2001 sup18m__Male__C - 181   sup18m Male   C     30                        8
      2002 sup18m__Male__C - 182   sup18m Male   C     30                        8
      2003 sup18m__Male__C - 183   sup18m Male   C     30                        8
      2004 sup18m__Male__C - 184   sup18m Male   C     30                        8
      2005 sup18m__Male__C - 185   sup18m Male   C     31                        8
      2006 sup18m__Male__C - 186   sup18m Male   C     31                        8
      2007 sup18m__Male__C - 187   sup18m Male   C     31                        8
      2008 sup18m__Male__C - 188   sup18m Male   C     31                        8
      2009 sup18m__Male__C - 189   sup18m Male   C     31                        8
      2010 sup18m__Male__C - 190   sup18m Male   C     31                        8
      2011 sup18m__Male__C - 191   sup18m Male   C     31                        8
      2012 sup18m__Male__C - 192   sup18m Male   C     31                        8
      2013 sup18m__Male__C - 193   sup18m Male   C     32                        8
      2014 sup18m__Male__C - 194   sup18m Male   C     32                        8
      2015 sup18m__Male__C - 195   sup18m Male   C     32                        8
      2016 sup18m__Male__C - 196   sup18m Male   C     32                        8
      2017 sup18m__Male__C - 197   sup18m Male   C     32                        8
      2018 sup18m__Male__C - 198   sup18m Male   C     32                        8
      2019 sup18m__Male__C - 199   sup18m Male   C     32                        8
      2020 sup18m__Male__C - 200   sup18m Male   C     32                        8
      2021 inf18m__Female__C - 001 inf18m Female C     1                         8
      2022 inf18m__Female__C - 002 inf18m Female C     1                         8
      2023 inf18m__Female__C - 003 inf18m Female C     1                         8
      2024 inf18m__Female__C - 004 inf18m Female C     1                         8
      2025 inf18m__Female__C - 005 inf18m Female C     1                         8
      2026 inf18m__Female__C - 006 inf18m Female C     1                         8
      2027 inf18m__Female__C - 007 inf18m Female C     1                         8
      2028 inf18m__Female__C - 008 inf18m Female C     1                         8
      2029 inf18m__Female__C - 009 inf18m Female C     2                         4
      2030 inf18m__Female__C - 010 inf18m Female C     2                         4
      2031 inf18m__Female__C - 011 inf18m Female C     2                         4
      2032 inf18m__Female__C - 012 inf18m Female C     2                         4
      2033 inf18m__Female__C - 013 inf18m Female C     3                         4
      2034 inf18m__Female__C - 014 inf18m Female C     3                         4
      2035 inf18m__Female__C - 015 inf18m Female C     3                         4
      2036 inf18m__Female__C - 016 inf18m Female C     3                         4
      2037 inf18m__Female__C - 017 inf18m Female C     4                         4
      2038 inf18m__Female__C - 018 inf18m Female C     4                         4
      2039 inf18m__Female__C - 019 inf18m Female C     4                         4
      2040 inf18m__Female__C - 020 inf18m Female C     4                         4
      2041 inf18m__Female__C - 021 inf18m Female C     5                         8
      2042 inf18m__Female__C - 022 inf18m Female C     5                         8
      2043 inf18m__Female__C - 023 inf18m Female C     5                         8
      2044 inf18m__Female__C - 024 inf18m Female C     5                         8
      2045 inf18m__Female__C - 025 inf18m Female C     5                         8
      2046 inf18m__Female__C - 026 inf18m Female C     5                         8
      2047 inf18m__Female__C - 027 inf18m Female C     5                         8
      2048 inf18m__Female__C - 028 inf18m Female C     5                         8
      2049 inf18m__Female__C - 029 inf18m Female C     6                         4
      2050 inf18m__Female__C - 030 inf18m Female C     6                         4
      2051 inf18m__Female__C - 031 inf18m Female C     6                         4
      2052 inf18m__Female__C - 032 inf18m Female C     6                         4
      2053 inf18m__Female__C - 033 inf18m Female C     7                         4
      2054 inf18m__Female__C - 034 inf18m Female C     7                         4
      2055 inf18m__Female__C - 035 inf18m Female C     7                         4
      2056 inf18m__Female__C - 036 inf18m Female C     7                         4
      2057 inf18m__Female__C - 037 inf18m Female C     8                         4
      2058 inf18m__Female__C - 038 inf18m Female C     8                         4
      2059 inf18m__Female__C - 039 inf18m Female C     8                         4
      2060 inf18m__Female__C - 040 inf18m Female C     8                         4
      2061 inf18m__Female__C - 041 inf18m Female C     9                         8
      2062 inf18m__Female__C - 042 inf18m Female C     9                         8
      2063 inf18m__Female__C - 043 inf18m Female C     9                         8
      2064 inf18m__Female__C - 044 inf18m Female C     9                         8
      2065 inf18m__Female__C - 045 inf18m Female C     9                         8
      2066 inf18m__Female__C - 046 inf18m Female C     9                         8
      2067 inf18m__Female__C - 047 inf18m Female C     9                         8
      2068 inf18m__Female__C - 048 inf18m Female C     9                         8
      2069 inf18m__Female__C - 049 inf18m Female C     10                        8
      2070 inf18m__Female__C - 050 inf18m Female C     10                        8
      2071 inf18m__Female__C - 051 inf18m Female C     10                        8
      2072 inf18m__Female__C - 052 inf18m Female C     10                        8
      2073 inf18m__Female__C - 053 inf18m Female C     10                        8
      2074 inf18m__Female__C - 054 inf18m Female C     10                        8
      2075 inf18m__Female__C - 055 inf18m Female C     10                        8
      2076 inf18m__Female__C - 056 inf18m Female C     10                        8
      2077 inf18m__Female__C - 057 inf18m Female C     11                        8
      2078 inf18m__Female__C - 058 inf18m Female C     11                        8
      2079 inf18m__Female__C - 059 inf18m Female C     11                        8
      2080 inf18m__Female__C - 060 inf18m Female C     11                        8
      2081 inf18m__Female__C - 061 inf18m Female C     11                        8
      2082 inf18m__Female__C - 062 inf18m Female C     11                        8
      2083 inf18m__Female__C - 063 inf18m Female C     11                        8
      2084 inf18m__Female__C - 064 inf18m Female C     11                        8
      2085 inf18m__Female__C - 065 inf18m Female C     12                        4
      2086 inf18m__Female__C - 066 inf18m Female C     12                        4
      2087 inf18m__Female__C - 067 inf18m Female C     12                        4
      2088 inf18m__Female__C - 068 inf18m Female C     12                        4
      2089 inf18m__Female__C - 069 inf18m Female C     13                        8
      2090 inf18m__Female__C - 070 inf18m Female C     13                        8
      2091 inf18m__Female__C - 071 inf18m Female C     13                        8
      2092 inf18m__Female__C - 072 inf18m Female C     13                        8
      2093 inf18m__Female__C - 073 inf18m Female C     13                        8
      2094 inf18m__Female__C - 074 inf18m Female C     13                        8
      2095 inf18m__Female__C - 075 inf18m Female C     13                        8
      2096 inf18m__Female__C - 076 inf18m Female C     13                        8
      2097 inf18m__Female__C - 077 inf18m Female C     14                        4
      2098 inf18m__Female__C - 078 inf18m Female C     14                        4
      2099 inf18m__Female__C - 079 inf18m Female C     14                        4
      2100 inf18m__Female__C - 080 inf18m Female C     14                        4
      2101 inf18m__Female__C - 081 inf18m Female C     15                        4
      2102 inf18m__Female__C - 082 inf18m Female C     15                        4
      2103 inf18m__Female__C - 083 inf18m Female C     15                        4
      2104 inf18m__Female__C - 084 inf18m Female C     15                        4
      2105 inf18m__Female__C - 085 inf18m Female C     16                        8
      2106 inf18m__Female__C - 086 inf18m Female C     16                        8
      2107 inf18m__Female__C - 087 inf18m Female C     16                        8
      2108 inf18m__Female__C - 088 inf18m Female C     16                        8
      2109 inf18m__Female__C - 089 inf18m Female C     16                        8
      2110 inf18m__Female__C - 090 inf18m Female C     16                        8
      2111 inf18m__Female__C - 091 inf18m Female C     16                        8
      2112 inf18m__Female__C - 092 inf18m Female C     16                        8
      2113 inf18m__Female__C - 093 inf18m Female C     17                        4
      2114 inf18m__Female__C - 094 inf18m Female C     17                        4
      2115 inf18m__Female__C - 095 inf18m Female C     17                        4
      2116 inf18m__Female__C - 096 inf18m Female C     17                        4
      2117 inf18m__Female__C - 097 inf18m Female C     18                        4
      2118 inf18m__Female__C - 098 inf18m Female C     18                        4
      2119 inf18m__Female__C - 099 inf18m Female C     18                        4
      2120 inf18m__Female__C - 100 inf18m Female C     18                        4
      2121 inf18m__Female__C - 101 inf18m Female C     19                        8
      2122 inf18m__Female__C - 102 inf18m Female C     19                        8
      2123 inf18m__Female__C - 103 inf18m Female C     19                        8
      2124 inf18m__Female__C - 104 inf18m Female C     19                        8
      2125 inf18m__Female__C - 105 inf18m Female C     19                        8
      2126 inf18m__Female__C - 106 inf18m Female C     19                        8
      2127 inf18m__Female__C - 107 inf18m Female C     19                        8
      2128 inf18m__Female__C - 108 inf18m Female C     19                        8
      2129 inf18m__Female__C - 109 inf18m Female C     20                        8
      2130 inf18m__Female__C - 110 inf18m Female C     20                        8
      2131 inf18m__Female__C - 111 inf18m Female C     20                        8
      2132 inf18m__Female__C - 112 inf18m Female C     20                        8
      2133 inf18m__Female__C - 113 inf18m Female C     20                        8
      2134 inf18m__Female__C - 114 inf18m Female C     20                        8
      2135 inf18m__Female__C - 115 inf18m Female C     20                        8
      2136 inf18m__Female__C - 116 inf18m Female C     20                        8
      2137 inf18m__Female__C - 117 inf18m Female C     21                        8
      2138 inf18m__Female__C - 118 inf18m Female C     21                        8
      2139 inf18m__Female__C - 119 inf18m Female C     21                        8
      2140 inf18m__Female__C - 120 inf18m Female C     21                        8
      2141 inf18m__Female__C - 121 inf18m Female C     21                        8
      2142 inf18m__Female__C - 122 inf18m Female C     21                        8
      2143 inf18m__Female__C - 123 inf18m Female C     21                        8
      2144 inf18m__Female__C - 124 inf18m Female C     21                        8
      2145 inf18m__Female__C - 125 inf18m Female C     22                        8
      2146 inf18m__Female__C - 126 inf18m Female C     22                        8
      2147 inf18m__Female__C - 127 inf18m Female C     22                        8
      2148 inf18m__Female__C - 128 inf18m Female C     22                        8
      2149 inf18m__Female__C - 129 inf18m Female C     22                        8
      2150 inf18m__Female__C - 130 inf18m Female C     22                        8
      2151 inf18m__Female__C - 131 inf18m Female C     22                        8
      2152 inf18m__Female__C - 132 inf18m Female C     22                        8
      2153 inf18m__Female__C - 133 inf18m Female C     23                        8
      2154 inf18m__Female__C - 134 inf18m Female C     23                        8
      2155 inf18m__Female__C - 135 inf18m Female C     23                        8
      2156 inf18m__Female__C - 136 inf18m Female C     23                        8
      2157 inf18m__Female__C - 137 inf18m Female C     23                        8
      2158 inf18m__Female__C - 138 inf18m Female C     23                        8
      2159 inf18m__Female__C - 139 inf18m Female C     23                        8
      2160 inf18m__Female__C - 140 inf18m Female C     23                        8
      2161 inf18m__Female__C - 141 inf18m Female C     24                        4
      2162 inf18m__Female__C - 142 inf18m Female C     24                        4
      2163 inf18m__Female__C - 143 inf18m Female C     24                        4
      2164 inf18m__Female__C - 144 inf18m Female C     24                        4
      2165 inf18m__Female__C - 145 inf18m Female C     25                        4
      2166 inf18m__Female__C - 146 inf18m Female C     25                        4
      2167 inf18m__Female__C - 147 inf18m Female C     25                        4
      2168 inf18m__Female__C - 148 inf18m Female C     25                        4
      2169 inf18m__Female__C - 149 inf18m Female C     26                        8
      2170 inf18m__Female__C - 150 inf18m Female C     26                        8
      2171 inf18m__Female__C - 151 inf18m Female C     26                        8
      2172 inf18m__Female__C - 152 inf18m Female C     26                        8
      2173 inf18m__Female__C - 153 inf18m Female C     26                        8
      2174 inf18m__Female__C - 154 inf18m Female C     26                        8
      2175 inf18m__Female__C - 155 inf18m Female C     26                        8
      2176 inf18m__Female__C - 156 inf18m Female C     26                        8
      2177 inf18m__Female__C - 157 inf18m Female C     27                        8
      2178 inf18m__Female__C - 158 inf18m Female C     27                        8
      2179 inf18m__Female__C - 159 inf18m Female C     27                        8
      2180 inf18m__Female__C - 160 inf18m Female C     27                        8
      2181 inf18m__Female__C - 161 inf18m Female C     27                        8
      2182 inf18m__Female__C - 162 inf18m Female C     27                        8
      2183 inf18m__Female__C - 163 inf18m Female C     27                        8
      2184 inf18m__Female__C - 164 inf18m Female C     27                        8
      2185 inf18m__Female__C - 165 inf18m Female C     28                        8
      2186 inf18m__Female__C - 166 inf18m Female C     28                        8
      2187 inf18m__Female__C - 167 inf18m Female C     28                        8
      2188 inf18m__Female__C - 168 inf18m Female C     28                        8
      2189 inf18m__Female__C - 169 inf18m Female C     28                        8
      2190 inf18m__Female__C - 170 inf18m Female C     28                        8
      2191 inf18m__Female__C - 171 inf18m Female C     28                        8
      2192 inf18m__Female__C - 172 inf18m Female C     28                        8
      2193 inf18m__Female__C - 173 inf18m Female C     29                        8
      2194 inf18m__Female__C - 174 inf18m Female C     29                        8
      2195 inf18m__Female__C - 175 inf18m Female C     29                        8
      2196 inf18m__Female__C - 176 inf18m Female C     29                        8
      2197 inf18m__Female__C - 177 inf18m Female C     29                        8
      2198 inf18m__Female__C - 178 inf18m Female C     29                        8
      2199 inf18m__Female__C - 179 inf18m Female C     29                        8
      2200 inf18m__Female__C - 180 inf18m Female C     29                        8
      2201 inf18m__Female__C - 181 inf18m Female C     30                        4
      2202 inf18m__Female__C - 182 inf18m Female C     30                        4
      2203 inf18m__Female__C - 183 inf18m Female C     30                        4
      2204 inf18m__Female__C - 184 inf18m Female C     30                        4
      2205 inf18m__Female__C - 185 inf18m Female C     31                        8
      2206 inf18m__Female__C - 186 inf18m Female C     31                        8
      2207 inf18m__Female__C - 187 inf18m Female C     31                        8
      2208 inf18m__Female__C - 188 inf18m Female C     31                        8
      2209 inf18m__Female__C - 189 inf18m Female C     31                        8
      2210 inf18m__Female__C - 190 inf18m Female C     31                        8
      2211 inf18m__Female__C - 191 inf18m Female C     31                        8
      2212 inf18m__Female__C - 192 inf18m Female C     31                        8
      2213 inf18m__Female__C - 193 inf18m Female C     32                        8
      2214 inf18m__Female__C - 194 inf18m Female C     32                        8
      2215 inf18m__Female__C - 195 inf18m Female C     32                        8
      2216 inf18m__Female__C - 196 inf18m Female C     32                        8
      2217 inf18m__Female__C - 197 inf18m Female C     32                        8
      2218 inf18m__Female__C - 198 inf18m Female C     32                        8
      2219 inf18m__Female__C - 199 inf18m Female C     32                        8
      2220 inf18m__Female__C - 200 inf18m Female C     32                        8
      2221 sup18m__Female__C - 001 sup18m Female C     1                         8
      2222 sup18m__Female__C - 002 sup18m Female C     1                         8
      2223 sup18m__Female__C - 003 sup18m Female C     1                         8
      2224 sup18m__Female__C - 004 sup18m Female C     1                         8
      2225 sup18m__Female__C - 005 sup18m Female C     1                         8
      2226 sup18m__Female__C - 006 sup18m Female C     1                         8
      2227 sup18m__Female__C - 007 sup18m Female C     1                         8
      2228 sup18m__Female__C - 008 sup18m Female C     1                         8
      2229 sup18m__Female__C - 009 sup18m Female C     2                         4
      2230 sup18m__Female__C - 010 sup18m Female C     2                         4
      2231 sup18m__Female__C - 011 sup18m Female C     2                         4
      2232 sup18m__Female__C - 012 sup18m Female C     2                         4
      2233 sup18m__Female__C - 013 sup18m Female C     3                         4
      2234 sup18m__Female__C - 014 sup18m Female C     3                         4
      2235 sup18m__Female__C - 015 sup18m Female C     3                         4
      2236 sup18m__Female__C - 016 sup18m Female C     3                         4
      2237 sup18m__Female__C - 017 sup18m Female C     4                         8
      2238 sup18m__Female__C - 018 sup18m Female C     4                         8
      2239 sup18m__Female__C - 019 sup18m Female C     4                         8
      2240 sup18m__Female__C - 020 sup18m Female C     4                         8
      2241 sup18m__Female__C - 021 sup18m Female C     4                         8
      2242 sup18m__Female__C - 022 sup18m Female C     4                         8
      2243 sup18m__Female__C - 023 sup18m Female C     4                         8
      2244 sup18m__Female__C - 024 sup18m Female C     4                         8
      2245 sup18m__Female__C - 025 sup18m Female C     5                         4
      2246 sup18m__Female__C - 026 sup18m Female C     5                         4
      2247 sup18m__Female__C - 027 sup18m Female C     5                         4
      2248 sup18m__Female__C - 028 sup18m Female C     5                         4
      2249 sup18m__Female__C - 029 sup18m Female C     6                         4
      2250 sup18m__Female__C - 030 sup18m Female C     6                         4
      2251 sup18m__Female__C - 031 sup18m Female C     6                         4
      2252 sup18m__Female__C - 032 sup18m Female C     6                         4
      2253 sup18m__Female__C - 033 sup18m Female C     7                         4
      2254 sup18m__Female__C - 034 sup18m Female C     7                         4
      2255 sup18m__Female__C - 035 sup18m Female C     7                         4
      2256 sup18m__Female__C - 036 sup18m Female C     7                         4
      2257 sup18m__Female__C - 037 sup18m Female C     8                         4
      2258 sup18m__Female__C - 038 sup18m Female C     8                         4
      2259 sup18m__Female__C - 039 sup18m Female C     8                         4
      2260 sup18m__Female__C - 040 sup18m Female C     8                         4
      2261 sup18m__Female__C - 041 sup18m Female C     9                         8
      2262 sup18m__Female__C - 042 sup18m Female C     9                         8
      2263 sup18m__Female__C - 043 sup18m Female C     9                         8
      2264 sup18m__Female__C - 044 sup18m Female C     9                         8
      2265 sup18m__Female__C - 045 sup18m Female C     9                         8
      2266 sup18m__Female__C - 046 sup18m Female C     9                         8
      2267 sup18m__Female__C - 047 sup18m Female C     9                         8
      2268 sup18m__Female__C - 048 sup18m Female C     9                         8
      2269 sup18m__Female__C - 049 sup18m Female C     10                        4
      2270 sup18m__Female__C - 050 sup18m Female C     10                        4
      2271 sup18m__Female__C - 051 sup18m Female C     10                        4
      2272 sup18m__Female__C - 052 sup18m Female C     10                        4
      2273 sup18m__Female__C - 053 sup18m Female C     11                        8
      2274 sup18m__Female__C - 054 sup18m Female C     11                        8
      2275 sup18m__Female__C - 055 sup18m Female C     11                        8
      2276 sup18m__Female__C - 056 sup18m Female C     11                        8
      2277 sup18m__Female__C - 057 sup18m Female C     11                        8
      2278 sup18m__Female__C - 058 sup18m Female C     11                        8
      2279 sup18m__Female__C - 059 sup18m Female C     11                        8
      2280 sup18m__Female__C - 060 sup18m Female C     11                        8
      2281 sup18m__Female__C - 061 sup18m Female C     12                        8
      2282 sup18m__Female__C - 062 sup18m Female C     12                        8
      2283 sup18m__Female__C - 063 sup18m Female C     12                        8
      2284 sup18m__Female__C - 064 sup18m Female C     12                        8
      2285 sup18m__Female__C - 065 sup18m Female C     12                        8
      2286 sup18m__Female__C - 066 sup18m Female C     12                        8
      2287 sup18m__Female__C - 067 sup18m Female C     12                        8
      2288 sup18m__Female__C - 068 sup18m Female C     12                        8
      2289 sup18m__Female__C - 069 sup18m Female C     13                        4
      2290 sup18m__Female__C - 070 sup18m Female C     13                        4
      2291 sup18m__Female__C - 071 sup18m Female C     13                        4
      2292 sup18m__Female__C - 072 sup18m Female C     13                        4
      2293 sup18m__Female__C - 073 sup18m Female C     14                        4
      2294 sup18m__Female__C - 074 sup18m Female C     14                        4
      2295 sup18m__Female__C - 075 sup18m Female C     14                        4
      2296 sup18m__Female__C - 076 sup18m Female C     14                        4
      2297 sup18m__Female__C - 077 sup18m Female C     15                        4
      2298 sup18m__Female__C - 078 sup18m Female C     15                        4
      2299 sup18m__Female__C - 079 sup18m Female C     15                        4
      2300 sup18m__Female__C - 080 sup18m Female C     15                        4
      2301 sup18m__Female__C - 081 sup18m Female C     16                        4
      2302 sup18m__Female__C - 082 sup18m Female C     16                        4
      2303 sup18m__Female__C - 083 sup18m Female C     16                        4
      2304 sup18m__Female__C - 084 sup18m Female C     16                        4
      2305 sup18m__Female__C - 085 sup18m Female C     17                        8
      2306 sup18m__Female__C - 086 sup18m Female C     17                        8
      2307 sup18m__Female__C - 087 sup18m Female C     17                        8
      2308 sup18m__Female__C - 088 sup18m Female C     17                        8
      2309 sup18m__Female__C - 089 sup18m Female C     17                        8
      2310 sup18m__Female__C - 090 sup18m Female C     17                        8
      2311 sup18m__Female__C - 091 sup18m Female C     17                        8
      2312 sup18m__Female__C - 092 sup18m Female C     17                        8
      2313 sup18m__Female__C - 093 sup18m Female C     18                        4
      2314 sup18m__Female__C - 094 sup18m Female C     18                        4
      2315 sup18m__Female__C - 095 sup18m Female C     18                        4
      2316 sup18m__Female__C - 096 sup18m Female C     18                        4
      2317 sup18m__Female__C - 097 sup18m Female C     19                        8
      2318 sup18m__Female__C - 098 sup18m Female C     19                        8
      2319 sup18m__Female__C - 099 sup18m Female C     19                        8
      2320 sup18m__Female__C - 100 sup18m Female C     19                        8
      2321 sup18m__Female__C - 101 sup18m Female C     19                        8
      2322 sup18m__Female__C - 102 sup18m Female C     19                        8
      2323 sup18m__Female__C - 103 sup18m Female C     19                        8
      2324 sup18m__Female__C - 104 sup18m Female C     19                        8
      2325 sup18m__Female__C - 105 sup18m Female C     20                        4
      2326 sup18m__Female__C - 106 sup18m Female C     20                        4
      2327 sup18m__Female__C - 107 sup18m Female C     20                        4
      2328 sup18m__Female__C - 108 sup18m Female C     20                        4
      2329 sup18m__Female__C - 109 sup18m Female C     21                        4
      2330 sup18m__Female__C - 110 sup18m Female C     21                        4
      2331 sup18m__Female__C - 111 sup18m Female C     21                        4
      2332 sup18m__Female__C - 112 sup18m Female C     21                        4
      2333 sup18m__Female__C - 113 sup18m Female C     22                        8
      2334 sup18m__Female__C - 114 sup18m Female C     22                        8
      2335 sup18m__Female__C - 115 sup18m Female C     22                        8
      2336 sup18m__Female__C - 116 sup18m Female C     22                        8
      2337 sup18m__Female__C - 117 sup18m Female C     22                        8
      2338 sup18m__Female__C - 118 sup18m Female C     22                        8
      2339 sup18m__Female__C - 119 sup18m Female C     22                        8
      2340 sup18m__Female__C - 120 sup18m Female C     22                        8
      2341 sup18m__Female__C - 121 sup18m Female C     23                        8
      2342 sup18m__Female__C - 122 sup18m Female C     23                        8
      2343 sup18m__Female__C - 123 sup18m Female C     23                        8
      2344 sup18m__Female__C - 124 sup18m Female C     23                        8
      2345 sup18m__Female__C - 125 sup18m Female C     23                        8
      2346 sup18m__Female__C - 126 sup18m Female C     23                        8
      2347 sup18m__Female__C - 127 sup18m Female C     23                        8
      2348 sup18m__Female__C - 128 sup18m Female C     23                        8
      2349 sup18m__Female__C - 129 sup18m Female C     24                        4
      2350 sup18m__Female__C - 130 sup18m Female C     24                        4
      2351 sup18m__Female__C - 131 sup18m Female C     24                        4
      2352 sup18m__Female__C - 132 sup18m Female C     24                        4
      2353 sup18m__Female__C - 133 sup18m Female C     25                        4
      2354 sup18m__Female__C - 134 sup18m Female C     25                        4
      2355 sup18m__Female__C - 135 sup18m Female C     25                        4
      2356 sup18m__Female__C - 136 sup18m Female C     25                        4
      2357 sup18m__Female__C - 137 sup18m Female C     26                        4
      2358 sup18m__Female__C - 138 sup18m Female C     26                        4
      2359 sup18m__Female__C - 139 sup18m Female C     26                        4
      2360 sup18m__Female__C - 140 sup18m Female C     26                        4
      2361 sup18m__Female__C - 141 sup18m Female C     27                        8
      2362 sup18m__Female__C - 142 sup18m Female C     27                        8
      2363 sup18m__Female__C - 143 sup18m Female C     27                        8
      2364 sup18m__Female__C - 144 sup18m Female C     27                        8
      2365 sup18m__Female__C - 145 sup18m Female C     27                        8
      2366 sup18m__Female__C - 146 sup18m Female C     27                        8
      2367 sup18m__Female__C - 147 sup18m Female C     27                        8
      2368 sup18m__Female__C - 148 sup18m Female C     27                        8
      2369 sup18m__Female__C - 149 sup18m Female C     28                        8
      2370 sup18m__Female__C - 150 sup18m Female C     28                        8
      2371 sup18m__Female__C - 151 sup18m Female C     28                        8
      2372 sup18m__Female__C - 152 sup18m Female C     28                        8
      2373 sup18m__Female__C - 153 sup18m Female C     28                        8
      2374 sup18m__Female__C - 154 sup18m Female C     28                        8
      2375 sup18m__Female__C - 155 sup18m Female C     28                        8
      2376 sup18m__Female__C - 156 sup18m Female C     28                        8
      2377 sup18m__Female__C - 157 sup18m Female C     29                        4
      2378 sup18m__Female__C - 158 sup18m Female C     29                        4
      2379 sup18m__Female__C - 159 sup18m Female C     29                        4
      2380 sup18m__Female__C - 160 sup18m Female C     29                        4
      2381 sup18m__Female__C - 161 sup18m Female C     30                        4
      2382 sup18m__Female__C - 162 sup18m Female C     30                        4
      2383 sup18m__Female__C - 163 sup18m Female C     30                        4
      2384 sup18m__Female__C - 164 sup18m Female C     30                        4
      2385 sup18m__Female__C - 165 sup18m Female C     31                        8
      2386 sup18m__Female__C - 166 sup18m Female C     31                        8
      2387 sup18m__Female__C - 167 sup18m Female C     31                        8
      2388 sup18m__Female__C - 168 sup18m Female C     31                        8
      2389 sup18m__Female__C - 169 sup18m Female C     31                        8
      2390 sup18m__Female__C - 170 sup18m Female C     31                        8
      2391 sup18m__Female__C - 171 sup18m Female C     31                        8
      2392 sup18m__Female__C - 172 sup18m Female C     31                        8
      2393 sup18m__Female__C - 173 sup18m Female C     32                        8
      2394 sup18m__Female__C - 174 sup18m Female C     32                        8
      2395 sup18m__Female__C - 175 sup18m Female C     32                        8
      2396 sup18m__Female__C - 176 sup18m Female C     32                        8
      2397 sup18m__Female__C - 177 sup18m Female C     32                        8
      2398 sup18m__Female__C - 178 sup18m Female C     32                        8
      2399 sup18m__Female__C - 179 sup18m Female C     32                        8
      2400 sup18m__Female__C - 180 sup18m Female C     32                        8
      2401 sup18m__Female__C - 181 sup18m Female C     33                        4
      2402 sup18m__Female__C - 182 sup18m Female C     33                        4
      2403 sup18m__Female__C - 183 sup18m Female C     33                        4
      2404 sup18m__Female__C - 184 sup18m Female C     33                        4
      2405 sup18m__Female__C - 185 sup18m Female C     34                        4
      2406 sup18m__Female__C - 186 sup18m Female C     34                        4
      2407 sup18m__Female__C - 187 sup18m Female C     34                        4
      2408 sup18m__Female__C - 188 sup18m Female C     34                        4
      2409 sup18m__Female__C - 189 sup18m Female C     35                        4
      2410 sup18m__Female__C - 190 sup18m Female C     35                        4
      2411 sup18m__Female__C - 191 sup18m Female C     35                        4
      2412 sup18m__Female__C - 192 sup18m Female C     35                        4
      2413 sup18m__Female__C - 193 sup18m Female C     36                        4
      2414 sup18m__Female__C - 194 sup18m Female C     36                        4
      2415 sup18m__Female__C - 195 sup18m Female C     36                        4
      2416 sup18m__Female__C - 196 sup18m Female C     36                        4
      2417 sup18m__Female__C - 197 sup18m Female C     37                        8
      2418 sup18m__Female__C - 198 sup18m Female C     37                        8
      2419 sup18m__Female__C - 199 sup18m Female C     37                        8
      2420 sup18m__Female__C - 200 sup18m Female C     37                        8
      2421 sup18m__Female__C - 201 sup18m Female C     37                        8
      2422 sup18m__Female__C - 202 sup18m Female C     37                        8
      2423 sup18m__Female__C - 203 sup18m Female C     37                        8
      2424 sup18m__Female__C - 204 sup18m Female C     37                        8
           treatment treatment_id  
           <fct>     <chr>         
         1 Control   Control-0001  
         2 Control   Control-0002  
         3 Treatment Treatment-0003
         4 Treatment Treatment-0004
         5 Treatment Treatment-0005
         6 Control   Control-0006  
         7 Treatment Treatment-0007
         8 Control   Control-0008  
         9 Treatment Treatment-0009
        10 Control   Control-0010  
        11 Control   Control-0011  
        12 Treatment Treatment-0012
        13 Control   Control-0013  
        14 Control   Control-0014  
        15 Control   Control-0015  
        16 Treatment Treatment-0016
        17 Control   Control-0017  
        18 Treatment Treatment-0018
        19 Treatment Treatment-0019
        20 Treatment Treatment-0020
        21 Treatment Treatment-0021
        22 Control   Control-0022  
        23 Control   Control-0023  
        24 Treatment Treatment-0024
        25 Control   Control-0025  
        26 Treatment Treatment-0026
        27 Treatment Treatment-0027
        28 Control   Control-0028  
        29 Treatment Treatment-0029
        30 Control   Control-0030  
        31 Control   Control-0031  
        32 Treatment Treatment-0032
        33 Control   Control-0033  
        34 Control   Control-0034  
        35 Treatment Treatment-0035
        36 Treatment Treatment-0036
        37 Treatment Treatment-0037
        38 Treatment Treatment-0038
        39 Control   Control-0039  
        40 Control   Control-0040  
        41 Control   Control-0041  
        42 Control   Control-0042  
        43 Treatment Treatment-0043
        44 Control   Control-0044  
        45 Treatment Treatment-0045
        46 Treatment Treatment-0046
        47 Control   Control-0047  
        48 Treatment Treatment-0048
        49 Treatment Treatment-0049
        50 Control   Control-0050  
        51 Treatment Treatment-0051
        52 Control   Control-0052  
        53 Control   Control-0053  
        54 Treatment Treatment-0054
        55 Control   Control-0055  
        56 Treatment Treatment-0056
        57 Control   Control-0057  
        58 Treatment Treatment-0058
        59 Treatment Treatment-0059
        60 Control   Control-0060  
        61 Treatment Treatment-0061
        62 Treatment Treatment-0062
        63 Control   Control-0063  
        64 Control   Control-0064  
        65 Control   Control-0065  
        66 Treatment Treatment-0066
        67 Treatment Treatment-0067
        68 Control   Control-0068  
        69 Treatment Treatment-0069
        70 Control   Control-0070  
        71 Control   Control-0071  
        72 Treatment Treatment-0072
        73 Treatment Treatment-0073
        74 Treatment Treatment-0074
        75 Control   Control-0075  
        76 Control   Control-0076  
        77 Control   Control-0077  
        78 Control   Control-0078  
        79 Treatment Treatment-0079
        80 Treatment Treatment-0080
        81 Control   Control-0081  
        82 Control   Control-0082  
        83 Treatment Treatment-0083
        84 Treatment Treatment-0084
        85 Control   Control-0085  
        86 Treatment Treatment-0086
        87 Treatment Treatment-0087
        88 Treatment Treatment-0088
        89 Control   Control-0089  
        90 Treatment Treatment-0090
        91 Control   Control-0091  
        92 Control   Control-0092  
        93 Control   Control-0093  
        94 Control   Control-0094  
        95 Control   Control-0095  
        96 Treatment Treatment-0096
        97 Treatment Treatment-0097
        98 Control   Control-0098  
        99 Treatment Treatment-0099
       100 Treatment Treatment-0100
       101 Control   Control-0101  
       102 Control   Control-0102  
       103 Treatment Treatment-0103
       104 Treatment Treatment-0104
       105 Control   Control-0105  
       106 Treatment Treatment-0106
       107 Treatment Treatment-0107
       108 Control   Control-0108  
       109 Control   Control-0109  
       110 Treatment Treatment-0110
       111 Control   Control-0111  
       112 Control   Control-0112  
       113 Treatment Treatment-0113
       114 Treatment Treatment-0114
       115 Control   Control-0115  
       116 Treatment Treatment-0116
       117 Control   Control-0117  
       118 Treatment Treatment-0118
       119 Control   Control-0119  
       120 Control   Control-0120  
       121 Treatment Treatment-0121
       122 Treatment Treatment-0122
       123 Treatment Treatment-0123
       124 Control   Control-0124  
       125 Treatment Treatment-0125
       126 Control   Control-0126  
       127 Treatment Treatment-0127
       128 Treatment Treatment-0128
       129 Control   Control-0129  
       130 Control   Control-0130  
       131 Control   Control-0131  
       132 Treatment Treatment-0132
       133 Control   Control-0133  
       134 Control   Control-0134  
       135 Treatment Treatment-0135
       136 Treatment Treatment-0136
       137 Treatment Treatment-0137
       138 Control   Control-0138  
       139 Treatment Treatment-0139
       140 Control   Control-0140  
       141 Treatment Treatment-0141
       142 Control   Control-0142  
       143 Treatment Treatment-0143
       144 Control   Control-0144  
       145 Treatment Treatment-0145
       146 Control   Control-0146  
       147 Control   Control-0147  
       148 Treatment Treatment-0148
       149 Treatment Treatment-0149
       150 Treatment Treatment-0150
       151 Control   Control-0151  
       152 Control   Control-0152  
       153 Control   Control-0153  
       154 Control   Control-0154  
       155 Treatment Treatment-0155
       156 Control   Control-0156  
       157 Treatment Treatment-0157
       158 Treatment Treatment-0158
       159 Treatment Treatment-0159
       160 Control   Control-0160  
       161 Control   Control-0161  
       162 Control   Control-0162  
       163 Treatment Treatment-0163
       164 Treatment Treatment-0164
       165 Treatment Treatment-0165
       166 Control   Control-0166  
       167 Treatment Treatment-0167
       168 Control   Control-0168  
       169 Treatment Treatment-0169
       170 Control   Control-0170  
       171 Treatment Treatment-0171
       172 Control   Control-0172  
       173 Treatment Treatment-0173
       174 Control   Control-0174  
       175 Control   Control-0175  
       176 Treatment Treatment-0176
       177 Treatment Treatment-0177
       178 Treatment Treatment-0178
       179 Control   Control-0179  
       180 Control   Control-0180  
       181 Control   Control-0181  
       182 Treatment Treatment-0182
       183 Treatment Treatment-0183
       184 Control   Control-0184  
       185 Control   Control-0185  
       186 Control   Control-0186  
       187 Treatment Treatment-0187
       188 Treatment Treatment-0188
       189 Treatment Treatment-0189
       190 Control   Control-0190  
       191 Control   Control-0191  
       192 Control   Control-0192  
       193 Treatment Treatment-0193
       194 Treatment Treatment-0194
       195 Treatment Treatment-0195
       196 Control   Control-0196  
       197 Control   Control-0197  
       198 Treatment Treatment-0198
       199 Treatment Treatment-0199
       200 Control   Control-0200  
       201 Control   Control-0201  
       202 Treatment Treatment-0202
       203 Treatment Treatment-0203
       204 Treatment Treatment-0204
       205 Treatment Treatment-0205
       206 Control   Control-0206  
       207 Control   Control-0207  
       208 Control   Control-0208  
       209 Control   Control-0209  
       210 Treatment Treatment-0210
       211 Treatment Treatment-0211
       212 Control   Control-0212  
       213 Control   Control-0213  
       214 Treatment Treatment-0214
       215 Treatment Treatment-0215
       216 Control   Control-0216  
       217 Treatment Treatment-0217
       218 Control   Control-0218  
       219 Treatment Treatment-0219
       220 Control   Control-0220  
       221 Treatment Treatment-0221
       222 Treatment Treatment-0222
       223 Control   Control-0223  
       224 Control   Control-0224  
       225 Treatment Treatment-0225
       226 Treatment Treatment-0226
       227 Treatment Treatment-0227
       228 Control   Control-0228  
       229 Control   Control-0229  
       230 Treatment Treatment-0230
       231 Control   Control-0231  
       232 Control   Control-0232  
       233 Control   Control-0233  
       234 Control   Control-0234  
       235 Treatment Treatment-0235
       236 Treatment Treatment-0236
       237 Treatment Treatment-0237
       238 Control   Control-0238  
       239 Treatment Treatment-0239
       240 Control   Control-0240  
       241 Control   Control-0241  
       242 Treatment Treatment-0242
       243 Treatment Treatment-0243
       244 Control   Control-0244  
       245 Control   Control-0245  
       246 Control   Control-0246  
       247 Treatment Treatment-0247
       248 Treatment Treatment-0248
       249 Treatment Treatment-0249
       250 Treatment Treatment-0250
       251 Control   Control-0251  
       252 Control   Control-0252  
       253 Control   Control-0253  
       254 Control   Control-0254  
       255 Treatment Treatment-0255
       256 Treatment Treatment-0256
       257 Treatment Treatment-0257
       258 Control   Control-0258  
       259 Treatment Treatment-0259
       260 Control   Control-0260  
       261 Treatment Treatment-0261
       262 Control   Control-0262  
       263 Control   Control-0263  
       264 Treatment Treatment-0264
       265 Control   Control-0265  
       266 Treatment Treatment-0266
       267 Control   Control-0267  
       268 Control   Control-0268  
       269 Treatment Treatment-0269
       270 Treatment Treatment-0270
       271 Treatment Treatment-0271
       272 Control   Control-0272  
       273 Control   Control-0273  
       274 Control   Control-0274  
       275 Treatment Treatment-0275
       276 Treatment Treatment-0276
       277 Control   Control-0277  
       278 Treatment Treatment-0278
       279 Treatment Treatment-0279
       280 Control   Control-0280  
       281 Control   Control-0281  
       282 Treatment Treatment-0282
       283 Treatment Treatment-0283
       284 Control   Control-0284  
       285 Treatment Treatment-0285
       286 Treatment Treatment-0286
       287 Control   Control-0287  
       288 Treatment Treatment-0288
       289 Treatment Treatment-0289
       290 Control   Control-0290  
       291 Control   Control-0291  
       292 Control   Control-0292  
       293 Control   Control-0293  
       294 Treatment Treatment-0294
       295 Treatment Treatment-0295
       296 Treatment Treatment-0296
       297 Treatment Treatment-0297
       298 Control   Control-0298  
       299 Control   Control-0299  
       300 Control   Control-0300  
       301 Control   Control-0301  
       302 Treatment Treatment-0302
       303 Treatment Treatment-0303
       304 Control   Control-0304  
       305 Control   Control-0305  
       306 Treatment Treatment-0306
       307 Treatment Treatment-0307
       308 Control   Control-0308  
       309 Treatment Treatment-0309
       310 Control   Control-0310  
       311 Treatment Treatment-0311
       312 Control   Control-0312  
       313 Control   Control-0313  
       314 Treatment Treatment-0314
       315 Control   Control-0315  
       316 Treatment Treatment-0316
       317 Control   Control-0317  
       318 Treatment Treatment-0318
       319 Treatment Treatment-0319
       320 Control   Control-0320  
       321 Control   Control-0321  
       322 Treatment Treatment-0322
       323 Treatment Treatment-0323
       324 Control   Control-0324  
       325 Control   Control-0325  
       326 Treatment Treatment-0326
       327 Treatment Treatment-0327
       328 Control   Control-0328  
       329 Treatment Treatment-0329
       330 Control   Control-0330  
       331 Treatment Treatment-0331
       332 Control   Control-0332  
       333 Control   Control-0333  
       334 Treatment Treatment-0334
       335 Treatment Treatment-0335
       336 Control   Control-0336  
       337 Treatment Treatment-0337
       338 Control   Control-0338  
       339 Treatment Treatment-0339
       340 Control   Control-0340  
       341 Control   Control-0341  
       342 Treatment Treatment-0342
       343 Treatment Treatment-0343
       344 Control   Control-0344  
       345 Control   Control-0345  
       346 Control   Control-0346  
       347 Treatment Treatment-0347
       348 Treatment Treatment-0348
       349 Treatment Treatment-0349
       350 Control   Control-0350  
       351 Control   Control-0351  
       352 Treatment Treatment-0352
       353 Control   Control-0353  
       354 Treatment Treatment-0354
       355 Control   Control-0355  
       356 Treatment Treatment-0356
       357 Treatment Treatment-0357
       358 Control   Control-0358  
       359 Treatment Treatment-0359
       360 Control   Control-0360  
       361 Control   Control-0361  
       362 Treatment Treatment-0362
       363 Control   Control-0363  
       364 Treatment Treatment-0364
       365 Treatment Treatment-0365
       366 Treatment Treatment-0366
       367 Control   Control-0367  
       368 Control   Control-0368  
       369 Control   Control-0369  
       370 Control   Control-0370  
       371 Treatment Treatment-0371
       372 Treatment Treatment-0372
       373 Treatment Treatment-0373
       374 Treatment Treatment-0374
       375 Control   Control-0375  
       376 Control   Control-0376  
       377 Treatment Treatment-0377
       378 Control   Control-0378  
       379 Treatment Treatment-0379
       380 Control   Control-0380  
       381 Treatment Treatment-0381
       382 Control   Control-0382  
       383 Control   Control-0383  
       384 Treatment Treatment-0384
       385 Control   Control-0385  
       386 Control   Control-0386  
       387 Treatment Treatment-0387
       388 Treatment Treatment-0388
       389 Control   Control-0389  
       390 Treatment Treatment-0390
       391 Treatment Treatment-0391
       392 Control   Control-0392  
       393 Control   Control-0393  
       394 Control   Control-0394  
       395 Treatment Treatment-0395
       396 Treatment Treatment-0396
       397 Control   Control-0397  
       398 Treatment Treatment-0398
       399 Treatment Treatment-0399
       400 Control   Control-0400  
       401 Control   Control-0401  
       402 Treatment Treatment-0402
       403 Treatment Treatment-0403
       404 Control   Control-0404  
       405 Control   Control-0405  
       406 Treatment Treatment-0406
       407 Treatment Treatment-0407
       408 Control   Control-0408  
       409 Treatment Treatment-0409
       410 Control   Control-0410  
       411 Treatment Treatment-0411
       412 Control   Control-0412  
       413 Control   Control-0413  
       414 Treatment Treatment-0414
       415 Treatment Treatment-0415
       416 Control   Control-0416  
       417 Control   Control-0417  
       418 Treatment Treatment-0418
       419 Treatment Treatment-0419
       420 Control   Control-0420  
       421 Control   Control-0421  
       422 Treatment Treatment-0422
       423 Treatment Treatment-0423
       424 Control   Control-0424  
       425 Control   Control-0425  
       426 Treatment Treatment-0426
       427 Treatment Treatment-0427
       428 Control   Control-0428  
       429 Control   Control-0429  
       430 Treatment Treatment-0430
       431 Control   Control-0431  
       432 Treatment Treatment-0432
       433 Control   Control-0433  
       434 Treatment Treatment-0434
       435 Treatment Treatment-0435
       436 Control   Control-0436  
       437 Control   Control-0437  
       438 Treatment Treatment-0438
       439 Control   Control-0439  
       440 Treatment Treatment-0440
       441 Treatment Treatment-0441
       442 Treatment Treatment-0442
       443 Treatment Treatment-0443
       444 Control   Control-0444  
       445 Control   Control-0445  
       446 Treatment Treatment-0446
       447 Control   Control-0447  
       448 Control   Control-0448  
       449 Treatment Treatment-0449
       450 Control   Control-0450  
       451 Treatment Treatment-0451
       452 Control   Control-0452  
       453 Control   Control-0453  
       454 Control   Control-0454  
       455 Treatment Treatment-0455
       456 Control   Control-0456  
       457 Treatment Treatment-0457
       458 Control   Control-0458  
       459 Treatment Treatment-0459
       460 Treatment Treatment-0460
       461 Control   Control-0461  
       462 Treatment Treatment-0462
       463 Control   Control-0463  
       464 Treatment Treatment-0464
       465 Treatment Treatment-0465
       466 Treatment Treatment-0466
       467 Control   Control-0467  
       468 Control   Control-0468  
       469 Control   Control-0469  
       470 Control   Control-0470  
       471 Control   Control-0471  
       472 Control   Control-0472  
       473 Treatment Treatment-0473
       474 Treatment Treatment-0474
       475 Treatment Treatment-0475
       476 Treatment Treatment-0476
       477 Treatment Treatment-0477
       478 Treatment Treatment-0478
       479 Control   Control-0479  
       480 Control   Control-0480  
       481 Treatment Treatment-0481
       482 Treatment Treatment-0482
       483 Treatment Treatment-0483
       484 Control   Control-0484  
       485 Control   Control-0485  
       486 Control   Control-0486  
       487 Treatment Treatment-0487
       488 Control   Control-0488  
       489 Treatment Treatment-0489
       490 Control   Control-0490  
       491 Control   Control-0491  
       492 Treatment Treatment-0492
       493 Control   Control-0493  
       494 Treatment Treatment-0494
       495 Treatment Treatment-0495
       496 Control   Control-0496  
       497 Treatment Treatment-0497
       498 Treatment Treatment-0498
       499 Control   Control-0499  
       500 Control   Control-0500  
       501 Control   Control-0501  
       502 Treatment Treatment-0502
       503 Control   Control-0503  
       504 Treatment Treatment-0504
       505 Control   Control-0505  
       506 Control   Control-0506  
       507 Treatment Treatment-0507
       508 Treatment Treatment-0508
       509 Control   Control-0509  
       510 Control   Control-0510  
       511 Control   Control-0511  
       512 Treatment Treatment-0512
       513 Treatment Treatment-0513
       514 Treatment Treatment-0514
       515 Treatment Treatment-0515
       516 Control   Control-0516  
       517 Control   Control-0517  
       518 Treatment Treatment-0518
       519 Control   Control-0519  
       520 Control   Control-0520  
       521 Treatment Treatment-0521
       522 Treatment Treatment-0522
       523 Control   Control-0523  
       524 Treatment Treatment-0524
       525 Treatment Treatment-0525
       526 Control   Control-0526  
       527 Treatment Treatment-0527
       528 Control   Control-0528  
       529 Treatment Treatment-0529
       530 Treatment Treatment-0530
       531 Control   Control-0531  
       532 Control   Control-0532  
       533 Treatment Treatment-0533
       534 Treatment Treatment-0534
       535 Control   Control-0535  
       536 Control   Control-0536  
       537 Treatment Treatment-0537
       538 Control   Control-0538  
       539 Control   Control-0539  
       540 Control   Control-0540  
       541 Control   Control-0541  
       542 Treatment Treatment-0542
       543 Treatment Treatment-0543
       544 Treatment Treatment-0544
       545 Treatment Treatment-0545
       546 Control   Control-0546  
       547 Treatment Treatment-0547
       548 Control   Control-0548  
       549 Control   Control-0549  
       550 Treatment Treatment-0550
       551 Control   Control-0551  
       552 Treatment Treatment-0552
       553 Control   Control-0553  
       554 Treatment Treatment-0554
       555 Control   Control-0555  
       556 Treatment Treatment-0556
       557 Treatment Treatment-0557
       558 Control   Control-0558  
       559 Treatment Treatment-0559
       560 Treatment Treatment-0560
       561 Control   Control-0561  
       562 Control   Control-0562  
       563 Control   Control-0563  
       564 Treatment Treatment-0564
       565 Treatment Treatment-0565
       566 Control   Control-0566  
       567 Control   Control-0567  
       568 Treatment Treatment-0568
       569 Treatment Treatment-0569
       570 Treatment Treatment-0570
       571 Control   Control-0571  
       572 Control   Control-0572  
       573 Treatment Treatment-0573
       574 Treatment Treatment-0574
       575 Control   Control-0575  
       576 Treatment Treatment-0576
       577 Control   Control-0577  
       578 Control   Control-0578  
       579 Control   Control-0579  
       580 Treatment Treatment-0580
       581 Treatment Treatment-0581
       582 Control   Control-0582  
       583 Control   Control-0583  
       584 Treatment Treatment-0584
       585 Treatment Treatment-0585
       586 Control   Control-0586  
       587 Treatment Treatment-0587
       588 Control   Control-0588  
       589 Control   Control-0589  
       590 Control   Control-0590  
       591 Treatment Treatment-0591
       592 Treatment Treatment-0592
       593 Treatment Treatment-0593
       594 Control   Control-0594  
       595 Control   Control-0595  
       596 Treatment Treatment-0596
       597 Treatment Treatment-0597
       598 Control   Control-0598  
       599 Treatment Treatment-0599
       600 Control   Control-0600  
       601 Treatment Treatment-0601
       602 Control   Control-0602  
       603 Treatment Treatment-0603
       604 Control   Control-0604  
       605 Control   Control-0605  
       606 Control   Control-0606  
       607 Treatment Treatment-0607
       608 Treatment Treatment-0608
       609 Treatment Treatment-0609
       610 Control   Control-0610  
       611 Control   Control-0611  
       612 Treatment Treatment-0612
       613 Control   Control-0613  
       614 Treatment Treatment-0614
       615 Control   Control-0615  
       616 Treatment Treatment-0616
       617 Treatment Treatment-0617
       618 Control   Control-0618  
       619 Treatment Treatment-0619
       620 Control   Control-0620  
       621 Control   Control-0621  
       622 Control   Control-0622  
       623 Treatment Treatment-0623
       624 Treatment Treatment-0624
       625 Treatment Treatment-0625
       626 Treatment Treatment-0626
       627 Control   Control-0627  
       628 Control   Control-0628  
       629 Control   Control-0629  
       630 Treatment Treatment-0630
       631 Control   Control-0631  
       632 Treatment Treatment-0632
       633 Treatment Treatment-0633
       634 Control   Control-0634  
       635 Control   Control-0635  
       636 Treatment Treatment-0636
       637 Treatment Treatment-0637
       638 Treatment Treatment-0638
       639 Control   Control-0639  
       640 Control   Control-0640  
       641 Control   Control-0641  
       642 Treatment Treatment-0642
       643 Control   Control-0643  
       644 Treatment Treatment-0644
       645 Control   Control-0645  
       646 Treatment Treatment-0646
       647 Control   Control-0647  
       648 Treatment Treatment-0648
       649 Control   Control-0649  
       650 Treatment Treatment-0650
       651 Treatment Treatment-0651
       652 Control   Control-0652  
       653 Control   Control-0653  
       654 Treatment Treatment-0654
       655 Treatment Treatment-0655
       656 Control   Control-0656  
       657 Treatment Treatment-0657
       658 Treatment Treatment-0658
       659 Control   Control-0659  
       660 Treatment Treatment-0660
       661 Treatment Treatment-0661
       662 Control   Control-0662  
       663 Control   Control-0663  
       664 Control   Control-0664  
       665 Control   Control-0665  
       666 Treatment Treatment-0666
       667 Treatment Treatment-0667
       668 Treatment Treatment-0668
       669 Control   Control-0669  
       670 Control   Control-0670  
       671 Treatment Treatment-0671
       672 Control   Control-0672  
       673 Treatment Treatment-0673
       674 Treatment Treatment-0674
       675 Control   Control-0675  
       676 Control   Control-0676  
       677 Control   Control-0677  
       678 Treatment Treatment-0678
       679 Treatment Treatment-0679
       680 Control   Control-0680  
       681 Treatment Treatment-0681
       682 Treatment Treatment-0682
       683 Control   Control-0683  
       684 Control   Control-0684  
       685 Treatment Treatment-0685
       686 Treatment Treatment-0686
       687 Control   Control-0687  
       688 Control   Control-0688  
       689 Treatment Treatment-0689
       690 Control   Control-0690  
       691 Treatment Treatment-0691
       692 Control   Control-0692  
       693 Treatment Treatment-0693
       694 Treatment Treatment-0694
       695 Control   Control-0695  
       696 Control   Control-0696  
       697 Control   Control-0697  
       698 Treatment Treatment-0698
       699 Control   Control-0699  
       700 Treatment Treatment-0700
       701 Treatment Treatment-0701
       702 Control   Control-0702  
       703 Treatment Treatment-0703
       704 Control   Control-0704  
       705 Control   Control-0705  
       706 Control   Control-0706  
       707 Treatment Treatment-0707
       708 Treatment Treatment-0708
       709 Treatment Treatment-0709
       710 Treatment Treatment-0710
       711 Control   Control-0711  
       712 Control   Control-0712  
       713 Control   Control-0713  
       714 Control   Control-0714  
       715 Treatment Treatment-0715
       716 Treatment Treatment-0716
       717 Control   Control-0717  
       718 Treatment Treatment-0718
       719 Treatment Treatment-0719
       720 Treatment Treatment-0720
       721 Treatment Treatment-0721
       722 Control   Control-0722  
       723 Control   Control-0723  
       724 Control   Control-0724  
       725 Control   Control-0725  
       726 Treatment Treatment-0726
       727 Treatment Treatment-0727
       728 Control   Control-0728  
       729 Control   Control-0729  
       730 Treatment Treatment-0730
       731 Treatment Treatment-0731
       732 Control   Control-0732  
       733 Control   Control-0733  
       734 Control   Control-0734  
       735 Treatment Treatment-0735
       736 Treatment Treatment-0736
       737 Control   Control-0737  
       738 Treatment Treatment-0738
       739 Treatment Treatment-0739
       740 Control   Control-0740  
       741 Control   Control-0741  
       742 Treatment Treatment-0742
       743 Control   Control-0743  
       744 Treatment Treatment-0744
       745 Treatment Treatment-0745
       746 Control   Control-0746  
       747 Control   Control-0747  
       748 Treatment Treatment-0748
       749 Control   Control-0749  
       750 Treatment Treatment-0750
       751 Control   Control-0751  
       752 Treatment Treatment-0752
       753 Treatment Treatment-0753
       754 Treatment Treatment-0754
       755 Control   Control-0755  
       756 Control   Control-0756  
       757 Treatment Treatment-0757
       758 Treatment Treatment-0758
       759 Control   Control-0759  
       760 Control   Control-0760  
       761 Treatment Treatment-0761
       762 Treatment Treatment-0762
       763 Control   Control-0763  
       764 Control   Control-0764  
       765 Control   Control-0765  
       766 Control   Control-0766  
       767 Treatment Treatment-0767
       768 Treatment Treatment-0768
       769 Treatment Treatment-0769
       770 Control   Control-0770  
       771 Control   Control-0771  
       772 Treatment Treatment-0772
       773 Treatment Treatment-0773
       774 Treatment Treatment-0774
       775 Control   Control-0775  
       776 Treatment Treatment-0776
       777 Control   Control-0777  
       778 Control   Control-0778  
       779 Treatment Treatment-0779
       780 Control   Control-0780  
       781 Treatment Treatment-0781
       782 Treatment Treatment-0782
       783 Control   Control-0783  
       784 Treatment Treatment-0784
       785 Control   Control-0785  
       786 Control   Control-0786  
       787 Control   Control-0787  
       788 Treatment Treatment-0788
       789 Treatment Treatment-0789
       790 Control   Control-0790  
       791 Treatment Treatment-0791
       792 Control   Control-0792  
       793 Control   Control-0793  
       794 Control   Control-0794  
       795 Treatment Treatment-0795
       796 Treatment Treatment-0796
       797 Treatment Treatment-0797
       798 Control   Control-0798  
       799 Control   Control-0799  
       800 Treatment Treatment-0800
       801 Control   Control-0801  
       802 Treatment Treatment-0802
       803 Treatment Treatment-0803
       804 Control   Control-0804  
       805 Control   Control-0805  
       806 Treatment Treatment-0806
       807 Treatment Treatment-0807
       808 Control   Control-0808  
       809 Control   Control-0809  
       810 Treatment Treatment-0810
       811 Control   Control-0811  
       812 Treatment Treatment-0812
       813 Treatment Treatment-0813
       814 Control   Control-0814  
       815 Treatment Treatment-0815
       816 Treatment Treatment-0816
       817 Control   Control-0817  
       818 Control   Control-0818  
       819 Control   Control-0819  
       820 Treatment Treatment-0820
       821 Treatment Treatment-0821
       822 Control   Control-0822  
       823 Control   Control-0823  
       824 Control   Control-0824  
       825 Treatment Treatment-0825
       826 Treatment Treatment-0826
       827 Control   Control-0827  
       828 Treatment Treatment-0828
       829 Control   Control-0829  
       830 Treatment Treatment-0830
       831 Treatment Treatment-0831
       832 Control   Control-0832  
       833 Treatment Treatment-0833
       834 Control   Control-0834  
       835 Treatment Treatment-0835
       836 Control   Control-0836  
       837 Treatment Treatment-0837
       838 Control   Control-0838  
       839 Treatment Treatment-0839
       840 Control   Control-0840  
       841 Control   Control-0841  
       842 Treatment Treatment-0842
       843 Control   Control-0843  
       844 Treatment Treatment-0844
       845 Treatment Treatment-0845
       846 Treatment Treatment-0846
       847 Treatment Treatment-0847
       848 Control   Control-0848  
       849 Control   Control-0849  
       850 Control   Control-0850  
       851 Treatment Treatment-0851
       852 Control   Control-0852  
       853 Treatment Treatment-0853
       854 Control   Control-0854  
       855 Control   Control-0855  
       856 Control   Control-0856  
       857 Treatment Treatment-0857
       858 Control   Control-0858  
       859 Treatment Treatment-0859
       860 Treatment Treatment-0860
       861 Control   Control-0861  
       862 Treatment Treatment-0862
       863 Treatment Treatment-0863
       864 Control   Control-0864  
       865 Control   Control-0865  
       866 Treatment Treatment-0866
       867 Treatment Treatment-0867
       868 Control   Control-0868  
       869 Treatment Treatment-0869
       870 Control   Control-0870  
       871 Treatment Treatment-0871
       872 Control   Control-0872  
       873 Control   Control-0873  
       874 Treatment Treatment-0874
       875 Treatment Treatment-0875
       876 Control   Control-0876  
       877 Treatment Treatment-0877
       878 Control   Control-0878  
       879 Control   Control-0879  
       880 Treatment Treatment-0880
       881 Treatment Treatment-0881
       882 Control   Control-0882  
       883 Treatment Treatment-0883
       884 Control   Control-0884  
       885 Treatment Treatment-0885
       886 Control   Control-0886  
       887 Treatment Treatment-0887
       888 Control   Control-0888  
       889 Control   Control-0889  
       890 Treatment Treatment-0890
       891 Control   Control-0891  
       892 Treatment Treatment-0892
       893 Treatment Treatment-0893
       894 Control   Control-0894  
       895 Control   Control-0895  
       896 Control   Control-0896  
       897 Control   Control-0897  
       898 Treatment Treatment-0898
       899 Treatment Treatment-0899
       900 Treatment Treatment-0900
       901 Treatment Treatment-0901
       902 Treatment Treatment-0902
       903 Control   Control-0903  
       904 Control   Control-0904  
       905 Control   Control-0905  
       906 Treatment Treatment-0906
       907 Control   Control-0907  
       908 Treatment Treatment-0908
       909 Control   Control-0909  
       910 Treatment Treatment-0910
       911 Treatment Treatment-0911
       912 Control   Control-0912  
       913 Treatment Treatment-0913
       914 Control   Control-0914  
       915 Treatment Treatment-0915
       916 Control   Control-0916  
       917 Treatment Treatment-0917
       918 Treatment Treatment-0918
       919 Control   Control-0919  
       920 Control   Control-0920  
       921 Treatment Treatment-0921
       922 Control   Control-0922  
       923 Control   Control-0923  
       924 Treatment Treatment-0924
       925 Treatment Treatment-0925
       926 Control   Control-0926  
       927 Control   Control-0927  
       928 Treatment Treatment-0928
       929 Control   Control-0929  
       930 Treatment Treatment-0930
       931 Control   Control-0931  
       932 Treatment Treatment-0932
       933 Control   Control-0933  
       934 Control   Control-0934  
       935 Treatment Treatment-0935
       936 Treatment Treatment-0936
       937 Treatment Treatment-0937
       938 Treatment Treatment-0938
       939 Control   Control-0939  
       940 Control   Control-0940  
       941 Control   Control-0941  
       942 Treatment Treatment-0942
       943 Control   Control-0943  
       944 Treatment Treatment-0944
       945 Control   Control-0945  
       946 Treatment Treatment-0946
       947 Control   Control-0947  
       948 Treatment Treatment-0948
       949 Control   Control-0949  
       950 Treatment Treatment-0950
       951 Control   Control-0951  
       952 Treatment Treatment-0952
       953 Treatment Treatment-0953
       954 Control   Control-0954  
       955 Control   Control-0955  
       956 Control   Control-0956  
       957 Treatment Treatment-0957
       958 Control   Control-0958  
       959 Treatment Treatment-0959
       960 Treatment Treatment-0960
       961 Treatment Treatment-0961
       962 Treatment Treatment-0962
       963 Control   Control-0963  
       964 Control   Control-0964  
       965 Control   Control-0965  
       966 Treatment Treatment-0966
       967 Treatment Treatment-0967
       968 Control   Control-0968  
       969 Control   Control-0969  
       970 Control   Control-0970  
       971 Control   Control-0971  
       972 Treatment Treatment-0972
       973 Control   Control-0973  
       974 Treatment Treatment-0974
       975 Treatment Treatment-0975
       976 Treatment Treatment-0976
       977 Treatment Treatment-0977
       978 Control   Control-0978  
       979 Control   Control-0979  
       980 Treatment Treatment-0980
       981 Control   Control-0981  
       982 Control   Control-0982  
       983 Treatment Treatment-0983
       984 Treatment Treatment-0984
       985 Treatment Treatment-0985
       986 Treatment Treatment-0986
       987 Control   Control-0987  
       988 Control   Control-0988  
       989 Control   Control-0989  
       990 Treatment Treatment-0990
       991 Treatment Treatment-0991
       992 Control   Control-0992  
       993 Treatment Treatment-0993
       994 Treatment Treatment-0994
       995 Control   Control-0995  
       996 Control   Control-0996  
       997 Treatment Treatment-0997
       998 Control   Control-0998  
       999 Treatment Treatment-0999
      1000 Control   Control-1000  
      1001 Control   Control-1001  
      1002 Control   Control-1002  
      1003 Treatment Treatment-1003
      1004 Treatment Treatment-1004
      1005 Control   Control-1005  
      1006 Control   Control-1006  
      1007 Treatment Treatment-1007
      1008 Treatment Treatment-1008
      1009 Control   Control-1009  
      1010 Treatment Treatment-1010
      1011 Treatment Treatment-1011
      1012 Control   Control-1012  
      1013 Control   Control-1013  
      1014 Treatment Treatment-1014
      1015 Treatment Treatment-1015
      1016 Control   Control-1016  
      1017 Control   Control-1017  
      1018 Treatment Treatment-1018
      1019 Control   Control-1019  
      1020 Treatment Treatment-1020
      1021 Treatment Treatment-1021
      1022 Treatment Treatment-1022
      1023 Control   Control-1023  
      1024 Control   Control-1024  
      1025 Control   Control-1025  
      1026 Control   Control-1026  
      1027 Control   Control-1027  
      1028 Control   Control-1028  
      1029 Treatment Treatment-1029
      1030 Treatment Treatment-1030
      1031 Treatment Treatment-1031
      1032 Treatment Treatment-1032
      1033 Control   Control-1033  
      1034 Treatment Treatment-1034
      1035 Treatment Treatment-1035
      1036 Control   Control-1036  
      1037 Control   Control-1037  
      1038 Control   Control-1038  
      1039 Treatment Treatment-1039
      1040 Treatment Treatment-1040
      1041 Treatment Treatment-1041
      1042 Treatment Treatment-1042
      1043 Control   Control-1043  
      1044 Control   Control-1044  
      1045 Control   Control-1045  
      1046 Control   Control-1046  
      1047 Treatment Treatment-1047
      1048 Treatment Treatment-1048
      1049 Control   Control-1049  
      1050 Treatment Treatment-1050
      1051 Control   Control-1051  
      1052 Treatment Treatment-1052
      1053 Control   Control-1053  
      1054 Control   Control-1054  
      1055 Treatment Treatment-1055
      1056 Treatment Treatment-1056
      1057 Treatment Treatment-1057
      1058 Treatment Treatment-1058
      1059 Control   Control-1059  
      1060 Control   Control-1060  
      1061 Control   Control-1061  
      1062 Treatment Treatment-1062
      1063 Control   Control-1063  
      1064 Control   Control-1064  
      1065 Treatment Treatment-1065
      1066 Treatment Treatment-1066
      1067 Control   Control-1067  
      1068 Treatment Treatment-1068
      1069 Treatment Treatment-1069
      1070 Treatment Treatment-1070
      1071 Treatment Treatment-1071
      1072 Control   Control-1072  
      1073 Treatment Treatment-1073
      1074 Control   Control-1074  
      1075 Control   Control-1075  
      1076 Control   Control-1076  
      1077 Treatment Treatment-1077
      1078 Treatment Treatment-1078
      1079 Control   Control-1079  
      1080 Control   Control-1080  
      1081 Control   Control-1081  
      1082 Treatment Treatment-1082
      1083 Control   Control-1083  
      1084 Treatment Treatment-1084
      1085 Control   Control-1085  
      1086 Control   Control-1086  
      1087 Treatment Treatment-1087
      1088 Treatment Treatment-1088
      1089 Treatment Treatment-1089
      1090 Treatment Treatment-1090
      1091 Control   Control-1091  
      1092 Control   Control-1092  
      1093 Treatment Treatment-1093
      1094 Control   Control-1094  
      1095 Control   Control-1095  
      1096 Treatment Treatment-1096
      1097 Treatment Treatment-1097
      1098 Control   Control-1098  
      1099 Treatment Treatment-1099
      1100 Control   Control-1100  
      1101 Control   Control-1101  
      1102 Treatment Treatment-1102
      1103 Control   Control-1103  
      1104 Treatment Treatment-1104
      1105 Treatment Treatment-1105
      1106 Control   Control-1106  
      1107 Treatment Treatment-1107
      1108 Control   Control-1108  
      1109 Control   Control-1109  
      1110 Treatment Treatment-1110
      1111 Control   Control-1111  
      1112 Treatment Treatment-1112
      1113 Control   Control-1113  
      1114 Control   Control-1114  
      1115 Treatment Treatment-1115
      1116 Treatment Treatment-1116
      1117 Treatment Treatment-1117
      1118 Control   Control-1118  
      1119 Control   Control-1119  
      1120 Treatment Treatment-1120
      1121 Control   Control-1121  
      1122 Treatment Treatment-1122
      1123 Control   Control-1123  
      1124 Treatment Treatment-1124
      1125 Control   Control-1125  
      1126 Control   Control-1126  
      1127 Treatment Treatment-1127
      1128 Control   Control-1128  
      1129 Treatment Treatment-1129
      1130 Control   Control-1130  
      1131 Treatment Treatment-1131
      1132 Treatment Treatment-1132
      1133 Treatment Treatment-1133
      1134 Control   Control-1134  
      1135 Control   Control-1135  
      1136 Treatment Treatment-1136
      1137 Treatment Treatment-1137
      1138 Control   Control-1138  
      1139 Control   Control-1139  
      1140 Treatment Treatment-1140
      1141 Treatment Treatment-1141
      1142 Treatment Treatment-1142
      1143 Control   Control-1143  
      1144 Treatment Treatment-1144
      1145 Control   Control-1145  
      1146 Control   Control-1146  
      1147 Treatment Treatment-1147
      1148 Control   Control-1148  
      1149 Control   Control-1149  
      1150 Control   Control-1150  
      1151 Treatment Treatment-1151
      1152 Treatment Treatment-1152
      1153 Control   Control-1153  
      1154 Treatment Treatment-1154
      1155 Control   Control-1155  
      1156 Treatment Treatment-1156
      1157 Control   Control-1157  
      1158 Treatment Treatment-1158
      1159 Control   Control-1159  
      1160 Treatment Treatment-1160
      1161 Control   Control-1161  
      1162 Control   Control-1162  
      1163 Treatment Treatment-1163
      1164 Treatment Treatment-1164
      1165 Treatment Treatment-1165
      1166 Treatment Treatment-1166
      1167 Control   Control-1167  
      1168 Control   Control-1168  
      1169 Control   Control-1169  
      1170 Control   Control-1170  
      1171 Treatment Treatment-1171
      1172 Treatment Treatment-1172
      1173 Control   Control-1173  
      1174 Treatment Treatment-1174
      1175 Control   Control-1175  
      1176 Treatment Treatment-1176
      1177 Treatment Treatment-1177
      1178 Treatment Treatment-1178
      1179 Control   Control-1179  
      1180 Control   Control-1180  
      1181 Treatment Treatment-1181
      1182 Control   Control-1182  
      1183 Control   Control-1183  
      1184 Treatment Treatment-1184
      1185 Treatment Treatment-1185
      1186 Control   Control-1186  
      1187 Control   Control-1187  
      1188 Treatment Treatment-1188
      1189 Control   Control-1189  
      1190 Treatment Treatment-1190
      1191 Control   Control-1191  
      1192 Treatment Treatment-1192
      1193 Treatment Treatment-1193
      1194 Treatment Treatment-1194
      1195 Control   Control-1195  
      1196 Control   Control-1196  
      1197 Control   Control-1197  
      1198 Treatment Treatment-1198
      1199 Treatment Treatment-1199
      1200 Control   Control-1200  
      1201 Control   Control-1201  
      1202 Control   Control-1202  
      1203 Treatment Treatment-1203
      1204 Treatment Treatment-1204
      1205 Treatment Treatment-1205
      1206 Control   Control-1206  
      1207 Treatment Treatment-1207
      1208 Control   Control-1208  
      1209 Control   Control-1209  
      1210 Treatment Treatment-1210
      1211 Treatment Treatment-1211
      1212 Control   Control-1212  
      1213 Treatment Treatment-1213
      1214 Control   Control-1214  
      1215 Treatment Treatment-1215
      1216 Control   Control-1216  
      1217 Treatment Treatment-1217
      1218 Control   Control-1218  
      1219 Control   Control-1219  
      1220 Control   Control-1220  
      1221 Control   Control-1221  
      1222 Treatment Treatment-1222
      1223 Treatment Treatment-1223
      1224 Treatment Treatment-1224
      1225 Control   Control-1225  
      1226 Control   Control-1226  
      1227 Treatment Treatment-1227
      1228 Treatment Treatment-1228
      1229 Treatment Treatment-1229
      1230 Treatment Treatment-1230
      1231 Control   Control-1231  
      1232 Control   Control-1232  
      1233 Treatment Treatment-1233
      1234 Control   Control-1234  
      1235 Treatment Treatment-1235
      1236 Control   Control-1236  
      1237 Treatment Treatment-1237
      1238 Control   Control-1238  
      1239 Treatment Treatment-1239
      1240 Control   Control-1240  
      1241 Treatment Treatment-1241
      1242 Treatment Treatment-1242
      1243 Control   Control-1243  
      1244 Treatment Treatment-1244
      1245 Treatment Treatment-1245
      1246 Control   Control-1246  
      1247 Control   Control-1247  
      1248 Control   Control-1248  
      1249 Control   Control-1249  
      1250 Treatment Treatment-1250
      1251 Treatment Treatment-1251
      1252 Treatment Treatment-1252
      1253 Treatment Treatment-1253
      1254 Control   Control-1254  
      1255 Control   Control-1255  
      1256 Control   Control-1256  
      1257 Control   Control-1257  
      1258 Treatment Treatment-1258
      1259 Treatment Treatment-1259
      1260 Control   Control-1260  
      1261 Treatment Treatment-1261
      1262 Control   Control-1262  
      1263 Control   Control-1263  
      1264 Treatment Treatment-1264
      1265 Control   Control-1265  
      1266 Control   Control-1266  
      1267 Treatment Treatment-1267
      1268 Treatment Treatment-1268
      1269 Treatment Treatment-1269
      1270 Treatment Treatment-1270
      1271 Control   Control-1271  
      1272 Control   Control-1272  
      1273 Control   Control-1273  
      1274 Control   Control-1274  
      1275 Treatment Treatment-1275
      1276 Treatment Treatment-1276
      1277 Treatment Treatment-1277
      1278 Control   Control-1278  
      1279 Control   Control-1279  
      1280 Treatment Treatment-1280
      1281 Control   Control-1281  
      1282 Treatment Treatment-1282
      1283 Treatment Treatment-1283
      1284 Treatment Treatment-1284
      1285 Treatment Treatment-1285
      1286 Control   Control-1286  
      1287 Control   Control-1287  
      1288 Control   Control-1288  
      1289 Control   Control-1289  
      1290 Control   Control-1290  
      1291 Treatment Treatment-1291
      1292 Treatment Treatment-1292
      1293 Treatment Treatment-1293
      1294 Control   Control-1294  
      1295 Control   Control-1295  
      1296 Treatment Treatment-1296
      1297 Control   Control-1297  
      1298 Control   Control-1298  
      1299 Treatment Treatment-1299
      1300 Treatment Treatment-1300
      1301 Control   Control-1301  
      1302 Control   Control-1302  
      1303 Treatment Treatment-1303
      1304 Treatment Treatment-1304
      1305 Treatment Treatment-1305
      1306 Control   Control-1306  
      1307 Treatment Treatment-1307
      1308 Control   Control-1308  
      1309 Treatment Treatment-1309
      1310 Control   Control-1310  
      1311 Treatment Treatment-1311
      1312 Control   Control-1312  
      1313 Control   Control-1313  
      1314 Treatment Treatment-1314
      1315 Control   Control-1315  
      1316 Treatment Treatment-1316
      1317 Control   Control-1317  
      1318 Treatment Treatment-1318
      1319 Treatment Treatment-1319
      1320 Control   Control-1320  
      1321 Control   Control-1321  
      1322 Control   Control-1322  
      1323 Treatment Treatment-1323
      1324 Treatment Treatment-1324
      1325 Control   Control-1325  
      1326 Treatment Treatment-1326
      1327 Treatment Treatment-1327
      1328 Control   Control-1328  
      1329 Treatment Treatment-1329
      1330 Control   Control-1330  
      1331 Treatment Treatment-1331
      1332 Control   Control-1332  
      1333 Treatment Treatment-1333
      1334 Control   Control-1334  
      1335 Control   Control-1335  
      1336 Treatment Treatment-1336
      1337 Treatment Treatment-1337
      1338 Control   Control-1338  
      1339 Treatment Treatment-1339
      1340 Control   Control-1340  
      1341 Treatment Treatment-1341
      1342 Treatment Treatment-1342
      1343 Treatment Treatment-1343
      1344 Control   Control-1344  
      1345 Treatment Treatment-1345
      1346 Control   Control-1346  
      1347 Control   Control-1347  
      1348 Control   Control-1348  
      1349 Treatment Treatment-1349
      1350 Treatment Treatment-1350
      1351 Control   Control-1351  
      1352 Control   Control-1352  
      1353 Control   Control-1353  
      1354 Treatment Treatment-1354
      1355 Control   Control-1355  
      1356 Treatment Treatment-1356
      1357 Control   Control-1357  
      1358 Control   Control-1358  
      1359 Treatment Treatment-1359
      1360 Treatment Treatment-1360
      1361 Control   Control-1361  
      1362 Treatment Treatment-1362
      1363 Treatment Treatment-1363
      1364 Control   Control-1364  
      1365 Control   Control-1365  
      1366 Control   Control-1366  
      1367 Control   Control-1367  
      1368 Treatment Treatment-1368
      1369 Control   Control-1369  
      1370 Treatment Treatment-1370
      1371 Treatment Treatment-1371
      1372 Treatment Treatment-1372
      1373 Treatment Treatment-1373
      1374 Treatment Treatment-1374
      1375 Control   Control-1375  
      1376 Control   Control-1376  
      1377 Control   Control-1377  
      1378 Treatment Treatment-1378
      1379 Control   Control-1379  
      1380 Control   Control-1380  
      1381 Treatment Treatment-1381
      1382 Control   Control-1382  
      1383 Treatment Treatment-1383
      1384 Treatment Treatment-1384
      1385 Treatment Treatment-1385
      1386 Treatment Treatment-1386
      1387 Control   Control-1387  
      1388 Treatment Treatment-1388
      1389 Control   Control-1389  
      1390 Control   Control-1390  
      1391 Control   Control-1391  
      1392 Treatment Treatment-1392
      1393 Control   Control-1393  
      1394 Treatment Treatment-1394
      1395 Treatment Treatment-1395
      1396 Control   Control-1396  
      1397 Treatment Treatment-1397
      1398 Treatment Treatment-1398
      1399 Control   Control-1399  
      1400 Treatment Treatment-1400
      1401 Control   Control-1401  
      1402 Control   Control-1402  
      1403 Treatment Treatment-1403
      1404 Control   Control-1404  
      1405 Control   Control-1405  
      1406 Control   Control-1406  
      1407 Treatment Treatment-1407
      1408 Treatment Treatment-1408
      1409 Control   Control-1409  
      1410 Treatment Treatment-1410
      1411 Treatment Treatment-1411
      1412 Control   Control-1412  
      1413 Treatment Treatment-1413
      1414 Treatment Treatment-1414
      1415 Treatment Treatment-1415
      1416 Treatment Treatment-1416
      1417 Control   Control-1417  
      1418 Control   Control-1418  
      1419 Control   Control-1419  
      1420 Control   Control-1420  
      1421 Control   Control-1421  
      1422 Treatment Treatment-1422
      1423 Control   Control-1423  
      1424 Treatment Treatment-1424
      1425 Treatment Treatment-1425
      1426 Control   Control-1426  
      1427 Control   Control-1427  
      1428 Treatment Treatment-1428
      1429 Treatment Treatment-1429
      1430 Treatment Treatment-1430
      1431 Control   Control-1431  
      1432 Control   Control-1432  
      1433 Treatment Treatment-1433
      1434 Treatment Treatment-1434
      1435 Treatment Treatment-1435
      1436 Control   Control-1436  
      1437 Control   Control-1437  
      1438 Control   Control-1438  
      1439 Control   Control-1439  
      1440 Treatment Treatment-1440
      1441 Treatment Treatment-1441
      1442 Control   Control-1442  
      1443 Treatment Treatment-1443
      1444 Control   Control-1444  
      1445 Treatment Treatment-1445
      1446 Control   Control-1446  
      1447 Treatment Treatment-1447
      1448 Control   Control-1448  
      1449 Control   Control-1449  
      1450 Control   Control-1450  
      1451 Treatment Treatment-1451
      1452 Treatment Treatment-1452
      1453 Treatment Treatment-1453
      1454 Treatment Treatment-1454
      1455 Treatment Treatment-1455
      1456 Treatment Treatment-1456
      1457 Control   Control-1457  
      1458 Control   Control-1458  
      1459 Control   Control-1459  
      1460 Control   Control-1460  
      1461 Control   Control-1461  
      1462 Control   Control-1462  
      1463 Treatment Treatment-1463
      1464 Treatment Treatment-1464
      1465 Control   Control-1465  
      1466 Treatment Treatment-1466
      1467 Control   Control-1467  
      1468 Treatment Treatment-1468
      1469 Treatment Treatment-1469
      1470 Treatment Treatment-1470
      1471 Control   Control-1471  
      1472 Control   Control-1472  
      1473 Control   Control-1473  
      1474 Treatment Treatment-1474
      1475 Control   Control-1475  
      1476 Treatment Treatment-1476
      1477 Control   Control-1477  
      1478 Control   Control-1478  
      1479 Treatment Treatment-1479
      1480 Treatment Treatment-1480
      1481 Treatment Treatment-1481
      1482 Treatment Treatment-1482
      1483 Control   Control-1483  
      1484 Control   Control-1484  
      1485 Control   Control-1485  
      1486 Treatment Treatment-1486
      1487 Control   Control-1487  
      1488 Treatment Treatment-1488
      1489 Treatment Treatment-1489
      1490 Control   Control-1490  
      1491 Control   Control-1491  
      1492 Treatment Treatment-1492
      1493 Treatment Treatment-1493
      1494 Treatment Treatment-1494
      1495 Control   Control-1495  
      1496 Control   Control-1496  
      1497 Control   Control-1497  
      1498 Control   Control-1498  
      1499 Treatment Treatment-1499
      1500 Treatment Treatment-1500
      1501 Control   Control-1501  
      1502 Treatment Treatment-1502
      1503 Treatment Treatment-1503
      1504 Control   Control-1504  
      1505 Treatment Treatment-1505
      1506 Treatment Treatment-1506
      1507 Control   Control-1507  
      1508 Control   Control-1508  
      1509 Treatment Treatment-1509
      1510 Treatment Treatment-1510
      1511 Control   Control-1511  
      1512 Control   Control-1512  
      1513 Control   Control-1513  
      1514 Control   Control-1514  
      1515 Treatment Treatment-1515
      1516 Treatment Treatment-1516
      1517 Control   Control-1517  
      1518 Treatment Treatment-1518
      1519 Treatment Treatment-1519
      1520 Control   Control-1520  
      1521 Control   Control-1521  
      1522 Treatment Treatment-1522
      1523 Control   Control-1523  
      1524 Control   Control-1524  
      1525 Treatment Treatment-1525
      1526 Control   Control-1526  
      1527 Treatment Treatment-1527
      1528 Treatment Treatment-1528
      1529 Control   Control-1529  
      1530 Treatment Treatment-1530
      1531 Control   Control-1531  
      1532 Treatment Treatment-1532
      1533 Treatment Treatment-1533
      1534 Control   Control-1534  
      1535 Control   Control-1535  
      1536 Treatment Treatment-1536
      1537 Treatment Treatment-1537
      1538 Control   Control-1538  
      1539 Treatment Treatment-1539
      1540 Control   Control-1540  
      1541 Treatment Treatment-1541
      1542 Control   Control-1542  
      1543 Control   Control-1543  
      1544 Treatment Treatment-1544
      1545 Treatment Treatment-1545
      1546 Treatment Treatment-1546
      1547 Treatment Treatment-1547
      1548 Control   Control-1548  
      1549 Treatment Treatment-1549
      1550 Control   Control-1550  
      1551 Control   Control-1551  
      1552 Control   Control-1552  
      1553 Control   Control-1553  
      1554 Control   Control-1554  
      1555 Treatment Treatment-1555
      1556 Control   Control-1556  
      1557 Control   Control-1557  
      1558 Treatment Treatment-1558
      1559 Treatment Treatment-1559
      1560 Treatment Treatment-1560
      1561 Control   Control-1561  
      1562 Treatment Treatment-1562
      1563 Treatment Treatment-1563
      1564 Control   Control-1564  
      1565 Treatment Treatment-1565
      1566 Control   Control-1566  
      1567 Treatment Treatment-1567
      1568 Control   Control-1568  
      1569 Control   Control-1569  
      1570 Treatment Treatment-1570
      1571 Control   Control-1571  
      1572 Treatment Treatment-1572
      1573 Treatment Treatment-1573
      1574 Treatment Treatment-1574
      1575 Treatment Treatment-1575
      1576 Control   Control-1576  
      1577 Control   Control-1577  
      1578 Control   Control-1578  
      1579 Treatment Treatment-1579
      1580 Control   Control-1580  
      1581 Control   Control-1581  
      1582 Treatment Treatment-1582
      1583 Control   Control-1583  
      1584 Treatment Treatment-1584
      1585 Control   Control-1585  
      1586 Control   Control-1586  
      1587 Treatment Treatment-1587
      1588 Treatment Treatment-1588
      1589 Treatment Treatment-1589
      1590 Treatment Treatment-1590
      1591 Control   Control-1591  
      1592 Control   Control-1592  
      1593 Control   Control-1593  
      1594 Control   Control-1594  
      1595 Control   Control-1595  
      1596 Treatment Treatment-1596
      1597 Treatment Treatment-1597
      1598 Treatment Treatment-1598
      1599 Treatment Treatment-1599
      1600 Control   Control-1600  
      1601 Control   Control-1601  
      1602 Treatment Treatment-1602
      1603 Treatment Treatment-1603
      1604 Control   Control-1604  
      1605 Treatment Treatment-1605
      1606 Treatment Treatment-1606
      1607 Treatment Treatment-1607
      1608 Control   Control-1608  
      1609 Control   Control-1609  
      1610 Control   Control-1610  
      1611 Control   Control-1611  
      1612 Treatment Treatment-1612
      1613 Treatment Treatment-1613
      1614 Control   Control-1614  
      1615 Control   Control-1615  
      1616 Treatment Treatment-1616
      1617 Treatment Treatment-1617
      1618 Control   Control-1618  
      1619 Treatment Treatment-1619
      1620 Control   Control-1620  
      1621 Treatment Treatment-1621
      1622 Treatment Treatment-1622
      1623 Treatment Treatment-1623
      1624 Control   Control-1624  
      1625 Control   Control-1625  
      1626 Control   Control-1626  
      1627 Control   Control-1627  
      1628 Treatment Treatment-1628
      1629 Treatment Treatment-1629
      1630 Treatment Treatment-1630
      1631 Treatment Treatment-1631
      1632 Control   Control-1632  
      1633 Control   Control-1633  
      1634 Treatment Treatment-1634
      1635 Control   Control-1635  
      1636 Control   Control-1636  
      1637 Treatment Treatment-1637
      1638 Control   Control-1638  
      1639 Control   Control-1639  
      1640 Treatment Treatment-1640
      1641 Control   Control-1641  
      1642 Control   Control-1642  
      1643 Treatment Treatment-1643
      1644 Control   Control-1644  
      1645 Treatment Treatment-1645
      1646 Treatment Treatment-1646
      1647 Control   Control-1647  
      1648 Treatment Treatment-1648
      1649 Control   Control-1649  
      1650 Treatment Treatment-1650
      1651 Treatment Treatment-1651
      1652 Control   Control-1652  
      1653 Treatment Treatment-1653
      1654 Control   Control-1654  
      1655 Treatment Treatment-1655
      1656 Treatment Treatment-1656
      1657 Control   Control-1657  
      1658 Control   Control-1658  
      1659 Treatment Treatment-1659
      1660 Control   Control-1660  
      1661 Treatment Treatment-1661
      1662 Control   Control-1662  
      1663 Treatment Treatment-1663
      1664 Control   Control-1664  
      1665 Control   Control-1665  
      1666 Treatment Treatment-1666
      1667 Control   Control-1667  
      1668 Treatment Treatment-1668
      1669 Control   Control-1669  
      1670 Treatment Treatment-1670
      1671 Treatment Treatment-1671
      1672 Control   Control-1672  
      1673 Treatment Treatment-1673
      1674 Control   Control-1674  
      1675 Treatment Treatment-1675
      1676 Treatment Treatment-1676
      1677 Treatment Treatment-1677
      1678 Control   Control-1678  
      1679 Control   Control-1679  
      1680 Control   Control-1680  
      1681 Treatment Treatment-1681
      1682 Treatment Treatment-1682
      1683 Control   Control-1683  
      1684 Treatment Treatment-1684
      1685 Control   Control-1685  
      1686 Treatment Treatment-1686
      1687 Control   Control-1687  
      1688 Control   Control-1688  
      1689 Control   Control-1689  
      1690 Treatment Treatment-1690
      1691 Treatment Treatment-1691
      1692 Control   Control-1692  
      1693 Treatment Treatment-1693
      1694 Control   Control-1694  
      1695 Treatment Treatment-1695
      1696 Control   Control-1696  
      1697 Treatment Treatment-1697
      1698 Control   Control-1698  
      1699 Treatment Treatment-1699
      1700 Control   Control-1700  
      1701 Control   Control-1701  
      1702 Treatment Treatment-1702
      1703 Treatment Treatment-1703
      1704 Control   Control-1704  
      1705 Control   Control-1705  
      1706 Treatment Treatment-1706
      1707 Control   Control-1707  
      1708 Treatment Treatment-1708
      1709 Control   Control-1709  
      1710 Control   Control-1710  
      1711 Treatment Treatment-1711
      1712 Treatment Treatment-1712
      1713 Control   Control-1713  
      1714 Treatment Treatment-1714
      1715 Treatment Treatment-1715
      1716 Control   Control-1716  
      1717 Treatment Treatment-1717
      1718 Control   Control-1718  
      1719 Control   Control-1719  
      1720 Treatment Treatment-1720
      1721 Control   Control-1721  
      1722 Treatment Treatment-1722
      1723 Treatment Treatment-1723
      1724 Control   Control-1724  
      1725 Control   Control-1725  
      1726 Treatment Treatment-1726
      1727 Control   Control-1727  
      1728 Treatment Treatment-1728
      1729 Treatment Treatment-1729
      1730 Control   Control-1730  
      1731 Control   Control-1731  
      1732 Treatment Treatment-1732
      1733 Treatment Treatment-1733
      1734 Control   Control-1734  
      1735 Treatment Treatment-1735
      1736 Control   Control-1736  
      1737 Control   Control-1737  
      1738 Treatment Treatment-1738
      1739 Treatment Treatment-1739
      1740 Control   Control-1740  
      1741 Treatment Treatment-1741
      1742 Control   Control-1742  
      1743 Control   Control-1743  
      1744 Control   Control-1744  
      1745 Treatment Treatment-1745
      1746 Treatment Treatment-1746
      1747 Treatment Treatment-1747
      1748 Control   Control-1748  
      1749 Treatment Treatment-1749
      1750 Control   Control-1750  
      1751 Treatment Treatment-1751
      1752 Control   Control-1752  
      1753 Treatment Treatment-1753
      1754 Control   Control-1754  
      1755 Control   Control-1755  
      1756 Treatment Treatment-1756
      1757 Control   Control-1757  
      1758 Treatment Treatment-1758
      1759 Control   Control-1759  
      1760 Control   Control-1760  
      1761 Treatment Treatment-1761
      1762 Treatment Treatment-1762
      1763 Control   Control-1763  
      1764 Treatment Treatment-1764
      1765 Control   Control-1765  
      1766 Control   Control-1766  
      1767 Control   Control-1767  
      1768 Treatment Treatment-1768
      1769 Treatment Treatment-1769
      1770 Control   Control-1770  
      1771 Treatment Treatment-1771
      1772 Treatment Treatment-1772
      1773 Control   Control-1773  
      1774 Control   Control-1774  
      1775 Treatment Treatment-1775
      1776 Treatment Treatment-1776
      1777 Control   Control-1777  
      1778 Treatment Treatment-1778
      1779 Treatment Treatment-1779
      1780 Treatment Treatment-1780
      1781 Control   Control-1781  
      1782 Treatment Treatment-1782
      1783 Control   Control-1783  
      1784 Control   Control-1784  
      1785 Treatment Treatment-1785
      1786 Control   Control-1786  
      1787 Control   Control-1787  
      1788 Treatment Treatment-1788
      1789 Control   Control-1789  
      1790 Control   Control-1790  
      1791 Treatment Treatment-1791
      1792 Control   Control-1792  
      1793 Treatment Treatment-1793
      1794 Control   Control-1794  
      1795 Treatment Treatment-1795
      1796 Treatment Treatment-1796
      1797 Treatment Treatment-1797
      1798 Treatment Treatment-1798
      1799 Control   Control-1799  
      1800 Control   Control-1800  
      1801 Control   Control-1801  
      1802 Treatment Treatment-1802
      1803 Treatment Treatment-1803
      1804 Control   Control-1804  
      1805 Treatment Treatment-1805
      1806 Treatment Treatment-1806
      1807 Treatment Treatment-1807
      1808 Treatment Treatment-1808
      1809 Control   Control-1809  
      1810 Control   Control-1810  
      1811 Control   Control-1811  
      1812 Control   Control-1812  
      1813 Treatment Treatment-1813
      1814 Control   Control-1814  
      1815 Control   Control-1815  
      1816 Treatment Treatment-1816
      1817 Treatment Treatment-1817
      1818 Control   Control-1818  
      1819 Control   Control-1819  
      1820 Treatment Treatment-1820
      1821 Control   Control-1821  
      1822 Treatment Treatment-1822
      1823 Control   Control-1823  
      1824 Treatment Treatment-1824
      1825 Control   Control-1825  
      1826 Control   Control-1826  
      1827 Control   Control-1827  
      1828 Treatment Treatment-1828
      1829 Treatment Treatment-1829
      1830 Treatment Treatment-1830
      1831 Treatment Treatment-1831
      1832 Control   Control-1832  
      1833 Control   Control-1833  
      1834 Treatment Treatment-1834
      1835 Treatment Treatment-1835
      1836 Control   Control-1836  
      1837 Control   Control-1837  
      1838 Control   Control-1838  
      1839 Treatment Treatment-1839
      1840 Treatment Treatment-1840
      1841 Treatment Treatment-1841
      1842 Treatment Treatment-1842
      1843 Control   Control-1843  
      1844 Control   Control-1844  
      1845 Control   Control-1845  
      1846 Control   Control-1846  
      1847 Treatment Treatment-1847
      1848 Treatment Treatment-1848
      1849 Control   Control-1849  
      1850 Control   Control-1850  
      1851 Control   Control-1851  
      1852 Treatment Treatment-1852
      1853 Treatment Treatment-1853
      1854 Control   Control-1854  
      1855 Treatment Treatment-1855
      1856 Treatment Treatment-1856
      1857 Treatment Treatment-1857
      1858 Control   Control-1858  
      1859 Treatment Treatment-1859
      1860 Control   Control-1860  
      1861 Treatment Treatment-1861
      1862 Control   Control-1862  
      1863 Treatment Treatment-1863
      1864 Control   Control-1864  
      1865 Control   Control-1865  
      1866 Treatment Treatment-1866
      1867 Control   Control-1867  
      1868 Treatment Treatment-1868
      1869 Control   Control-1869  
      1870 Control   Control-1870  
      1871 Treatment Treatment-1871
      1872 Treatment Treatment-1872
      1873 Control   Control-1873  
      1874 Control   Control-1874  
      1875 Treatment Treatment-1875
      1876 Treatment Treatment-1876
      1877 Control   Control-1877  
      1878 Treatment Treatment-1878
      1879 Treatment Treatment-1879
      1880 Control   Control-1880  
      1881 Control   Control-1881  
      1882 Control   Control-1882  
      1883 Treatment Treatment-1883
      1884 Treatment Treatment-1884
      1885 Treatment Treatment-1885
      1886 Treatment Treatment-1886
      1887 Control   Control-1887  
      1888 Control   Control-1888  
      1889 Control   Control-1889  
      1890 Control   Control-1890  
      1891 Treatment Treatment-1891
      1892 Treatment Treatment-1892
      1893 Control   Control-1893  
      1894 Treatment Treatment-1894
      1895 Control   Control-1895  
      1896 Treatment Treatment-1896
      1897 Control   Control-1897  
      1898 Treatment Treatment-1898
      1899 Control   Control-1899  
      1900 Treatment Treatment-1900
      1901 Control   Control-1901  
      1902 Treatment Treatment-1902
      1903 Treatment Treatment-1903
      1904 Control   Control-1904  
      1905 Treatment Treatment-1905
      1906 Control   Control-1906  
      1907 Treatment Treatment-1907
      1908 Control   Control-1908  
      1909 Control   Control-1909  
      1910 Control   Control-1910  
      1911 Treatment Treatment-1911
      1912 Treatment Treatment-1912
      1913 Treatment Treatment-1913
      1914 Control   Control-1914  
      1915 Treatment Treatment-1915
      1916 Control   Control-1916  
      1917 Control   Control-1917  
      1918 Treatment Treatment-1918
      1919 Control   Control-1919  
      1920 Treatment Treatment-1920
      1921 Treatment Treatment-1921
      1922 Treatment Treatment-1922
      1923 Control   Control-1923  
      1924 Control   Control-1924  
      1925 Control   Control-1925  
      1926 Treatment Treatment-1926
      1927 Treatment Treatment-1927
      1928 Control   Control-1928  
      1929 Control   Control-1929  
      1930 Treatment Treatment-1930
      1931 Control   Control-1931  
      1932 Treatment Treatment-1932
      1933 Treatment Treatment-1933
      1934 Treatment Treatment-1934
      1935 Control   Control-1935  
      1936 Control   Control-1936  
      1937 Treatment Treatment-1937
      1938 Control   Control-1938  
      1939 Treatment Treatment-1939
      1940 Control   Control-1940  
      1941 Control   Control-1941  
      1942 Treatment Treatment-1942
      1943 Treatment Treatment-1943
      1944 Control   Control-1944  
      1945 Treatment Treatment-1945
      1946 Treatment Treatment-1946
      1947 Control   Control-1947  
      1948 Control   Control-1948  
      1949 Control   Control-1949  
      1950 Treatment Treatment-1950
      1951 Treatment Treatment-1951
      1952 Control   Control-1952  
      1953 Control   Control-1953  
      1954 Treatment Treatment-1954
      1955 Control   Control-1955  
      1956 Treatment Treatment-1956
      1957 Treatment Treatment-1957
      1958 Treatment Treatment-1958
      1959 Control   Control-1959  
      1960 Control   Control-1960  
      1961 Control   Control-1961  
      1962 Treatment Treatment-1962
      1963 Control   Control-1963  
      1964 Treatment Treatment-1964
      1965 Control   Control-1965  
      1966 Control   Control-1966  
      1967 Treatment Treatment-1967
      1968 Treatment Treatment-1968
      1969 Control   Control-1969  
      1970 Treatment Treatment-1970
      1971 Control   Control-1971  
      1972 Control   Control-1972  
      1973 Control   Control-1973  
      1974 Treatment Treatment-1974
      1975 Treatment Treatment-1975
      1976 Treatment Treatment-1976
      1977 Treatment Treatment-1977
      1978 Control   Control-1978  
      1979 Treatment Treatment-1979
      1980 Control   Control-1980  
      1981 Treatment Treatment-1981
      1982 Treatment Treatment-1982
      1983 Control   Control-1983  
      1984 Control   Control-1984  
      1985 Control   Control-1985  
      1986 Treatment Treatment-1986
      1987 Control   Control-1987  
      1988 Treatment Treatment-1988
      1989 Control   Control-1989  
      1990 Treatment Treatment-1990
      1991 Control   Control-1991  
      1992 Treatment Treatment-1992
      1993 Treatment Treatment-1993
      1994 Treatment Treatment-1994
      1995 Control   Control-1995  
      1996 Control   Control-1996  
      1997 Treatment Treatment-1997
      1998 Treatment Treatment-1998
      1999 Control   Control-1999  
      2000 Treatment Treatment-2000
      2001 Control   Control-2001  
      2002 Control   Control-2002  
      2003 Treatment Treatment-2003
      2004 Control   Control-2004  
      2005 Treatment Treatment-2005
      2006 Treatment Treatment-2006
      2007 Treatment Treatment-2007
      2008 Control   Control-2008  
      2009 Control   Control-2009  
      2010 Treatment Treatment-2010
      2011 Control   Control-2011  
      2012 Control   Control-2012  
      2013 Control   Control-2013  
      2014 Control   Control-2014  
      2015 Treatment Treatment-2015
      2016 Treatment Treatment-2016
      2017 Control   Control-2017  
      2018 Treatment Treatment-2018
      2019 Treatment Treatment-2019
      2020 Control   Control-2020  
      2021 Treatment Treatment-2021
      2022 Control   Control-2022  
      2023 Treatment Treatment-2023
      2024 Treatment Treatment-2024
      2025 Control   Control-2025  
      2026 Control   Control-2026  
      2027 Control   Control-2027  
      2028 Treatment Treatment-2028
      2029 Control   Control-2029  
      2030 Treatment Treatment-2030
      2031 Treatment Treatment-2031
      2032 Control   Control-2032  
      2033 Treatment Treatment-2033
      2034 Treatment Treatment-2034
      2035 Control   Control-2035  
      2036 Control   Control-2036  
      2037 Treatment Treatment-2037
      2038 Treatment Treatment-2038
      2039 Control   Control-2039  
      2040 Control   Control-2040  
      2041 Treatment Treatment-2041
      2042 Treatment Treatment-2042
      2043 Control   Control-2043  
      2044 Control   Control-2044  
      2045 Control   Control-2045  
      2046 Control   Control-2046  
      2047 Treatment Treatment-2047
      2048 Treatment Treatment-2048
      2049 Control   Control-2049  
      2050 Treatment Treatment-2050
      2051 Control   Control-2051  
      2052 Treatment Treatment-2052
      2053 Control   Control-2053  
      2054 Control   Control-2054  
      2055 Treatment Treatment-2055
      2056 Treatment Treatment-2056
      2057 Control   Control-2057  
      2058 Treatment Treatment-2058
      2059 Control   Control-2059  
      2060 Treatment Treatment-2060
      2061 Treatment Treatment-2061
      2062 Treatment Treatment-2062
      2063 Control   Control-2063  
      2064 Treatment Treatment-2064
      2065 Control   Control-2065  
      2066 Treatment Treatment-2066
      2067 Control   Control-2067  
      2068 Control   Control-2068  
      2069 Treatment Treatment-2069
      2070 Treatment Treatment-2070
      2071 Control   Control-2071  
      2072 Control   Control-2072  
      2073 Treatment Treatment-2073
      2074 Control   Control-2074  
      2075 Control   Control-2075  
      2076 Treatment Treatment-2076
      2077 Treatment Treatment-2077
      2078 Treatment Treatment-2078
      2079 Treatment Treatment-2079
      2080 Treatment Treatment-2080
      2081 Control   Control-2081  
      2082 Control   Control-2082  
      2083 Control   Control-2083  
      2084 Control   Control-2084  
      2085 Treatment Treatment-2085
      2086 Control   Control-2086  
      2087 Control   Control-2087  
      2088 Treatment Treatment-2088
      2089 Control   Control-2089  
      2090 Treatment Treatment-2090
      2091 Treatment Treatment-2091
      2092 Control   Control-2092  
      2093 Control   Control-2093  
      2094 Control   Control-2094  
      2095 Treatment Treatment-2095
      2096 Treatment Treatment-2096
      2097 Treatment Treatment-2097
      2098 Control   Control-2098  
      2099 Treatment Treatment-2099
      2100 Control   Control-2100  
      2101 Treatment Treatment-2101
      2102 Control   Control-2102  
      2103 Control   Control-2103  
      2104 Treatment Treatment-2104
      2105 Control   Control-2105  
      2106 Control   Control-2106  
      2107 Treatment Treatment-2107
      2108 Control   Control-2108  
      2109 Control   Control-2109  
      2110 Treatment Treatment-2110
      2111 Treatment Treatment-2111
      2112 Treatment Treatment-2112
      2113 Treatment Treatment-2113
      2114 Control   Control-2114  
      2115 Treatment Treatment-2115
      2116 Control   Control-2116  
      2117 Control   Control-2117  
      2118 Control   Control-2118  
      2119 Treatment Treatment-2119
      2120 Treatment Treatment-2120
      2121 Control   Control-2121  
      2122 Control   Control-2122  
      2123 Control   Control-2123  
      2124 Treatment Treatment-2124
      2125 Control   Control-2125  
      2126 Treatment Treatment-2126
      2127 Treatment Treatment-2127
      2128 Treatment Treatment-2128
      2129 Control   Control-2129  
      2130 Control   Control-2130  
      2131 Treatment Treatment-2131
      2132 Treatment Treatment-2132
      2133 Control   Control-2133  
      2134 Control   Control-2134  
      2135 Treatment Treatment-2135
      2136 Treatment Treatment-2136
      2137 Control   Control-2137  
      2138 Control   Control-2138  
      2139 Treatment Treatment-2139
      2140 Treatment Treatment-2140
      2141 Control   Control-2141  
      2142 Treatment Treatment-2142
      2143 Treatment Treatment-2143
      2144 Control   Control-2144  
      2145 Treatment Treatment-2145
      2146 Treatment Treatment-2146
      2147 Treatment Treatment-2147
      2148 Control   Control-2148  
      2149 Control   Control-2149  
      2150 Control   Control-2150  
      2151 Treatment Treatment-2151
      2152 Control   Control-2152  
      2153 Control   Control-2153  
      2154 Treatment Treatment-2154
      2155 Control   Control-2155  
      2156 Control   Control-2156  
      2157 Treatment Treatment-2157
      2158 Treatment Treatment-2158
      2159 Treatment Treatment-2159
      2160 Control   Control-2160  
      2161 Treatment Treatment-2161
      2162 Control   Control-2162  
      2163 Treatment Treatment-2163
      2164 Control   Control-2164  
      2165 Treatment Treatment-2165
      2166 Treatment Treatment-2166
      2167 Control   Control-2167  
      2168 Control   Control-2168  
      2169 Control   Control-2169  
      2170 Control   Control-2170  
      2171 Control   Control-2171  
      2172 Treatment Treatment-2172
      2173 Control   Control-2173  
      2174 Treatment Treatment-2174
      2175 Treatment Treatment-2175
      2176 Treatment Treatment-2176
      2177 Treatment Treatment-2177
      2178 Treatment Treatment-2178
      2179 Control   Control-2179  
      2180 Treatment Treatment-2180
      2181 Control   Control-2181  
      2182 Treatment Treatment-2182
      2183 Control   Control-2183  
      2184 Control   Control-2184  
      2185 Treatment Treatment-2185
      2186 Treatment Treatment-2186
      2187 Treatment Treatment-2187
      2188 Treatment Treatment-2188
      2189 Control   Control-2189  
      2190 Control   Control-2190  
      2191 Control   Control-2191  
      2192 Control   Control-2192  
      2193 Treatment Treatment-2193
      2194 Control   Control-2194  
      2195 Treatment Treatment-2195
      2196 Treatment Treatment-2196
      2197 Treatment Treatment-2197
      2198 Control   Control-2198  
      2199 Control   Control-2199  
      2200 Control   Control-2200  
      2201 Treatment Treatment-2201
      2202 Control   Control-2202  
      2203 Treatment Treatment-2203
      2204 Control   Control-2204  
      2205 Treatment Treatment-2205
      2206 Control   Control-2206  
      2207 Control   Control-2207  
      2208 Treatment Treatment-2208
      2209 Treatment Treatment-2209
      2210 Control   Control-2210  
      2211 Treatment Treatment-2211
      2212 Control   Control-2212  
      2213 Control   Control-2213  
      2214 Treatment Treatment-2214
      2215 Control   Control-2215  
      2216 Control   Control-2216  
      2217 Control   Control-2217  
      2218 Treatment Treatment-2218
      2219 Treatment Treatment-2219
      2220 Treatment Treatment-2220
      2221 Control   Control-2221  
      2222 Treatment Treatment-2222
      2223 Control   Control-2223  
      2224 Treatment Treatment-2224
      2225 Treatment Treatment-2225
      2226 Control   Control-2226  
      2227 Control   Control-2227  
      2228 Treatment Treatment-2228
      2229 Control   Control-2229  
      2230 Treatment Treatment-2230
      2231 Treatment Treatment-2231
      2232 Control   Control-2232  
      2233 Treatment Treatment-2233
      2234 Control   Control-2234  
      2235 Control   Control-2235  
      2236 Treatment Treatment-2236
      2237 Treatment Treatment-2237
      2238 Treatment Treatment-2238
      2239 Treatment Treatment-2239
      2240 Control   Control-2240  
      2241 Control   Control-2241  
      2242 Control   Control-2242  
      2243 Control   Control-2243  
      2244 Treatment Treatment-2244
      2245 Treatment Treatment-2245
      2246 Treatment Treatment-2246
      2247 Control   Control-2247  
      2248 Control   Control-2248  
      2249 Control   Control-2249  
      2250 Control   Control-2250  
      2251 Treatment Treatment-2251
      2252 Treatment Treatment-2252
      2253 Control   Control-2253  
      2254 Treatment Treatment-2254
      2255 Treatment Treatment-2255
      2256 Control   Control-2256  
      2257 Control   Control-2257  
      2258 Treatment Treatment-2258
      2259 Treatment Treatment-2259
      2260 Control   Control-2260  
      2261 Control   Control-2261  
      2262 Control   Control-2262  
      2263 Treatment Treatment-2263
      2264 Control   Control-2264  
      2265 Control   Control-2265  
      2266 Treatment Treatment-2266
      2267 Treatment Treatment-2267
      2268 Treatment Treatment-2268
      2269 Control   Control-2269  
      2270 Treatment Treatment-2270
      2271 Treatment Treatment-2271
      2272 Control   Control-2272  
      2273 Control   Control-2273  
      2274 Treatment Treatment-2274
      2275 Control   Control-2275  
      2276 Control   Control-2276  
      2277 Treatment Treatment-2277
      2278 Treatment Treatment-2278
      2279 Treatment Treatment-2279
      2280 Control   Control-2280  
      2281 Control   Control-2281  
      2282 Treatment Treatment-2282
      2283 Treatment Treatment-2283
      2284 Control   Control-2284  
      2285 Control   Control-2285  
      2286 Treatment Treatment-2286
      2287 Control   Control-2287  
      2288 Treatment Treatment-2288
      2289 Control   Control-2289  
      2290 Treatment Treatment-2290
      2291 Treatment Treatment-2291
      2292 Control   Control-2292  
      2293 Treatment Treatment-2293
      2294 Control   Control-2294  
      2295 Control   Control-2295  
      2296 Treatment Treatment-2296
      2297 Treatment Treatment-2297
      2298 Treatment Treatment-2298
      2299 Control   Control-2299  
      2300 Control   Control-2300  
      2301 Treatment Treatment-2301
      2302 Control   Control-2302  
      2303 Control   Control-2303  
      2304 Treatment Treatment-2304
      2305 Treatment Treatment-2305
      2306 Treatment Treatment-2306
      2307 Control   Control-2307  
      2308 Treatment Treatment-2308
      2309 Control   Control-2309  
      2310 Control   Control-2310  
      2311 Control   Control-2311  
      2312 Treatment Treatment-2312
      2313 Treatment Treatment-2313
      2314 Control   Control-2314  
      2315 Control   Control-2315  
      2316 Treatment Treatment-2316
      2317 Control   Control-2317  
      2318 Control   Control-2318  
      2319 Treatment Treatment-2319
      2320 Treatment Treatment-2320
      2321 Treatment Treatment-2321
      2322 Treatment Treatment-2322
      2323 Control   Control-2323  
      2324 Control   Control-2324  
      2325 Control   Control-2325  
      2326 Treatment Treatment-2326
      2327 Control   Control-2327  
      2328 Treatment Treatment-2328
      2329 Control   Control-2329  
      2330 Treatment Treatment-2330
      2331 Treatment Treatment-2331
      2332 Control   Control-2332  
      2333 Treatment Treatment-2333
      2334 Treatment Treatment-2334
      2335 Control   Control-2335  
      2336 Treatment Treatment-2336
      2337 Control   Control-2337  
      2338 Control   Control-2338  
      2339 Control   Control-2339  
      2340 Treatment Treatment-2340
      2341 Treatment Treatment-2341
      2342 Control   Control-2342  
      2343 Control   Control-2343  
      2344 Treatment Treatment-2344
      2345 Control   Control-2345  
      2346 Treatment Treatment-2346
      2347 Control   Control-2347  
      2348 Treatment Treatment-2348
      2349 Control   Control-2349  
      2350 Treatment Treatment-2350
      2351 Treatment Treatment-2351
      2352 Control   Control-2352  
      2353 Control   Control-2353  
      2354 Treatment Treatment-2354
      2355 Treatment Treatment-2355
      2356 Control   Control-2356  
      2357 Control   Control-2357  
      2358 Treatment Treatment-2358
      2359 Control   Control-2359  
      2360 Treatment Treatment-2360
      2361 Treatment Treatment-2361
      2362 Treatment Treatment-2362
      2363 Treatment Treatment-2363
      2364 Control   Control-2364  
      2365 Control   Control-2365  
      2366 Control   Control-2366  
      2367 Control   Control-2367  
      2368 Treatment Treatment-2368
      2369 Control   Control-2369  
      2370 Control   Control-2370  
      2371 Treatment Treatment-2371
      2372 Control   Control-2372  
      2373 Treatment Treatment-2373
      2374 Treatment Treatment-2374
      2375 Treatment Treatment-2375
      2376 Control   Control-2376  
      2377 Control   Control-2377  
      2378 Control   Control-2378  
      2379 Treatment Treatment-2379
      2380 Treatment Treatment-2380
      2381 Control   Control-2381  
      2382 Treatment Treatment-2382
      2383 Control   Control-2383  
      2384 Treatment Treatment-2384
      2385 Control   Control-2385  
      2386 Treatment Treatment-2386
      2387 Control   Control-2387  
      2388 Treatment Treatment-2388
      2389 Treatment Treatment-2389
      2390 Control   Control-2390  
      2391 Control   Control-2391  
      2392 Treatment Treatment-2392
      2393 Control   Control-2393  
      2394 Treatment Treatment-2394
      2395 Control   Control-2395  
      2396 Treatment Treatment-2396
      2397 Control   Control-2397  
      2398 Treatment Treatment-2398
      2399 Control   Control-2399  
      2400 Treatment Treatment-2400
      2401 Treatment Treatment-2401
      2402 Control   Control-2402  
      2403 Control   Control-2403  
      2404 Treatment Treatment-2404
      2405 Treatment Treatment-2405
      2406 Treatment Treatment-2406
      2407 Control   Control-2407  
      2408 Control   Control-2408  
      2409 Control   Control-2409  
      2410 Treatment Treatment-2410
      2411 Control   Control-2411  
      2412 Treatment Treatment-2412
      2413 Treatment Treatment-2413
      2414 Control   Control-2414  
      2415 Treatment Treatment-2415
      2416 Control   Control-2416  
      2417 Treatment Treatment-2417
      2418 Control   Control-2418  
      2419 Treatment Treatment-2419
      2420 Treatment Treatment-2420
      2421 Control   Control-2421  
      2422 Control   Control-2422  
      2423 Treatment Treatment-2423
      2424 Control   Control-2424  
    Code
      randomisation_list(n = 10, arms = c("A", "B"), strata = NULL, block.sizes = c(4,
        8))
    Message
      Randomisation list for 10 patients randomized in arms "A" and "B" across 1 strata with blocks of length 4 and 8.
    Output
      # A tibble: 16 x 6
         id             strata    stratum.block.id block.size treatment treatment_id
         <chr>          <chr>     <fct>                 <dbl> <fct>     <chr>       
       1 no_strata - 01 no_strata 1                         8 A         A-01        
       2 no_strata - 02 no_strata 1                         8 B         B-02        
       3 no_strata - 03 no_strata 1                         8 B         B-03        
       4 no_strata - 04 no_strata 1                         8 A         A-04        
       5 no_strata - 05 no_strata 1                         8 A         A-05        
       6 no_strata - 06 no_strata 1                         8 A         A-06        
       7 no_strata - 07 no_strata 1                         8 B         B-07        
       8 no_strata - 08 no_strata 1                         8 B         B-08        
       9 no_strata - 09 no_strata 2                         8 B         B-09        
      10 no_strata - 10 no_strata 2                         8 B         B-10        
      11 no_strata - 11 no_strata 2                         8 A         A-11        
      12 no_strata - 12 no_strata 2                         8 B         B-12        
      13 no_strata - 13 no_strata 2                         8 A         A-13        
      14 no_strata - 14 no_strata 2                         8 A         A-14        
      15 no_strata - 15 no_strata 2                         8 A         A-15        
      16 no_strata - 16 no_strata 2                         8 B         B-16        

