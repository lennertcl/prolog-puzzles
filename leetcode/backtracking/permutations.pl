permutations(XS, R):-
    findall(P, permutation(XS, P), R).
permutation(XS, R):-
    length(XS, L),
    length(PS, L),
    fill(XS, PS, R).
fill([], PS, PS).
fill([X|XS], PS, R):-
    member(X, PS),
    fill(XS, PS, R).