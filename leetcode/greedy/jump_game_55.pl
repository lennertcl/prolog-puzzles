jump(N):-
    length(N, L),
    jump(N, 1, 1, L).
jump(_, _, M, L):-
    M >= L,
    !.
jump(_, C, M, _):-
    C > M,
    !,
    fail.
jump([X|XS], C, M, L):-
    NM is max(M, X + C),
    NC is C + 1,
    jump(XS, NC, NM, L).