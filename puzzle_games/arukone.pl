% Arukone

% Puzzle:
% puzzle(dimensions: grid/2, list of link/3)
% grid(nb rows, number cols)
% link(number, start pos/2, end pos/2)
% pos(row nb, col nb)

% Solution: 
% List of connect/2
% connect(number, list of pos/2)

% Method:
% Find all paths connecting first number without going through other numbers
% Find all paths connecting second number without going through other numbers or
% through an existing path
% ...

% 15,156 inferences, 0.000 CPU in 0.001 seconds (0% CPU, Infinite Lips)
%puzzle(grid(5, 5), [
%    link(1, pos(2, 1), pos(5, 5)),
%    link(2, pos(1, 5), pos(3, 2)),
%    link(3, pos(1, 3), pos(3, 3)),
%    link(4, pos(1, 1), pos(2, 3))]).

% 311,694 inferences, 0.047 CPU in 0.045 seconds (105% CPU, 6649472 Lips)
puzzle(grid(5, 5),[
    link(1, pos(5, 1), pos(5, 4)),
    link(2, pos(2, 4), pos(5, 5)),
    link(3, pos(1, 4), pos(2, 2))]).

/**
 * Solve arukone puzzle inside S
 */
solve(S):-
    puzzle(_, L),
    position_list(R),
    solve(L, R, S).
% Valid solution has no more points to connect and occupies every pos
solve([], [], []).
solve([link(A, Spos, Epos) | L], R, S):-
    % Find path connecting A's
    path(Spos, Epos, R, P),
    % Remove all positions in the path from the valid positions
    subtract(R, P, NR),
    % Solve rest of the puzzle with remaining valid positions
    solve(L, NR, NS),
    % Add path to solution
    S = [connects(A, P) | NS].

/**
 * Find a path from starting position to end position
 * without going through invalid positions. 
 */
path(Spos, Epos, _, P):-
    % Directly from start to end in 1 move
    puzzle(G, _),
    move(Spos, Epos, G),
    P = [Spos, Epos].
path(Spos, Epos, R, P):-
    puzzle(G, _),
    % Make valid move
    move(Spos, Tpos, G),
    % Don't go to occupied pos
    member(Tpos, R),
    % Tpos is now occupied
    delete(R, Tpos, NR),
    % Find rest of the path
    path(Tpos, Epos, NR, NP),
    P = [Spos | NP].

/**
 * Valid move between 2 positions
 */
move(pos(A, B), pos(C, B), grid(M, _)):-
    % Move 1 square horizontally
    (C is A + 1 ; C is A - 1),
    % Don't go out of the grid
    (C > 0, C =< M).
move(pos(A, B), pos(A, C), grid(_, N)):-
    % Move 1 square vertically
    (C is B + 1; C is B - 1),
    (C > 0, C =< N).

/**
 * Build list with all valid positions on the board
 * i.e. : all positions without number
*/
position_list(R):-
    puzzle(grid(M, N), L), 
    % Find all occupied positions
    findall(pos(X, Y), 
            (member(link(_, pos(X, Y), _), L);
            member(link(_, _, pos(X, Y)), L)),
            I),
    % Find all positions
    numlist(1, M, Rmax),
    numlist(1, N, Cmax),
    findall(pos(X, Y),
            (member(X, Rmax),
            member(Y, Cmax)),
            G),
    % Find all non-occupied positions
    subtract(G, I, R).