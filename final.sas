FILENAME REFFILE '/home/u64004348/stu.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=student;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=student; RUN;

/* View the summary statistics of grades by school */
PROC MEANS DATA=student N MEAN STD MIN MAX;
  CLASS school;
  VAR G3;
RUN;

/* Visualize grade distributions using boxplots */
PROC SGPLOT DATA=student;
  VBOX G3 / CATEGORY=school;
  TITLE "Grade Distributions by School";
RUN;


/* Perform Shapiro-Wilk test for normality on each group */
PROC UNIVARIATE DATA=student NORMAL;
  CLASS school;
  VAR G3;
  HISTOGRAM G3 / NORMAL(MU=EST SIGMA=EST);
  INSET N MEAN STD / POSITION=NE;
RUN;

/* Test for equality of variances using Levene's test */
PROC TTEST DATA=student;
  CLASS school;
  VAR G3;
RUN;

/* Perform Mann-Whitney U test */
proc npar1way data=student wilcoxon;
    class school; /* Group variable */
    var G3;    /* Numerical variable */
run;

/* Summarize test results */
PROC TABULATE DATA=student;
  CLASS school;
  VAR G3;
  TABLE school, G3*(MEAN STD MEDIAN);
RUN;




