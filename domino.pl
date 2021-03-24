% Domino

% Puzzle: create a list of the stones such that
% if a stone ends in X, the next one starts in X
stone(2,2).
stone(4,6).
stone(1,2).
stone(2,4).
stone(6,2).

domino(Stones):-
    findall(stone(X, Y), stone(X, Y), L),
    select(stone(X, Y), L, Rest),
    domino(Rest, Y, NewStones),
    Stones = [stone(X, Y) | NewStones].
domino([], _, []):-!.
domino(L, X, Stones):-
    select(stone(X, Y), L, Rest),
    domino(Rest, Y, NewStones),
    Stones = [stone(X, Y) | NewStones].