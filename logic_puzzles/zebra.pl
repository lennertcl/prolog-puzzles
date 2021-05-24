% Zebra

% Source: https://en.wikipedia.org/wiki/Zebra_Puzzle

%There are five houses.
%The Englishman lives in the red house.
%The Spaniard owns the dog.
%Coffee is drunk in the green house.
%The Ukrainian drinks tea.
%The green house is immediately to the right of the ivory house.
%The Old Gold smoker owns snails.
%Kools are smoked in the yellow house.
%Milk is drunk in the middle house.
%The Norwegian lives in the first house.
%The man who smokes Chesterfields lives in the house next to the man with the fox.
%Kools are smoked in the house next to the house where the horse is kept.
%The Lucky Strike smoker drinks orange juice.
%The Japanese smokes Parliaments.
%The Norwegian lives next to the blue house.
%
%Now, who drinks water? Who owns the zebra?

solve(S):-
    S = [[1, _Color1, _Nationality1, Pet1, Drink1, _Smoke1],
        [2, _Color2, _Nationality2, Pet2, Drink2, _Smoke2],
        [3, _Color3, _Nationality3, Pet3, Drink3, _Smoke3],
        [4, _Color4, _Nationality4, Pet4, Drink4, _Smoke4],
        [5, _Color5, _Nationality5, Pet5, Drink5, _Smoke5]],

    % The englishman lives in the red house
    member([_, red, english, _, _, _], S),

    % The spaniard owns the dog
    member([_, _, spaniard, dog, _, _], S),

    %Coffee is drunk in the green house.
    member([_, green, _, _, coffee, _], S),

    %The Ukrainian drinks tea.
    member([_, _, ukrainian, _, tea, _], S),

    %The green house is immediately to the right of the ivory house.
    member([Greenpos, green, _, _, _, _], S),
    member([Ivorypos, ivory, _, _, _, _], S),
    Greenpos is Ivorypos + 1,

    %The Old Gold smoker owns snails.
    member([_, _, _, snail, _, oldgold], S),

    %Kools are smoked in the yellow house.
    member([_, yellow, _, _, _, kools], S),

    %Milk is drunk in the middle house.
    member([3, _, _, _, milk, _], S),

    %The Norwegian lives in the first house.
    member([1, _, norwegian, _, _, _], S),

    %The man who smokes Chesterfields lives in the house next to the man with the fox.
    member([Chesterfieldpos, _, _, _, _, chesterfields], S),
    member([Foxpos, _, _, fox, _, _], S),
    1 is abs(Chesterfieldpos - Foxpos),

    %Kools are smoked in the house next to the house where the horse is kept.
    member([Koolspos, _, _, _, _, kools], S),
    member([Horsepos, _, _, horse, _, _], S),
    1 is abs(Koolspos - Horsepos),

    %The Lucky Strike smoker drinks orange juice.
    member([_, _, _, _, orangejuice, luckystrike], S),

    %The Japanese smokes Parliaments.
    member([_, _, japanese, _, _, parliaments], S),

    %The Norwegian lives next to the blue house.
    member([Norwegianpos, _, norwegian, _, _, _], S),
    member([Bluepos, blue, _, _, _, _], S),
    1 is abs(Norwegianpos - Bluepos),

    %Now, who drinks water? Who owns the zebra?
    member(water, [Drink1, Drink2, Drink3, Drink4, Drink5]),
    member(zebra, [Pet1, Pet2, Pet3, Pet4, Pet5]).