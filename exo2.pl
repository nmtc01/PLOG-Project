:-use_module(library(lists)).

initboard(Board1, Board2):-
    Board1 = [ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ],

    Board2 = [ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ].

initscore(Score):-
    Score = [0,0].

initstacks(Pack1, Pack2, Pack3):-
    Pack1 = ['G1X', 'R1Y', 'B1X', 'R1X', 'B3X', 'R1Z', 'B1Z', 'G2Z',  'BIY'],
    Pack2 = ['G2X', 'B2X', 'R2X', 'B3Y', 'B2Z', 'B2Y', 'R2Z', 'G1Z', 'R2Y'],
    Pack3 = ['G1Y', 'G2Y', 'R3Y', 'B3Z', 'R3X', 'G3X', 'G3Y', 'G3Z', 'R3Z'].

initgame(Board1, Board2, Score, Pack1, Pack2, Pack3):-
    initboard(Board1, Board2),
    initscore(Score),
    initstacks(Pack1, Pack2, Pack3),
    displayGame(Board1, Board2, Score, Pack1, Pack2, Pack3).

displayGame(Board1, Board2, Score, Pack1, Pack2, Pack3):-
    write('           PLAYER 1                        PLAYER 2\n'),
    displayBoards(0, Board1, Board2),
    displayScore(Score),
    displayStacks(Pack1, Pack2, Pack3).

displayScore(Score):-
    write('\n'),
    write('                        SCORE: '),
    displayLine(Score).


displayBoards(13, _, _).

displayBoards(N, Board1, Board2):-
    nth0(N, Board1, Board1LineN),
    nth0(N, Board2, Board2LineN),
    write('| '),
    displayLine(Board1LineN),
    write('|\t| '),
    displayLine(Board2LineN),
    write('|\n'),
    N1 is N+1,
    displayBoards(N1, Board1, Board2).

displayStacks(Pack1, Pack2, Pack3):-
    write('\n'),
    write('| '),
    nth0(0, Pack1, Top1),
    write(Top1),
    write('\n'),
    write('| '),
    nth0(0, Pack2, Top2),
    write(Top2),
    write('\n'),
    write('| '),
    nth0(0, Pack3, Top3),
    write(Top3).

displayLine([]).
displayLine([Head | Tail]):-
    write(Head),
    write(' '),
    displayLine(Tail).









