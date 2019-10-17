:-use_module(library(lists)).

init_board(Board1, Board2):-
    Board1 = [ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ],

    Board2 = [ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ].

init_key(Key):-
    Key = [ ['A - R1X', '| B - R2X', '| C - R3X', '| D - R1Y', '| E - R2Y', '| F - R3Y', '| G - R1Z', '| H - R2Z', '| I - R3Z'],
            ['J - G1X', '| K - G2X', '| L - G3X', '| M - G1Y', '| N - G2Y', '| O - G3Y', '| P - G1Z', '| Q - G2Z', '| R - G3Z'],
            ['S - B1X', '| T - B2X', '| U - B3X', '| V - B1Y', '| W - B2Y', '| X - B3Y', '| Y - B1Z', '| Z - B2Z', '| % - B3Z'] ].

init_score(Score):-
    Score = [0,0].

init_stacks(Pack1, Pack2, Pack3):-
    Pack1 = ['J', 'D', 'S', 'A', 'U', 'G', 'Y', 'Q', 'V'],
    Pack2 = ['K', 'T', 'B', 'X', 'Z', 'W', 'H', 'P', 'E'],
    Pack3 = ['M', 'N', 'F', '%', 'C', 'L', 'O', 'R', 'I'].

init_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Key, Player):-
    (Player = 1; Player = 2),
    init_board(Board1, Board2),
    init_key(Key),
    init_score(Score),
    init_stacks(Pack1, Pack2, Pack3),
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Key, Player).

display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Key, Player):-
    write('\t   PLAYER 1\t\t\t\t\t    PLAYER 2\n'),
    display_boards(0, Board1, Board2),
    display_score(Score),
    display_stacks(Pack1, Pack2, Pack3),
    display_key(0, Key),
    display_player_playing(Player).

display_boards(14, _, _).
display_boards(N, Board1, Board2):-
    nth0(N, Board1, Board1LineN),
    nth0(N, Board2, Board2LineN),
    write('| '),
    display_line(Board1LineN),
    write('|\t \t \t| '),
    display_line(Board2LineN),
    write('|\n'),
    N1 is N+1,
    display_boards(N1, Board1, Board2).

display_score(Score):-
    write('\n'),
    write('\t\t\t\t   SCORE: '),
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

display_key(3, _).
display_key(N, Key):-
    nth0(N, Key, KeyLineN),
    write('| '),
    display_line(KeyLineN),
    write('|\n'),
    N1 is N+1,
    display_key(N1, Key).

display_line([]).
display_line([Head | Tail]):-
    write(Head),
    write(' '),
    display_line(Tail).

display_player_playing(Player):-
    write('Player '),
    write(Player),
    write(': I am playing bro').







