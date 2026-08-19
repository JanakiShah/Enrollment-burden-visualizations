/* Bundle setup for t001_onecombo_burden.
   The original script reads AN.coenrollim_us from a UNC network share
   (\\Dept\ChildrensHealthWatch\08Data\04Analytic_Data). That dataset isn't in the repo, so this
   builds a small synthetic stand-in with the same column shape the script expects: one row per
   household (likelyeligibletanf=1, _imputation_=10 to match the script's own subsetting WHERE
   clause), benefit_ct holding the author's own digit-coded "which program is missing" groups
   (111/1011/1101/1110 = missing Medicaid/SNAP/TANF/WIC respectively), and the corresponding
   *b_4 burden code (1=Learning Cost, 2=Compliance Cost, 3=Psychological Cost,
   4=Choose Not to Participate) populated only for the missing program, per the author's own
   finalf format. All values below are fabricated -- no real household or study data. */

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
