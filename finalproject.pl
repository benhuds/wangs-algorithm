% COMP 360 Final Project:
% A Propositional Theorem Prover using Wang's Algorithm
% Ben Hudson

:-op(700,xfy, => ). 
:-op(650,xfy,-> ). 
:-op(600,xfy,v). 
:-op(550,xfy,&). 
:-op(500,xfy,^).
:-op(450,fy,~).

%TYPE 'run.' INTO THE CONSOLE TO START

run:-
	write('\nA Propositional Theorem Prover using Wang\'s Algorithm\n'),
	write('\tby Ben Hudson\n\n'),
	getPremises(T).

getPremises(Premises):-
	write('Input premises as a list (e.g. [a ^ b, c]): '),
	nl,
	read(Premises),
	nl,
	getTheorem(Premises,X).

getTheorem(Premises,Theorem):-
	write('Input consequent as a list: '),
	nl,
	read(Theorem),
	nl,
	write('To prove: '),
	nl,
	write(Premises => Theorem),
	go(Premises => Theorem).

go(X):-
	prove(X),
	write('\n\nConclude that this is a theorem.\n').
go(X):-
	write('\n=\tCannot be proved.'),
	write('\n\nWe can conclude that this is not a theorem.\n').

%predicate to delete an element X from a list L.
del(X,[X|Tail],Tail).
del(X,[H|Tl1],[H|Tl2]):-
        del(X,Tl1,Tl2).

%negation
prove(L => R):-
	member(~X,L),
	del(~X,L,NewL),
	nl,write('=\t'),write(NewL => [X|R]),
	write('\t (by negation/left)'),
	prove(NewL => [X|R]).
prove(L => R):-
	member(~X,R),
	del(~X,R,NewR),
	nl,write('=\t'),write([X|L] => NewR),
	write('\t (by negation/right)'),
	prove([X|L] => NewR).

%non-branching rules
prove(L => R):-
	member(A ^ B,L),
	del(A ^ B,L,NewL),
	nl,write('=\t'),write([A,B|NewL] => R),
	write('\t (by and/left)'),
	prove([A,B|NewL] => R).
prove(L => R):-
	member(A v B,R),
	del(A v B,R,NewR),
	nl,write('=\t'),write(L => [A,B|NewR]),
	write('\t (by or/right)'),
	prove(L => [A,B|NewR]).
prove(L => R):-
	member(A -> B,R),
	del(A -> B,R,NewR),
	nl,write('=\t'),write([A|L] => [B|NewR]),
	write('\t (by arrow/right)'),
	prove([A|L] => [B|NewR]).

%branching rules
prove(L => R):-
	member(A ^ B,R),
	del(A ^ B,R,NewR),
	nl,write('\tFirst branch: '),
	nl,write('=\t'),write(L => [A|NewR]),
	write('\t (by and/right)'),
	prove(L => [A|NewR]),
	nl,write('\tSecond branch: '),
	nl,write('=\t'),write(L => [B|NewR]),
	write('\t (by and/right)'),
	prove(L => [B|NewR]).
prove(L => R):-
	member(A v B,L),
	del(A v B,L,NewL),
	nl,write('\tFirst branch: '),
	nl,write('=\t'),write([A|NewL] => R),
	write('\t (by or/left)'),
	prove([A|NewL] => R),
	nl,write('\tSecond branch: '),
	nl,write('=\t'),write([B|NewL] => R),
	write('\t (by or/left)'),
	prove([B|NewL] => R).
prove(L => R):-
	member(A -> B,L),
	del(A -> B,L,NewL),
	nl,write('\tFirst branch: '),
	nl,write('=\t'),write([B|NewL] => R),
	write('\t (by arrow/left)'),
	prove([B|NewL] => R),
	nl,write('\tSecond branch: '),
	nl,write('=\t'),write(NewL => [A|R]),
	write('\t (by arrow/left)'),
	prove(NewL => [A|R]).

%rule for id*
prove(L => R):-
	member(X,L),
	member(X,R),
	nl,write('=\tDone (by id*)').