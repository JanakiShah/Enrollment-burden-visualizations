/* Adapted from enrollment_AdminBurden_viz.sas (JanakiShah/Enrollment-burden-visualizations)
   Original reads AN.coenrollim_us from a UNC network share and writes the ODS EXCEL destination
   to a UNC path (\\ad.bu.edu\bumcfiles\...&rundate..xlsx). Here the data source is the same small
   inline mock used by the sibling bundles, and the ODS EXCEL FILE= target is a relative path.
   The four per-program summary DATA/PROC SUMMARY/PROC SQL steps (originally further down the file,
   in the author's own "additional individual plots" section) are reordered ahead of the ODS EXCEL
   block so onecombo_M/S/T/W exist before the block that plots them -- a reordering only, no logic
   changed. The ODS EXCEL options, per-plot titles (with the author's own household counts), custom
   fillattrs colors, and PROC SGPLOT calls are the author's own code, unmodified. */

proc format;
value finalf
1= "[1]=Learning Cost "
2= "[2]=Compliance Cost "
3= "[3]=Psychological Cost"
4= "[4]=Choose Not to Participate"
;
run;

data temp_im1;
set AN.coenrollim_us;
where likelyeligibletanf=1 and _imputation_=10;
run;

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

/**************************************/
/*	   export plots					  */
/**************************************/

ODS EXCEL FILE="./output/Administrative_Burden_DataViz.xlsx"
options(sheet_name = "figures" sheet_interval="none" embedded_titles ="on" start_at ="2,2" ); *embedded_titles puts header row in the worksheet;

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
