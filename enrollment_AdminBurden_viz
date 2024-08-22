libname library  '\Dept\ChildrensHealthWatch\08Data\05Formats\x64';
libname AN '\\Dept\ChildrensHealthWatch\08Data\04Analytic_Data';
options nofmterr fmtsearch=(work library.formats_64);

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
value gap3f
1= "[1]=Not enrolled in 1 program"
2= "[2]=Not enrolled in 2 programs"
3= "[3]=Not enrolled in 3 or 4 programs"
;
value learningf 
1= "[1]=Learning Cost WIC"
2= "[2]=Learning Cost SNAP"
3= "[3]=Learning Cost TANF"
4= "[4]=Learning Cost Medicaid"
;

value compf
1= "[1]=Compliance Cost WIC"
2= "[2]=Compliance Cost SNAP"
3= "[3]=Compliance Cost TANF"
4= "[4]=Compliance Cost Medicaid"
;
value psychf
1= "[1]=Psychological Cost WIC"
2= "[2]=Psychological Cost SNAP"
3= "[3]=Psychological Cost TANF"
4= "[4]=Psychological Cost Medicaid"
;
value comparef
1= "[1]=Choose Not to Participate WIC"
2= "[2]=Choose Not to Participate SNAP"
3= "[3]=Choose Not to Participate TANF"
4= "[4]=No Change in Status Medicaid"
;
value wicbf
1= "[1]=Learning Cost WIC"
2= "[2]=Compliance Cost WIC"
3= "[3]=Psychological Cost WIC"
4= "[4]=Choose Not to Participate WIC"
;

value snapbf
1= "[1]=Learning Cost SNAP"
2= "[2]=Compliance Cost SNAP"
3= "[3]=Psychological Cost SNAP"
4= "[4]=Choose Not to Participate SNAP"
;
value tanfbf
1= "[1]=Learning Cost TANF"
2= "[2]=Compliance Cost TANF"
3= "[3]=Psychological Cost TANF"
4= "[4]=Choose Not to Participate TANF"
;
value mcbf
1= "[1]=Learning Cost Medicaid"
2= "[2]=Compliance Cost Medicaid"
3= "[3]=Psychological Cost Medicaid"
4= "[4]=Choose Not to Participate Medicaid"
;
value gap5f
0= "[0]=enrolled in all programs"
1= "[1]=Not enrolled in 1 program"
2= "[2]=Not enrolled in 2 programs"
3= "[3]=Not enrolled in 3 programs"
4= "[4]=Not enrolled in 4 programs"
;
value exclf
0= "[0]=SSGI analysis sample"
1= "[1]=missing enrollment sum"
;
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
value burd_label3f
1= "LLL"
2= "LLC"
3= "LLP"
4= "LLN"
5= "LCC"
6= "LCP"
7= "LCN"
8= "LPP"
9= "LPN"
10= "LNN"
11= "CCC"
12= "CCP"
13= "CCN"
14= "CPP"
15= "CPN"
16= "CNN"
17= "PPP"
18= "PPN"
19= "PNN"
20= "NNN"
;
value burd_label4f
1= "LLLL"
2= "LLLC"
3= "LLLP"
4= "LLLO"
5= "LLCC"
6= "LLCP"
7= "LLCO"
8= "LLPP"
9= "LLPO"
10= "LLOO"
11= "LCCC"
12= "LCCP"
13= "LCCO"
14= "LCPP"
15= "LCPO"
16= "LCOO"
17= "LPPP"
18= "LPPO"
19= "LPOO"
20= "LOOO"
21= "CCCC"
22= "CCCP"
23= "CCCO"
24= "CCPP"
25= "CCPO"
26= "CCOO"
27= "CPPP"
28= "CPPO"
29= "CPOO"
30= "COOO"
31= "PPPP"
32= "PPPO"
33= "PPOO"
34= "POOO"
35= "OOOO"
;
run;
 

/**************************************/
/*	   Descriptives					  */
/**************************************/



/* check combinations of programs missing match those with administrative burdens reported */
PROC FREQ DATA=AN.coenrollim_us(where=(_imputation_=1));
where likelyeligibletanf=1;
*table gap_ct*coenroll_sum / nocol norow nopercent missing;
table benefit_ct*mcb_4 benefit_ct*snapb_4 benefit_ct*tanfb_4 benefit_ct*wicb_4/norow nocol nopercent ;
RUN;


/**************************************/
/*	  	 one imputation for testing	  */
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



