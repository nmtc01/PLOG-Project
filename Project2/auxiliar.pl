:-use_module(library(lists)).

/*
* Given a board with size N*N, gives line with index Index
*/
getLine(Board, N, Index, Line):-
    Before is N*Index,
    sublist(Board, Line, Before, N, _).

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
