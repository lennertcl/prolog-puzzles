% Towers of hanoi
% https://en.wikipedia.org/wiki/Tower_of_Hanoi

hanoi(0, _, _, _):-!.
hanoi(N, From, To, Other):-
    N1 is N - 1,
    hanoi(N1, From, Other, To),
    move(From, To),
    hanoi(N1, Other, To, From).

move(From, To):-
    write("Move from "),
    write(From),
    write(" to "),
    write(To),
    nl.
