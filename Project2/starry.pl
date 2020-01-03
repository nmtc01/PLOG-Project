:-use_module(library(clpfd)).
:-[constraints].
:-[menu].

/*
* Start predicate
*/
play:-
    %Start menu
    mainMenu(N, RulesLines, RulesColumns),
    %Solve starry night generated puzzle
    starry(N, _, RulesLines, RulesColumns).

/*
* Main - Solves starry night puzzle
*/
starry(N, Vars, RulesLines, RulesColumns):-
    /*
        1-Star
        2-White circle
        3-Black circle
        4-Empty
    */
    %Vars declaration
    NVars is N*N,
    length(Vars, NVars),
    %Domain
    domain(Vars, 1, 4),
    %Constraints
    verifyLines(Vars, N, 0),
    verifyColumns(Vars, N, 0),
    leftDiagonals(Vars, N, 0),
    rightDiagonals(Vars, N, 0),
    applyLinesRules(Vars, N, RulesLines, 0),
    applyColumnsRules(Vars, N, RulesColumns, 0),
    %Labeling
    labeling([], Vars),
    %Statistics
    %fd_statistics,
    %statistics,
    %Display solution
    nl, display(Vars, RulesLines, RulesColumns, N, 0).



