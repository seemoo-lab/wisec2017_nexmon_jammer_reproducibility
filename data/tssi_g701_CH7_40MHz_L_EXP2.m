% 7/40L
% chanspec: 0x1807
% tssi-idle_tssi    ipa     txlpf   pga     pad     txgm    bbmult   
tssi_7_40L = [ ...
  -291 0 0 0 0 0 0; ... % idle_tssi
  715 255 0 255 255 255 51; ... % tssi[0]
  714 255 0 255 255 255 49; ... % tssi[1]
  715 255 0 255 255 255 48; ... % tssi[2]
  711 255 0 247 255 255 48; ... % tssi[3]
  709 255 0 238 255 255 48; ... % tssi[4]
  705 255 0 230 255 255 48; ... % tssi[5]
  703 255 0 223 255 255 48; ... % tssi[6]
  698 255 0 215 255 255 48; ... % tssi[7]
  694 255 0 207 255 255 47; ... % tssi[8]
  693 255 0 201 255 255 47; ... % tssi[9]
  686 255 0 194 255 255 48; ... % tssi[10]
  681 255 0 187 255 255 48; ... % tssi[11]
  677 255 0 182 255 255 49; ... % tssi[12]
  671 255 0 177 255 255 48; ... % tssi[13]
  663 255 0 170 255 255 48; ... % tssi[14]
  658 255 0 165 255 255 48; ... % tssi[15]
  649 255 0 160 255 255 48; ... % tssi[16]
  643 255 0 155 255 255 48; ... % tssi[17]
  632 255 0 149 255 255 48; ... % tssi[18]
  623 255 0 145 255 255 48; ... % tssi[19]
  614 255 0 141 255 255 48; ... % tssi[20]
  604 255 0 136 255 255 48; ... % tssi[21]
  594 255 0 133 255 255 48; ... % tssi[22]
  581 255 0 128 255 255 48; ... % tssi[23]
  561 255 0 124 255 255 47; ... % tssi[24]
  548 255 0 120 255 255 47; ... % tssi[25]
  535 255 0 117 255 255 48; ... % tssi[26]
  517 255 0 113 255 255 48; ... % tssi[27]
  511 255 0 110 255 255 48; ... % tssi[28]
  493 255 0 106 255 255 47; ... % tssi[29]
  478 255 0 103 255 255 48; ... % tssi[30]
  466 255 0 100 255 255 48; ... % tssi[31]
  448 255 0 97 255 255 47; ... % tssi[32]
  434 255 0 94 255 255 48; ... % tssi[33]
  416 255 0 91 255 255 48; ... % tssi[34]
  398 255 0 88 255 255 48; ... % tssi[35]
  389 255 0 86 255 255 48; ... % tssi[36]
  371 255 0 83 255 255 48; ... % tssi[37]
  358 255 0 81 255 255 48; ... % tssi[38]
  348 255 0 78 255 255 48; ... % tssi[39]
  335 255 0 76 255 255 48; ... % tssi[40]
  323 255 0 74 255 255 48; ... % tssi[41]
  312 255 0 72 255 255 48; ... % tssi[42]
  300 255 0 70 255 255 48; ... % tssi[43]
  287 255 0 68 255 255 48; ... % tssi[44]
  268 255 0 65 255 255 48; ... % tssi[45]
  263 255 0 63 255 255 48; ... % tssi[46]
  250 255 0 61 255 255 48; ... % tssi[47]
  236 255 0 59 255 255 47; ... % tssi[48]
  230 255 0 58 255 255 47; ... % tssi[49]
  218 255 0 56 255 255 47; ... % tssi[50]
  212 255 0 55 255 255 47; ... % tssi[51]
  199 255 0 53 255 255 48; ... % tssi[52]
  185 255 0 51 255 255 48; ... % tssi[53]
  180 255 0 50 255 255 48; ... % tssi[54]
  168 255 0 48 255 255 48; ... % tssi[55]
  166 255 0 47 255 255 48; ... % tssi[56]
  160 255 0 46 255 255 47; ... % tssi[57]
  149 255 0 44 255 255 48; ... % tssi[58]
  141 255 0 43 255 255 48; ... % tssi[59]
  136 255 0 42 255 255 47; ... % tssi[60]
  124 255 0 40 255 255 48; ... % tssi[61]
  118 255 0 39 255 255 48; ... % tssi[62]
  119 255 0 39 255 255 47; ... % tssi[63]
  108 255 0 37 255 255 48; ... % tssi[64]
  102 255 0 36 255 255 48; ... % tssi[65]
  96 255 0 35 255 255 48; ... % tssi[66]
  90 255 0 34 255 255 48; ... % tssi[67]
  86 255 0 33 255 255 48; ... % tssi[68]
  80 255 0 32 255 255 48; ... % tssi[69]
  72 255 0 31 255 255 48; ... % tssi[70]
  68 255 0 30 255 255 48; ... % tssi[71]
  64 255 0 29 255 255 47; ... % tssi[72]
  60 255 0 28 255 255 48; ... % tssi[73]
  55 255 0 27 255 255 48; ... % tssi[74]
  50 255 0 26 255 255 48; ... % tssi[75]
  47 255 0 25 255 255 48; ... % tssi[76]
  47 255 0 25 255 255 48; ... % tssi[77]
  42 255 0 24 255 255 47; ... % tssi[78]
  39 255 0 23 255 255 48; ... % tssi[79]
  39 255 0 23 255 255 47; ... % tssi[80]
  35 255 0 22 255 255 48; ... % tssi[81]
  32 255 0 21 255 255 48; ... % tssi[82]
  33 255 0 21 255 255 47; ... % tssi[83]
  28 255 0 20 255 255 48; ... % tssi[84]
  29 255 0 20 255 255 47; ... % tssi[85]
  27 255 0 19 255 255 48; ... % tssi[86]
  22 255 0 18 255 255 49; ... % tssi[87]
  22 255 0 18 255 255 48; ... % tssi[88]
  20 255 0 17 255 255 49; ... % tssi[89]
  20 255 0 17 255 255 48; ... % tssi[90]
  18 255 0 16 255 255 48; ... % tssi[91]
  17 255 0 16 255 255 46; ... % tssi[92]
  19 255 0 15 255 255 47; ... % tssi[93]
  17 255 0 15 255 255 46; ... % tssi[94]
  14 255 0 14 255 255 48; ... % tssi[95]
  18 255 0 14 255 255 47; ... % tssi[96]
  14 255 0 14 255 255 45; ... % tssi[97]
  14 255 0 13 255 255 46; ... % tssi[98]
  13 255 0 13 255 255 44; ... % tssi[99]
  10 255 0 12 255 255 44; ... % tssi[100]
  11 255 0 12 255 255 43; ... % tssi[101]
  13 255 0 12 255 255 42; ... % tssi[102]
  9 255 0 11 255 255 44; ... % tssi[103]
  9 255 0 11 255 255 43; ... % tssi[104]
  7 255 0 10 255 255 44; ... % tssi[105]
  8 255 0 10 255 255 43; ... % tssi[106]
  8 255 0 10 255 255 42; ... % tssi[107]
  7 255 0 9 255 255 44; ... % tssi[108]
  6 255 0 9 255 255 43; ... % tssi[109]
  7 255 0 9 255 255 42; ... % tssi[110]
  6 255 0 9 255 255 41; ... % tssi[111]
  6 255 0 8 255 255 44; ... % tssi[112]
  5 255 0 8 255 255 42; ... % tssi[113]
  7 255 0 8 255 255 41; ... % tssi[114]
  6 255 0 8 255 255 39; ... % tssi[115]
  4 255 0 7 255 255 41; ... % tssi[116]
  4 255 0 7 255 255 40; ... % tssi[117]
  5 255 0 7 255 255 39; ... % tssi[118]
  4 255 0 7 255 255 38; ... % tssi[119]
  4 255 0 7 255 255 37; ... % tssi[120]
  4 255 0 6 255 255 36; ... % tssi[121]
  4 255 0 6 255 255 35; ... % tssi[122]
  3 255 0 6 255 255 34; ... % tssi[123]
  4 255 0 6 255 255 33; ... % tssi[124]
  4 255 0 6 255 255 32; ... % tssi[125]
  3 255 0 5 255 255 31; ... % tssi[126]
  4 255 0 5 255 255 28; ... % tssi[127]
];