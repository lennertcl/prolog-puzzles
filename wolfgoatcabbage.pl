% Wolf goat and cabbage problem

% Puzzle:
% https://en.wikipedia.org/wiki/Wolf,_goat_and_cabbage_problem
%Once upon a time a farmer went to a market and purchased a wolf, a goat, and a cabbage. On his way home, the farmer came to the bank of a river and rented a boat. But crossing the river by boat, the farmer could carry only himself and a single one of his purchases: the wolf, the goat, or the cabbage.
%If left unattended together, the wolf would eat the goat, or the goat would eat the cabbage.
%The farmer's challenge was to carry himself and his purchases to the far bank of the river, leaving each purchase intact. How did he do it?

solve(Solution):-
    solve([farmer, goat, cabbage, wolf], [], [], Solution).
% Done when all animals and the farmer are on the right side
solve([], [farmer, goat, cabbage, wolf], _, []):-!.
solve(Left, Right, Visited, [Left | Solution]):-
    \+ member(Left, Visited),
    move(Left, Right, NewLeft, NewRight),
    check_valid(NewLeft),
    check_valid(NewRight),
    solve(NewLeft, NewRight, [Left | Visited], Solution),
    !.

/**
 * Move the farmer (with or without something else)
 * to the other side
 */
% Move only the farmer to the right
move(Left, Right, NewLeft, NewRight):-
    select(farmer, Left, NewLeft),
    NewRight = [farmer | Right].
% Move the farmer with something else to the right
move(Left, Right, NewLeft, NewRight):-
    select(farmer, Left, TempLeft),
    select(X, TempLeft, NewLeft), 
    NewRight = [farmer, X | Right].
% All movements are reversed when the farmer is
% on the right side
move(Left, Right, NewLeft, NewRight):-
    member(farmer, Right),
    move(Right, Left, NewRight, NewLeft).

/**
 * Determine whether list does not violate the rules
 */
check_valid(List):-
    % If the farmer is a member, the list is always
    % valid
    member(farmer, List);
    % Otherwise either the goat is gone
    \+member(goat, List);
    % Or the cabbage and wolf are gone
    (\+member(cabbage, List), \+(member(wolf, List))).