%displays the game on the screen, calling various display predicates
display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    write('\33\[2J\n'),
    write('\t      PLAYER 1\t\t\t\t\t         PLAYER 2\n'),
    write('    1   2   3   4   5   6   7   8   9 '),
    write('\t\t'),
    write('      1   2   3   4   5   6   7   8   9 '),nl,
    display_boards(0, Board1, Board2),
    display_score(Score),
    display_stacks(Pack1, Pack2, Pack3),
    display_player_playing(Player).

%displays the boards on the screen
display_boards(9, _, _):-
    write('  -------------------------------------\t\t'),
    write('    -------------------------------------\n').
display_boards(N, Board1, Board2):-
    write('  _____________________________________\t\t'),
    write('    _____________________________________\n'),
    nth0(N, Board1, Board1LineN),
    N1 is N+1,
    write(N1), write(' '),
    write('|'),
    display_line(Board1LineN),
    write('\t\t  '),

    nth0(N, Board2, Board2LineN),
    write(N1), write(' '),
    write('|'),
    display_line(Board2LineN),
    write('\n'),
    
    display_boards(N1, Board1, Board2).

%displays the three pieces on the top of each stack. displays "empty" when the stack doesn't have any more pieces
display_stacks(Pack1, Pack2, Pack3):-
    write('\n'),
    write('| '),
    ((nth0(0, Pack1, Top1), write(Top1));
     write('Empty')),
    write('\t'),
    write('| '),
    ((nth0(0, Pack2, Top2), write(Top2));
     write('Empty')),
    write('\t'),
    write('| '),
    ((nth0(0, Pack3, Top3), write(Top3));
     write('Empty')),
    write('\n'),
    write('\n').

%displays which player is currently playing
display_player_playing(Player):-
    write('Player '),
    write(Player),
    write(': I am playing bro\n').

%displays the current score
display_score(Score):-
    write('\n'),
    write('SCORE: '),
    display_line(Score).

%the following predicates are used to help display the board on the screen
display_line([]).
display_line([Head | Tail]):-
    display_cell(Head),
    display_line(Tail).

display_cell(Cell):-
    write(Cell),
    write('|').





