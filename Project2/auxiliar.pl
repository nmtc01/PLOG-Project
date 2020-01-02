:-use_module(library(lists)).

/*
* Given a board with size N*N, gives line with index Index
*/
getLine(Board, N, Index, Line):-
    Before is N*Index,
    sublist(Board, Line, Before, N, _).