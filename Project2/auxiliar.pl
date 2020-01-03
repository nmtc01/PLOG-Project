:-use_module(library(lists)).

/*
* Given a board with size N*N, gives line with index Index
*/
getLine(Board, N, Index, Line):-
    Before is N*Index,
    sublist(Board, Line, Before, N, _).

/*
* Given a board with size N*N, gives column with index Index
*/
getColumn(_,N,_,N,ColIn,ColOut):-
    ColIn = ColOut.

getColumn(Board, N, IndexCol, IndexLine, ColIn, ColOut):-
    IndexLine < N,
    I is N*IndexLine + IndexCol,
    nth0(I, Board, Element),
    append(ColIn, [Element], Col),
    New is IndexLine+1, 
    getColumn(Board, N, IndexCol, New, Col, ColOut).

/*
* Displays puzzle solution at the end
*/
display(_, N, N).

display(Board, N, Index):-
    Index < N,
    getLine(Board, N, Index, Line),
    write(Line),nl,
    New is Index+1,
    display(Board, N, New).
