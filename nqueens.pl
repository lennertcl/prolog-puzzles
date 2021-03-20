% N queens

% Solution:
% List of numbers denoting position of queen in row
% [2, 4, 3, 1] means queens are on positions
% (1, 2), (2, 4), (3, 3), (4, 1)

% Method: 
% Find all squares for first queen
% Find squares this queen does not restrict for other queens

/**
 * queens(N, L) generates solution L for problem with N queens
 */
queens(N, L):-
    squares_list(N, V),
    queens(N, L, V).
% There is 1 valid spot left for the last queen
queens(1, [S], [[S]]):-!.
queens(N, L, [F | R]):-
    % Pick spot for first queen
    member(S, F),
    % Get the remaining spots not attacked by the queen on S
    not_attacked(S, 1, R, NR),
    % Pick spot for next queen that is not attacked by previous queens
    N1 is N - 1,
    queens(N1, NL, NR),
    L = [S | NL].
/**
 * NR is the list containing the spots from [F | R] that are not
 * attacked by a queen placed on spot S on distance D away 
 */
not_attacked(_, _, [], []):-!.
not_attacked(S, D, [F | R], NR):-
    Up is S + D,
    Down is S - D,
    % S: on same row, Up/Down: on same diagonal
    subtract(F, [S, Up, Down], NF),
    % Rest
    D1 is D + 1,
    not_attacked(S, D1, R, NNR),
    NR = [NF | NNR].

/**
 * Build a list L of length N 
 * with each element Col :numlist(1, N, Col)
 * eg: squares_list(2, L):
 *  L = [[1, 2], [1, 2]]
 */
squares_list(N, L):-
    numlist(1, N, Col),
    squares_list(N, Col, L).
squares_list(1, Col, [Col]):-!.
squares_list(N, Col, L):-
    N1 is N - 1,
    squares_list(N1, Col, R),
    L = [Col | R].


