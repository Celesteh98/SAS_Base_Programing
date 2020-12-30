libname Data1 '/folders/myfolders/PSTAT130/Data1';

*Question 1*;
proc contents data=data1.shoes;
run;
/*How many variables does it contain? 7*/

proc means data=data1.shoes;
run;
/*Which variables are displayed in the report? Stores Sales Invetory and  Returns
/*Is this all of the variables in the data set? No*/
/*Of what type are these variables? Numeric variables*/

proc means data=data1.shoes mean std sum maxdec=2;
run;

proc means data=data1.shoes mean std sum maxdec=2;
	var sales inventory returns;
run;

proc means data=data1.shoes mean std sum maxdec=2;
	var sales inventory returns;
	class product;
run;

proc tabulate data=data1.shoes;
	class region product;
	var sales;
	tables product*sales*median;
	table region;
	format sales dollar10.2;
run;

*Does the format appear in the Product table? No*/;

proc tabulate data=data1.shoes format=dollar10.2;
	class region product;
	var sales;
	tables product*sales*median;
	table region;
run;

*/Does the format appear in the Product table? Yes*/
*/What about the Region table? Yes*/;

proc tabulate data=data1.shoes;
	class region product;
	var sales;
	tables product*sales*f=dollar10.2*median;
	table region;
run;
*/Does the format appear in the Product table? Yes*/
*/What about the Region table? No*/;

proc format;
	value Sale
			low-<100000 = 'Under 100k'
			100000-200000= '$100k - $200k'
			200000<-high= 'More than 200k';
	value Return
			low-<1000 = 'Under 1k'
			1000-5000= '$1k - $5k'
			5000<-high= 'More than 5k';
run;

proc tabulate data=data1.shoes;
	class sales returns;
	label sales='Ql Sales'
		  Returns='Amount of Returns';
	tables Sales all,Returns all;
	format Sales Sale. Returns Return.;
run;
			
*Question 2*;
proc sort data=data1.target121999 out=work.target_sort;
	by FlightID;
	where Origin= 'BHM' and date=14593;
run;

proc sort data=data1.sales121999 out=work.sales_sort;
	by FlightID;
	where Origin= 'BHM' and date=14593;
run;

data work.compare;
	merge work.target_sort work.sales_sort;
	by FlightID;
	LostCargoRev=CargoTarRev-CargoRev;
run;

proc print data=work.compare label;
	var CargoTarRev CargoRev LostCargoRev;
	label CargoTarRev= 'Target Cargo Revenue'
		  LostCargoRev='Lost Cargo Revenue';
	format CargoTarRev dollar9.2;
	format CargoRev dollar9.2;
	format LostCargoRev dollar5.;
run;


**Question 3*;
proc freq data=data1.shoes;
run;
*/How many frequency tables are displayed? 7*/
*/Is this all of the variables in the data set? Yes*/;

proc freq data=data1.shoes;
tables region product;
run;

proc freq data=data1.shoes;
tables region product / nocum;
run;

proc freq data=data1.shoes;
tables region*product /nocum;
run;