path_sum(nil, _, []).
path_sum(tree(X, nil, nil), X, [[X]]):-!.
path_sum(tree(X, L, R), S, P):-
    NS is S - X,
    path_sum(L, NS, LP),
    path_sum(R, NS, RP),
    findall([X|PP], (member(PP, LP) ; member(PP, RP)), P1),
    list_to_set(P1, P).