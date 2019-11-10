:-use_module(library(lists)).

init_board(Board1, Board2):-
    Board1 = [ [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '] ],

    Board2 = [ [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '] ].


init_score(Score):-
    Score = [0,0].

init_stacks(Pack1, Pack2, Pack3):-
    Pack1 = ['G1X', 'R1Y', 'B1X', 'R1X', 'B3X', 'R1Z', 'B1Z', 'G2Z', 'B1Y'],
    Pack2 = ['G2X', 'B2X', 'R2X', 'B3Y', 'B2Z', 'B2Y', 'R2Z', 'G1Z', 'R2Y'],
    Pack3 = ['G1Y', 'G2Y', 'R3Y', 'B3Z', 'R3X', 'G3X', 'G3Y', 'G3Z', 'R3Z'].

init_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    (Player = 1; Player = 2),
    init_board(Board1, Board2),
    init_score(Score),
    init_stacks(Pack1, Pack2, Pack3).

display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    write('\t\t      PLAYER 1\t\t\t\t\t\t\t\t\tPLAYER 2\n'),
    display_boards(0, Board1, Board2),
    display_score(Score),
    display_stacks(Pack1, Pack2, Pack3),
    display_player_playing(Player).

display_boards(14, _, _):-
    write('---------------------------------------------------------\t\t'),
    write('---------------------------------------------------------\n').

display_boards(N, Board1, Board2):-
    write('_________________________________________________________\t\t'),
    write('_________________________________________________________\n'),
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
    write(': I am playing bro').

set_piece(Line, Column, Piece, BoardIn, BoardOut):-
    set_in_line(Line, Column, Piece, BoardIn, BoardOut).

set_in_line(1, Column, Piece, [Line| Others], [NewLine| Others]):-
    set_in_column(Column, Piece, Line, NewLine).

set_in_line(N, Column, Piece, [Line| Others], [Line| NewOthers]):-
    N > 1,
    Next is N-1,
    set_in_line(Next, Column, Piece, Others, NewOthers).

set_in_column(1, Piece, [_|Others], [Piece|Others]).

set_in_column(N, Piece, [Column|Others], [Column|NewOthers]):-
    N > 1,
    Next is N-1,
    set_in_column(Next, Piece, Others, NewOthers).

play:-
    init_game(Board1, Board2, Score, Pack1, Pack2, Pack3, 1),
    repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, 1).

repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),
    write('\nChoose a piece (example: "g1x.")\n'),
    read(InputPiece),
    get_char(_),
    write('Input coordinates (example: "(x,y).")\n'),
    read(InputCoords),
    InputCoords =.. List,
    getXY(3, List, InputCoordX, InputCoordY),
    write('Piece: '),
    write(InputPiece),
    write(' at Coords: ('),
    write(InputCoordX),
    write(','),
    write(InputCoordY),
    write(')\n\n'),
    set_piece(InputCoordX, InputCoordY, InputPiece, Board1, BoardOut1),
    repeat(BoardOut1, Board2, Score, Pack1, Pack2, Pack3, 1).

getXY(2, [HeadX|[HeadY|_Tail]], InputCoordX, InputCoordY):-
    InputCoordX is HeadX,
    InputCoordY is HeadY.

getXY(N, [_Head|Tail], InputCoordX, InputCoordY):-
    N > 2,
    Next is N-1,
    getXY(Next, Tail, InputCoordX, InputCoordY).
















