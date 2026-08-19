/* Adapted from enrollment_AdminBurden_viz.sas (JanakiShah/Enrollment-burden-visualizations)
   Original reads AN.coenrollim_us from a UNC network share (\\Dept\ChildrensHealthWatch\...).
   Here that source is replaced with a small inline mock dataset (built below with DATALINES),
   shaped like the real one, covering the six "two programs missing" benefit_ct groups the author
   defined (11, 101, 110, 1001, 1010, 1100). Everything downstream -- the burdf/burd_label2f
   formats, the PROC SUMMARY/PROC SQL aggregation, and the DATA step building the two-letter
   burden-combination code (LL/LC/LP/... via CATX + cascading IF/ELSE IF) and the final
   PROC SGPLOT -- is the author's own code, unmodified except for the swapped data source.
   All values below are fabricated -- no real household or study data. */

/**************************************/
/*	   mock AN.coenrollim_us		  */
/**************************************/
data AN_coenrollim_us;
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

/**************************************/
/*				FORMATS			   	  */
/**************************************/
proc format;
value burdf
1= "L"
2= "C"
3= "P"
4= "O"
;
value burd_label2f
1= "LL"
2= "LC"
3= "LP"
4= "LN"
5= "CC"
6= "CP"
7= "CN"
8= "PP"
9= "PN"
10= "NN"
;
run;

/**************************************/
/*	   one imputation for testing	  */
/**************************************/

/* subset one imputation for developing code */
data temp_im1;
set AN_coenrollim_us;
where likelyeligibletanf=1 and _imputation_=10;
run;

/**************************************/
/*	   two programs missing			  */
/**************************************/

proc freq data=temp_im1;
where benefit_ct in (11 101 110 1001 1010 1100); /* missing SNAP/Med, TANF/Med, WIC/Med, SNAP/TANF, WIC/SNAP, WIC/TANF */
table benefit_ct*mcb_4 benefit_ct*snapb_4 benefit_ct*tanfb_4 benefit_ct*wicb_4/norow nocol nopercent ;
run;

/* calculate summaries for each combination of enrolled programs */
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (11 101 110 1001 1010 1100); /* missing SNAP/Med, TANF/Med, WIC/Med, SNAP/TANF, WIC/SNAP, WIC/TANF */
   class mcb_4 snapb_4 tanfb_4 wicb_4/ preloadfmt order=formated missing;
   output out=countstwo0;
run;
/* use the prg_total variable to label the plots with the total number of households */
proc sql;
create table countstwo1 as
select *, sum(_FREQ_) as prg_total1,
sum(case when nmiss(mcb_4, snapb_4, tanfb_4, wicb_4)=2 then _FREQ_ else . end) as prg_total /* total households with one program missing and reported a burden */
/* specifying exact nmiss includes only those households who reported reasons for all missing programs (aka complete case analysis) */
from countstwo0;
quit;

/* create combined categories for 2 programs */
/* after running this block, visually check all higher order combinations have FREQ=0 */
/* need to set missing to blank for numeric in order for concatenate to work properly (not concatenate periods) */
options missing=' ';
data twocombo;
set countstwo1;
burden_ct=N(mcb_4, snapb_4, tanfb_4, wicb_4);
if missing(mcb_4)=0 then mcb_burd=mcb_4;
if missing(snapb_4)=0 then snapb_burd=snapb_4;
if missing(tanfb_4)=0 then tanfb_burd=tanfb_4;
if missing(wicb_4)=0 then wicb_burd=wicb_4;
format mcb_burd snapb_burd tanfb_burd wicb_burd burdf.;
burd0=catx("_", mcb_burd, snapb_burd, tanfb_burd, wicb_burd);
if burd0="1_1"                        then burd_label2=1; /* LL */
   else if burd0="1_2" or burd0="2_1" then burd_label2=2; /* LC */
   else if burd0="1_3" or burd0="3_1" then burd_label2=3; /* LP */
   else if burd0="1_4" or burd0="4_1" then burd_label2=4; /* LO */
   else if burd0="2_2"                then burd_label2=5; /* CC */
   else if burd0="2_3" or burd0="3_2" then burd_label2=6; /* CP */
   else if burd0="2_4" or burd0="4_2" then burd_label2=7; /* CO */
   else if burd0="3_3"                then burd_label2=8; /* PP */
   else if burd0="3_4" or burd0="4_3" then burd_label2=9; /* PO */
   else if burd0="4_4"                then burd_label2=10; /* OO */
format burd_label2 burd_label2f.;
run;
options missing='.';

proc sgplot data=twocombo;
	Hbar burd_label2/ response=_FREQ_ stat=sum statlabel;
run;
