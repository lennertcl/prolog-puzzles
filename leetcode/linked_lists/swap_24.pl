swap([], []).
swap([_], [_]).
swap([X, Y | XS], [Y, X | R]):-
    swap(XS, R).