remove(XS, N, R):-
    length(XS, L),
    A is L - N,
    remove_at(XS, A, R).

remove_at([_|XS], 0, XS).
remove_at([X|XS], N, [X|R]):-
    N1 is N - 1,
    remove_at(XS, N1, R).