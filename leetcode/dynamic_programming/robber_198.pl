:- dynamic rob/3.

robber([], _, 0).
robber(XS, T, R):-
    rob(XS, T, R),
    !.
robber([X|XS], false, R):-
    robber(XS, true, R),
    assert(rob([X|XS], false, R)).
robber([X|XS], true, R):-
    robber(XS, true, RT),
    robber(XS, false, RF),
    R is max(RT, RF + X),
    assert(rob([X|XS], true, R)).