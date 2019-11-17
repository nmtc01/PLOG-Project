:-use_module(library(lists)).
:-use_module(library(random)).
:-[init].
:-[display].
:-[aux].
:-[menu].

play:-
    repeat,
    main_menu(Choice, PlayerChoice, AI1Level, AI2Level),!,
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    play_game(2, Board1, Board2, Score, PackOut1, PackOut2, PackOut3, 1, _, _, Choice, PlayerChoice, AI1Level, AI2Level).

play_game(0,Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level):-
    loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level).

play_game(N, Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level):-
    N > 0,

    display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    repeat,
    place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2, Choice, PlayerChoice, AI1Level, AI2Level),

    Next is N-1,
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, play_game(Next, BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, MovesOut1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
     (Player = 2, play_game(Next, Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, MovesOut2, Choice, PlayerChoice, AI1Level, AI2Level))).

place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2, Choice, PlayerChoice, AI1Level, AI2Level):-
    write('Choose a place for your star\n'),
    (
        ((Choice = 1 ; PlayerChoice == Player), 
            handle_coords(InputCoordX, InputCoordY))
        ;
        (Choice = 2,
            (
                (PlayerChoice = 1, choose_move(AI2Level, InputCoordX, InputCoordY,_,_,_,_, _, 'coords',_));
                (PlayerChoice = 2, choose_move(AI1Level, InputCoordX, InputCoordY,_,_,_,_, _, 'coords',_))
            )
        );
        (Choice = 3,
         write('Press Enter'),nl,
         get_char(_),
            (move
                (Player = 1, choose_move(AI1Level, InputCoordX, InputCoordY,_,_,_,_, _, 'coords',_));
                (Player = 2, choose_move(AI2Level, InputCoordX, InputCoordY,_,_,_,_, _, 'coords',_))
            )
        )
    ),
    move(Player, InputCoordX, InputCoordY, ' S ', Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2).

loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2,Choice, PlayerChoice, AI1Level, AI2Level):-
    (Pack1 = [], Pack2 = [], Pack3 = [], 
    game_over(Board1, Board2, Score, Winner),
    write('The winner is... '), nl,
    write(Winner), nl,
    write('bro...'), nl);

    (display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    ((
        Player = 1,
        (
            ((Choice = 1 ; PlayerChoice == Player), 
                handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves1))
            ;
            (Choice = 2,
                (
                    (PlayerChoice = 1, choose_move(AI2Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves1));
                    (PlayerChoice = 2, choose_move(AI1Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves1))
                )
            )
            ;
            (Choice = 3,
             write('Press Enter'),nl,
             get_char(_),
             choose_move(AI1Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves1)
            )
        ), 
        move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
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
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, NewPack1, Pack2, Pack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, NewPack2, Pack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 3, delete(Pack3, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, Pack2, NewPack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level))
        )
     );
     (
        Player = 2, 
        (
            ((Choice = 1 ; PlayerChoice == Player), 
                handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves2))
            ;
            (Choice = 2,
                (
                    (PlayerChoice = 1, choose_move(AI2Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves2));
                    (PlayerChoice = 2, choose_move(AI1Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves2))
                )
            )
            ;
            (Choice = 3,
             write('Press Enter'),nl,
             get_char(_),
             choose_move(AI2Level, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, InputPiece, 'piece', PossibleMoves2)
            )
        ),
        move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
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
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, NewPack1, Pack2, Pack3, PossibleMoves1, NextMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, NewPack2, Pack3, PossibleMoves1, NextMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 3, delete(Pack3, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, Pack2, NewPack3, PossibleMoves1, NextMoves2, Choice, PlayerChoice, AI1Level, AI2Level))
        )
    ))).

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
    get_coord_codes(0, InputCoords, NewInputCoordX), 
    get_coord_codes(2, InputCoords, NewInputCoordY),
    NewInputCoordX < 10, NewInputCoordX > 0,
    NewInputCoordY < 10, NewInputCoordY > 0,
    InputCoordX = NewInputCoordX,
    InputCoordY = NewInputCoordY, !.

move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2):-
    (
        (
            Player = 1, 
            set_piece(InputCoordX, InputCoordY, InputPiece, Board1, BoardOut),
            valid_moves(Board1, InputCoordX, InputCoordY, PossibleMoves1, MovesOut1)
        );
        (
            Player = 2, 
            set_piece(InputCoordX, InputCoordY, InputPiece, Board2, BoardOut),
            valid_moves(Board2, InputCoordX, InputCoordY, PossibleMoves2, MovesOut2)
        )
    ).

handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, Pack3, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level):-
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, loop(BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
     (Player = 2, loop(Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level))).

get_winner(Score, Winner):-
    nth0(0, Score, Score1),
    nth0(1, Score, Score2),
    ((Score1 > Score2,
    Winner = 'Player 1');
    (Score1 < Score2,
    Winner = 'Player 2');
    Winner = 'Wait! It is a Tie!!! :)'). 

game_over(Board1, Board2, Score, Winner):-
    display_boards(0, Board1, Board2),
    get_winner(Score, Winner).

choose_move(AILevel, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, Piece, MoveType, PossibleMoves):-
    (MoveType = 'coords',
    (((\+var(PossibleMoves)),
    length(PossibleMoves, Size),
    randomize_number(Size, MoveNr),
    nth0(MoveNr, PossibleMoves, PossibleMove),
    atom_chars(PossibleMove, Move),
    get_coord(0, Move, InputCoordX), 
    get_coord(2, Move, InputCoordY));
    (var(PossibleMoves),
    random(1, 10, InputCoordX),
    random(1, 10, InputCoordY))))
    ;
    (MoveType = 'piece',
    repeat,
    random(1, 4, PackUsed),
    ((PackUsed = 1, nth0(0, Pack1, Piece));
     (PackUsed = 2, nth0(0, Pack2, Piece));
     (PackUsed = 3, nth0(0, Pack3, Piece))),!,
     choose_move(AILevel, InputCoordX, InputCoordY, Pack1, Pack2, Pack3, PackUsed, Piece, 'coords', PossibleMoves)).

