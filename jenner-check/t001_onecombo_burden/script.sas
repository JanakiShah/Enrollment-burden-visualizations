/* Adapted from enrollment_AdminBurden_viz.sas (JanakiShah/Enrollment-burden-visualizations)
   Original reads AN.coenrollim_us from a UNC network share (\\Dept\ChildrensHealthWatch\...).
   Here that source is replaced with a small inline mock dataset (mock_coenroll, in autoexec.sas)
   shaped like the real one: one row per household x imputation, with likelyeligibletanf,
   _imputation_, benefit_ct (which of the 4 programs a household is missing, as the author's own
   digit-coded groups), and the 4 program-burden codes (mcb_4/snapb_4/tanfb_4/wicb_4, coded
   1=Learning Cost, 2=Compliance Cost, 3=Psychological Cost, 4=Choose Not to Participate, per the
   author's finalf format below). Everything downstream -- the PROC FORMAT catalog, the PROC
   SUMMARY/PROC SQL/DATA-step combinatorics, and the PROC SGPLOT calls -- is the author's own code,
   unmodified except for the swapped data source. */

/**************************************/
/*				FORMATS			   	  */
/**************************************/
proc format;
value yn01f		1='1=yes' 0='0=no';

value statusf 1='1=20 or more hours'
              0='Less than 20 hours';

value evictionstatusf 2='2=formal evictions'
                      1='1=informal evictions'
					  0='0=no evictions';

value energy4f 	    0='0=No Energy Problems' 1='1=Less Severe-threatened'
				    2='2=Severe-shut off/unheated/cooking stove' 3='3=Landlord pays';

value snap4f 1="SNAP participant"
2="SNAP non-participant(access problems)"
3="SNAP non-participant(no perceived need)"
4="SNAP non-participant(uncertain eligibility)"
5="SNAP non-participant(pending)"
6="SNAP non-participant(Concerned about immigration/stigma/personal reasons)";
value wel4f
1="Welfare participant"
2="Welfare non-participant(access problems)"
3="Welfare non-participant(no perceived need)"
4="Welfare non-participant(uncertain eligibility)"
5="Welfare non-participant(pending)" 6="Welfare non-participant(child support)"
7="Welfare non-participant(family cap)";

value wic6f 1="WIC participant"
2="WIC non-participant(access problems)"
3="WIC non-participant(no perceived need)"
4="WIC non-participant(uncertain eligibility)"
5="WIC non-participant(Pending WIC application/ reapplication)"
6="WIC non-participant(Not meeting food need)";

value childinsuraf 0="No insurance/lost coverage"
1="Has public insurance/didn't lose coverage"
2="Insurance pending (newborn)" ;
value coenrollsf 0="No programs" 1="Enrolled in one program"
2="Enrolled in two programs" 3="Enrolled in three programs" 4="Enrolled in four programs";
value coinsuraf 0="No insurance" 1="Has public insurance"  ;

value finalf
1= "[1]=Learning Cost "
2= "[2]=Compliance Cost "
3= "[3]=Psychological Cost"
4= "[4]=Choose Not to Participate"
;
value gap4f
1= "[1]=Not enrolled in 1 program"
2= "[2]=Not enrolled in 2 programs"
3= "[3]=Not enrolled in 3 programs"
4= "[4]=Not enrolled in 4 programs"
;
run;

/**************************************/
/*	   one imputation for testing	  */
/**************************************/

/* subset one imputation for developing code */
data temp_im1;
set AN.coenrollim_us;
where likelyeligibletanf=1 and _imputation_=10;
run;
/* why are there missing values in coenroll_sum, but NOT in gap? */
/* use coenroll_sum FREQS to compare/check with prg_total1 and prg_total when calculated below */
proc freq data=temp_im1;
table gap coenroll_sum;
run;

/**************************************/
/*	   one program missing			  */
/**************************************/

proc freq data=temp_im1;
where benefit_ct in (111 1011 1101 1110); /* missing Med, SNAP, TANF, WIC*/
table benefit_ct*mcb_4 benefit_ct*snapb_4 benefit_ct*tanfb_4 benefit_ct*wicb_4/norow nocol nopercent ;
run;

/* calculate summaries for each combination of enrolled programs */
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (111 1011 1101 1110); /* missing Med, SNAP, TANF, WIC*/
   class mcb_4 snapb_4 tanfb_4 wicb_4/ preloadfmt order=formated missing;
   output out=countsone0;
run;
/* use the prg_total variable to label the plots with the total number of households */
proc sql;
create table countsone1 as
select *, sum(_FREQ_) as prg_total1,
sum(case when nmiss(mcb_4, snapb_4, tanfb_4, wicb_4)=3 then _FREQ_ else . end) as prg_total /* total households with one program missing and reported a burden */
from countsone0;
quit;
data onecombo;
set countsone1;
if missing(mcb_4)=0 and missing(snapb_4)=1 and missing(tanfb_4)=1 and missing(wicb_4)=1 then do;
    program="M";
	burden=mcb_4;
	end;
if missing(mcb_4)=1 and missing(snapb_4)=0 and missing(tanfb_4)=1 and missing(wicb_4)=1 then do;
    program="S";
	burden=snapb_4;
	end;
if missing(mcb_4)=1 and missing(snapb_4)=1 and missing(tanfb_4)=0 and missing(wicb_4)=1 then do;
    program="T";
	burden=tanfb_4;
	end;
if missing(mcb_4)=1 and missing(snapb_4)=1 and missing(tanfb_4)=1 and missing(wicb_4)=0 then do;
    program="W";
	burden=wicb_4;
	end;
format burden finalf.;
run;

proc sgplot data=onecombo;
	Hbar burden/ response=_FREQ_ stat=sum statlabel;
run;
/* stacked barplot by program */
proc sgplot data=onecombo;
	hbarparm category=burden response=_FREQ_ / group=program groupdisplay=stack;
run;
