:-use_module(library(lists)).
:-use_module(library(random)).
:-[init].
:-[display].
:-[aux].
:-[menu].

%main predicate of the game. when called on the terminal, displays the main menu and then starts the game according to the options chosen
play:-
    repeat,
    main_menu(Choice, PlayerChoice, AI1Level, AI2Level),!,
    init_game(Board1, Board2, Score, _Pack1, _Pack2, _Pack3,  PackOut1, PackOut2, PackOut3, 1),
    play_game(2, Board1, Board2, Score, PackOut1, PackOut2, PackOut3, 1, _, _, Choice, PlayerChoice, AI1Level, AI2Level).

%calls for the loop predicate after all the players have chosen a place for the star
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

%used to place the star (first move of the game) on the board of each player. when playing pvp, the player should input the coordinates desired for the star. when the computer is playing, choose_move is called
place_star(Board1, Board2, BoardOut, Player, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2, Choice, PlayerChoice, AI1Level, AI2Level):-
    write('Choose a place for your star\n'),
    (
        ((Choice = 1 ; PlayerChoice == Player), 
            handle_coords(InputCoordX, InputCoordY))
        ;
        (Choice = 2,
            (
                (PlayerChoice = 1, choose_move(_,_,_,_,_,AI2Level, InputCoordX, InputCoordY,_, _, 'coords'));
                (PlayerChoice = 2, choose_move(_,_,_,_,_,AI1Level, InputCoordX, InputCoordY,_, _, 'coords'))
            )
        );
        (Choice = 3,
         write('Press Enter'),nl,
         get_char(_),
            (
                (Player = 1, choose_move(_,_,_,_,_,AI1Level, InputCoordX, InputCoordY,_, _, 'coords'));
                (Player = 2, choose_move(_,_,_,_,_,AI2Level, InputCoordX, InputCoordY,_, _, 'coords'))
            )
        )
    ),
    move(Player, InputCoordX, InputCoordY, ' S ', Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2).

