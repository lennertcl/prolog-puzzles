% Send more money

% Puzzle:
% SEND + MORE + MONEY 
% Each letter represents a different digit
% Solution is unique
digit(0).
digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).

solve([S, E, N, D, M, O, R, Y]):-
    % S E N D + M O R E = M O N E Y
    init_num(D, [], O1),
    init_num(E, O1, O2),
    make_sum(D, E, T1, Y),
    init_num(Y, O2, O3),
    init_num(N, O3, O4),
    init_num(R, O4, O5),
    make_sum(N + T1, R, T2, E),
    init_num(O, O5, O6),
    make_sum(E + T2, O, T3, N),
    init_num(S, O6, O7),
    init_num(M, O7, _),
    M \== 0,
    make_sum(S + T3, M, M, O).

% X + Y + FDigSdig
% e.g. make_sum(7, 5, 1, 2), because 7 + 5 = 12
make_sum(X, Y, FDig, SDig):-
    Sum is X + Y,
    (
    Sum >= 10 ->
        SDig is Sum - 10,
        FDig is 1
    ;
        SDig = Sum,
        FDig = 0
    ).

/**
 * Initialize a valid digit
 */
init_num(Num, Taken, [Num | Taken]):-
    digit(Num),
    \+ member(Num, Taken).