/**************************************/
/*	   three programs missing		  */
/**************************************/

proc freq data=temp_im1;
where benefit_ct in (1 10 100 1000); /* missing SNAP/Med/TANF, WIC/SNAP/Med, WIC/TANF/Med, WIC/SNAP/TANF */
table benefit_ct*mcb_4 benefit_ct*snapb_4 benefit_ct*tanfb_4 benefit_ct*wicb_4/norow nocol nopercent ;
run;

/* calculate summaries for each combination of enrolled programs */
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (1 10 100 1000); /* missing SNAP/Med/TANF, WIC/SNAP/Med, WIC/TANF/Med, WIC/SNAP/TANF */
   class mcb_4 snapb_4 tanfb_4 wicb_4/ preloadfmt order=formated missing;
   output out=countsthree0;
run;
/* use the prg_total variable to label the plots with the total number of households */
proc sql;
create table countsthree1 as
select *, sum(_FREQ_) as prg_total1, 
sum(case when nmiss(mcb_4, snapb_4, tanfb_4, wicb_4)=1 then _FREQ_ else . end) as prg_total /* total households with one program missing and reported a burden */
from countsthree0;
quit;

/* create combined categories for 3 programs */
/* after running this block, visually check all higher order combinations have FREQ=0 */
options missing=' ';
data threecombo;
set countsthree1;
burden_ct=N(mcb_4, snapb_4, tanfb_4, wicb_4);
if missing(mcb_4)=0 then mcb_burd=mcb_4;
if missing(snapb_4)=0 then snapb_burd=snapb_4;
if missing(tanfb_4)=0 then tanfb_burd=tanfb_4;
if missing(wicb_4)=0 then wicb_burd=wicb_4;
format mcb_burd snapb_burd tanfb_burd wicb_burd burdf.;
burd0=catx("_", mcb_burd, snapb_burd, tanfb_burd, wicb_burd);
if burd0="1_1_1"                                           then burd_label3=1; /* LLL */
   else if burd0="1_1_2" or burd0="1_2_1" or burd0="2_1_1" then burd_label3=2; /* LLC */
   else if burd0="1_1_3" or burd0="1_3_1" or burd0="3_1_1" then burd_label3=3; /* LLP */
   else if burd0="1_1_4" or burd0="1_4_1" or burd0="4_1_1" then burd_label3=4; /* LLO */

   else if burd0="1_2_2" or burd0="2_1_2" or 
           burd0="2_2_1"                     then burd_label3=5; /* LCC */
   else if burd0="1_2_3" or burd0="1_3_2" or 
           burd0="2_1_3" or burd0="2_3_1" or 
		   burd0="3_1_2" or burd0="3_2_1"    then burd_label3=6; /* LCP */
   else if burd0="1_2_4" or burd0="1_4_2" or 
           burd0="2_1_4" or burd0="2_4_1" or 
		   burd0="4_1_2" or burd0="4_2_1"    then burd_label3=7; /* LCO */

   else if burd0="1_3_3" or burd0="3_1_3" or 
           burd0="3_3_1"                     then burd_label3=8; /* LPP */
   else if burd0="1_3_4" or burd0="1_4_3" or 
           burd0="3_1_4" or burd0="3_4_1" or 
		   burd0="4_1_3" or burd0="4_3_1"    then burd_label3=9; /* LPO */

   else if burd0="1_4_4" or burd0="4_1_4" or 
           burd0="4_4_1"                     then burd_label3=10; /* LOO */

   else if burd0="2_2_2"                                   then burd_label3=11; /* CCC */
   else if burd0="2_2_3" or burd0="2_3_2" or burd0="3_2_2" then burd_label3=12; /* CCP */
   else if burd0="2_2_4" or burd0="2_4_2" or burd0="4_2_2" then burd_label3=13; /* CCO */

   else if burd0="2_3_3" or burd0="3_2_3" or 
           burd0="3_3_2"                     then burd_label3=14; /* CPP */
   else if burd0="2_3_4" or burd0="2_4_3" or 
           burd0="3_2_4" or burd0="3_4_2" or 
		   burd0="4_2_3" or burd0="4_3_2"    then burd_label3=15; /* CPO */
   else if burd0="2_4_4" or burd0="4_2_4" or 
           burd0="4_4_2"                     then burd_label3=16; /* COO */

   else if burd0="3_3_3"                                   then burd_label3=17; /* PPP */
   else if burd0="3_3_4" or burd0="3_4_3" or burd0="4_3_3" then burd_label3=18; /* PPO */

   else if burd0="3_4_4" or burd0="4_3_4" or 
           burd0="4_4_3"                     then burd_label3=19; /* POO */

   else if burd0="4_4_4"                                   then burd_label3=20; /* OOO */

