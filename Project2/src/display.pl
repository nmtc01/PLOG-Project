/*
* Displays initial menu
*/
displayMainMenu:-
    write('\33\[2J\n'),
    write('   _____  _                               _    _  _        _      _'),nl,   
    write('  /  ___|| |                             | \\  | |(_)      | |    | |'),nl, 
    write('  \\  \\   | |   ___ _  _ __  _ __  _   _  |  \\ | |_   __ _ | |__  | |_'),nl, 
    write('   \\  \\ | __| /  _  ||  __||  __|| | | | | . \\| | | /    ||  _ \\ | __|'),nl,
    write('/\\__/ /  | |_ | (_| || |   | |   | |_| | | |\\   | || (_| || | | || |_'),nl, 
    write('\\____/    \\__| \\__,_||_|   |_|    \\__, | \\_| \\_/|_| \\__, ||_| |_| \\__|'),nl,
    write('                                   __/ |             __/ |'),nl,     
    write('                                  |___/             |___/'),nl,
    write('Choose an option:'),nl,
    write('1 - Program generates random puzzle and solves it'),nl,
    write('2 - User inputs a puzzle and program solves it'),nl,
    write('3 - Exit'),nl.

/*
* Displays puzzle grid.
*/
displayGrid(0,_):-
    resetTimer,
    nl.

displayGrid(N, Char):-
    N > 0,
    ((Char='_', write('________'));
     (Char='-', write('--------'))),
    Next is N-1,
    displayGrid(Next,Char).

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
* Displays column rules on a line at the end
*/
displayLineOfRules([]):-nl,nl.

displayLineOfRules([Head|Tail]):-
    write(' '),
    ((Head = 1, write(' star  '));
     (Head = 2, write(' white '));
     (Head = 3, write(' black '));
     (Head = 4, write('       '))),
    displayLineOfRules(Tail).

/*
* Displays puzzle line
*/
displayLine([], RulesLines, Index):-
    write('|'),
    nth0(Index, RulesLines, Rule),
    ((Rule = 1, write(' star  '));
     (Rule = 2, write(' white '));
     (Rule = 3, write(' black '));
     (Rule = 4, write('       '))),
    nl.

displayLine([Head|Tail], RulesLines, Index):-
    write('|'),
    ((Head = 1, write(' star  '));
     (Head = 2, write(' white '));
     (Head = 3, write(' black '));
     (Head = 4, write('       '))),
    displayLine(Tail, RulesLines, Index).

/*
* Prints statistics
*/
printStatistics(Time, BackTracks, Constraints):-
    nl,write('Time: '),
    write(Time), write('ms'),nl,
    write('Backtracks: '),
    write(BackTracks),nl,
    write('Number of Constraints: '),
    write(Constraints),nl,nl.

/*
* Displays puzzle solution at the end
*/
display(_, _, RulesCols, N, N):-
    displayGrid(N, '-'),nl,
    displayLineOfRules(RulesCols).

display(Puzzle, RulesLines, RulesCols, N, Index):-
    displayGrid(N, '_'),
    Index < N,
    getLine(Puzzle, N, Index, Line),
    displayBlanckLine(N),
    displayLine(Line, RulesLines, Index),
    New is Index+1,
    display(Puzzle, RulesLines, RulesCols, N, New).