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
* A given puzzle with N*N elements has one star, one black circle and one white circle on each line.
* The remaining places are empty.
*/
verifyLines(_, N, N).

verifyLines(Puzzle, N, Index):-
    Index < N,
    getLine(Puzzle, N, Index, Line),
    verifyList(Line, N),
    New is Index+1,
    verifyLines(Puzzle, N, New).

/*
* A given puzzle with N*N elements has one star, one black circle and one white circle on each column.
* The remaining places are empty.
*/
verifyColumns(_, N, N).

verifyColumns(Puzzle, N, IndexCol):-
    IndexCol < N,
    getColumn(Puzzle, N, IndexCol, 0, [], Column),
    verifyList(Column, N),
    New is IndexCol+1,
    verifyColumns(Puzzle, N, New).

/*
* Given two lines with size N, verifies the left diagonals constraint for every left(/) diagonal of the two lines.
*/
leftDiagonalPair(_, _, N, N).

leftDiagonalPair(Line1, Line2, N, Index):-
    Index < N,
    I2 is Index-1,
    nth0(Index, Line1, Element1),
    nth0(I2, Line2, Element2),
    %If they are equal then have to be empty places
    %Else they have to be different
    ((Element1 #= Element2 #/\ Element1 #= 4) #\/
    Element1 #\= Element2),
    Next1 is Index+1,
    leftDiagonalPair(Line1, Line2, N, Next1).

/*
* A given puzzle with N*N elements can't have the same element on two contiguous diagonal positions.
* Verifies that situation to left diagonals (/).
*/
leftDiagonals(_, N, Index):-
    Index is N-1.

leftDiagonals(Puzzle, N, Index):-
    I2 is Index+1,
    getLine(Puzzle, N, Index, Line1),
    getLine(Puzzle, N, I2, Line2),
    leftDiagonalPair(Line1, Line2, N, 1),
    leftDiagonals(Puzzle, N, I2).

/*
* Given two lines with size N, verifies the right diagonals constraint for every right(\) diagonal of the two lines.
*/
rightDiagonalPair(_, _, N, N).

rightDiagonalPair(Line1, Line2, N, Index):-
    Index < N,
    I1 is Index-1,
    nth0(I1, Line1, Element1),
    nth0(Index, Line2, Element2),
    %If they are equal then have to be empty places
    %Else they have to be different
    ((Element1 #= Element2 #/\ Element1 #= 4) #\/
    Element1 #\= Element2),
    Next2 is Index+1,
    rightDiagonalPair(Line1, Line2, N, Next2).

/*
* A given puzzle with N*N elements can't have the same element on two contiguous diagonal positions.
* Verifies that situation to right diagonals (\).
*/
rightDiagonals(_, N, Index):-
    Index is N-1.

rightDiagonals(Puzzle, N, Index):-
    I2 is Index+1,
    getLine(Puzzle, N, Index, Line1),
    getLine(Puzzle, N, I2, Line2),
    rightDiagonalPair(Line1, Line2, N, 1),
    rightDiagonals(Puzzle, N, I2).

/*
* Given a list, it makes sure the white circle and the black circle in the list are equally distanced from the star.
*/
starRule(List):-
    nth0(Star, List, 1),
    nth0(White, List, 2),
    nth0(Black, List, 3),
    DistWhite is abs(Star-White),
    DistBlack is abs(Star-Black),
    DistWhite #= DistBlack.

/*
* Given a list, it makes sure the white circle is closer to the star than the black circle in the list.
*/
whiteRule(List):-
    nth0(Star, List, 1),
    nth0(White, List, 2),
    nth0(Black, List, 3),
    DistWhite is abs(Star-White),
    DistBlack is abs(Star-Black),
    DistWhite #< DistBlack.

/*
* Given a list, it makes sure the black circle is closer to the star than the white circle in the list.
*/
blackRule(List):-
    nth0(Star, List, 1),
    nth0(White, List, 2),
    nth0(Black, List, 3),
    DistWhite is abs(Star-White),
    DistBlack is abs(Star-Black),
    DistBlack #< DistWhite.

/*
* Given a puzzle and a list of rules, it applies the rules to the corresponding lines
*/
/*applyLinesRules(Puzzle, Rules, Index):-*/


