% Write a predicate kay4/1 which draws the famous K4 graph on the screen
% Source : https://dtai.cs.kuleuven.be/ppcbook/ppcbook.pdf

kay4(N):-
    boundary("a", "b", N),
    lines(1, N),
    boundary("c", "d", N).

lines(N, N):-!.
lines(Row, N):-
    line(Row, N),
    NR is Row + 1,
    lines(NR, N).

line(Row, N):-
    write("|"),
    line_fill(1, Row, N),
    write("|"),
    nl.

line_fill(N, _, N):-!.
line_fill(Pos, Row, N):-
    write_char(Pos, Row, N),
    Npos is Pos + 1,
    line_fill(Npos, Row, N).

write_char(Row, Row, _):-
    write("\\"),
    !.
write_char(Pos, Row, N):-
    ((N is Pos + Row) ->
        write("/")
    ;
        write(" ")
    ).

boundary(A, B, N):-
    N2 is N - 2,
    write(A),
    write_times("-", N2),
    write(B),
    nl.

write_times(_, 0):-!.
write_times(A, N):-
    N1 is N - 1,
    write(A),
    write_times(A, N1).
