Normally, a player only plays one character in a game, and the player
information (at least the playername, and possibly email address,
phone number, real address, and playerlist note) is part of the Char
macro.  If there are multiple runs, player information is added to
existing Char macros in the run*-LIST.tex files (using \updatemacro,
\updateplayer, and \updateplayeremail).

The Player datatype is useful for when you have players who play more
than one character.  These could be helpful people who are playing NPC
parts run by the GMs.  If your playerlist and/or box labels print by
player rather than character, using Player macros will prevent players
with multiple entries.

You declare Player macros with player information:

  \NEW{Player}{\pSomeguy}{
    \s\MYplayer	{Some Player}
    \s\MYemail	{someguy@hotmail.com}
    \s\MYphone	{xxx-xxx-xxxx}
    \s\MYaddress{XX Some Street}
    \s\MYnote	{don't call during business hours}
    }

Make sure that the command names for Player macros do not overlap
those for Place macros.

\listfalse or \labelfalse inside a Player macro specify that the
player will not have an entry in, respectively, the playerlist or box
labels, if they are printed by player rather than character.
\listtrue and \labeltrue are the default for Players.

You do not need to create Player macros for any players playing one
and only one character.  Just make them part of the Char macro as
normal.




Assigning Player macros: You specify that a Char is played by a Player
macro using:

  \s\MYplayer	{\pSomeguy{}}

The \MYplayer field will be processed to extract Player information
and make it part of the Char.  Do not assign other player info by
hand.



GMs as Players: A GM macro can be assigned as the player as well.

  \s\MYplayer	{\gmHappy{}}

will cast the GM in the given part.  As above, do not assign other
player info by hand.



Multiple Runs: If you have multiple runs and are using run*-LIST.tex
files, create your Player macros in those files for the players who
change between runs.  You can then use \updateplayer (or a line in
\updatemacro) to assign Player macros to Char macros.