format burd_label3 burd_label3f.;
run;
options missing='.';

proc sgplot data=threecombo;
	Hbar burd_label3/ response=_FREQ_ stat=sum statlabel; 
run;


/**************************************/
/*	   four programs missing		  */
/**************************************/

proc freq data=temp_im1;
where benefit_ct in (0); /* missing all four programs */
table benefit_ct*mcb_4 benefit_ct*snapb_4 benefit_ct*tanfb_4 benefit_ct*wicb_4/norow nocol nopercent ;
run;

/* calculate summaries for each combination of enrolled programs */
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (0); /* missing all four programs */
   class mcb_4 snapb_4 tanfb_4 wicb_4/ preloadfmt order=formated missing;
   output out=countsfour0;
run;
/* use the prg_total variable to label the plots with the total number of households */
proc sql;
create table countsfour1 as
select *, sum(_FREQ_) as prg_total1, 
sum(case when nmiss(mcb_4, snapb_4, tanfb_4, wicb_4)=0 then _FREQ_ else . end) as prg_total /* total households with one program missing and reported a burden */
from countsfour0;
quit;

/* create combined categories for 3 programs */
/* after running this block, visually check all higher order combinations have FREQ=0 */
options missing=' ';
data fourcombo;
set countsfour1;
burden_ct=N(mcb_4, snapb_4, tanfb_4, wicb_4);
if missing(mcb_4)=0 then mcb_burd=mcb_4;
if missing(snapb_4)=0 then snapb_burd=snapb_4;
if missing(tanfb_4)=0 then tanfb_burd=tanfb_4;
if missing(wicb_4)=0 then wicb_burd=wicb_4;
format mcb_burd snapb_burd tanfb_burd wicb_burd burdf.;
burd0=catx("_", mcb_burd, snapb_burd, tanfb_burd, wicb_burd);
if burd0="1_1_1_1"                            then burd_label4=1; /* LLLL */
   else if burd0="1_1_1_2" or burd0="1_1_2_1" or 
           burd0="1_2_1_1" or burd0="2_1_1_1" then burd_label4=2; /* LLLC */
   else if burd0="1_1_1_3" or burd0="1_1_3_1" or 
           burd0="1_3_1_1" or burd0="3_1_1_1" then burd_label4=3; /* LLLP */
   else if burd0="1_1_1_4" or burd0="1_1_4_1" or 
           burd0="1_4_1_1" or burd0="4_1_1_1" then burd_label4=4; /* LLLO */

   else if burd0="1_1_2_2" or burd0="1_2_1_2" or burd0="1_2_2_1" or
           burd0="2_2_1_1" or burd0="2_1_2_1" or burd0="2_1_1_2" then burd_label4=5; /* LLCC */
   else if burd0="1_1_2_3" or burd0="1_1_3_2" or burd0="1_2_1_3" or burd0="1_2_3_1" or
           burd0="1_3_1_2" or burd0="1_3_2_1" or burd0="2_1_1_3" or burd0="2_1_3_1" or
           burd0="2_3_1_1" or burd0="3_1_1_2" or burd0="3_1_2_1" or burd0="3_2_1_1" then burd_label4=6; /* LLCP */
   else if burd0="1_1_2_4" or burd0="1_1_4_2" or burd0="1_2_1_4" or burd0="1_2_4_1" or
           burd0="1_4_1_2" or burd0="1_4_2_1" or burd0="2_1_1_4" or burd0="2_1_4_1" or
           burd0="2_4_1_1" or burd0="4_1_1_2" or burd0="4_1_2_1" or burd0="4_2_1_1" then burd_label4=7; /* LLCO */

   else if burd0="1_1_3_3" or burd0="1_3_1_3" or burd0="1_3_3_1" or
           burd0="3_3_1_1" or burd0="3_1_3_1" or burd0="3_1_1_3" then burd_label4=8; /* LLPP */
   else if burd0="1_1_3_4" or burd0="1_1_4_3" or burd0="1_3_1_4" or burd0="1_3_4_1" or
           burd0="1_4_1_3" or burd0="1_4_3_1" or burd0="3_1_1_4" or burd0="3_1_4_1" or
           burd0="3_4_1_1" or burd0="4_1_1_3" or burd0="4_1_3_1" or burd0="4_3_1_1" then burd_label4=9; /* LLPO */

   else if burd0="1_1_4_4" or burd0="1_4_1_4" or burd0="1_4_4_1" or
           burd0="4_4_1_1" or burd0="4_1_4_1" or burd0="4_1_1_4" then burd_label4=10; /* LLOO */

   else if burd0="1_2_2_2" or burd0="2_1_2_2" or 
           burd0="2_2_1_2" or burd0="2_2_2_1" then burd_label4=11; /* LCCC */
   else if burd0="2_2_1_3" or burd0="2_2_3_1" or burd0="2_1_2_3" or burd0="2_1_3_2" or
           burd0="2_3_2_1" or burd0="2_3_1_2" or burd0="1_2_2_3" or burd0="1_2_3_2" or
           burd0="1_3_2_2" or burd0="3_2_2_1" or burd0="3_2_1_2" or burd0="3_1_2_2" then burd_label4=12; /* LCCP */
   else if burd0="2_2_1_4" or burd0="2_2_4_1" or burd0="2_1_2_4" or burd0="2_1_4_2" or
           burd0="2_4_2_1" or burd0="2_4_1_2" or burd0="1_2_2_4" or burd0="1_2_4_2" or
           burd0="1_4_2_2" or burd0="4_2_2_1" or burd0="4_2_1_2" or burd0="4_1_2_2" then burd_label4=13; /* LCCO */

   else if burd0="3_3_1_2" or burd0="3_3_2_1" or burd0="3_1_3_2" or burd0="3_1_2_3" or
           burd0="3_2_3_1" or burd0="3_2_1_3" or burd0="1_3_3_2" or burd0="1_3_2_3" or
           burd0="1_2_3_3" or burd0="2_3_3_1" or burd0="2_3_1_3" or burd0="2_1_3_3" then burd_label4=14; /* LCPP */
   else if burd0="1_2_3_4" or burd0="1_2_4_3" or burd0="1_3_2_4" or burd0="1_3_4_2" or burd0="1_4_2_3" or burd0="1_4_3_2" or
           burd0="2_3_4_1" or burd0="2_3_1_4" or burd0="2_4_1_3" or burd0="2_4_3_1" or burd0="2_1_3_4" or burd0="2_1_4_3" or
		   burd0="3_4_1_2" or burd0="3_4_2_1" or burd0="3_1_4_2" or burd0="3_1_2_4" or burd0="3_2_4_1" or burd0="3_2_1_4" or
           burd0="4_1_2_3" or burd0="4_1_3_2" or burd0="4_2_1_3" or burd0="4_2_3_1" or burd0="4_3_1_2" or burd0="4_3_2_1"
           then burd_label4=15; /* LCPO */
   else if burd0="4_4_1_2" or burd0="4_4_2_1" or burd0="4_1_4_2" or burd0="4_1_2_4" or
           burd0="4_2_4_1" or burd0="4_2_1_4" or burd0="1_4_4_2" or burd0="1_4_2_4" or
           burd0="1_2_4_4" or burd0="2_4_4_1" or burd0="2_4_1_4" or burd0="2_1_4_4" then burd_label4=16; /* LCOO */

   else if burd0="1_3_3_3" or burd0="3_1_3_3" or 
           burd0="3_3_1_3" or burd0="3_3_3_1"  then burd_label4=17; /* LPPP */
   else if burd0="3_3_1_4" or burd0="3_3_4_1" or burd0="3_1_3_4" or burd0="3_1_4_3" or
           burd0="3_4_3_1" or burd0="3_4_1_3" or burd0="1_3_3_4" or burd0="1_3_4_3" or
           burd0="1_4_3_3" or burd0="4_3_3_1" or burd0="4_3_1_3" or burd0="4_1_3_3" then burd_label4=18; /* LPPO */

   else if burd0="4_4_1_3" or burd0="4_4_3_1" or burd0="4_1_4_3" or burd0="4_1_3_4" or
           burd0="4_3_4_1" or burd0="4_3_1_4" or burd0="1_4_4_3" or burd0="1_4_3_4" or
           burd0="1_3_4_4" or burd0="3_4_4_1" or burd0="3_4_1_4" or burd0="3_1_4_4" then burd_label4=19; /* LPOO */

   else if burd0="1_4_4_4" or burd0="4_1_4_4" or 
           burd0="4_4_1_4" or burd0="4_4_4_1"  then burd_label4=20; /* LOOO */

