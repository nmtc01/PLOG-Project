
init_board(Board1, Board2):-
    Board1 = [ [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ']],

    Board2 = [ [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 '],
            [' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ', ' 0 ']].

init_score(Score):-
    Score = [0,0].

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

