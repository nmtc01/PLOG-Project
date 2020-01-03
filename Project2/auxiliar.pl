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
* Displays puzzle grid.
*/
displayGrid(0):-
    nl.

displayGrid(N):-
    N > 0,
    write('________'),
    Next is N-1,
    displayGrid(Next).

/*
* Displays a line with no values, just ||.
*/
displayBlanckLine(0):-
    write('|'),nl.

displayBlanckLine(N):-
    N > 0,
    write('|       '),
    Next is N-1,
    displayBlanckLine(Next).

/*
* Displays puzzle line
*/
displayLine([]):-
    write('|'),nl.

displayLine([Head|Tail]):-
    write('|'),
    ((Head = 1, write(' star  '));
     (Head = 2, write(' white '));
     (Head = 3, write(' black '));
     (Head = 4, write('       '))),
    displayLine(Tail).

/*
* Displays puzzle solution at the end
*/
display(_, N, N):-
    write('--------------------------------------------------------'),nl.

display(Puzzle, N, Index):-
    displayGrid(N),
    Index < N,
    getLine(Puzzle, N, Index, Line),
    displayBlanckLine(N),
    displayLine(Line),
    New is Index+1,
    display(Puzzle, N, New).
