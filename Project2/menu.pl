:-[display].

/*
* Creates a menu with two options
* 1- Generate random puzzle and solve it
* 2- Input a puzzle and solve it
*/
mainMenu(Choice):-
    displayMainMenu,
    repeat,
    read_line(Line),
    nth0(0, Line, ChoiceCode),
    char_code(Choice, ChoiceCode),!.

/*
* Creates a sub menu - user has to input the board so that the program can solve it
*/
subMenu(N, RulesLines, RulesColumns):-
    nMenu(N),

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
* Requests for input of number of lines/columns
*/
nMenu(N):-
    repeat,
    write('Input the number of lines/columns (example: 5):'),nl,
    write('Number bigger than 4:'),nl,
    read_line(NCodes),
    isNumber(NCodes),
    number_codes(N, NCodes),
    N > 4,!.
