display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    write('\33\[2J\n'),
    write('\t    PLAYER 1\t\t\t\t\t      PLAYER 2\n'),
    display_boards(0, Board1, Board2),
    display_score(Score),
    display_stacks(Pack1, Pack2, Pack3),
    display_player_playing(Player).

display_boards(9, _, _):-
    write('-------------------------------------\t\t'),
    write('-------------------------------------\n').

display_boards(N, Board1, Board2):-
    write('_____________________________________\t\t'),
    write('_____________________________________\n'),
    nth0(N, Board1, Board1LineN),
    write('|'),
    display_line(Board1LineN),
    write('\t \t'),

    nth0(N, Board2, Board2LineN),
    write('|'),
    display_line(Board2LineN),
    write('\n'),

    N1 is N+1,
    display_boards(N1, Board1, Board2).

display_line([]).
display_line([Head | Tail]):-
    display_cell(Head),
    display_line(Tail).

display_cell(Cell):-
    write(Cell),
    write('|').

display_score(Score):-
    write('\n'),
    write('SCORE: '),
    display_line(Score).

display_stacks(Pack1, Pack2, Pack3):-
    write('\n'),
    write('| '),
    nth0(0, Pack1, Top1),
    write(Top1),
    write('\t'),
    write('| '),
    nth0(0, Pack2, Top2),
    write(Top2),
    write('\t'),
    write('| '),
    nth0(0, Pack3, Top3),
    write(Top3),
    write('\n'),
    write('\n').

display_player_playing(Player):-
    write('Player '),
    write(Player),
    write(': I am playing bro\n').