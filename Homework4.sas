libname Data1 '/folders/myfolders/PSTAT130/Data1';
*Question 1a*;
proc print data=data1.pilots;
run;

proc format;
	value $jfmt Pilot1='PT1'
			    Pilot2='PT2'
			    Pilot3='PT3';
	value $gfmt Female='F'
			    Male='M';

ods listing file='/folders/myfolders/PSTAT130/Homework/pilots1.lst';
title 'List Report of Pilot Salaries';
proc report data=data1.pilots;
	column jobcode gender salary;
	define jobcode/group 'Job Title' format=$jfmt. width=10;
	define gender/ group format=$gfmt. width=8;
	define salary/ group 'Annual Salary' format=dollar8. width=15;
run;
ods listing close;
	
*Question1b*;
proc format;
	value $jfmt Pilot1='PT1'
			    Pilot2='PT2'
			    Pilot3='PT3';
	value $gfmt Female='F'
			    Male='M';

ods listing file='/folders/myfolders/PSTAT130/Homework/pilots2.lst';
title2 'Summary Report of Pilot Salaries';
proc report data=data1.pilots headline;
	column jobcode gender salary;
	define jobcode/group 'Job Title' format=$jfmt. width=10;
	define gender/ group format=$gfmt. width=8;
	define salary/analysis mean 'Mean Annual Salary' format=dollar12.2 width=21;
	break after jobcode / summarize OL UL;
	rbreak after / summarize UL;
run;
ods listing close;

*Question 2a*;
proc print data=data1.military;
run;

data Airforce(keep=code airport awards) 
	 Army
	 Marines(keep=code city) 
	 Naval(keep=type code state country);
	set data1.military;
if type='Air Force' then output airforce;
else if type='Army' then output army;
else if type='Marine' then output marines;
else if type='Naval' then output naval;
run;
proc print data=airforce;
run;
proc print data=army;
run;
proc print data=marines;
run;
proc print data=naval;
run;

*Question 2b*;
/*How many observations are in each of the data sets created in part A?*/ 
*There are 64 observations in airforce, 41 observations in military, 4 observations in marines and 28 observations in Naval.*; 
/*How many observations are in the military data set? 137*/;

*Question 2c*;
data m1;
set data1.military;
AwardsRT=sum(AwardsRT,Awards);
retain;
run;
proc print data=m1;
run;
data m2;
set data1.military;
AwardsRT+Awards;
run;
proc print data=m2;
run;

*Question 2d*;
proc sort data=data1.military out=military_sort;
	by type;
run;
data m3;
	set military_sort;
	by type;
	if first.type then TotalAwards=0;
	TotalAwards+Awards; 
	if last.type;
	keep Type TotalAwards;
run;
proc print data=m3;
run;

*Question 3a*;
proc gchart data=data1.laguardia;
	pie	dest / fill=x
			   explode='PAR';
run;

*Question 3b*;
proc gchart data=data1.laguardia;
	vbar dest / sumvar=revenue type=mean;
	format revenue dollar8.;
run;

*Question 3c*;
proc gplot data=data1.laguardia;
	plot revenue*boarded / regeqn
						   vaxis=100000 to 200000 by 10000;
	label revenue='Flight Revenue'
		  boarded='Passengers Boarded';
	symbol v=circle color=blue i=rlclm95;
run;

*Question 4a*;
proc print data=data1.flydays;
run;
data weekend weekdays;
set data1.flydays;
if code='MF' then output weekdays;
else if code='SS' then output weekend;
run;

proc print data=weekend;
	var id code miles;
run;

proc print data=weekdays;
	var id code miles;
run;

*Question 4b*;
data fd1;
set data1.flydays;
Miles2DateRT+miles;
run;
proc print data=fd1;
run;

data fd2;
set data1.flydays;
Miles2DateRT=sum(Miles2DateRT,miles);
retain;
run;
proc print data=fd2;
run;

*Question 4c*;
proc sort data=data1.flydays out=flydays_sort;
	by code;
run;
data fd3;
	set flydays_sort;
	by code;
	if first.code then CodeMiles=0;
	CodeMiles+miles; 
	if last.code;
run;
proc print data=fd3;
run;