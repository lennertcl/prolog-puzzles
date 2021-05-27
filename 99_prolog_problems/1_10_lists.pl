% Last elem of list
my_last([X], X):-!.
my_last([_|XS], Y):-
    my_last(XS, Y).

% Last but one
my_last_1([X, _], X):-!.
my_last_1([_|XS], Y):-
    my_last_1(XS, Y).

% kth elem
k_elem(XS, K, X):-
    k_elem(XS, K, 0, X).
k_elem([X|_], K, K, X):-!.
k_elem([_|XS], K, I, X):-
    I1 is I + 1,
    k_elem(XS, K, I1, X).

% number of elements
nb_elem([], 0).
nb_elem([_|XS], N):-
    nb_elem(XS, N1),
    N is N1 + 1.

% reverse a list
my_reverse([], Acc, Acc).
my_reverse([X|XS], Acc, Reversed):-
    my_reverse(XS, [X|Acc], Reversed).

% palindrome
palindrome(XS):-
    length(XS, N),
    H is div(N, 2),
    % First H elements
    take(XS, H, YS),
    % Last H elements
    (even(N) ->
        H1 = H 
    ;   
        H1 is H + 1
    ),
    drop(XS, H1, SY),
    my_reverse(YS, [], SY).

% Take n elements of xs
take(_, 0, []):-!.
take([X|XS], N, [X|YS]):-
    N1 is N - 1,
    take(XS, N1, YS).

% Drop n elements of xs
drop(XS, 0, XS):-!.
drop([_|XS], N, YS):-
    N1 is N - 1,
    drop(XS, N1, YS).

even(X):-
    0 is mod(X, 2).

% Flatten the list of lists (of lists ...)
my_flatten([], []):-!.
my_flatten(X, [X]):-
    \+(is_list(X)),
    !.
my_flatten([X|XS], YSS):-
    my_flatten(X, Y),
    my_flatten(XS, YS),
    append(Y, YS, YSS).

% Eliminate consecutive duplicates
compress([X|XS], [X|YS]):-
    compress(XS, X, YS).
compress([], _, []):-!.
compress([X|XS], X, YS):-
    !,
    compress(XS, X, YS).
compress([X|XS], _, [X|YS]):-
    compress(XS, X, YS).

% Pack repeated elements into sublists
pack([X|XS], YS):-
    pack(XS, [X], YS).
pack([], Acc, [Acc]):-!.
pack([X|XS], [X|Acc], YS):-
    !,
    pack(XS, [X, X |Acc], YS).
pack([X|XS], Acc, [Acc|YS]):-
    pack(XS, [X], YS).

% Encode by number of repetitions of elem
rl_encode(XS, YS):-
    pack(XS, PS),
    rl_encode_packed(PS, YS).
rl_encode_packed([], []).
rl_encode_packed([[P|PS]|PSS], [[N, P] | YS]):-
    length([P|PS], N),
    rl_encode_packed(PSS, YS).
