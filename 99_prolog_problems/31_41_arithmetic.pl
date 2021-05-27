consult(problems1_10).

/**
 * Determine whether a given integer is prime
 */
is_prime(X):-
    X1 is X - 1,
    numlist(2, X1, XS),
    \+(div_by(X, XS)).

/**
 * Check if a number is divisible by any number in the list
 */
div_by(_, []):- false.
div_by(X, [Y|_]):-
    0 is mod(X, Y).
div_by(X, [_|YS]):-
    div_by(X, YS).

/**
 * Determine the greatest common divisor
 */
gcd(A, 0, A):-!.
gcd(A, B, G):-
    C is mod(A, B),
    gcd(B, C, G).

/**
 * Determine whether 2 numbers are coprime
 */
coprime(A, B):-
    gcd(A, B, G),
    G == 1.

/**
 * Eulers totient function phi(m)
 * == the number of positive integers 1 <= r < m coprime to m
 */
totient_phi(M, X):-
    totient_phi(M, 1, X).
totient_phi(M, M, 0):-!.
totient_phi(M, R, X):-
    coprime(M, R),
    !,
    R1 is R + 1,
    totient_phi(M, R1, X1),
    X is X1 + 1.
totient_phi(M, R, X):-
    R1 is R + 1,
    totient_phi(M, R1, X).

/**
 * Determine prime factors of an integer
 */
prime_factors(X, L):-
    prime_factors(X, 2, L).
prime_factors(1, _, []):-!.
prime_factors(X, P, L):-
    M is mod(X, P),
    (M == 0 ->
        NX is div(X, P),
        prime_factors(NX, P, NL),
        L = [P|NL]
    ;
        next_prime(P, NP),
        prime_factors(X, NP, L)
    ).

/**
 * Determine the next prime number after P
 */
next_prime(P, NP):-
    P1 is P + 1,
    next_prime(P, P1, NP).
next_prime(_, NP, NP):-
    is_prime(NP),
    !.
next_prime(_, P1, NP):-
    next_prime(P1, NP).

/**
 * Determine prime factors and their multiplicity
 */
prime_factors_mult(X, L):-
    prime_factors(X, F),
    rl_encode(F, L). % from problems1_10

/**
 * Calculate phi(m) using prime factors
 */
phi_m_improved(M, X):-
    prime_factors_mult(M, L),
    phi_m_improved(M, L, X).
phi_m_improved(_, [], 1):-!.
phi_m_improved(M, [[MI, PI]|R], X):-
    phi_m_improved(M, R, NX),
    MI1 is MI - 1,
    pow(PI, MI1, PM),
    X is NX * (PI - 1) * PM.

/**
 * List of primes between M and N
 * M excluded
 */
prime_list(M, N, L):-
    next_prime(M, P),
    (P > N ->
        L = []
    ;
        prime_list(P, N, NL),
        L = [P|NL]
    ).

/**
 * Goldbachs conjecture
 */
goldbach(X, [N1, N2]):-
    between(2, X, N1),
    is_prime(N1),
    N2 is X - N1,
    is_prime(N2),
    !.

/**
 * List of goldbach compositions
 */
goldbach_list(M, N, L):-
    findall(X, (between(M, N, X), even(X)), XS),
    findall(G, (member(X, XS), goldbach(X, G)), L).

% To find all couples where both numbers are bigger than 50
% goldbach_list(1, 2000, L), findall(X-Y, (member([X, Y], L), X>50, Y>50), G).

even(X):-
    0 is mod(X, 2).