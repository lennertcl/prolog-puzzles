reverse([], Acc, Acc).
reverse([X|XS], Acc, R):-
    reverse(XS, [X|Acc], R).

add_numbers([], [], O, R):-
    !,
    (O == 1 -> R = [1] ; R = []).
add_numbers(XS, [], O, R):-
    add_numbers(XS, [0], O, R).
add_numbers([], YS, O, R):-
    add_numbers([0], YS, O, R).
add_numbers([X|XS], [Y|YS], O, [M|R]):-
    S is X + Y + O,
    M is mod(S, 10),
    (S > 9 -> NO = 1 ; NO = 0),
    add_numbers(XS, YS, NO, R).