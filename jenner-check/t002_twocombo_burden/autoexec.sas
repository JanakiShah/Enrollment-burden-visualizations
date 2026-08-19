/* Bundle setup for t002_twocombo_burden.
   The original script reads AN.coenrollim_us from a UNC network share
   (\\Dept\ChildrensHealthWatch\08Data\04Analytic_Data). That dataset isn't in the repo, so this
   builds a small synthetic stand-in with the same column shape the script expects: households
   (likelyeligibletanf=1, _imputation_=10 to match the script's own subsetting WHERE clause) with
   benefit_ct set to each of the six "two programs missing" groups the author defined
   (11/101/110/1001/1010/1100 = missing SNAP+Medicaid, TANF+Medicaid, WIC+Medicaid, SNAP+TANF,
   WIC+SNAP, WIC+TANF respectively), with the two relevant *b_4 burden columns populated
   (1=Learning Cost, 2=Compliance Cost, 3=Psychological Cost, 4=Choose Not to Participate) and the
   other two left missing. All values below are fabricated -- no real household or study data. */

options obs=100; /* cap input rows for the captured run */

libname AN "%sysfunc(pathname(work))";

data AN.coenrollim_us;
  infile datalines dsd dlm=' ' missover;
  input hh_id likelyeligibletanf _imputation_ benefit_ct
        mcb_4 snapb_4 tanfb_4 wicb_4 coenroll_sum gap;
  datalines;
2000 1 10 11 3 2 . . 2 1
2001 1 10 11 4 1 . . 2 1
2002 1 10 11 1 1 . . 2 1
2003 1 10 11 3 1 . . 2 1
2004 1 10 101 2 . 1 . 2 1
2005 1 10 101 1 . 4 . 2 1
2006 1 10 101 4 . 1 . 2 1
2007 1 10 101 2 . 1 . 2 1
2008 1 10 110 4 . . 1 2 1
2009 1 10 110 1 . . 2 2 1
2010 1 10 110 1 . . 4 2 1
2011 1 10 110 1 . . 2 2 1
2012 1 10 1001 . 1 2 . 2 1
2013 1 10 1001 . 3 4 . 2 1
2014 1 10 1001 . 2 1 . 2 1
2015 1 10 1001 . 3 2 . 2 1
2016 1 10 1010 . 1 . 2 2 1
2017 1 10 1010 . 3 . 1 2 1
2018 1 10 1010 . 1 . 1 2 1
2019 1 10 1010 . 2 . 4 2 1
2020 1 10 1100 . . 4 3 2 1
2021 1 10 1100 . . 4 4 2 1
2022 1 10 1100 . . 3 3 2 1
2023 1 10 1100 . . 2 2 2 1
;
run;
