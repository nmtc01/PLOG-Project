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
    NVars is N*N,
    length(Vars, NVars),
    domain(Vars, 1, 4),
    verifyLine(Vars, N),
    labeling([], Vars).

/*starry(N, Vars):-*/
    /*
        1-Star
        2-White circle
        3-Black circle
        4-Empty
    */
    /*NVars is N*N,
    length(Vars, NVars),
    domain(Vars, 1, 4),
    generate_board(N, RuleLines, RuleCols),

    verifyLines(Vars, RuleLines, N, N).*/
    /*verifyCols(RuleCols, N),
    verifyDiagonals(),
    labeling([], Vars).*/

/*verifyLines(_, _, _, 0).

verifyLines(Vars, Rules, Size, Index):-
    getLine(Index, Vars, [], Line, Size),
    verifyLine(Line),
    Next is Index-1,
    verifyLines(Vars, Rules, Size, Next).*/




