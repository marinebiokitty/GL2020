The GameTeX class file, by default, loads the standard LaTeX article
class, with no special options, meaning it inherits the standard
settings and commands provided by article.  You can make a given file
that is based on a different class by defining \BASECLASS before
\documentclass:

  \def\BASECLASS{report}
  \documentclass[<option>]{<gameclassname>}

will make the file be based on the standard report class.

You may specify options to be sent to whichever base class you are
using by defining \BASEOPTIONS before \begin{document}:

  \def\BASEOPTIONS{12pt,foobar}
  \documentclass[<option>]{<gameclassname>}

This will send the 12pt and foobar options to the default base class
(article).  Also, any non-GameTeX options you specify will be passed
to the base class.  For example, the line

  \documentclass[sheet,12pt,foobar]{somegame}

will execute the GameTeX sheet option, after loading the article class
with the 12pt and foobar options.  Instead, if you use

  \def\BASECLASS{report}
  \documentclass[sheet,12pt,foobar]{somegame}

or

  \def\BASECLASS{report}
  \def\BASEOPTIONS{12pt,foobar}
  \documentclass[sheet]{somegame}

or

  \def\BASECLASS{report}
  \def\BASEOPTIONS{12pt}
  \documentclass[sheet,foobar]{somegame}
  
the 12pt and foobar options will be sent to the report class.  Keep in
mind that changing the base class or sending options to the base class
count as preamble modifications for sheets.  These functions may be
useful for unique central documents, but should not be used for
general sheets or other game documents that are part of the game's
database.