%this predicate handles the course of the game
loop(Board1, Board2, Score, Pack1, Pack2, Pack3, Player, PossibleMoves1, PossibleMoves2,Choice, PlayerChoice, AI1Level, AI2Level):-
    %when all packs are empty, a winner is chosen, calling game_over
    (Pack1 = [], Pack2 = [], Pack3 = [], 
    game_over(Board1, Board2, Score, Winner),
    write('The winner is... '), nl,
    %display the winner on the screen
    write(Winner), nl,
    write('bro...'), nl);

    %displaying the game on the screen
    (display_game(Board1, Board2, Score, Pack1, Pack2, Pack3, Player),!,
    ((
        Player = 1,
        (   
            %player vs player
            ((Choice = 1 ; PlayerChoice == Player), 
                %handles the player input
                handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves1))
            ;
            %AI vs Player
            (Choice = 2,
                (
                    %choosing moves for the AI depending on the difficulty level chosen (1 or 2)
                    (PlayerChoice = 1, choose_move(Board1, Pack1, Pack2, Pack3, PossibleMoves1, AI2Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece'));
                    (PlayerChoice = 2, choose_move(Board1, Pack1, Pack2, Pack3, PossibleMoves1, AI1Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece'))
                )
            )
            ;
            %AI vs AI
            (Choice = 3,
             write('Press Enter'),nl,
             get_char(_),
             choose_move(Board1, Pack1, Pack2, Pack3, PossibleMoves1, AI1Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece')
            )
        ),
        %player making a move in the game 
        move(Player, InputCoordX, InputCoordY, InputPiece, Board1, Board2, BoardOut, PossibleMoves1, MovesOut1, PossibleMoves2, MovesOut2),
        nth0(0, Score, Points),
        %verifying if there are any points gained by the group of pieces being formed
        verify_combination(Board1, InputCoordX, InputCoordY, InputPiece, Points, PointsOut),
        %updates the score accordingly
        set_score(Player, PointsOut, Score, ScoreOut),

        %after the move is processed, it is deleted from the list of possible moves...
        X is InputCoordX,
        Y is InputCoordY,
        string_number(X, InputXSame),
        string_number(Y, InputYSame),
        atom_concat(InputXSame, ',', PreapareCoords),
        atom_concat(PreapareCoords, InputYSame, Coords),
        delete(MovesOut1, Coords, NextMoves1),

        %...and the piece used is deleted from its pack
        (
        (PackUsed = 1, delete(Pack1, InputPiece, NewPack1), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, NewPack1, Pack2, Pack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 2, delete(Pack2, InputPiece, NewPack2), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, NewPack2, Pack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
        (PackUsed = 3, delete(Pack3, InputPiece, NewPack3), handle_next_move(Player, BoardOut, Board1, Board2, ScoreOut, Pack1, Pack2, NewPack3, NextMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level))
        )
     );
     (
        %the same is done for player 2
        Player = 2, 
        (
            ((Choice = 1 ; PlayerChoice == Player), 
                handle_in_out(Pack1, Pack2, Pack3, InputCoordX, InputCoordY,InputPiece, PackUsed, PossibleMoves2))
            ;
            (Choice = 2,
                (
                    (PlayerChoice = 1, choose_move(Board2, Pack1, Pack2, Pack3, PossibleMoves2, AI2Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece'));
                    (PlayerChoice = 2, choose_move(Board2, Pack1, Pack2, Pack3, PossibleMoves2, AI1Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece'))
                )
            )
            ;
            (Choice = 3,
             write('Press Enter'),nl,
             get_char(_),
             choose_move(Board2, Pack1, Pack2, Pack3, PossibleMoves2, AI2Level, InputCoordX, InputCoordY, PackUsed, InputPiece, 'piece')
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

%handles input from the player, both the pieces and the coords chosen
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

%handles the coordinates chosen by the player, checking if they are valid and in range
handle_coords(InputCoordX, InputCoordY):-
    write('Input coordinates (example: "x,y")\n'),
    read_line(InputCoords),
    get_coord_codes(0, InputCoords, NewInputCoordX), 
    get_coord_codes(2, InputCoords, NewInputCoordY),
    NewInputCoordX < 10, NewInputCoordX > 0,
    NewInputCoordY < 10, NewInputCoordY > 0,
    InputCoordX = NewInputCoordX,
    InputCoordY = NewInputCoordY, !.

%handles a move from a player, setting the piece on the desired coordinates and then calculating the possible next moves surrounding that piece
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

%handles the move of the next player
handle_next_move(Player, BoardOut, Board1, Board2, Score, Pack1, Pack2, Pack3, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level):-
    NextPlayer is (Player mod 2) + 1,
    ((Player = 1, loop(BoardOut, Board2, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level));
     (Player = 2, loop(Board1, BoardOut, Score, Pack1, Pack2, Pack3, NextPlayer, PossibleMoves1, PossibleMoves2, Choice, PlayerChoice, AI1Level, AI2Level))).

%compares both players' scores and defines a winner
get_winner(Score, Winner):-
    nth0(0, Score, Score1),
    nth0(1, Score, Score2),
    ((Score1 > Score2,
    Winner = 'Player 1');
    (Score1 < Score2,
    Winner = 'Player 2');
    Winner = 'Wait! It is a Tie!!! :)'). 

%called when there are no more available pieces, displays the boards on the screen and chooses a winner
game_over(Board1, Board2, Score, Winner):-
    display_boards(0, Board1, Board2),
    get_winner(Score, Winner).

%handles the moves for the AI according to the difficulty level (AILevel)
choose_move(Board, Pack1, Pack2, Pack3, PossibleMoves, AILevel, InputCoordX, InputCoordY, PackUsed, Piece, MoveType):-
    %for AI level 1, the moves are randomly chosen from a list of possible moves
    (AILevel = 1, 
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
        random(1, 10, InputCoordY)))
        ;
        (MoveType = 'piece',
        repeat,
        random(1, 4, PackUsed),
        ((PackUsed = 1, nth0(0, Pack1, Piece));
        (PackUsed = 2, nth0(0, Pack2, Piece));
        (PackUsed = 3, nth0(0, Pack3, Piece))),!,
        choose_move(Board, Pack1, Pack2, Pack3, PossibleMoves, AILevel, InputCoordX, InputCoordY, PackUsed, Piece, 'coords')))
    );
    %for AI level 2, the moves are chosen according to what moves give the AI the best score
    (AILevel = 2,
        ((MoveType = 'coords',
        choose_move(Board, Pack1, Pack2, Pack3, PossibleMoves, 1, InputCoordX, InputCoordY, PackUsed, Piece, 'coords'))
        ;
        (MoveType = 'piece',
            (get_best_move(Board, Pack1, Pack2, Pack3, PackUsed, PossibleMoves, _, InputCoordX, InputCoordY, Piece)
            ;
            (choose_move(Board, Pack1, Pack2, Pack3, PossibleMoves, 1, InputCoordX, InputCoordY, PackUsed, Piece, 'piece')))))
    ).

%used to find the best moves for the AI level 2
get_best_move(Board, Pack1, Pack2, Pack3, PackUsed, PossibleMoves, Player, BestX, BestY, BestPiece):-
    (nth0(0, Pack1, Piece1);Piece1=' 0 '),
    (nth0(0, Pack2, Piece2);Piece2=' 0 '),
    (nth0(0, Pack3, Piece3);Piece3=' 0 '),
    get_best_move_for_piece(Board, PossibleMoves, Piece1, Player, 0, _, _, Best1X, Best1Y, Best1Value),!,
    get_best_move_for_piece(Board, PossibleMoves, Piece2, Player, 0, _, _, Best2X, Best2Y, Best2Value),!,
    get_best_move_for_piece(Board, PossibleMoves, Piece3, Player, 0, _, _, Best3X, Best3Y, Best3Value),!,
    (
        (Best1Value > Best2Value, Best1Value > Best3Value, BestX = Best1X, BestY = Best1Y, BestPiece = Piece1, PackUsed = 1);
        (Best2Value > Best1Value, Best2Value > Best3Value, BestX = Best2X, BestY = Best2Y, BestPiece = Piece2, PackUsed = 2);
        (Best3Value > Best2Value, Best3Value > Best1Value, BestX = Best3X, BestY = Best3Y, BestPiece = Piece3, PackUsed = 3)
    ).

%getting the best possible move for a certain piece
get_best_move_for_piece(Board, PossibleMoves, Piece, Player, InitialValue, InitialX, InitialY, BestX, BestY, BestValue):-
    length(PossibleMoves, N),
    get_best_value(N, Board, PossibleMoves, PossibleMoves, Piece, Player, InitialValue, InitialX, InitialY, BestX, BestY, BestValue).

%recursively checks what move will bring the most points to the AI
get_best_value(1, _, _, _, _, _, Value, X, Y, BestX, BestY, BestValue):-
    BestX = X, 
    BestY = Y,
    BestValue = Value.

get_best_value(N, Board, PossibleMoves, [PossibleMove|Tail], Piece, Player, InitialValue, InitialX, InitialY, BestX, BestY, BestValue):-
    Next is N-1,
    atom_chars(PossibleMove, ListMove),
    get_coord(0, ListMove, X),
    get_coord(2, ListMove, Y),
    value(Board, X, Y, PossibleMoves, Piece, Player, Points),
    ((Points > InitialValue, NewValue = Points, NewX = X, NewY = Y); 
    (NewValue = InitialValue, NewX = InitialX, NewY = InitialY)),
    get_best_value(Next, Board, PossibleMoves, Tail, Piece, Player, NewValue, NewX, NewY, BestX, BestY, BestValue).

%to get the score (Value) of a specific move
value(Board, X, Y, PossibleMoves, Piece, Player, Value):-
    move(Player, X, Y, Piece, Board, Board, _, PossibleMoves, _, PossibleMoves, _),
    verify_combination(Board, X, Y, Piece, 0, Value).