if burd0="2_2_2_2"                                           then burd_label4=21; /* CCCC */
   else if burd0="2_2_2_3" or burd0="2_2_3_2" or 
           burd0="2_3_2_2" or burd0="3_2_2_2"  then burd_label4=22; /* CCCP */
   else if burd0="2_2_2_4" or burd0="2_2_4_2" or 
           burd0="2_4_2_2" or burd0="4_2_2_2"  then burd_label4=23; /* CCCO */

   else if burd0="2_2_3_3" or burd0="2_3_2_3" or burd0="2_3_3_2" or
           burd0="3_3_2_2" or burd0="3_2_3_2" or burd0="3_2_2_3" then burd_label4=24; /* CCPP */
   else if burd0="2_2_3_4" or burd0="2_2_4_3" or burd0="2_3_2_4" or burd0="2_3_4_2" or
           burd0="2_4_2_3" or burd0="2_4_3_2" or burd0="3_2_2_4" or burd0="3_2_4_2" or
           burd0="3_4_2_2" or burd0="4_2_2_3" or burd0="4_2_3_2" or burd0="4_3_2_2" then burd_label4=25; /* CCPO */
   else if burd0="2_2_4_4" or burd0="2_4_2_4" or burd0="2_4_4_2" or
           burd0="4_4_2_2" or burd0="4_2_4_2" or burd0="4_2_2_4" then burd_label4=26; /* CCOO */

   else if burd0="2_3_3_3" or burd0="3_3_2_3" or 
           burd0="3_2_3_3" or burd0="3_3_3_2"  then burd_label4=27; /* CPPP */
   else if burd0="3_3_2_4" or burd0="3_3_4_2" or burd0="3_2_3_4" or burd0="3_2_4_3" or
           burd0="3_4_3_2" or burd0="3_4_2_3" or burd0="2_3_3_4" or burd0="2_3_4_3" or
           burd0="2_4_3_3" or burd0="4_3_3_2" or burd0="4_3_2_3" or burd0="4_2_3_3" then burd_label4=28; /* CPPO */

   else if burd0="4_4_2_3" or burd0="4_4_3_2" or burd0="4_2_4_3" or burd0="4_2_3_4" or
           burd0="4_3_4_2" or burd0="4_3_2_4" or burd0="2_4_4_3" or burd0="2_4_3_4" or
           burd0="2_3_4_4" or burd0="3_4_4_2" or burd0="3_4_2_4" or burd0="3_2_4_4" then burd_label4=29; /* CPOO */

   else if burd0="2_4_4_4" or burd0="4_4_2_4" or 
           burd0="4_2_4_4" or burd0="4_4_4_2"  then burd_label4=30; /* COOO */

