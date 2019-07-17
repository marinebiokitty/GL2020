%%%%%
%%
%% This .cls file contains basic customizations for your game, such as
%% the title and date.  It also serves as the root of everything.
%%
%% \gamedate, \gamedateabbrev, and \takedownby all might be based on
%% \gamerun.  \run\choice, documented in gametex.sty, is used to
%% specify run-conditional information.  For example:
%%
%%   \def\gamedate{\run\choice April 2003\or May 2003\endchoice}
%%
%% When \gamerun is set to 1, \gamedate will be "April 2003".  When
%% \gamerun is set to 2, \gamedate will be "May 2003".
%%
%%%%%

% Peter added the following to help with debugging:
%\errorcontextlines=10
%\tracingmacros=1
%\tracingcommands=1

%%%%%
%% \gameclassname
%%
%% When you change this, make sure the name of this file and the name
%% of the game's environment variable both match it.  See ../README.
\def\gameclassname{GL2020}


%%%%%
%% \gamerun
\def\gamerun{1}


%%%%%
%% \gamename
%% \gamedate
%%
%% Basic custom game information; gets used everywhere.  Don't put
%% linebreaks in these and keep their lengths reasonable.
\def\gamename{Grand Larp 2020 NEEDS A NAME}
\def\gamedate{NOV 2020 NEEDS A DATE}


%%%%%
%% \gamedraft
%%
%% \gamedraft can be defined as either \Draft or \Final.  This will be
%% the default draft state for the game.  \Draft is normal for
%% writing, \Final specifies that any \TODO commands remaining in the
%% text of the game will not typeset any todo info (they will still
%% output info to the terminal).
\def\gamedraft{\Final}


%%%%%
%% \gamenameabbrev
%% \gamedateabbrev
%%
%% These are used on cards and other places where the name and date
%% used need to be small.  If \gamename and \gamedate are long,
%% \gamenameabbrev and \gamedateabbrev should have shorter values.
%%
%% \gamedateabbrev is also used on transferrable things.  If you have
%% multiple runs close together, you may want to keep \gamedate
%% general, like "September 2002", while \gamedateabbrev shorter and
%% more specific, like "Sept run 1" and "Sept run 2".
\def\gamenameabbrev{\gamename}
\def\gamedateabbrev{\gamedate}


%%%%%
%% \takedownby
%% \signdate
%%
%% \takedownby is the date printed on signs (see the signs option) as
%% a label for when they will be taken down after the game ends.  This
%% is usually set to the day after the last day of game, or something
%% like "noon on Friday".
%%
%% Define \signdate as either \gamedate or \gamedateabbrev.  If you
%% plan to leave signs up between different runs, \gamedate may be
%% better.
\def\takedownby{NA}
\def\signdate{\gamedateabbrev}


%%%%%
%% \defaultnamemappings
%%
%% \defaultnamemappings contains the default settings for the
%% namemapping macros.  See Extras/README-namemappings.
\def\defaultnamemappings{
  \titlemap{\full}
  \mapnickinformal
  }


%%%%%
%% \badgemap
%%
%% \badgemap lists the Char fields used to generate namebages.  You
%% can disable parts with \unskip.  For example, to have badges
%% without character names, use:
%%
%%   \def\badgemap{{\unskip}{\MYnumber}{\MYplayer}{\MYdesc}}
%%
%% and for badges without descriptions:
%%
%%   \def\badgemap{{\MYname}{\MYnumber}{\MYplayer}{\unskip}}
\def\badgemap{{\MYname}{\MYnumber}{\MYplayer}{\MYdesc}}


%%%%%
%% \playerlistproduction
%% \playerlistcompendium
%% \charactergrouping
%% \playergrouping
%%
%% \playerlistproduction and \playerlistcompendium are, respectively,
%% what \production and \compendium are defined as for the playerlist.
%% Possible simple values are \longgameplayers (player, email,
%% address, phone, notes), \longgamechars (same plus character name),
%% \shortgameplayers (player, email, notes), and \shortgamechars (same
%% plus character name).
%%
%% \charactergrouping defines how characters (and GMs) are grouped for
%% \longgamechars and \shortgamechars.  \playergrouping is the same
%% for \longgameplayers and \shortgameplayers.
%%
%% Within the grouping commands, you can use \mark, \group,
%% \groupasis, \allchars, \allplayers, and \allgms, all of which are
%% documented in comments in Handouts/playerlist.tex.
\def\playerlistproduction{\longgameplayers}
\def\playerlistcompendium{\longgamechars}

