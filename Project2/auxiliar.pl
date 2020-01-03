:-use_module(library(lists)).

/*
* Given a puzzle with size N*N, gives line with index Index
*/
getLine(Puzzle, N, Index, Line):-
    Before is N*Index,
    sublist(Puzzle, Line, Before, N, _).

/*
* Given a puzzle with size N*N, gives column with index Index
*/
getColumn(_,N,_,N,ColIn,ColOut):-
    ColIn = ColOut.

getColumn(Puzzle, N, IndexCol, IndexLine, ColIn, ColOut):-
    IndexLine < N,
    I is N*IndexLine + IndexCol,
    nth0(I, Puzzle, Element),
    append(ColIn, [Element], Col),
    New is IndexLine+1, 
    getColumn(Puzzle, N, IndexCol, New, Col, ColOut).

/*
* Verifies if the list of codes given represent a number
*/
isNumber([]).

isNumber([Head|Tail]):-
    Head > 47, Head < 58,
    isNumber(Tail).

/*
* Converts a list of char codes representing numbers to a list of numbers
*/
codesToList(Numbers, [], List):-
    Numbers = List.

codesToList(Numbers, [Head|Tail], List):-
    Head > 47, Head < 58,
    number_codes(Number, [Head]),
    append(List, [Number], ListOut),
    codesToList(Numbers, Tail, ListOut).

codesToList(Numbers, [Head|Tail], List):-
    (Head < 48; Head > 57),
    codesToList(Numbers, Tail, List).