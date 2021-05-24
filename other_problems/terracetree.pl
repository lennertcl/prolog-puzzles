% Terrace to tree

% Puzzle:
% Determine the shortest path so only the existing paths are used and every tree
% is visited exactly once 
% Every valid path starts on the terrace and ends on the terrace

terrace_to_tree(t1, 4).
terrace_to_tree(t2, 4).
terrace_to_tree(t3, 1).
tree_to_tree(t1, t2, 4).
tree_to_tree(t1, t3, 2).
tree_to_tree(t2, t3, 5).

/**
 * Solve by finding every valid tour and taking the tour with
 * minimal length
 */
solve(Path, Length):-
    findall(L-P, tour(P, L), Ts),
    min_member(Length-Path, Ts).

/**
 * Determine the shortest path P with length L that starts on the terrace,
 * passes every tree and ends on the terrace
 */
tour(Path, Length):-
    findall(T, terrace_to_tree(T, _), Ts),
    list_to_set(Ts, Trees),
    % Pick a starting tree
    terrace_to_tree(Tree, Distance),
    select(Tree, Trees, Rest),
    % Make the tour
    tour(Tree, Rest, Npath, Nlength),
    Path = [t, Tree | Npath],
    Length is Nlength + Distance.

% Empty tour has empty path + distance to terrace
tour(Tree, [], [t], Distance):-
    terrace_to_tree(Tree, Distance).
tour(Tree, Trees, Path, Length):-
    % Move from this tree to next tree not visited yet
    (tree_to_tree(Tree, Next, Distance);
    tree_to_tree(Next, Tree, Distance)),
    % Make sure this tree has not been visited
    select(Next, Trees, Rest),
    % Extend the rest of the tour
    tour(Next, Rest, Npath, Nlength),
    Path = [Next | Npath],
    Length is Nlength + Distance.