set_piece(Line, Column, Piece, BoardIn, BoardOut):-
    set_in_line(Line, Column, Piece, BoardIn, BoardOut).

set_in_line(1, Column, Piece, [Line| Others], [NewLine| Others]):-
    set_in_column(Column, Piece, Line, NewLine).

set_in_line(N, Column, Piece, [Line| Others], [Line| NewOthers]):-
    N > 1,
    Next is N-1,
    set_in_line(Next, Column, Piece, Others, NewOthers).

set_in_column(1, Piece, [PieceInBoard|Others], [Piece|Others]):-
    PieceInBoard = ' 0 '.

set_in_column(N, Piece, [Column|Others], [Column|NewOthers]):-
    N > 1,
    Next is N-1,
    set_in_column(Next, Piece, Others, NewOthers).

get_coord_codes(0, [Head|_], InputCoord):-
    char_code(CharInputCoord, Head),
    string_number(InputCoord, CharInputCoord).

get_coord_codes(N, [_|Tail], InputCoord):-
    N > 0,
    Next is N-1,
    get_coord_codes(Next, Tail, InputCoord).

get_coord(0, [Head|_], InputCoord):-
    string_number(InputCoord, Head).

get_coord(N, [_|Tail], InputCoord):-
    N > 0,
    Next is N-1,
    get_coord(Next, Tail, InputCoord).

read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed):-
    write('\nChoose a piece (example: "g1x")\n'),
    read_line(PieceCode),
    atom_codes(InputPiece, PieceCode),

    (nth0(0, Pack1, Top1);
    nth0(0, Pack2, Top2);
    nth0(0, Pack3, Top3)),
    
    ((Top1 == InputPiece, PackUsed = 1);
      (Top2 == InputPiece, PackUsed = 2); 
      (Top3 == InputPiece, PackUsed = 3)).

valid_moves(InputCoordX, InputCoordY, PreviousPossibleMoves, PossibleMovesOut):-
    XUp is InputCoordX-1,
    XDown is InputCoordX+1,
    X is InputCoordX,
    YLeft is InputCoordY-1,
    YRight is InputCoordY+1,
    Y is InputCoordY,

    update_valid_moves(PreviousPossibleMoves, NewMoves1, Board, XUp, Y),
    update_valid_moves(NewMoves1, NewMoves2, Board, XUp, YRight),
    update_valid_moves(NewMoves2, NewMoves3, Board, XUp, YLeft),
    update_valid_moves(NewMoves3, NewMoves4, Board, XDown, Y),
    update_valid_moves(NewMoves4, NewMoves5, Board, XDown, YRight),
    update_valid_moves(NewMoves5, NewMoves6, Board, XDown, YLeft),
    update_valid_moves(NewMoves6, NewMoves7, Board, X, YRight),
    update_valid_moves(NewMoves7, PossibleMovesOut, Board, X, YLeft).

    %string_number(XDown,InputXDown),
    %string_number(XUp,InputXUp),
    %string_number(X, InputXSame),
    %string_number(YLeft,InputYLeft),
    %string_number(YRight,InputYRight),
    %string_number(Y,InputYSame),
    %atom_concat(InputXUp, ',', NewMove1),
    %atom_concat(NewMove1, InputYLeft, Move1),
    %atom_concat(InputXUp, ',', NewMove2),
    %atom_concat(NewMove2, InputYSame, Move2),
    %atom_concat(InputXUp, ',', NewMove3),
    %atom_concat(NewMove3, InputYRight, Move3),
    %atom_concat(InputXSame, ',', NewMove4),
    %atom_concat(NewMove4, InputYLeft, Move4),
    %atom_concat(InputXSame, ',', NewMove5),
    %atom_concat(NewMove5, InputYRight, Move5),
    %atom_concat(InputXDown, ',', NewMove6),
    %atom_concat(NewMove6, InputYLeft, Move6),
    %atom_concat(InputXDown, ',', NewMove7),
    %atom_concat(NewMove7, InputYSame, Move7),
    %atom_concat(InputXDown, ',', NewMove8),
    %atom_concat(NewMove8, InputYRight, Move8),

    %add_element(Move1, PreviousPossibleMoves, NewPMoves1),
    %add_element(Move2, NewPMoves1, NewPMoves2),
    %add_element(Move3, NewPMoves2, NewPMoves3),
    %add_element(Move4, NewPMoves3, NewPMoves4),
    %add_element(Move5, NewPMoves4, NewPMoves5),
    %add_element(Move6, NewPMoves5, NewPMoves6),
    %add_element(Move7, NewPMoves6, NewPMoves7),
    %add_element(Move8, NewPMoves7, NewPMoves8),
    %PossibleMovesOut = NewPMoves8.

update_valid_moves(PreviousMoves, NewMoves, Board, X, Y):-
    (get_valid_move(Board, X, Y, Move),
    add_element(Move, PreviousMoves, NewMoves));
    NewMoves is PreviousMoves.

