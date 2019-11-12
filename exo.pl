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
    read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed),
    handle_coords(InputCoords, InputCoordX, InputCoordY),
    length(PossibleMoves, Size),
    verifyMove(Size, InputCoords, PossibleMoves),
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
    (    
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), (NewInputCoordX > 14; NewInputCoordX < 1), write('Coord x out of range: [1,14]'));
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), (NewInputCoordY > 14; NewInputCoordY < 1), write('Coord y out of range: [1,14]'));
        (get_xy(3, List, NewInputCoordX, NewInputCoordY), InputCoordX = NewInputCoordX, InputCoordY = NewInputCoordY);
        handle_coords(InputCoords, InputCoordX, InputCoordY)
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

addMoves(InputCoordX, InputCoordY, PossibleMoves, MovesOut):-
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
    MovesOut = NewPMoves8,

    write(MovesOut).

verifyMove(N, InputCoords, [Move|Others]):-
    N > 0,
    (InputCoords = Move;
    (Next is N-1,
     verifyMove(Next, InputCoords, Others))).

handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves, MovesOut):-
    ((Player = 1, set_piece(InputCoordX, InputCoordY, InputPiece, Board1, BoardOut));
    (Player = 2, set_piece(InputCoordX, InputCoordY, InputPiece, Board2, BoardOut))),
    addMoves(InputCoordX, InputCoordY, PossibleMoves, MovesOut).


handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, Pack3, PossibleMoves):-
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, repeat(BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves));
     (Player = 2, repeat(Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves))).

repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves):-
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),
    handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves),
    handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves, MovesOut),
    (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, Score, NewPack1, Pack2, Pack3, MovesOut));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, NewPack2, Pack3, MovesOut));
        (PackUsed = 3, delete(Pack1, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, NewPack3, MovesOut))
    ).

place_star(Board1, Board2, BoardOut, Player, PossibleMoves, MovesOut):-
    write('Choose a place to your star\n'),
    handle_coords(_,InputCoordX, InputCoordY),
    handle_move(Player, InputCoordX, InputCoordY, ' S ', Board1, Board2, BoardOut, PossibleMoves, MovesOut).

play_game(0,Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves):-
    repeat(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves).

play_game(N, Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves):-
    N > 0,
    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),
    place_star(Board1, Board2, BoardOut, Player, PossibleMoves, MovesOut),
    Next is N-1,
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, play_game(Next, BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, MovesOut));
     (Player = 2, play_game(Next, Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, MovesOut))).

play:-
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    play_game(2, Board1, Board2, Score, PackOut1, PackOut2, PackOut3, 1, _).
