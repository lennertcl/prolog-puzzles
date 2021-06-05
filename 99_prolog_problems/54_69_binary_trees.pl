/**
 * Check whether a term is a binary tree
 */
istree(nil).
istree(t(_, L, R)):-
    istree(L),
    istree(R).

/**
 * Construct completely balanced binary tree with a given number of nodes
 */
cbal_tree(0, nil):-!.
cbal_tree(NN, t(x, LT, RT)):-
    NN > 0,
    N is NN - 1,
    LN is div(N, 2),
    RN is N - LN,
    divide_nodes(LN, RN, NL, NR),
    cbal_tree(NL, LT),
    cbal_tree(NR, RT).
divide_nodes(N, N, N, N):-!. % No duplicate trees
divide_nodes(LN, RN, LN, RN).
divide_nodes(LN, RN, RN, LN).

/**
 * Test if two binary trees are symmetric
 */
symmetric(T):-
    mirror(T, T).

/**
 * Mirror a binary tree
 */
mirror(nil, nil):-!.
mirror(t(A, L, R), t(A, NL, NR)):-
    mirror(L, NR),
    mirror(R, NL).

/**
 * Add a number to a binary tree
 */
add(X, nil, t(X, nil, nil)).
add(X, t(N, L, R), t(N, NL, R)):-
    X < N,
    add(X, L, NL).
add(X, t(N, L, R), t(N, L, NR)):-
    X > N,
    add(X, R, NR).

/**
 * Construct a binary tree from a list of numbers
 */
construct(L, T):-
    construct(L, nil, T).
construct([], T, T).
construct([X|R], T, NNT):-
    add(X, T, NT),
    construct(R, NT, NNT).

/**
 * Count the nodes of a binary tree
 */
count_nodes(nil, 0).
count_nodes(t(_, L, R), N):-
    count_nodes(L, NL),
    count_nodes(R, NR),
    N is NL + NR + 1.

/**
 * Count the leaves of a binary tree
 */
count_leaves(nil, 0).
count_leaves(t(_, nil, nil), 1):-!.
count_leaves(t(_, L, R), N):-
    count_leaves(L, NL),
    count_leaves(R, NR),
    N is NL + NR.

/**
 * Collect the leaves of a binary tree
 */
leaves(nil, []).
leaves(t(X, nil, nil), [X]):-!.
leaves(t(_, L, R), LT):-
    leaves(L, LL),
    leaves(R, LR),
    append(LL, LR, LT).

/**
 * Collect the internal nodes of a binary tree
 */
internals(nil, []).
internals(t(_, nil, nil), []):-!.
internals(t(X, L, R), [X|IT]):-
    internals(L, IL),
    internals(R, IR),
    append(IL, IR, IT).

/**
 * Collect the nodes at a given depth
 */
at_depth(nil, _, []).
at_depth(t(X, _, _), 0, [X]):-!.
at_depth(t(_, L, R), D, N):-
    D1 is D - 1,
    at_depth(L, D1, NL),
    at_depth(R, D1, NR),
    append(NL, NR, N).

/**
 * Construct a complete binary tree with N nodes
 */
complete_binary_tree(0, nil).
complete_binary_tree(N, T):-
    L is floor(log(N)/log(2)),
    L1 is L - 1,
    pow(2, L1, NN),
    RN is N - 2 * NN - 1,
    full_binary_tree(L, F),
    add_to_full(F, RN, NN, T).

/**
 * Add RN nodes to a full tree F with
 * NN nodes at the lowest level
 */
add_to_full(nil, _, _, t(x, nil, nil)):-!.
add_to_full(t(x, L, R), RN, NN, t(x, NL, NR)):-
    N is NN / 2,
    (RN =< N ->
        add_to_full(L, RN, N, NL),
        NR = R
    ;
        add_to_full(L, N, N, NL),
        NRN is RN - N,
        add_to_full(R, NRN, N, NR)
    ).

/**
 * Construct a full binary tree of a given height
 */
full_binary_tree(0, nil):-!.
full_binary_tree(D, t(x, T, T)):-
    D1 is D - 1,
    full_binary_tree(D1, T).

/**
 * Layout a binary tree
 * x(v) is position in inorder sequence
 * y(v) is depth of v
 */
layout(nil, _, P, [], P):-!.
layout(t(X, L, R), D, P, N, NNP):-
    D1 is D + 1,
    layout(L, D1, P, NL, NP),
    NP1 is NP + 1,
    layout(R, D1, NP1, NR, NNP),
    append(NL, [[D, NP, X]|NR], N).

/**
 * Draw a tree based on above layout
 */
draw_tree(T):-
    layout(T, 0, 0, L, _),
    sort(L, SL),
    max_x(L, 0, M),
    draw_tree(SL, M, 0, 0).
draw_tree([], _, _, _).
draw_tree([[Y,X,N]|R], M, X, Y):-
    !,
    write(N),
    next(X, Y, M, NX, NY),
    draw_tree(R, M, NX, NY).
draw_tree(R, M, X, Y):-
    next(X, Y, M, NX, NY),
    (NY == Y ->
        write(" ")
    ;
        nl),
    draw_tree(R, M, NX, NY).

/**
 * Determine the maximum X value
 */
max_x([], M, M).
max_x([[_, X, _] | R], M, NM):-
    (X > M -> TM = X ; TM = M),
    max_x(R, TM, NM).

/**
 * Get the next X and Y for a grid of given length
 */
next(X, Y, M, NX, NY):-
    (X =< M -> 
        (NX is X + 1, 
         NY = Y)
        ;
        (NX = 0,
         NY is Y + 1)
    ).
