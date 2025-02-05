% 7/40L
% chanspec: 0x1807
% tssi-idle_tssi    ipa     txlpf   pga     pad     txgm    bbmult   
tssi_7_40L = [ ...
  -290 0 0 0 0 0 0; ... % idle_tssi
  714 255 0 255 255 255 51; ... % tssi[0]
  713 255 0 255 255 255 49; ... % tssi[1]
  714 255 0 255 255 255 48; ... % tssi[2]
  711 255 0 247 255 255 48; ... % tssi[3]
  708 255 0 238 255 255 48; ... % tssi[4]
  704 255 0 230 255 255 48; ... % tssi[5]
  702 255 0 223 255 255 48; ... % tssi[6]
  697 255 0 215 255 255 48; ... % tssi[7]
  695 255 0 207 255 255 47; ... % tssi[8]
  689 255 0 201 255 255 47; ... % tssi[9]
  684 255 0 194 255 255 48; ... % tssi[10]
  681 255 0 187 255 255 48; ... % tssi[11]
  676 255 0 182 255 255 49; ... % tssi[12]
  672 255 0 177 255 255 48; ... % tssi[13]
  665 255 0 170 255 255 48; ... % tssi[14]
  658 255 0 165 255 255 48; ... % tssi[15]
  652 255 0 160 255 255 48; ... % tssi[16]
  641 255 0 155 255 255 48; ... % tssi[17]
  630 255 0 149 255 255 48; ... % tssi[18]
  626 255 0 145 255 255 48; ... % tssi[19]
  617 255 0 141 255 255 48; ... % tssi[20]
  604 255 0 136 255 255 48; ... % tssi[21]
  598 255 0 133 255 255 48; ... % tssi[22]
  582 255 0 128 255 255 48; ... % tssi[23]
  562 255 0 124 255 255 47; ... % tssi[24]
  547 255 0 120 255 255 47; ... % tssi[25]
  537 255 0 117 255 255 48; ... % tssi[26]
  521 255 0 113 255 255 48; ... % tssi[27]
  513 255 0 110 255 255 48; ... % tssi[28]
  492 255 0 106 255 255 47; ... % tssi[29]
  478 255 0 103 255 255 48; ... % tssi[30]
  466 255 0 100 255 255 48; ... % tssi[31]
  452 255 0 97 255 255 47; ... % tssi[32]
  434 255 0 94 255 255 48; ... % tssi[33]
  418 255 0 91 255 255 48; ... % tssi[34]
  402 255 0 88 255 255 48; ... % tssi[35]
  391 255 0 86 255 255 48; ... % tssi[36]
  373 255 0 83 255 255 48; ... % tssi[37]
  359 255 0 81 255 255 48; ... % tssi[38]
  349 255 0 78 255 255 48; ... % tssi[39]
  337 255 0 76 255 255 48; ... % tssi[40]
  324 255 0 74 255 255 48; ... % tssi[41]
  312 255 0 72 255 255 48; ... % tssi[42]
  300 255 0 70 255 255 48; ... % tssi[43]
  287 255 0 68 255 255 48; ... % tssi[44]
  267 255 0 65 255 255 48; ... % tssi[45]
  262 255 0 63 255 255 48; ... % tssi[46]
  251 255 0 61 255 255 48; ... % tssi[47]
  238 255 0 59 255 255 47; ... % tssi[48]
  231 255 0 58 255 255 47; ... % tssi[49]
  218 255 0 56 255 255 47; ... % tssi[50]
  213 255 0 55 255 255 47; ... % tssi[51]
  201 255 0 53 255 255 48; ... % tssi[52]
  188 255 0 51 255 255 48; ... % tssi[53]
  180 255 0 50 255 255 48; ... % tssi[54]
  167 255 0 48 255 255 48; ... % tssi[55]
  168 255 0 47 255 255 48; ... % tssi[56]
  160 255 0 46 255 255 47; ... % tssi[57]
  149 255 0 44 255 255 48; ... % tssi[58]
  141 255 0 43 255 255 48; ... % tssi[59]
  136 255 0 42 255 255 47; ... % tssi[60]
  124 255 0 40 255 255 48; ... % tssi[61]
  120 255 0 39 255 255 48; ... % tssi[62]
  120 255 0 39 255 255 47; ... % tssi[63]
  107 255 0 37 255 255 48; ... % tssi[64]
  102 255 0 36 255 255 48; ... % tssi[65]
  96 255 0 35 255 255 48; ... % tssi[66]
  90 255 0 34 255 255 48; ... % tssi[67]
  85 255 0 33 255 255 48; ... % tssi[68]
  79 255 0 32 255 255 48; ... % tssi[69]
  73 255 0 31 255 255 48; ... % tssi[70]
  68 255 0 30 255 255 48; ... % tssi[71]
  62 255 0 29 255 255 47; ... % tssi[72]
  59 255 0 28 255 255 48; ... % tssi[73]
  55 255 0 27 255 255 48; ... % tssi[74]
  51 255 0 26 255 255 48; ... % tssi[75]
  45 255 0 25 255 255 48; ... % tssi[76]
  46 255 0 25 255 255 48; ... % tssi[77]
  43 255 0 24 255 255 47; ... % tssi[78]
  39 255 0 23 255 255 48; ... % tssi[79]
  38 255 0 23 255 255 47; ... % tssi[80]
  35 255 0 22 255 255 48; ... % tssi[81]
  32 255 0 21 255 255 48; ... % tssi[82]
  31 255 0 21 255 255 47; ... % tssi[83]
  27 255 0 20 255 255 48; ... % tssi[84]
  29 255 0 20 255 255 47; ... % tssi[85]
  26 255 0 19 255 255 48; ... % tssi[86]
  22 255 0 18 255 255 49; ... % tssi[87]
  22 255 0 18 255 255 48; ... % tssi[88]
  20 255 0 17 255 255 49; ... % tssi[89]
  22 255 0 17 255 255 48; ... % tssi[90]
  18 255 0 16 255 255 48; ... % tssi[91]
  17 255 0 16 255 255 46; ... % tssi[92]
  16 255 0 15 255 255 47; ... % tssi[93]
  16 255 0 15 255 255 46; ... % tssi[94]
  16 255 0 14 255 255 48; ... % tssi[95]
  14 255 0 14 255 255 47; ... % tssi[96]
  15 255 0 14 255 255 45; ... % tssi[97]
  12 255 0 13 255 255 46; ... % tssi[98]
  13 255 0 13 255 255 44; ... % tssi[99]
  10 255 0 12 255 255 44; ... % tssi[100]
  10 255 0 12 255 255 43; ... % tssi[101]
  11 255 0 12 255 255 42; ... % tssi[102]
  9 255 0 11 255 255 44; ... % tssi[103]
  9 255 0 11 255 255 43; ... % tssi[104]
  8 255 0 10 255 255 44; ... % tssi[105]
  8 255 0 10 255 255 43; ... % tssi[106]
  6 255 0 10 255 255 42; ... % tssi[107]
  6 255 0 9 255 255 44; ... % tssi[108]
  7 255 0 9 255 255 43; ... % tssi[109]
  5 255 0 9 255 255 42; ... % tssi[110]
  6 255 0 9 255 255 41; ... % tssi[111]
  5 255 0 8 255 255 44; ... % tssi[112]
  6 255 0 8 255 255 42; ... % tssi[113]
  5 255 0 8 255 255 41; ... % tssi[114]
  5 255 0 8 255 255 39; ... % tssi[115]
  4 255 0 7 255 255 41; ... % tssi[116]
  5 255 0 7 255 255 40; ... % tssi[117]
  4 255 0 7 255 255 39; ... % tssi[118]
  3 255 0 7 255 255 38; ... % tssi[119]
  5 255 0 7 255 255 37; ... % tssi[120]
  4 255 0 6 255 255 36; ... % tssi[121]
  2 255 0 6 255 255 35; ... % tssi[122]
  4 255 0 6 255 255 34; ... % tssi[123]
  4 255 0 6 255 255 33; ... % tssi[124]
  2 255 0 6 255 255 32; ... % tssi[125]
  2 255 0 5 255 255 31; ... % tssi[126]
  2 255 0 5 255 255 28; ... % tssi[127]
];