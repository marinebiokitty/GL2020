#!/bin/bash

# Try to identify missing backslashes.
ls | grep tex | xargs sed -i 's/^c\([A-Z][a-zA-Z]*\){/\\c\1{/g'                                      # Paragraph beginning cCharacter{...} -> \cCharacter{...}
ls | grep tex | xargs sed -i 's/\([^\\a-zA-Z]\)c\([A-Z][a-zA-Z]*\){/\1\\c\2{/g'                      # Everywhere else: cCharacter{...} -> \cCharacter{...}
ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]+\){\([A-Za-z]*\)}/\\c\1{\\\2}/g'                        # Identify and correct missing backslashes: \cCharacter{Foo} -> \cCharacter{\Foo}

ls | grep tex | xargs sed -i 's/\\\([Tt]\)hey \\\(are\|were\|have\)/\\\1hey\2/g'                      # \cCharacter{\they \are} -> \Theyare, etc
ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]*\){\\\([tT]\)hey} \\c\1{\\\(are\|were\|have\)}/\\c\1{\\\2hey\3}/g' # \cCharacter{\They} \cCharacter{\are} -> \cCharacter{\Theyare}, for both capitalizations, are, were, have

ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]*\){\\\([Tt]\)hey} \(is\|are\)/\\c\1{\\\2heyare}/g'     # \cCharacter{\They} is/are -> \cCharacter{\Theyare}
ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]*\){\\\([Tt]\)hey} \(was\|were\)/\\c\1{\\\2heywere\3}/g'  # \cCharacter{\They} was/were -> \cCharacter{\Theywere}
# have/has can't be corrected automatically: "doesn't he have a carrot" is correct, "he have a carrot" isn't.

ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]*\){\\\([Tt]\)hey}'\''\(re\|s\)/\\c\1{\\\2heyre}/g'          # \cCharacter{\They}'re/\cCharacter{\They}'s -> \cCharacter{\Theyre}
ls | grep tex | xargs sed -i 's/\\c\([A-Za-z]*\){\\\([Tt]\)hey}'\''ve/\\c\1{\\\2heyve}/g'                # \cCharacter{\They}'ve -> \cCharacter{\Theyve}

ls | grep tex | xargs sed -i 's/\(is\|are\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\arethey}/g'               # is/are \cCharacter{\they} -> \cCharacter{\arethey}
ls | grep tex | xargs sed -i 's/\(was\|were\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\werethey}/g'            # was/were \cCharacter{\they} -> \cCharacter{\werethey}
ls | grep tex | xargs sed -i 's/\(has\|have\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\havethey}/g'            # has/have \cCharacter{\they} -> \cCharacter{\havethey}

ls | grep tex | xargs sed -i 's/\(Is\|Are\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\Arethey}/g'               # Is/Are \cCharacter{\they} -> \cCharacter{\Arethey}
ls | grep tex | xargs sed -i 's/\(Was\|Were\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\Werethey}/g'            # Was/Were \cCharacter{\they} -> \cCharacter{\Werethey}
ls | grep tex | xargs sed -i 's/\(Has\|Have\) \\c\([A-Za-z]*\){\\they}/\\c\2{\\Havethey}/g'            # Has/Have \cCharacter{\they} -> \cCharacter{\Havethey}

ls | grep tex | xargs sed -i "s/“\([^“”]\)”/``\1''/g"                                                # “curly quoted” -> ``curly quoted''

ls | grep tex | xargs sed -i 's/^\\c\([A-Za-z]*\){\\the\(y\|ir\)/\\c\1{\\The\2/g'                             # uncapitalized \they at the beginning of a paragraph(also \theyare, \their, etc)
ls | grep tex | xargs sed -i 's/\. \+\\c\([A-Za-z]*\){\\the\(y\|ir\)/\. \\c\1{\\The\2/g'                  # uncapitalized \they at the beginning of a sentence within a paragraph

### Eliminate \do.
#ls | grep tex | xargs sed -i 's/\\c\([a-zA-Z]*\){\\do}/do\\c\1{\\verbes}/g'                           # \cCharacter{\do} -> do\cCharacter{\verbes}
#ls | grep tex | xargs sed -i 's/\\c\([a-zA-Z]*\){\\\([tT]\)heydo}/\\c\1{\\\2hey} do\\c\1{\\verbes}/g' # \cCharacter{\theydo} -> \cCharacter{\they} do\cCharacter{\verbes}

# Use \intro.

ls | grep tex | xargs sed -i 's/\\c\([A-Z][A-Za-z]*\){\\full} (\\c\1{\\[Tt]hey}\/\\c\1{\\[Tt]hem})/\\c\1{\\intro}/g'
ls | grep tex | xargs sed -i 's/\\c\([A-Z][A-Za-z]*\){\\intro}'\''s/\\c\1{\\intros}/g'