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
* A given list (line or columns) with N elements has one star, one black circle and one white circle.
* The remaining places are empty.
*/
verifyList(List, N):-
    %Star
    appearsNtimesInList(1, List, 1),
    %Black circle
    appearsNtimesInList(2, List, 1),
    %White circle
    appearsNtimesInList(3, List, 1),
    %Empty places
    EmptyN is N-3,
    appearsNtimesInList(4, List, EmptyN).

/*
* A given board with N*N elements has one star, one black circle and one white circle on each line.
* The remaining places are empty.
*/
verifyLines(_, N, N).

verifyLines(Board, N, Index):-
    Index < N,
    getLine(Board, N, Index, Line),
    verifyList(Line, N),
    New is Index+1,
    verifyLines(Board, N, New).

/*
* A given board with N*N elements has one star, one black circle and one white circle on each column.
* The remaining places are empty.
*/
verifyColumns(_, N, N).

verifyColumns(Board, N, IndexCol):-
    IndexCol < N,
    getColumn(Board, N, IndexCol, 0, [], Column),
    verifyList(Column, N),
    New is IndexCol+1,
    verifyColumns(Board, N, New).