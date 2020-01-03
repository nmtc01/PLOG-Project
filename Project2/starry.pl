:-use_module(library(clpfd)).
:-[generate_puzzles].
:-[constraints].

starry(N, Vars):-
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
    %Generate puzzle
    generate_puzzle(N, RulesLines, RulesColumns),
    %Constraints
    verifyLines(Vars, N, 0),
    verifyColumns(Vars, N, 0),
    leftDiagonals(Vars, N, 0),
    rightDiagonals(Vars, N, 0),


    %testing
    
    %testing


    %Labeling
    labeling([], Vars),
    %Display solution
    display(Vars, N, 0).



