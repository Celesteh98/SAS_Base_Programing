libname Data1 '/folders/myfolders/PSTAT130/Data1';

data producers;
 input last $ first $ yrs employer $ dob;
 datalines;
Lin Cara 7 ABC 9437
Moore Henry 15 CBS 6283
Shah Chris 12 CBS 7423
Melendez Tyler 9 NBC 5845
Hart Erika 11 ABC 7973
Maddox Sam 5 ABC 9085
Doyle Cora 31 CBS -3086
Weber Laura 10 NBC 7309
Soto Eddie 2 NBC 10510
Obrien Lucas 18 CBS 6071
;
proc print;
run;

ods listing file='/folders/myfolders/PSTAT130/Producers.lst';
proc print data=producers noobs label;
 options date pageno=7;
 title1 'Network Producers';
 var employer last dob yrs;
 label employer='Network'
 	   last='Last Name'
 	   dob='Birthdate'
 	   yrs='Years of Experience';
 where yrs >= 10;
 format dob mmddyy10.;
 sum yrs;
run;
ods listing close;

libname Data1 '/folders/myfolders/PSTAT130/Data1';
proc print data=data1.insure2;
run;
proc format;
 Value $Company 	'ACME' = 'Mutual'
					'HOMELIFE'='Mutual'
					'COVINGTON'= 'Stock'
					'ESSENTIAL'= 'Stock'
					'RELIABLE'= 'Stock'
					OTHER= 'Other';
run;

proc print data= data1.insure2 LABEL;
 Title1 Color=blue HEIGHT=5 'Employee Insurance Information';
 Title2 Color=red Height=2 'Confidential';
 Footnote1 JUSTIFY=right 'Prepared on 6/25/2020';
 VAR Policy Name Company BalanceDue;
 LABEL Name= 'Employee Name'
 	   Company= 'Type of Insurance Company'
 	   BalanceDue= 'Remainding Balance';
 Format Company $Company.;
 Where BalanceDue>0;
run;