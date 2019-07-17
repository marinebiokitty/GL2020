When producing a game, you may want to delay the production of
particular elements or owners.  A greensheet may not be finished, or
you may want to print a specific packet later, or you may not have
finished assigning elements to game area yet.  The \punt command can
make this easy, by declaring a set of datatype macros to be inactive.
Thus

  \documentclass[abil]{game}
  \begin{document}
  \punt{Abil}{\aMagic{}}
  \production
  \end{document}

will produce the game's abilities (with the complete ownership
structure), but lacking all instances of the Magic ability.
References inside text to \aMagic{} (such as to its name) will be
unaffected.  \punt only disables the production of whole elements.

\punt can be applied to any type.  By latex'ing

  \documentclass[listgreen]{game}
  \begin{document}
  \punt{Green}{\gHacking{}\gSpelunking{}}
  \punt{Char}{\cJamesBond{}}
  \punt{Place}{\EVERY{Place}{}}
  \production
  \end{document}

you will get the game's greensheets, minus any copies of the Hacking
and Spelunking greensheets, any of James Bond's greensheets, and any
greensheets owned by any Place macros.

\unpunt acts in reverse.  It implicitly punts all macros of a given
type except those listed in the argument.  Therefore

  \documentclass[abils]{game}
  \begin{document}
  \unpunt{Abil}{\aMagic{}}
  \production
  \end{document}

will produce only copies of the Magic ability, within the full
ownership structure of \production.
