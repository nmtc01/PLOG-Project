:-use_module(library(lists)).
:-use_module(library(random)).
:-[init].
:-[display].
:-[stringnumber].

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

get_xy(2, [HeadX|[HeadY|_Tail]], InputCoordX, InputCoordY):-
    InputCoordX is HeadX,
    InputCoordY is HeadY.

get_xy(N, [_Head|Tail], InputCoordX, InputCoordY):-
    N > 2,
    Next is N-1,
    get_xy(Next, Tail, InputCoordX, InputCoordY).

handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY, InputPiece, PackUsed, PossibleMoves):-
    length(PossibleMoves, Size),
    read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed),!,
    repeat,
    handle_coords(InputCoords, InputCoordX, InputCoordY),
    verify_moves(Size, InputCoordX, InputCoordY, PossibleMoves),
    write('Piece: '),
    write(InputPiece),
    write(' at Coords: ('),
    write(InputCoordX),
    write(','),
    write(InputCoordY),
    write(')\n\n').

handle_coords(InputCoords, InputCoordX, InputCoordY):-
    write('Input coordinates (example: "(x,y).")\n'),
    read(InputCoords),
    InputCoords =.. List,
    get_xy(3, List, NewInputCoordX, NewInputCoordY), 
    NewInputCoordX < 15, NewInputCoordX > 0,
    InputCoordX = NewInputCoordX, 
    InputCoordY = NewInputCoordY,!.


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

add_moves(InputCoordX, InputCoordY, PossibleMoves, MovesOut):-
    XUp is InputCoordX-1,
    XDown is InputCoordX+1,
    X is InputCoordX,
    YLeft is InputCoordY-1,
    YRight is InputCoordY+1,
    Y is InputCoordY,

    string_number(XDown,InputXDown),
    string_number(XUp,InputXUp),
    string_number(X, InputXSame),
    string_number(YLeft,InputYLeft),
    string_number(YRight,InputYRight),
    string_number(Y,InputYSame),

    atom_concat(InputXUp, ',', NewMove1),
    atom_concat(NewMove1, InputYLeft, Move1),
    atom_concat(InputXUp, ',', NewMove2),
    atom_concat(NewMove2, InputYSame, Move2),
    atom_concat(InputXUp, ',', NewMove3),
    atom_concat(NewMove3, InputYRight, Move3),
    atom_concat(InputXSame, ',', NewMove4),
    atom_concat(NewMove4, InputYLeft, Move4),
    atom_concat(InputXSame, ',', NewMove5),
    atom_concat(NewMove5, InputYRight, Move5),
    atom_concat(InputXDown, ',', NewMove6),
    atom_concat(NewMove6, InputYLeft, Move6),
    atom_concat(InputXDown, ',', NewMove7),
    atom_concat(NewMove7, InputYSame, Move7),
    atom_concat(InputXDown, ',', NewMove8),
    atom_concat(NewMove8, InputYRight, Move8),

    add_element(Move1, PossibleMoves, NewPMoves1),
    add_element(Move2, NewPMoves1, NewPMoves2),
    add_element(Move3, NewPMoves2, NewPMoves3),
    add_element(Move4, NewPMoves3, NewPMoves4),
    add_element(Move5, NewPMoves4, NewPMoves5),
    add_element(Move6, NewPMoves5, NewPMoves6),
    add_element(Move7, NewPMoves6, NewPMoves7),
    add_element(Move8, NewPMoves7, NewPMoves8),
    MovesOut = NewPMoves8.



verify_moves(N, InputCoordX, InputCoordY, [Move|Others]):-
    N > 0,
    X is InputCoordX,
    Y is InputCoordY,
    string_number(X, InputXSame),
    string_number(Y, InputYSame),
    atom_concat(InputXSame, ',', PreapareCoords),
    atom_concat(PreapareCoords, InputYSame, Coords),

    (Coords == Move;
    (Next is N-1,
     verify_moves(Next, InputCoordX, InputCoordY, Others))).

handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2):-
    (
        (
            Player = 1, 
            set_piece(InputCoordX, InputCoordY, InputPiece, Board1, BoardOut),
            add_moves(InputCoordX, InputCoordY, PossibleMoves1, MovesOut1)
        );
        (
            Player = 2, 
            set_piece(InputCoordX, InputCoordY, InputPiece, Board2, BoardOut),
            add_moves(InputCoordX, InputCoordY, PossibleMoves2, MovesOut2)
        )
    ).

handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, Pack3, PossibleMoves1, PossibleMoves2):-
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, loop(BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2));
     (Player = 2, loop(Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2))).

loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2):-
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    ((
        Player = 1, 
        handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves1),
        handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
        (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, Score, NewPack1, Pack2, Pack3, MovesOut1, PossibleMoves2));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, NewPack2, Pack3, MovesOut1, PossibleMoves2));
        (PackUsed = 3, delete(Pack1, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, NewPack3, MovesOut1, PossibleMoves2))
        )
     );
     (
        Player = 2, 
        handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves2),
        handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
        (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, Score, NewPack1, Pack2, Pack3, PossibleMoves1, MovesOut2));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, NewPack2, Pack3, PossibleMoves1, MovesOut2));
        (PackUsed = 3, delete(Pack1, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, NewPack3, PossibleMoves1, MovesOut2))
        )
    )).

place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2):-
    write('Choose a place to your star\n'),
    handle_coords(_,InputCoordX, InputCoordY),
    handle_move(Player, InputCoordX, InputCoordY, ' S ', Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2).

play_game(0,Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2):-
    loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2).

play_game(N, Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2):-
    N > 0,

    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    repeat,
    place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),

    Next is N-1,
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, play_game(Next, BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, MovesOut1, PossibleMoves2));
     (Player = 2, play_game(Next, Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, MovesOut2))).

play:-
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    play_game(2, Board1, Board2, Score, PackOut1, PackOut2, PackOut3, 1, _, _).
