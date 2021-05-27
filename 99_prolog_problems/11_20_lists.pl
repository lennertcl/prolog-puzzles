consult(problems1_10).

/**
 * Encode by number of repetitions of elem
 * 1 repetition is not encoded
 */
rl_encode_2(XS, ZS):-
    rl_encode(XS, YS),
    modify(YS, ZS).

/**
 * Helper function for encode
 */
modify([], []):-!.
modify([[1, X] | XS], [X|YS]):-
    !,
    modify(XS, YS).
modify([X|XS], [X|YS]):-
    modify(XS, YS).

/**
 * Decode a rl_encoded list
 */
decode([], []).
decode([[N, X] | XS], YSS):-
    replicate(N, X, NX),
    decode(XS, YS),
    append(NX, YS, YSS).

/**
 * Replicate X N times
 */
replicate(0, _, []):-!.
replicate(N, X, [X | YS]):-
    N1 is N - 1,
    replicate(N1, X, YS).

/**
 * Duplicate every element
 */
dupli([], []).
dupli([X | XS], [X, X | XXS]):-
    dupli(XS, XXS).

/**
 * Drop every nth element
 */
drop_every(XS, N, YS):-
    drop_every(XS, N, 1, YS).
drop_every([], _, _, []).
drop_every([_|XS], N, N, YS):-
    !,
    drop_every(XS, N, 1, YS).
drop_every([X|XS], N, I, [X|YS]):-
    I1 is I + 1,
    drop_every(XS, N, I1, YS).

/**
 * Split a list into 2 lists
 */
split(XS, N, P1, P2):-
    split(XS, N, [], P, P2),
    reverse(P, P1).
split(XS, N, Acc, Acc, XS):-
    length(Acc, N),
    !.
split([X|XS], N, Acc, P1, P2):-
    split(XS, N, [X|Acc], P1, P2).

/**
 * Slice a part of a list from M to N
 */
slice(XS, M, N, YS):-
    drop(XS, M, Y1),
    R is N - M,
    take(Y1, R, YS).

/**
 * Rotate N places to the left
 */
rotate(XS, N, YS):-
    drop(XS, N, Y1),
    take(XS, N, Y2),
    append(Y1, Y2, YS).