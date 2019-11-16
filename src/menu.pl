menu(Choice):-
    write('Welcome to our game! Choose 1 to play PVP, 2 for AI!\n'),
    read_line(Line),
    nth0(0, Line, ChoiceCode),
    char_code(Choice, ChoiceCode).
