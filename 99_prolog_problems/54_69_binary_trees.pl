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