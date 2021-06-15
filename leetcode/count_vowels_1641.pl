count_vowels(0, 0).
count_vowels(N, R):-
    findall(XS, (length(XS, N), sorted(XS)), RS),
    length(RS, R).

sorted([X]):-
    member(X, [a, e, i, o, u]).
sorted([X, Y|XS]):-
    before(X, Y),
    sorted([Y|XS]).

before(a, X):-
    member(X, [a, e, i, o, u]).
before(e, X):-
    member(X, [e, i, o, u]).
before(i, X):-
    member(X, [i, o, u]).
before(o, X):-
    member(X, [o, u]).
before(u, u).