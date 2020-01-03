:-use_module(library(clpfd)).
:-[generate_puzzles].
:-[constraints].
:-[display].

%Generate puzzle
    %generate_puzzle(N, RulesLines, RulesColumns),

/*
* Main predicate - start
*/
play:-
    %Start menu
    mainMenu(N, RulesLines, RulesColumns),
    %Solve starry night generated puzzle
    starry(N, _, RulesLines, RulesColumns).

/*
* Creates a menu with two options
* 1- Generate random puzzle and solve it
* 2- Input a puzzle and solve it
*/
mainMenu(N, RulesLines, RulesColumns):-
    displayMainMenu,
    repeat,
    read_line(Line),
    nth0(0, Line, ChoiceCode),
    char_code(Choice, ChoiceCode),
    ((Choice = '1', generatePuzzle(N, RulesLines, RulesColumns));
     (Choice = '2', subMenu(N, RulesLines, RulesColumns))),!.

/*
* Creates a sub menu - user has to input the board so that the program can solve it
*/
subMenu(N, RulesLines, RulesColumns):-
    repeat,
    write('Input the number of lines/columns (example: 5):'),nl,
    read_line(NCodes),
    isNumber(NCodes),
    number_codes(N, NCodes),!,

    repeat,
    nl,write('Input a line rules list with size N:'),nl,
    write('1 - Represents a star'),nl,
    write('2 - Represents a white circle'),nl,
    write('3 - Represents a black'),nl,
    write('4 - Represents an empty place'),nl,
    write('Example for size of 5: [1, 2, 3, 4, 4]'),nl,
    read_line(RLCodes),
    codesToList(RulesLines, RLCodes, []),
    length(RulesLines, N),!,

    repeat,
    nl,write('Input a column rules list with size N:'),nl,
    write('1 - Represents a star'),nl,
    write('2 - Represents a white circle'),nl,
    write('3 - Represents a black'),nl,
    write('4 - Represents an empty place'),nl,
    write('Example for size of 5: [1, 2, 3, 4, 4]'),nl,
    read_line(RCCodes),
    codesToList(RulesColumns, RCCodes, []),
    length(RulesColumns, N),!.

/*
* Solves starry night puzzle
*/
starry(N, Vars, RulesLines, RulesColumns):-
    /*
        1-Star
        2-White circle
        3-Black circle
        4-Empty
    */
    %Vars declaration
    NVars is N*N,
    length(Vars, NVars),
    %Domain
    domain(Vars, 1, 4),
    %Constraints
    verifyLines(Vars, N, 0),
    verifyColumns(Vars, N, 0),
    leftDiagonals(Vars, N, 0),
    rightDiagonals(Vars, N, 0),
    applyLinesRules(Vars, N, RulesLines, 0),
    applyColumnsRules(Vars, N, RulesColumns, 0),
    %Labeling
    labeling([], Vars),
    %Statistics
    %fd_statistics,
    %statistics,
    %Display solution
    nl, display(Vars, RulesLines, RulesColumns, N, 0).



