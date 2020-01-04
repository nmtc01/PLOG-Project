:-use_module(library(clpfd)).
:-use_module(library(random)).
:-[constraints].
:-[menu].

/*  Symbols
    1-Star
    2-White circle
    3-Black circle
    4-Empty
*/

/*
* Start predicate.
*/
play(Vars):-
    %Start menu
    mainMenu(Choice),
    %Choose path 
    followPath(Choice, Vars).

/*
* Divides program in two paths, representing each of the two options of the menu.
* 1- Generate random puzzle and solve it
* 2- Input a puzzle and solve it
*/
followPath('1', Vars):-
    %Generate random N between 5 and 10
    random(5, 10, N),
    %Vars declaration - all puzzle including outside constraints
    No is N+1,
    NVars is (No)*(No),
    length(Vars, NVars),
    %get part of the puzzle that is inside of the grid
    getPuzzle(0, N, Vars, Puzzle, []),
    %Apply constraints that are equal on the two options - inside constraints
    starryCommon(N, Puzzle),
    %Apply constraints that are specific of this option - outside constraints
    starryGenerate(No, Vars).

followPath('2', Vars):-
    %User inputs a puzzle to be solved - submenu
    subMenu(N, RulesLines, RulesColumns),
    %Vars declaration - only puzzle inside grid
    NVars is N*N,
    length(Vars, NVars),
    %Apply constraints that are equal on the two options - inside constraints
    starryCommon(N, Vars),
    %Apply constraints that are specific of this option - outside constraints
    starryUser(N, Vars, RulesLines, RulesColumns).

/*
* Defines variables domain (domain)
* Applies main constraints of the intern puzzle, such as:
* 1- exactly one white circle (sun), one black circle (moon), and one star in every row of the grid (verifyLines)
* 2- exactly one white circle (sun), one black circle (moon), and one star in every row of the grid (verifyColumns)
* 3- symbols will not touch similar symbols diagonally (leftDiagonals and rightDiagonals)
*/
starryCommon(N, Vars):-
    %Domain
    domain(Vars, 1, 4),
    %Constraints
    verifyLines(Vars, N, 0),
    verifyColumns(Vars, N, 0),
    leftDiagonals(Vars, N, 0),
    rightDiagonals(Vars, N, 0).

/*
* Applies constraints to lines (constraintLinesRules) and to columns (constraintColumnsRules):
* 1- A circle on the side of the grid indicates the color of the circle closer to the star in that row or column. 
* 2- A star on the side of the grid indicates that the circles in that row or column are the same distance to the star.
* Then gives the solution.
*/
starryGenerate(N, Vars):-
    constraintLinesRules(Vars, N, 0),
    constraintColumnsRules(Vars, N, 0),
    %Labeling
    labeling([], Vars),
    %Statistics
    %fd_statistics,
    %statistics,
    %Get Rules
    getRulesLines(Vars, N, 0, RulesLines, []),
    getRulesColumns(Vars, N, 0, RulesColumns, []),
    %Display solution
    nl, display(Vars, RulesLines, RulesColumns, N, 0).

/*
* Applies constraints given by the user to lines (applyLinesRules) and to columns (applyColumnsRules):
* 1- A circle on the side of the grid indicates the color of the circle closer to the star in that row or column. 
* 2- A star on the side of the grid indicates that the circles in that row or column are the same distance to the star.
* Then gives the solution.
*/
starryUser(N, Vars, RulesLines, RulesColumns):-
    applyLinesRules(Vars, N, RulesLines, 0),
    applyColumnsRules(Vars, N, RulesColumns, 0),
    %Labeling
    labeling([], Vars),
    %Statistics
    %fd_statistics,
    %statistics,
    %Display solution
    nl, display(Vars, RulesLines, RulesColumns, N, 0).





