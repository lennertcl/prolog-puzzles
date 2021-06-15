% True if it is possible to represent n as sum of distinct powers of three

:- dynamic sum/2.

sum_powers(N, P):-
    sum(N, P),
    !.
sum_powers(0, _):-!.
sum_powers(N, P):-
    pow(3, P, X),
    X =< N,
    NN is N - X,
    P1 is P + 1,
    (sum_powers(NN, P1) ; sum_powers(N, P1)),
    assert(sum(N, P)).