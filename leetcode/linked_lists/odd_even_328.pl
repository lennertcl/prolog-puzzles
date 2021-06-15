odd_even(XS, R):-
    odd_even(XS, even, [], [], RR),
    reverse(RR, R).

odd_even([], _, O, E, R):-
    append(O, E, R).
odd_even([X|XS], even, O, E, R):-
    odd_even(XS, odd, O, [X|E], R).
odd_even([X|XS], odd, O, E, R):-
    odd_even(XS, even, [X|O], E, R).