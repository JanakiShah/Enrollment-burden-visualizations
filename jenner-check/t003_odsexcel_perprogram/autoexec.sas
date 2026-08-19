/* Bundle setup for t003_odsexcel_perprogram.
   Same synthetic AN.coenrollim_us stand-in as the sibling bundles: households
   (likelyeligibletanf=1, _imputation_=10) covering the four "one program missing" benefit_ct
   groups (111/1011/1101/1110 = missing Medicaid/SNAP/TANF/WIC) with a burden code
   (1=Learning Cost, 2=Compliance Cost, 3=Psychological Cost, 4=Choose Not to Participate) for the
   missing program. All values below are fabricated -- no real household or study data. */

options obs=100; /* cap input rows for the captured run */

libname AN "%sysfunc(pathname(work))";

data AN.coenrollim_us;
  infile datalines dsd dlm=' ' missover;
  input hh_id likelyeligibletanf _imputation_ benefit_ct
        mcb_4 snapb_4 tanfb_4 wicb_4 coenroll_sum gap;
  datalines;
1000 1 10 111 1 . . . 3 1
1001 1 10 111 1 . . . 3 1
1002 1 10 111 3 . . . 3 1
1003 1 10 111 2 . . . 3 1
1004 1 10 111 2 . . . 3 1
1005 1 10 111 2 . . . 3 1
1006 1 10 1011 . 1 . . 3 1
1007 1 10 1011 . 1 . . 3 1
1008 1 10 1011 . 4 . . 3 1
1009 1 10 1011 . 1 . . 3 1
1010 1 10 1011 . 1 . . 3 1
1011 1 10 1011 . 1 . . 3 1
1012 1 10 1101 . . 2 . 3 1
1013 1 10 1101 . . 2 . 3 1
1014 1 10 1101 . . 1 . 3 1
1015 1 10 1101 . . 2 . 3 1
1016 1 10 1101 . . 4 . 3 1
1017 1 10 1101 . . 2 . 3 1
1018 1 10 1110 . . . 4 3 1
1019 1 10 1110 . . . 3 3 1
1020 1 10 1110 . . . 1 3 1
1021 1 10 1110 . . . 2 3 1
1022 1 10 1110 . . . 4 3 1
1023 1 10 1110 . . . 3 3 1
;
run;
