:-use_module(library(lists)).
:-use_module(library(random)).

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

randomize_number(N, Random):-
    random(0, N, Random).

add_element(Element, List, [Element|List]).

prepare_pack(0, Pack, PackOut, PackNumber, PackOutNumber):-
    PackOut = Pack,
    PackOutNumber = PackNumber.

prepare_pack(NPieces, Pieces, PiecesOut, PackNumber, PackNumberOut):-
    length(Pieces, NElements),
    randomize_number(NElements, Random),
    nth0(Random, Pieces, Element),
    Next is NPieces-1,
    add_element(Element, PackNumber, NewPackNumber),
    delete(Pieces, Element, NewPieces),
    prepare_pack(Next, NewPieces, PiecesOut, NewPackNumber, PackNumberOut).

init_pieces(Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3):-
    Pieces = ['g1x', 'r1y', 'b1x', 'r1x', 'b3x', 'r1z', 'b1z', 'g2z', 'b1y', 'g2x', 'b2x', 'r2x', 'b3y', 'b2z', 'b2y', 'r2z', 'g1z', 'r2y', 'g1y', 'g2y', 'r3y', 'b3z', 'r3x', 'g3x', 'g3y', 'g3z', 'r3z'],
    prepare_pack(9, Pieces, NewPieces1, Pack1, PackOut1),
    prepare_pack(9, NewPieces1, NewPieces2, Pack2, PackOut2),
    prepare_pack(9, NewPieces2, _, Pack3, PackOut3).

init_game(Board1, Board2, Score, Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3, Player):-
    (Player = 1; Player = 2),
    init_board(Board1, Board2),
    init_score(Score),
    init_pieces(Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3).

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
    write(': I am playing bro\n').


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

repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),
    handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY, InputPiece, PackUsed),
    handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut),
    (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, Score, NewPack1, Pack2, Pack3));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, NewPack2, Pack3));
        (PackUsed = 3, delete(Pack1, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, NewPack3))
    ).

get_xy(2, [HeadX|[HeadY|_Tail]], InputCoordX, InputCoordY):-
    InputCoordX is HeadX,
    InputCoordY is HeadY.

get_xy(N, [_Head|Tail], InputCoordX, InputCoordY):-
    N > 2,
    Next is N-1,
    get_xy(Next, Tail, InputCoordX, InputCoordY).

handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY, InputPiece, PackUsed):-
    read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed),
    handle_coords(InputCoordX, InputCoordY),
    write('Piece: '),
    write(InputPiece),
    write(' at Coords: ('),
    write(InputCoordX),
    write(','),
    write(InputCoordY),
    write(')\n\n').

handle_coords(InputCoordX, InputCoordY):-
    write('Input coordinates (example: "(x,y).")\n'),
    read(InputCoords),
    InputCoords =.. List,
    get_xy(3, List, InputCoordX, InputCoordY).


read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed):-
    write('\nChoose a piece (example: "g1x.")\n'),
    read(InputPiece),
    get_char(_),

    nth0(0, Pack1, Top1),
    nth0(0, Pack2, Top2),
    nth0(0, Pack3, Top3),
    
    (((Top1 == InputPiece, PackUsed = 1);
      (Top2 == InputPiece, PackUsed = 2); 
      (Top3 == InputPiece, PackUsed = 3));

    (write('Please choose an available piece...'),
     read_piece(Pack1, Pack2, Pack3, InputPiece))).


handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut):-
    (Player = 1, set_piece(InputCoordX, InputCoordY, InputPiece, Board1, BoardOut));
    (Player = 2, set_piece(InputCoordX, InputCoordY, InputPiece, Board2, BoardOut)).

handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, Pack3):-
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, repeat(BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer));
     (Player = 2, repeat(Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer))).

place_star(Board1, Board2, BoardOut, Player):-
    write('Choose a place to your star\n'),
    handle_coords(InputCoordX, InputCoordY),
    handle_move(Player, InputCoordX, InputCoordY, ' S ', Board1, Board2, BoardOut).

play_game(0,Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, Player).

play_game(N, Board1, Board2, Score, Pack1, Pack2, Pack3, Player):-
    N > 0,
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),
    place_star(Board1, Board2, BoardOut, Player),
    Next is N-1,
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, play_game(Next, BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer));
     (Player = 2, play_game(Next, Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer))).

play:-
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    play_game(2, Board1, Board2, Score, PackOut1, PackOut2, PackOut3, 1).




















