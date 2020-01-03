:-use_module(library(random)).

/*generatePuzzle(N, RulesLines, RulesCols):-
    N = 6,
    RulesLines = [1, 4, 4, 4, 2, 4],
    RulesCols = [4, 3, 2, 4, 1, 1].*/

generatePuzzle(N, RulesLines, RulesCols):-
    random(5,10, N),
    add_random_to_list(N, [], RulesLines),
    add_random_to_list(N, [], RulesCols).

add_random_to_list(0, List, Out):-
    Out = List.

add_random_to_list(N, List, Out):-
    N > 0,
    Next is N-1,
    random(1, 5, RandomNumber),
    append(List, [RandomNumber], Output),
    add_random_to_list(Next, Output, Out).

    
