To generate quality PDF files from latex in a somewhat reliable
fashion, add the following alias to your .cshrc.mine file:

alias dvipdf 'dvips -Ppdf -tletterSize -G0 -f \!^.dvi | gs -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPAPERSIZE=letter -dPDFSETTINGS=/printer -sOutputFile=\!^.pdf -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100 -dCompatibilityLevel=1.3 -c save pop -;'

(logout and login, or source .cshrc.mine for it to take effect)

Then you can type "dvipdf foo" to create foo.pdf from foo.dvi.  The
resulting PDF will display nicely, because its fonts will be embedded
and not bitmapped.

This is distinct from the dvipdf distributed with Ghostscript.  The
alias applies the correct font options to gs, and the correct -Ppdf
option to dvips.  The alias requires gs version 6 or later; the
version on Athena suffices.

You should also be using the Athena version of dvips.  If you are
using the newtex locker (i.e. you have "add -f newtex" in your
.environment file), the dvipdf alias will likely not work.
