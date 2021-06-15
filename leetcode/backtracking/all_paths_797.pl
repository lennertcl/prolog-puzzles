% G[i] = all nodes you can visit from i
all_paths(G, R):-
    length(G, L),
    L1 is L - 1,
    find_paths(G, L1, R).

find_paths(_, 0, [[0]]):-!.
find_paths(G, N, R):-
    % All positions that get to goal node
    findall(X, (nth0(X, G, NS), member(N, NS)), PS),
    % All paths that lead to a position that leads to goal node
    findall(Y, (member(P, PS), find_paths(G, P, AA),
                member(A, AA), append(A, [N], Y)), R).