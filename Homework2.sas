libname Data1 '/folders/myfolders/PSTAT130/Data1';
*Question 1*;

proc sort data=data1.cars out=work.cars;
	by Type
	descending Make
	MSRP;
run;

proc print data=work.cars;
run;
proc print data=work.cars label;
	title1 'Cars';
	by Type;
	pageby Type;
	id Type;
	var Make Model MSRP MPG_CITY MPG_HIGHWAY;
	format MSRP DOLLAR9.2;
	label Type= 'Vehicle Type'
		  Make= 'Manufacturer'
		  MPG_City='City MPG'
		  MPG_Highway='Highway MPG';
run;
	
*Question 2*;
FILENAME REFFILE '/folders/myfolders/PSTAT130/Data1/LA_GradRates.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	REPLACE
	OUT=WORK.LA_GradRates;
	GETNAMES=YES;
	sheet='GradRates';
RUN;

PROC CONTENTS DATA=WORK.LA_GradRates; RUN;


proc print data=WORK.LA_GradRates;
run;

*Question 3*;
proc print data=data1.crew;
run;

data SalaryStatement;
   set data1.crew;
   if Salary<= 39475 then TaxwithHeld =0.12*Salary;
   if 39476<= Salary <= 84200 then TaxWithHeld=0.22*Salary;
   if 84201 <= Salary <= 160725 then TaxWithHeld=0.24*Salary;
   if Salary >= 160726 then TaxWithHeld=0.32*Salary;
   Netpay= Salary - TaxWithHeld;
   keep Salary EmpID Salary NetPay;
   format Salary Netpay DOLLAR10.;
   title1 'Salary Statement';
run;

proc print data=SalaryStatement noobs;
run;

*Question 4*;
proc print data=data1.crew;
run;

data AnnualBonus;
	set data1.crew;
	Bonus= Salary * 0.1;
	HireWeekday=Weekday(HireDate);
	label HireWeekday='Day of the Week Hired'
		  LastName='Last Name';
	keep HireWeekday LastName Bonus;
run;	

proc datasets library=work;
	modify AnnualBonus;
	label HireWeekday='Day of the Week Hired'
		  LastName='Last Name';
run;
proc print data=AnnualBonus label;
	format Bonus DOLLAR10.2;
	title1 'Annual Bonus';
run;

*Question 5*;
data work.passengers;
	infile'/folders/myfolders/PSTAT130/Data1/sfosch.dat';
	input @1 FlightID $7.
		  @8 RouteID $7.
		  @18 Destination $3.
		  @41 Depart Date9.
		  @57 BClassPass 3.
		  @65 TotPassCap 3.
		  @75 CargoRev 5.;
	format depart Date9.;
run;

proc print;
run;

/*i. How many records were read from the raw data file? 52 records*/
/*ii. How many observations are in the resulting SAS data set? 52 observations*/
/*iii. How many variables are in the resulting SAS data set? 7 variables*/
/*iv. What data errors are indicated in the SAS log? No errors are indicated*/

ods listing file= '/folders/myfolders/PSTAT130/Homework/passengers.lst';
proc print data=passengers;
	options date pageno=6 linesize=120;
	format Depart mmddyy8.
		   CargoRev Dollar10.;
run;
ods listing close;

*Question 6*;
data work.passengers;
	infile'/folders/myfolders/PSTAT130/Data1/sfosch.dat';
	input @1 FlightID $7.
		  @8 RouteID $7.
		  @18 Destination $3.
		  @41 Depart Date9.
		  @57 BClassPass 3.
		  @65 TotPassCap 3.
		  @75 CargoRev 5.;
	label BClassPass='Business Class'
		  TotPassCap='Total Passengers Capacity'
		  CargoRev='Cargo Revenue';
run;

proc contents data=passengers;
run;
proc datasets library=work;
	modify passengers;
	label Depart='Departure Date';
	format Depart mmddyy10.;
run;

proc contents data=passengers;
run;

*Question 7*;

data work.sanfran;
	infile'/folders/myfolders/PSTAT130/Data1/sfosch.dat';
	input FlightID $ 1-7
		  RouteID $ 8-14
		  Destination $ 18-20
		  Depart $ 41-49
		  TotPassCap $ 65-67;
run;
proc print;
run;

/*What type of variable is FlightID? FlightID is a character varaible*/
/*How many records were read from the raw data file? 52 records were read*/
/*How many observations does the resulting SAS data set contain? 52*/
/*How many variables does the resulting SAS data set contain? 5*/	  

proc contents data=sanfran;
run;

ods listing file='/folders/myfolders/PSTAT130/Homework/sanfran.lst';
proc print;
	options date nonumber linesize=80;
	title1 color=blue 'San Francisco Flight Data';
run;
ods listing close;


/*What is the color of the title in the Results window? Blue*/
/*What is the color of the title in the listing report? Black*/