get_valid_move(Board, X, Y, Move):-
    check_empty_place(Board, X, Y),
    prepare_possible_move(X, Y, Move).

check_empty_place(Board, X, Y):-
    get_piece(Board, X, Y, Piece),
    Piece = ' 0 '.

prepare_possible_move(X, Y, Move):-
    string_number(X,XString),
    string_number(Y,YString),
    atom_concat(XString, ',', NewMove),
    atom_concat(NewMove, YString, Move).

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

get_piece(Board, InputCoordX, InputCoordY, Piece):-
    get_in_line(InputCoordX, InputCoordY, Piece, Board);
    Piece = ' 0 '.

get_in_line(1, InputCoordY, Piece, [InputCoordX| _]):-
    get_in_column(InputCoordY, Piece, InputCoordX).

get_in_line(N, InputCoordY, Piece, [_| Others]):-
    Next is N-1,
    get_in_line(Next, InputCoordY, Piece, Others).

get_in_column(1, Piece, [Element|_]):-
    Piece = Element.

get_in_column(N, Piece, [_|Others]):-
    N > 1,
    Next is N-1,
    get_in_column(Next, Piece, Others).

get_piece_attributes(Piece, Color, Size, Type):-
    atom_chars(Piece, Attr),
    nth0(0, Attr, Color),
    nth0(1, Attr, Size),
    nth0(2, Attr, Type).

verify_combination(Board, X, Y, Piece, Score, ScoreOut):-
    XDown is X+1,
    XDownDown is X+2,
    XUp is X-1,
    XUpUp is X-2,
    YRight is Y+1,
    YRightRight is Y+2,
    YLeft is Y-1,
    YLeftLeft is Y-2,
    get_piece(Board, XDown, Y, Piece1),
    get_piece(Board, XDown, YLeft, Piece2),
    get_piece(Board, X, YLeft, Piece3),
    get_piece(Board, XUp, YLeft, Piece4),
    get_piece(Board, XUp, Y, Piece5),
    get_piece(Board, XUp, YRight, Piece6),
    get_piece(Board, X, YRight, Piece7),
    get_piece(Board, XDown, YRight, Piece8),
    get_piece(Board, XDownDown, Y, Piece9),
    get_piece(Board, XDownDown, YLeftLeft, Piece10),
    get_piece(Board, X, YLeftLeft, Piece11),
    get_piece(Board, XUpUp, YLeftLeft, Piece12),
    get_piece(Board, XUpUp, Y, Piece13),
    get_piece(Board, XUpUp, YRightRight, Piece14),
    get_piece(Board, X, YRightRight, Piece15),
    get_piece(Board, XDownDown, YRightRight, Piece16),

    verify_piece_combination(Piece, Piece1, Piece9, Score, ScoreOut1),
    verify_piece_combination(Piece, Piece2, Piece10, ScoreOut1, ScoreOut2),
    verify_piece_combination(Piece, Piece3, Piece11, ScoreOut2, ScoreOut3),
    verify_piece_combination(Piece, Piece4, Piece12, ScoreOut3, ScoreOut4),
    verify_piece_combination(Piece, Piece5, Piece13, ScoreOut4, ScoreOut5),
    verify_piece_combination(Piece, Piece6, Piece14, ScoreOut5, ScoreOut6),
    verify_piece_combination(Piece, Piece7, Piece15, ScoreOut6, ScoreOut7),
    verify_piece_combination(Piece, Piece8, Piece16, ScoreOut7, ScoreOut).

check_matching_attr(Attr1, Attr2, Attr3, Score, ScoreOut):-
    (verify_attribute_combination(Attr1, Attr2),
    verify_attribute_combination(Attr2, Attr3),
    ScoreOut is Score+1);
    ScoreOut is Score.

verify_piece_combination(Piece1, Piece2, Piece3, Score, ScoreOut):-
    get_piece_attributes(Piece1, Color1, Size1, Type1),
    
    get_piece_attributes(Piece2, Color2, Size2, Type2),
    get_piece_attributes(Piece3, Color3, Size3, Type3),
    check_matching_attr(Color1, Color2, Color3, Score, NewScoreOut1),
    check_matching_attr(Type1, Type2, Type3, NewScoreOut1, NewScoreOut2),
    check_matching_attr(Size1, Size2, Size3, NewScoreOut2, ScoreOut).

verify_attribute_combination(Attr1, Attr2):-
    Attr1 \= ' ', Attr2 \= ' ', Attr1 \= '0', Attr2 \= '0', Attr1 = Attr2.

set_score(1, PointsPlayer1, [_|Others], [PointsPlayer1|Others]).
set_score(2, PointsPlayer2, [PointsPlayer1|[_|Others]], [PointsPlayer1|[PointsPlayer2|Others]]).