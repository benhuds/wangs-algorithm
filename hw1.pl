% COMP360
% HW1
% Ben Hudson

%Task 2: Write a program which defines the family relationship sibling(X,Y), parent(X,Y), uncle(X,Y),cousin(X,Y),ancestor(X,Y)

%database
father(joe,michael).
father(alice,michael).
father(mary,jonah).
father(fred,adam).
father(michael,ian).
father(bill,ian).
father(bob,bill).

mother(joe,mary).
mother(rebecca,elissa).
mother(mary,barbara).
mother(fred,rebecca).
mother(michael,ann).
mother(bill,ann).

male(joe).
male(michael).
male(fred).
male(james).
male(bill).
male(adam).

female(rebecca).
female(mary).
female(alice).
female(elissa).
female(ann).
female(barbara).

%parent of C is P if father of C is P or mother of C is P 
parent(C,P):-father(C,P);mother(C,P).

%sibling of A is B if parent of A is P and parent of B is P
sibling(A,B):-parent(A,P),parent(B,P),A\=B.

%uncle of A is B if B is a man, C is sibling of A, and C is parent of A
uncle(A,B):-parent(A,C),sibling(C,B),male(B).

%cousin of A is B if parent of A is C, parent of B is D, sibling of A is B, and A\=B.
cousin(A,B):-parent(A,C),sibling(C,D),parent(B,D),A\=B.

%ancestor of A is B if parent of A is B
%ancestor of A is C if parent of A is B and ancestor of B is C
ancestor(A,B):-parent(A,B);
	       parent(A,C),ancestor(B,C).

%Task 3: define a predicate connect2(X,Y) which is true whenever there is a connection from City1 to City2 with at most 2 stopovers.

%database
flight(usair,newyork,boston).
flight(delta,newyork,miami).
flight(northwest,newyork,portland).
flight(northwest,portland,sanfrancisco).
flight(usair,boston,burlington).
flight(usair,burlington,toronto).
flight(usair,toronto,montreal).
flight(usair,montreal,ottawa).
flight(usair,newyork,burlington).

flighthelp(X,Y,N):-flight(_,X,Y) ,N < 3;
	           flight(_,X,Z),flighthelp(Z,Y,N + 1),N < 3.

connect2(X,Y):-flighthelp(X,Y,0).

%Task 4: Define a predicate fib(X,Y) which is true whenever Y is the Xth member of the fibonacci sequence

%fib(0)=0
%fib(1)=1
%fib(n) = fib(n-1)+fib(n-2) for n>1
fib(0,0).
fib(1,1).
fib(X,Y):-X > 1,
	  X1 is X - 1,
	  fib(X1,Y1),
	  X2 is X - 2,
	  fib(X2,Y2),
	  Y is Y1+Y2.

%Task 5: Define a predicate divides(X,Y) which is true whenever X is a divisor of Y

%addition
add(o,X,X).
add(s(X),Y,s(Z)):-add(X,Y,Z).

%multiplication
mult(o,X,o).
mult(s(X),Y,Z):-mult(X,Y,XY),add(XY,Y,Z).

%less than or equal
lessEq(o,N).
lessEq(s(M),s(N)):-lessEq(M,N).

%X is a divisor of Y when there exists a Z such that mult(X,Z,Y) and lessEq(Z,Y).
divides(X,Y):-mult(X,Z,Y),lessEq(X,Y),lessEq(Z,Y).