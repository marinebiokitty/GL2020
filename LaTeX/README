LaTeX/README

The class file (.cls) and style files (.sty), which are the "engine"
of GameTeX, are in the LaTeX/ directory.  The style files (other than
gametex.sty) are each independent and portable TeX macro files.  They
work independently of each other and any GameTeX code, each is
documented separately, and none (other than gametex.sty) are intended
for customization by GMs.

game.cls is the default name for the LaTeX2e class file.  It is
probably renamed for a given game.  The class file is for basic
customization.  Things defined there are available throughout GameTeX.

gametex.sty is the main central file which contains the engine of
GameTeX.  It sets up the basic structure and defines all of the
<option>s for \documentclass[<option>], e.g. sheet, char, and abil,
each of which sets up a type of game document.  Some of these
<option>s inherit from each other.

cards.sty is a "card layout" driver that defines macros for putting
cards, i.e. things that are meant to be cut out, on a page, in various
ways.  Commands provided by this file are only available for card
documents.

datatypes.sty is a macro set for an object-oriented database system.
Game elements such as character macros and bluesheet macros are
implemented with it.  It is relatively complex.  Commands provided by
it are available throughout GameTeX.

extraction.sty is for extraction from files, e.g. for getting the text
between \begin{document} and \end{document} for sheets, such that it
can be available and used elsewhere.  Commands provided by it are
available throughout GameTeX.

parsename.sty implements parsing of proper English names into
component parts, e.g. first, middle, and last names.  The \parsename
command provided by it is available throughout GameTeX.
