:-[stringnumber].

%displays a menu on the screen. the player can choose to play either against another player, against the computer or to watch AI vs AI. The user should input either 1, 2 or 3 to choose a game mode.
main_menu(Choice, PlayerChoice, AI1Level, AI2Level):-
    write('Welcome to our game!\nChoose\n1 to play Player vs Player\n2 for Player vs AI\n3 for AI vs AI\n'),
    read_line(Line),
    nth0(0, Line, ChoiceCode),
    char_code(CharChoice, ChoiceCode),
    string_number(Choice, CharChoice),
    sub_menu(Choice, PlayerChoice, AI1Level, AI2Level).

%after choosing an option, if AI is chosen, the player must choose which player they want to be
sub_menu(Choice, PlayerChoice, AI1Level, AI2Level):-
    (Choice = 1, write('Playing Player vs Player'), nl)
    ;
    (Choice = 2,
     write('Choose your player\n'),
     read_line(LinePlayerChoice),
     nth0(0, LinePlayerChoice, PlayerChoiceCode),
     char_code(PlayerCharChoice, PlayerChoiceCode),
     string_number(PlayerChoice, PlayerCharChoice),
     ((PlayerChoice = 1, ailevel_menu(AI2Level));
      (PlayerChoice = 2, ailevel_menu(AI1Level))))
    ;
    (ailevel_menu(AI1Level), ailevel_menu(AI2Level)).

%similarly, after choosing the player, you can also choose the level of difficulty of the AI (either 1 or 2)    
ailevel_menu(AILevel):-
    repeat,
    write('Choose the level\n'),
    read_line(LineAILevel),
    nth0(0, LineAILevel, AILevelCode),
    char_code(AILevelChar, AILevelCode),
    string_number(AILevel, AILevelChar),
    (AILevel = 1; AILevel=2),!.



