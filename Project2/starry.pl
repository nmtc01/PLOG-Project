:-use_module(library(clpfd)).
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
followPath('1', Vars).

followPath('2', Vars):-
    %User inputs a puzzle to be solved - submenu
    subMenu(N, RulesLines, RulesColumns),
    %Vars declaration
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
* Defines variables domain (domain)
* Applies main constraints of the intern puzzle, such as:
* 1- exactly one white circle (sun), one black circle (moon), and one star in every row of the grid (verifyLines)
* 2- exactly one white circle (sun), one black circle (moon), and one star in every row of the grid (verifyColumns)
* 3- symbols will not touch similar symbols diagonally (leftDiagonals and rightDiagonals)
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



