#!/bin/bash

# Note not all have/has can be autocorrected: "doesn't he have a carrot" is correct, "he have a carrot" isn't.

ls | xargs sed -i 's/\\\([Tt]\)hey\ \\\(are|were|do|have\)/\\\1hey\2/g'                      # \They \are -> \Theyare, etc.  Correct for "have" because it's already been backslashed.
ls | xargs sed -i "s/\\\([Tt]\)hey\ \\\(are|were|do|have\)nt/\\\1hey\2nt/g"                  # \They \arent -> \Theyarent
ls | xargs sed -i 's/\\c\([A-Za-z]*){\([A-Za-z]*\)}/\\c\1{\\\2}/g'                           # Identify and correct missing backslashes: \cCharacter{Foo} -> \cCharacter{\Foo}

ls | xargs sed -i 's/\\c\([A-Za-z]*){\\\([Tt]\)hey} \(is|are\)/\\c\1{\\\2heyare\3}/g'        # \cCharacter{\They} is/are -> \cCharacter{\Theyare}
ls | xargs sed -i "s/\\c\([A-Za-z]*){\\\([Tt]\)hey} \(is|are\)n't/\\c\1{\\\2heyarent\3}/g"   # \cCharacter{\They} isn't/aren't -> \cCharacter{\Theyare}

ls | xargs sed -i "s/\\c\([A-Za-z]*){\\\([Tt]\)hey} \(was|were\)/\\c\1{\\\2heywere\3}/g"            # \cCharacter{\They} was/were -> \cCharacter{\Theywere}
ls | xargs sed -i "s/\\c\([A-Za-z]*){\\\([Tt]\)hey} \(was|were\)n't/\\c\1{\\\2heywerent\3}/g"       # \cCharacter{\They} wasn't/weren't -> \cCharacter{\Theywerent}

ls | xargs sed -i "s/\\c\([A-Za-z]*){\\\([Tt]\)hey} \(do|does\)/\\c\1{\\\2heydo\3}/g"       # \cCharacter{\They} do/does -> \cCharacter{\They} do\cCharacter{erbes}


ls | xargs sed -i 's/\\c\([A-Za-z]*){\\\([Tt]\)hey} does/\\c\1{\\\2heydo\3}/g'    # \cCharacter{\They} does -> \cCharacter{\They} do\cCharacter{erbes}
ls | xargs sed -i 's/\(Are|Were|Do\) \\c\([A-Za-z]*){\\they}/\\c\2{\\\1they}/g'    # Are \cCharacter{\they} -> \cCharacter{\Arethey}
ls | xargs sed -i "s/Don't \\c\([A-Za-z]*){\\they}/\\c\1{\\Dontthey}/g"    # Don't \cCharacter{\they} -> \cCharacter{\Dontthey}

