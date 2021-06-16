% Horizontal, vertical or diagonal in either direction
puzzle([[c, a, b], [x, e, e], [y, f, d]], [b, e, d]).
directions([d(0, 1), d(1, 0), d(1, 1), d(0, -1), d(-1, 0), d(-1, -1)]).

% Translate puzzle to list of pos(X, Y, E)
translate(M, R):-
    translate(M, 0, R).
translate([], _, []).
translate([A|AS], Y, R):-
    translate_row(A, 0, Y, RT),
    Y1 is Y + 1,
    translate(AS, Y1, RR),
    append(RT, RR, R).

translate_row([], _, _, []).
translate_row([A|AS], X, Y, [pos(X, Y, A) | R]):-
    X1 is X + 1,
    translate_row(AS, X1, Y, R).

search(B, [W|WS]):-
    translate(B, TB),
    member(pos(X, Y, W), TB),
    directions(DS),
    member(D, DS),
    search(TB, WS, pos(X, Y), D),
    write("Found the word: "), nl,
    write("Starting position: "), write(pos(X, Y)), nl,
    write("Direction: "), write(D).
search(_, [], _, _).
search(B, [W|WS], pos(X, Y), D):-
    move(pos(X, Y), D, pos(NX, NY)),
    member(pos(NX, NY, W), B),
    search(B, WS, pos(NX, NY), D).

move(pos(X, Y), d(DX, DY), pos(NX, NY)):-
    NX is X + DX,
    NY is Y + DY.