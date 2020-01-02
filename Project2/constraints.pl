:-use_module(library(lists)).

/*
* A given element is present N times in a given list
*/
appearsNtimesInList(_, [], 0).
appearsNtimesInList(Element, [Head|Tail], N):-
    Element #= Head #<=> B,
    N #= M + B,
    appearsNtimesInList(Element, Tail, M). 

/*
* A given line with N elements has one star, one black circle, on white circle.
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
    write(EmptyN),
    write(Line),
    appearsNtimesInList(4, Line, EmptyN).





/*getLine(_, _, LineIn, LineOut, 0):-
    LineOut = LineIn.

getLine(Index, [Var|Others], LineIn, LineOut, N):-
    N > 0,*/
    /*Missing using index*/
    /*append(LineIn, [Var], LineIn2),
    Next is N-1,
    getLine(Index, Others, LineIn2, LineOut, Next).

verifyLine(Line).*/
