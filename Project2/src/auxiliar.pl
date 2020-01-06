:-use_module(library(lists)).
:-use_module(library(random)).

/*
* Given a puzzle with size N*N, gives line with index Index.
*/
getLine(Puzzle, N, Index, Line):-
    Before is N*Index,
    sublist(Puzzle, Line, Before, N, _).

/*
* Given a puzzle with size N*N, gives column with index Index.
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
* Verifies if the list of codes given represent a number.
*/
isNumber([]).

isNumber([Head|Tail]):-
    Head > 47, Head < 58,
    isNumber(Tail).

/*
* Converts a list of char codes representing numbers to a list of numbers.
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

/*
* Given a full puzzle, it provides the part of the puzzle line that is within the grid.
*/
getPuzzleLine(Index, N, Vars, Line):-
    No is N+1,
    Before is No*Index,
    sublist(Vars, Line, Before, N, _).

/*
* Gives the part of the puzzle that is inside of the grid.
*/
getPuzzle(N, N, _, Puzzle, List):-
    Puzzle = List.

getPuzzle(Index, N, Vars, Puzzle, List):-
    getPuzzleLine(Index, N, Vars, Line),
    append(List, Line, ListOut),
    Next is Index+1,
    getPuzzle(Next, N, Vars, Puzzle, ListOut).

/*
* Given a full puzzle, provides a list with line rules (outside constraints).
*/
getRulesLines(_, N, Index, RulesLines, List):-
    End is N-1,
    Index = End,
    RulesLines = List.

getRulesLines(Vars, N, Index, RulesLines, List):-
    getLine(Vars, N, Index, Line),
    nth1(N, Line, Rule),
    append(List, [Rule], ListOut),
    Next is Index+1,
    getRulesLines(Vars, N, Next, RulesLines, ListOut).

/*
* Given a full puzzle, provides a list with columns rules (outside constraints).
*/
getRulesColumns(_, N, Index, RulesColumns, List):-
    End is N-1,
    Index = End,
    RulesColumns = List.

getRulesColumns(Vars, N, Index, RulesColumns, List):-
    getColumn(Vars, N, Index, 0, [], Column),
    nth1(N, Column, Rule),
    append(List, [Rule], ListOut),
    Next is Index+1,
    getRulesColumns(Vars, N, Next, RulesColumns, ListOut).

/*
* Given a list, provides the distance between star and black circle, and star and white circle on that list
*/
getDistances(List, DistWhite, DistBlack):-
    nth0(Star, List, 1),
    nth0(White, List, 2),
    nth0(Black, List, 3),
    DistWhite is abs(Star-White),
    DistBlack is abs(Star-Black).

/*
* Selects a random solution
*/
selRandom(Var, _, BB0, BB1):-
    fd_set(Var, Set), fdset_to_list(Set, List),
    random_member(Value, List), 
    ( first_bound(BB0, BB1), Var #= Value ;
    later_bound(BB0, BB1), Var #\= Value ).

/*
* Resets timer
*/
resetTimer:-
    statistics(walltime,_).

/*
* Stops time counter and gives the statistics
*/
getStatistics(Time, BackTracks, Constraints):-
    statistics(walltime,[_,T]),
    Time is (T//10)*10,
    fd_statistics(backtracks, BackTracks),
    fd_statistics(constraints, Constraints).