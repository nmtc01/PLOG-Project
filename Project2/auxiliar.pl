getLine(_, _, LineIn, LineOut, 0):-
    LineOut = LineIn.

getLine(Index, [Var|Others], LineIn, LineOut, N):-
    N > 0,
    /*Missing using index*/
    append(LineIn, [Var], LineIn2),
    Next is N-1,
    getLine(Index, Others, LineIn2, LineOut, Next).

verifyLine(Line).