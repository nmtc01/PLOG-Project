:-use_module(library(clpfd)).
:-[generate_boards].
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
    %Constraints
    verifyLines(Vars, N, 0),
    %Labeling
    labeling([], Vars),
    %Display solution
    display(Vars, N, 0).



