:-use_module(library(lists)).
:-use_module(library(random)).
:-[init].
:-[display].

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
    (    
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), (NewInputCoordX > 14; NewInputCoordX < 1), write('Coord x out of range: [1,14]'));
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), (NewInputCoordY > 14; NewInputCoordY < 1), write('Coord y out of range: [1,14]'));
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), InputCoordX = NewInputCoordX, InputCoordY = NewInputCoordY);
        handle_coords(InputCoordX, InputCoordY)
    ).


read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed):-
    write('\nChoose a piece (example: "g1x.")\n'),
    read(InputPiece),
    get_char(_),

    nth0(0, Pack1, Top1),
    nth0(0, Pack2, Top2),
    nth0(0, Pack3, Top3),
    
    ((Top1 == InputPiece, PackUsed = 1);
      (Top2 == InputPiece, PackUsed = 2); 
      (Top3 == InputPiece, PackUsed = 3));

    (write('Please choose an available piece...'),
     read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed)).


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
