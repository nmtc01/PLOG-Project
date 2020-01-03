/*
* Displays initial menu
*/
displayMainMenu:-
    write('\33\[2J\n'),
    write('Choose an option:'),nl,
    write('1 - Program generates random puzzle and solves it'),nl,
    write('2 - User inputs a puzzle and program solves it'),nl.

/*
* Displays puzzle grid.
*/
displayGrid(0,_):-
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