if burd0="3_3_3_3"                                           then burd_label4=31; /* PPPP */
   else if burd0="3_3_3_4" or burd0="3_3_4_3" or 
           burd0="3_4_3_3" or burd0="4_3_3_3"  then burd_label4=32; /* PPPO */

   else if burd0="3_3_4_4" or burd0="3_4_3_4" or burd0="3_4_4_3" or
           burd0="4_4_3_3" or burd0="4_3_4_3" or burd0="4_3_3_4" then burd_label4=33; /* PPOO */

   else if burd0="3_4_4_4" or burd0="4_4_3_4" or 
           burd0="4_3_4_4" or burd0="3_4_4_4"  then burd_label4=34; /* POOO */

if burd0="4_4_4_4"                                           then burd_label4=35; /* OOOO */

format burd_label4 burd_label4f.;
run;
options missing='.';

proc sgplot data=fourcombo;
	Hbar burd_label4/ response=_FREQ_ stat=sum statlabel; 
run;


/**************************************/
/*	   export plots					  */
/**************************************/

ODS EXCEL FILE="\\ad.bu.edu\bumcfiles\SPH\DCC\Dept\ChildrensHealthWatch\07Analyses_and_Reporting\03Analyses\Coenrollment\Administrative_Burden_DataViz_&rundate..xlsx"
options(sheet_name = "figures" sheet_interval="none" embedded_titles ="on" start_at ="2,2" ); *embedded_titles puts header row in the worksheet;
ods graphics / width=640 height=400px;

/* one program missing */
proc sgplot data=onecombo;
    title 'Missing 1 program : 5954 households';
	Hbar burden/ response=_FREQ_ stat=sum statlabel; 
