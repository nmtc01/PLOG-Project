:-[auxiliar].

/*
* A given element is present N times in a given list
*/
appearsNtimesInList(_, [], 0).
appearsNtimesInList(Element, [Head|Tail], N):-
    Element #= Head #<=> B,
    N #= M + B,
    appearsNtimesInList(Element, Tail, M). 

/*
* A given line with N elements has one star, one black circle and one white circle.
* The remaining places are empty.
*/
verifyLine(Line, N):-
    %Star
    appearsNtimesInList(1, Line, 1),
    %Black circle
    appearsNtimesInList(2, Line, 1),
    %White circle
    appearsNtimesInList(3, Line, 1),
    %Empty places
    EmptyN is N-3,
    appearsNtimesInList(4, Line, EmptyN).

/*
* A given board with N*N elements has one star, one black circle and one white circle on each line.
* The remaining places are empty.
*/
verifyLines(_, N, N).

verifyLines(Board, N, Index):-
    Index < N,
    getLine(Board, N, Index, Line),
    verifyLine(Line, N),
    New is Index+1,
    verifyLines(Board, N, New).