\def\charactergrouping{
  \mark{GMs}\allgms
  \mark{Characters}\allchars
  }

\def\playergrouping{
  \mark{GMs}\allgms
  \mark{Players}\allplayers
  }


%%%%%
%% \theboxpref
%%
%% \theboxpref can be set to \boxbyplayer, which means labels in the
%% GM Box will print by player name, and \boxbycharacter, which means
%% labels will print by character name.
\def\theboxpref{\boxbyplayer}


%%%%%
%% \charsproduction
%%
%% \charsproduction can be defined as either \charsbyname,
%% \charsbyplayer, or \charsasis.  If it is defined as
%% \charsbycharacter, characters and their elements will be produced
%% sorted by character name.  If it is \charsbyplayer, they will be
%% produced sorted by player name.  If \charsasis, they will be
%% produced in the order they were created.
\def\charsproduction{\charsbycharacter}


%%%%%
%% \usetags
%%
%% \usetags can be defined as either \tagstrue or \tagsfalse.
%% \tagstrue specifies that \starttag{<tag>} <elements> \endtag
%% entries will be extracted from character sheets.  \tagsfalse turns
%% this off, which makes production files latex more quickly if your
%% game does not use character sheet tags.
\def\usetags{\tagstrue}


%%%%%
%% \charsheetlists
%%
%% \charsheetlists defines the lists printed at the end of a character
%% sheet.  It is built from tlist environments.  You can redefine it
%% to change the lists.  For example, if your game has no ability
%% cards of any sort, everyone knows this, and you don't want everyone
%% to have an empty ability list on their sheet, remove (or comment
%% out) the tlist environment that corresponds to abilities.
\def\charsheetlists{%
  %% listed mempackets
  \begin{tlist}{Memory/Event Packets}
    \MYmems
  \end{tlist}
  %% listed bluesheets
  \begin{tlist}{Bluesheets}
    \MYblues
  \end{tlist}
  %% listed greensheets
  \begin{tlist}{Greensheets}
    \MYgreens
  \end{tlist}
  %% listed abilities
  \begin{tlist}{Abilities}
    \MYabils
    \MYskills
  \end{tlist}
  %% listed items, etc
  \begin{tlist}{Items}
    \MYitems
    \MYwhites
    \MYcash
  \end{tlist}
  %% listed stats
  \begin{tlist}{Stats}
    \MYstats
  \end{tlist}
  %%
  }


%%%%%
%% \gamepath, etc.
%%
%% \gamepath is the path to the game's location.  It is pulled from
%% the game's environment variable, the name of which matches
%% \gameclassname.  This works because kpathsea can expand environment
%% variables in filepaths.
%%
%% The other path macros are built on \gamepath, so they can be used
%% like relative filepaths.  Change them if you change the directory
%% structure.  This file is at \latex/\gameclassname.cls.
%%\edef\gamepath{\string${\gameclassname}} %$

% The following code allows you to create a file named gamename_path.cls.  If that file exists, it will be read and the contents used as the game path.  Otherwise, this uses the environment variables to find the game path.  The file should have only the following line: \edef\gamepath{"path_to_game"}.  You may need to substitute forward slashes for backslashes in the file path.
\IfFileExists{\gameclassname_path.cls}{\input{\gameclassname_path.cls}}{\edef\gamepath{\string${\gameclassname}}} %$

\def\blues{\gamepath/Bluesheets}
\def\chars{\gamepath/Charsheets}
\def\greens{\gamepath/Greensheets}
\def\latex{\gamepath/LaTeX}
\def\lists{\gamepath/Lists}
\def\notebooks{\gamepath/Notebooks}
\def\postscript{\gamepath/Postscript}
\def\whites{\gamepath/Whitesheets}


%%%%%
%% Lastly, gametex.sty is input, making everything work.
\input \latex/gametex.sty