run;
/* stacked barplot by program */
proc sgplot data=onecombo;
    title 'Missing 1 program : 5954 households';
	hbarparm category=burden response=_FREQ_ / group=program groupdisplay=stack;
run;

/* two programs missing */
proc sgplot data=twocombo;
    title 'Missing 2 programs : 2974 households';
	Hbar burd_label2/ response=_FREQ_ stat=sum statlabel; 
run;

/* three programs missing */
proc sgplot data=threecombo;
    title 'Missing 3 programs : 741 households';
	Hbar burd_label3/ response=_FREQ_ stat=sum statlabel; 
run;

/* four programs missing */
ods graphics / width=640 height=800px;
proc sgplot data=fourcombo;
    title 'Missing 4 programs : 94 households';
	Hbar burd_label4/ response=_FREQ_ stat=sum statlabel; 
run;
title;

ods graphics / width=440 height=300px;
proc sgplot data=onecombo_M;
    title1 'Medicaid administrative burdens : 177 households';
	title2 'out of 5954 households missing 1 program';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CXFFFF00); 
run;
proc sgplot data=onecombo_S;
    title1 'SNAP administrative burdens : 421 households';
	title2 'out of 5954 households missing 1 program';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CX00FF00); 
run;
proc sgplot data=onecombo_T;
    title1 'TANF administrative burdens : 4430 households';
	title2 'out of 5954 households missing 1 program';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CX0000FF); 
run;
proc sgplot data=onecombo_W;
    title1 'WIC administrative burdens : 926 households';
	title2 'out of 5954 households missing 1 program';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CXFF00FF); 
run;
title1;
title2;

ODS EXCEL CLOSE;



/**************************************************************/
/*	   additional individual plots for one program missing	  */
/**************************************************************/

/* calculate summaries for each combination of enrolled programs */
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (111); /* missing Med */
   class mcb_4/ preloadfmt order=formated missing;
   output out=countsone0_M;
run;
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in ( 1011 ); /* missing SNAP */
   class snapb_4 / preloadfmt order=formated missing;
   output out=countsone0_S;
run;
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (1101 ); /* missing TANF */
   class  tanfb_4 / preloadfmt order=formated missing;
   output out=countsone0_T;
run;
proc summary data=temp_im1 nway completetypes;
   where benefit_ct in (1110); /* missing WIC*/
   class wicb_4/ preloadfmt order=formated missing;
   output out=countsone0_W;
run;
/* use the prg_total variable to label the plots with the total number of households */
proc sql;
create table countsone1_M as
select *, sum(_FREQ_) as prg_total1
from countsone0_M;
quit;
proc sql;
create table countsone1_S as
select *, sum(_FREQ_) as prg_total1 /* total households with one program missing and reported a burden */
from countsone0_S;
quit;
proc sql;
create table countsone1_T as
select *, sum(_FREQ_) as prg_total1 /* total households with one program missing and reported a burden */
from countsone0_T;
quit;
proc sql;
create table countsone1_W as
select *, sum(_FREQ_) as prg_total1 /* total households with one program missing and reported a burden */
from countsone0_W;
quit;
data onecombo_M;
set countsone1_M;
if missing(mcb_4)=0 then do;
    program="M";
	burden=mcb_4;
	end;
format burden finalf.;
run;
data onecombo_S;
set countsone1_S;
if missing(snapb_4)=0 then do;
    program="S";
	burden=snapb_4;
	end;
format burden finalf.;
run;
data onecombo_T;
set countsone1_T;
if missing(tanfb_4)=0 then do;
    program="T";
	burden=tanfb_4;
	end;
format burden finalf.;
run;
data onecombo_W;
set countsone1_W;
if missing(wicb_4)=0 then do;
    program="W";
	burden=wicb_4;
	end;
format burden finalf.;
run;

proc sgplot data=onecombo_M;
    title 'Medicaid administrative burdens : 177 households';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CXFFFF00); 
run;
proc sgplot data=onecombo_S;
    title 'SNAP administrative burdens : 421 households';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CX00FF00); 
run;
proc sgplot data=onecombo_T;
    title 'TANF administrative burdens : 4430 households';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CX0000FF); 
run;
proc sgplot data=onecombo_W;
    title 'WIC administrative burdens : 926 households';
	Hbar burden/ response=_FREQ_ stat=sum statlabel fillattrs=(color=CXFF00FF); 
run;
