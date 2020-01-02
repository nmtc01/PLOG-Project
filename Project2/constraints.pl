:-use_module(library(lists)).

/*getLine(_, _, LineIn, LineOut, 0):-
    LineOut = LineIn.

getLine(Index, [Var|Others], LineIn, LineOut, N):-
    N > 0,*/
    /*Missing using index*/
    /*append(LineIn, [Var], LineIn2),
    Next is N-1,
    getLine(Index, Others, LineIn2, LineOut, Next).

verifyLine(Line).*/

/*
* A given element is present only once in a given list
*/
appearsOnceOnList(Element, List):-
    select(Element, List, ListOut),
    \+member(Element, ListOut).

/*
* A given list with N elements has N-3 places empty.
*/
fillWithEmpty(_, 0).

fillWithEmpty([Head|Tail], N):-
    Head #\= 1,
    Head #\= 2,
    Head #\= 3,
    Head #= 4,
    Next is N-1,
    fillWithEmpty(Tail, Next).

fillWithEmpty([Head|Tail], N):-
    Head #= 4,
    Next is N-1,
    fillWithEmpty(Tail, Next).

/*
* A given line with N elements has one star, one black circle, on white circle.
* The remaining places are empty.
*/
verifyLine(Line, N):-
    appearsOnceOnList(1, Line),
    appearsOnceOnList(2, Line),
    appearsOnceOnList(3, Line),
    fillWithEmpty(Line, N).
