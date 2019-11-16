:-use_module(library(lists)).
:-use_module(library(random)).
:-[init].
:-[display].
:-[stringnumber].
:-[aux].
:-[menu].

handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY, InputPiece, PackUsed, PossibleMoves):-
    length(PossibleMoves, Size),
    repeat,
    read_piece(Pack1, Pack2, Pack3, InputPiece, PackUsed),!,
    repeat,
    handle_coords(InputCoordX, InputCoordY),
    verify_moves(Size, InputCoordX, InputCoordY, PossibleMoves),
    write('Piece: '),
    write(InputPiece),
    write(' at Coords: ('),
    write(InputCoordX),
    write(','),
    write(InputCoordY),
    write(')\n\n').

handle_coords(InputCoordX, InputCoordY):-
    write('Input coordinates (example: "x,y")\n'),
    read_line(InputCoords),
    get_coord(0, InputCoords, NewInputCoordX), 
    get_coord(2, InputCoords, NewInputCoordY),
    NewInputCoordX < 10, NewInputCoordX > 0,
    NewInputCoordY < 10, NewInputCoordY > 0,
    InputCoordX = NewInputCoordX,
    InputCoordY = NewInputCoordY, !.

game_over(Board1, Board2, Winner):-
    display_boards(0, Board1, Board2),
    write('The winner is... '), nl,
    write(Winner), nl,
    write('bro...'), nl.

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

get_winner(Score, Winner):-
    nth0(0, Score, Score1),
    nth0(1, Score, Score2),
    ((Score1 > Score2,
    Winner = 'Player 1');
    (Score1 < Score2,
    Winner = 'Player 2');
    Winner = 'Wait! It is a Tie!!! :)'). 

loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2):-
    (Pack1 = [], Pack2 = [], Pack3 = [], 
    get_winner(Score, Winner),
    game_over(Board1, Board2, Winner));

    (display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    ((
        Player = 1, 
        handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves1),
        handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
        nth0(0, Score, Points),
        verify_combination(Board1, InputCoordX, InputCoordY, InputPiece, Points, PointsOut),
        set_score(Player, PointsOut, Score, ScoreOut),
        
        X is InputCoordX,
        Y is InputCoordY,
        string_number(X, InputXSame),
        string_number(Y, InputYSame),
        atom_concat(InputXSame, ',', PreapareCoords),
        atom_concat(PreapareCoords, InputYSame, Coords),
        delete(MovesOut1, Coords, NextMoves1),

        (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, NewPack1, Pack2, Pack3, NextMoves1, PossibleMoves2));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, NewPack2, Pack3, NextMoves1, PossibleMoves2));
        (PackUsed = 3, delete(Pack3, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, Pack2, NewPack3, NextMoves1, PossibleMoves2))
        )
     );
     (
        Player = 2, 
        handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves2),
        handle_move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
        nth0(1, Score, Points),
        verify_combination(Board2, InputCoordX, InputCoordY, InputPiece, Points, PointsOut),
        set_score(Player, PointsOut, Score, ScoreOut),

        X is InputCoordX,
        Y is InputCoordY,
        string_number(X, InputXSame),
        string_number(Y, InputYSame),
        atom_concat(InputXSame, ',', PreapareCoords),
        atom_concat(PreapareCoords, InputYSame, Coords),
        delete(MovesOut2, Coords, NextMoves2),
        
        (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, NewPack1, Pack2, Pack3, PossibleMoves1, NextMoves2));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, NewPack2, Pack3, PossibleMoves1, NextMoves2));
        (PackUsed = 3, delete(Pack3, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, Pack2, NewPack3, PossibleMoves1, NextMoves2))
        )
    ))).

place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2):-
    write('Choose a place to your star\n'),
    handle_coords(InputCoordX, InputCoordY),
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
    menu(Choice),
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    ((Choice = '1', play_pvp(Board1, Board2, Score, PackOut1, PackOut2, PackOut3));
     play_ai1(Board1, Board2, Score, PackOut1, PackOut2, PackOut3)).

play_pvp(Board1, Board2, Score, Pack1, Pack2, Pack3):-
    play_game(2, Board1, Board2, Score, Pack1, Pack2, Pack3, 1, _, _).

play_ai1(Board1, Board2, Score, Pack1, Pack2, Pack3):-
    play_game(2, Board1, Board2, Score, Pack1, Pack2, Pack3, 1, _, _).