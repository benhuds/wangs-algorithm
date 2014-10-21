% COMP360
% HW3
% Ben Hudson

% Task 1: flatten a list.

% append two lists.
append([],L,L).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

flatten([],[]).
flatten([X|Xs],L) :- 
	flatten(X,FlatX), 
	flatten(Xs,FlatXs), 
	append(FlatX,FlatXs,L).
flatten(X,[X]).

% Task 2: write a prolog program for a predicate divisors(X,L)
% when run with a positive integer input X, returns the list L of all divisors of X.

% X divides N if N mod X is 0.
divides(X,N):-
	0 is N mod X.

% uses an accumulator to build up a list of divisors
% if N is a divisor of X, add it to the list L and recurse.
% else don't add it to the list and recurse.
divhelp(0,X,L,L).
divhelp(N,X,L,Ans):-
	divides(N,X),
	N1 is N-1,
	divhelp(N1,X,[N|L],Ans).
divhelp(N,X,L,Ans):-
	\+ divides(N,X),
	N1 is N-1,
	divhelp(N1,X,L,Ans).

% set the accumulator to the empty list for the real function.
divisors(N,L):-
	divhelp(N,N,[],L).

% Task 3: Define a predicate isPrime(X) which is true when X is prime.
% Then define a predicate PrimeList(N,L) which returns a list L of all
% primes less than N.

% a positive integer n is prime if it has no divisors other than 1 and itself.
% i.e. the list of divisors for X is just [1,X].
isPrime(X):-
	divisors(X,[1,X]).

% Task 4: Define a predicate powerset(L,PL) which is true when PL is the list
% representation of the power set of the set represented by the list L. 

% concatenates two lists.
concat([],L,L).
concat([X|Xs],L,[X|Ans]):-
	concat(Xs,L,Ans).

% appends X to all elements of a list.
powhelp(_,[],[]).
powhelp(X,[Y|Ys],[[X|Y]|Ans]):-
	powhelp(X,Ys,Ans).

powerset([],[[]]).
powerset([X|Xs],PL):-
	powerset(Xs,L),
	powhelp(X,L,R),
	concat(L,R,PL).