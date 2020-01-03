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
* Displays puzzle solution at the end
*/
display(_, N, N).

display(Puzzle, N, Index):-
    Index < N,
    getLine(Puzzle, N, Index, Line),
    write(Line),nl,
    New is Index+1,
    display(Puzzle, N, New).
