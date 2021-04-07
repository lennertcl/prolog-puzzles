% Minesweeper game

% Puzzle:
% Flag the bombs and determine how many are are around position (vertical, horizontal, diagonal)

% Solution:
% If the value of a square is n, there must exactly n bombs in its neighbors


% Definition of a game


% The game grid
grid(10, 10).
% The chance that a square is a bomb
bomb_odds(0.2).


% Helper functions


/**
 * Print a visual representation of the board
 */
% TODO
% Write non unified variables as _
write_board(Board):-
    write_board(Board, 1).
write_board([], _):- nl.
write_board([pos(Row, _, Elem) | Positions], Row):-
    !,
    write("|"), write(Elem), write("|"),
    write_board(Positions, Row).
write_board([pos(Row, Col, Elem) | Positions], _):-
    nl,
    write_board([pos(Row, Col, Elem) | Positions], Row).

/**
 * Write instructions for the minesweeper game
 */
write_instructions():-
    write("Minesweeper game"), nl,
    write("Instructions: "), nl,
    write("Enter a move like this 'pos(Row, Col, Move).', where Move is either f to Flag or r to reveal"), nl,
    write("Flags can be removed by revealing the flagged square"), nl.

/**
 * Determines randomly (based on bomb odds) whether
 * it is a bomb or not
 */
is_bomb():-
    random(R),
    bomb_odds(O),
    R < O.

/**
 * Determine neighboring positions
 */
neighbors(pos(A, B, _), pos(C, B, E), Board):-
    % Move 1 square horizontally
    (C is A + 1 ; C is A - 1),
    % Don't go outside of the board
    member(pos(C, B, E), Board).
neighbors(pos(A, B, _), pos(A, C, E), Board):-
    % Move 1 square vertically
    (C is B + 1 ; C is B - 1),
    % Don't go outside of the board
    member(pos(A, C, E), Board).
neighbors(pos(A, B, _), pos(C, D, E), Board):-
    % Move 1 square diagonally
    (C is A + 1 ; C is A - 1),
    (D is B + 1 ; D is B - 1),
    % Don't go outside of the board
    member(pos(C, D, E), Board).


% Initialization of a game


/**
 * Make a game of minesweeper
 * Board is the actual board containing bombs
 * Playboard is the board with bombs hidden
 */
init_game(Board, Playboard):-
    init_board(Board),
    init_bombs(Board),
    init_numbers(Board, Board),
    init_board(Playboard).

/**
 * Initialize a board based on the game grid
 */
init_board(Board):-
    grid(X, Y),
    numlist(1, X, Xlist),
    numlist(1, Y, Ylist),
    findall(pos(Px, Py, _), (member(Px, Xlist), member(Py, Ylist)), Board).

/**
 * Initialize a list of positions with bombs randomly
 */
init_bombs([]).
init_bombs([pos(_, _, B) | Positions]):-
    (is_bomb()
    -> B = b
    ; var(B)),
    init_bombs(Positions).

/**
 * Initialize the number of bombs in surrounding squares
 */
init_numbers([], _).
init_numbers([pos(X, Y, N) | Positions], FullBoard):-
    % Only initialize if the position is not a bomb yet
    var(N),
    !,
    % Count all neighbor bombs 
    % Only the neighbors already instantiated as a bomb should be counted
    % Subtracting is necessary to only find real bombs
    findall(_, (neighbors(pos(X, Y, _), pos(_, _, NotBomb), FullBoard), var(NotBomb)), NotBombs),
    findall(_, neighbors(pos(X, Y, _), pos(_, _, b), FullBoard), Bombs),
    length(NotBombs, NBs),
    length(Bombs, Bs),
    N is Bs - NBs,
    init_numbers(Positions, FullBoard).
init_numbers([pos(_, _, b) | Positions], FullBoard):-
    !,
    init_numbers(Positions, FullBoard).
    

% Playing the game


/**
 * Start a game of minesweeper
 */
play_game():-
    init_game(Board, Playboard),
    write_instructions(),
    play_game(Board, Playboard).
play_game(Board, Playboard):-
    write_board(Playboard),
    write("Enter a move: "),
    make_move(Board, Playboard),
    % Test whether the game is done and exit or continue
    (is_finished(Board, Playboard)
    -> write_board(Board), nl, write("Thank you for playing")
    ; play_game(Board, Playboard)).


/**
 * Make a move on the playboard based on the real board
 */
% TODO
% When revealing a zero, recursively reveal all neighbors
% When revealing a position, test whether it was flagged before
% (Flagged positions can still be revealed)
make_move(Board, Playboard):-
    read(pos(X, Y, A)),
    (A == r
    % Reveal pos(X, Y, E) -> init this as member of playboard
    -> member(pos(X, Y, E), Board), member(pos(X, Y, E), Playboard)
    % Flag pos(X, Y, _) -> init this as member of playboard
    ; member(pos(X, Y, f), Playboard)),
    !.
make_move(Board, Playboard):-
    write("Invalid move"), nl,
    make_move(Board, Playboard).


/**
 * Test whether a game is finished: The game is a win or a loss
 */
is_finished(Board, Playboard):-
    is_win(Board, Playboard);
    is_loss(Playboard).

/**
 * The game is a win when every non bomb square is revealed
 */
is_win(Board, Playboard):-
    % Count the actual non bomb squares
    findall(_, (member(pos(_, _, X), Board), X \= b), Actual),
    % Count the revealed non bomb squares: not var and not flagged
    findall(_, (member(pos(_, _, X), Playboard), \+ var(X), X \== f), Revealed),
    length(Actual, LA),
    length(Revealed, LR),
    LA == LR.

/**
 * The game is a loss when a bomb square is revealed 
 */
is_loss(Playboard):-
    % If and element has been unified as a bomb, the game is finished
    member(pos(_, _, X), Playboard),
    X == b.
