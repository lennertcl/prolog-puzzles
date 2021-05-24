% Operator board
% https://dtai.cs.kuleuven.be/ppcbook/ppcbook.pdf p 52

% Puzzle: Find the path with minimal value
% Path can start anywhere
board([[op(*,-1), op(-, 3), op(-,555), op(-, 3)],
[op(-, 3), op(-,2000), op(*,133), op(-,555)],
[op(*, 0), op(*, 133), op(-, 2), op(+, 19)],
[op(-, 3), op(-,1000), op(-, 2), op(*, 3)]]).

/**
 * Find the minimal result for the board and the
 * path to obtain that result
 */
solve(Result):-
    findall(Score:Path, find_path(Score, Path), Scores),
    min_member(Result, Scores).

/**
 * Find valid path and calculate the path result
 */
find_path(Result, Path):-
    board(B),
    grid_to_pos(1, B, Board),
    % Pick the starting square 
    select(pos(X, Y, Op), Board, NewBoard),
    calculate(0, Op, Curr),
    find_path(pos(X, Y, Op), NewBoard, Curr, Result, Path).
% If an empty board is left the result is known
find_path(_, [], Result, Result, []).
find_path(pos(X, Y, Op), Board, Curr, Result, Path):-
    % Move to next position and calculate
    move(pos(X, Y, Op), Next, Board),
    calculate(Curr, Op, NewCurr),
    % Remove the visited position
    select(Next, Board, NewBoard),
    % Calculate the rest of the board
    find_path(Next, NewBoard, NewCurr, Result, NewPath),
    Path = [Op | NewPath].

/**
 * Calculate the result of the operation
 */
calculate(Left, op(*, Right), Result):-
    Result is Left * Right.
calculate(Left, op(+, Right), Result):-
    Result is Left + Right.
calculate(Left, op(-, Right), Result):-
    Result is Left - Right.

/**
 * Turn the board into a list of pos/3
 * pos(Row nr, Col nr, op/2)
 */
grid_to_pos(_, [], []).
grid_to_pos(RowNum, [List | Rest], PosList):-
    list_to_pos(RowNum, 1, List, Pos),
    RN1 is RowNum + 1,
    grid_to_pos(RN1, Rest, RestPos),
    append(Pos, RestPos, PosList).
list_to_pos(_, _, [], []).
list_to_pos(RowNum, Colnum, [Elem | Rest], PosList):-
    Pos = pos(RowNum, Colnum, Elem),
    CN1 is Colnum + 1,
    list_to_pos(RowNum, CN1, Rest, RestPos),
    PosList = [Pos | RestPos].

/**
 * A move can be horizontal or vertical
 */
move(pos(X, Y, _), pos(A, Y, _), Positions):-
    (A is X + 1; A is X - 1),
    member(pos(A, Y, _), Positions).
move(pos(X, Y, _), pos(X, B, _), Positions):-
    (B is Y + 1; B is Y - 1),
    member(pos(X, B, _), Positions).

% Extra test: verify a solution
% solve(Score:Result), verify(0, Result, Score).
verify(Curr, [], Curr).
verify(Curr, [Op | Rest], Score):-
    calculate(Curr, Op, NewCurr),
    verify(NewCurr, Rest, Score).