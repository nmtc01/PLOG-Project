%initializes two lists (Board1 and Board2), each one with 9 lists with 9 elements, representing the two boards (9x9)
init_board(Board1, Board2):-
    Board1 = [ ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']],

    Board2 = [ ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
            ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']].

%initializes a list, Score, where each element is the score of, respectively, Player 1 and Player 2
init_score(Score):-
    Score = [0,0].

%initializes the available game pieces, starting with a list with all the 27 pieces of the game (Pieces). Calls prepare_pack to prepare each one of the 3 groups of pieces.
init_pieces(Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3):-
    Pieces = ['g1x', 'r1y', 'b1x', 'r1x', 'b3x', 'r1z', 'b1z', 'g2z', 'b1y', 'g2x', 'b2x', 'r2x', 'b3y', 'b2z', 'b2y', 'r2z', 'g1z', 'r2y', 'g1y', 'g2y', 'r3y', 'b3z', 'r3x', 'g3x', 'g3y', 'g3z', 'r3z'],
    prepare_pack(9, Pieces, NewPieces1, Pack1, PackOut1),
    prepare_pack(9, NewPieces1, NewPieces2, Pack2, PackOut2),
    prepare_pack(9, NewPieces2, _, Pack3, PackOut3).

%initializes the game, creating the boards, the score and the available pieces
init_game(Board1, Board2, Score, Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3, Player):-
    (Player = 1; Player = 2),
    init_board(Board1, Board2),
    init_score(Score),
    init_pieces(Pack1, Pack2, Pack3, PackOut1, PackOut2, PackOut3).

%gets a random integer between 0 and N
randomize_number(N, Random):-
    random(0, N, Random).

%adds an element to the head of the list
add_element(Element, List, [Element|List]).

%prepares the 3 lists of available pieces. Chooses a piece randomly from the "Pieces" list (see init_pieces) and adds it to each pack, to a total of 9 pieces per pack. 
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

