#input data 

#all fields from sudoku labeld from 1 to 81
set numbers:= { 1..81}; 

#all branches which has to be in a conflict
set pair:= { read "Kanten.txt" as "<1n, 2n>" comment "#" }; 

#maximum amount of colors
set colors := {1..9}; 

#given numbers
set given := { <6,9>, <8,7>, <14,8>, <15,2>, <17,5>, <19,3>, <20,2>, <21,7>, <26,4>, <29,1>, <30,6>, <32,4>, <38,5>, <43,3>, <50,9>, <52,7>, <58,6>, <63,5>, <64,8>, <66,2>, <75,4>, <76,2>, <81,8> };

#variables of the model 
var x[numbers*colors] binary; 
var y[colors] binary; 

#IP 
minimize color:
	sum <c> in colors :  y[c]; 

#contraints
#each cell is occupied by exactly one number
subto unique: 
	forall <i> in numbers do 
		sum <c> in colors : x[i,c] == 1;
		
#respect edges that conflict with each other
subto conflict: 
forall <i,j> in pair do
	forall <c> in colors do
		x[i,c] + x[j,c] <= y[c];

#respect given numbers
subto givennumbers:
	forall <a,b> in given do 
		x[a,b] == 1;
