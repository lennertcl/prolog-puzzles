% Board is represented by a list of pos(P, X, Y) where P is either o or x

/**
 * Minimax where P is the current player to move
 * Score is 1 if x wins, 0 if draw and -1 if o wins
 */
minimax(_, B, S, _):-
    has_won(W, B),
    !,
    (W == x -> S = 1 ; S = -1).
minimax(P, B, S, M):-
    swap(P, NP),
    findall(ms(pos(P, X, Y), NS), (legal_move(B, pos(P, X, Y)),
                                  NB = [pos(P, X, Y) | B],
                                  minimax(NP, NB, NS, _)),
                                  MS),
    (length(MS, 0) -> S = 0 ; best_move(P, MS, ms(M, S))).

/**
 * Finds the best move for the player out of a list with moves and scores
 */
best_move(_, [X], X).
best_move(o, [ms(pos(o, X, Y), S) | MS], BM):-
    best_move(o, MS, ms(pos(o, BX, BY), BS)),
    (S < BS -> BM = ms(pos(o, X, Y), S) ; BM = ms(pos(o, BX, BY), BS)).
best_move(x, [ms(pos(x, X, Y), S) | MS], BM):-
    best_move(x, MS, ms(pos(x, BX, BY), BS)),
    (S > BS -> BM = ms(pos(x, X, Y), S) ; BM = ms(pos(x, BX, BY), BS)).

/**
 * Swap player
 */
swap(o, x).
swap(x, o).

/**
 * Generates legal moves for a board
 */
legal_move(B, pos(_, X, Y)):-
    member(X, [1, 2, 3]),
    member(Y, [1, 2, 3]),
    \+ member(pos(_, X, Y), B).

/**
 * Determines whether player P has won
 */
has_won(P, B):-
    member(X, [1, 2, 3]),
    member(pos(P, X, 1), B),
    member(pos(P, X, 2), B),
    member(pos(P, X, 3), B).
has_won(P, B):-
    member(Y, [1, 2, 3]),
    member(pos(P, 1, Y), B),
    member(pos(P, 2, Y), B),
    member(pos(P, 3, Y), B).
has_won(P, B):-
    member(pos(P, 1, 1), B),
    member(pos(P, 2, 2), B),
    member(pos(P, 3, 3), B).
has_won(P, B):-
    member(pos(P, 3, 1), B),
    member(pos(P, 2, 2), B),
    member(pos(P, 1, 3), B).


% PLAYING THE GAME


start_game():-
    write("Enter your player (x or o) (x goes first): "),
    read(P),
    write_board([]),
    play_game(x, P, []).

play_game(_, _, B):-
    has_won(P, B),
    !,
    write("Player "), write(P), write(" has won.").
play_game(_, _, B):-
    length(B, 9),
    !,
    write("Game ended in a draw.").
play_game(P, P, B):-
    !,
    write("Enter your move pos(P, X, Y) where P is your player: "),
    read(pos(P, X, Y)),
    (legal_move(B, pos(P, X, Y)) ->
        NB = [pos(P, X, Y) | B],
        swap(P, NP)
    ;
        write("Illegal move"),
        NB = B,
        NP = P
    ),
    write_board(NB),
    play_game(NP, P, NB).
play_game(C, P, B):-
    minimax(C, B, _, M),
    NB = [M | B],
    write_board(NB),
    play_game(P, P, NB).

write_board(B):-
    write_line,
    write("|"),
    write_board(B, 1, 1).

write_board(_, _, 4):-!.
write_board(B, X, Y):-
    (member(pos(P, X, Y), B) -> write(P) ; write("_")),
    write("|"),
    update(X, Y, NX, NY),
    write_board(B, NX, NY).

update(3, Y, 1, NY):-
    !,
    NY is Y + 1,
    nl,
    write_line,
    (NY == 4 -> write("") ; write("|")).
update(X, Y, NX, Y):-
    NX is X + 1.


write_line():-
    write("-------"),nl.
