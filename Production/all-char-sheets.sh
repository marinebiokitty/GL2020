
#!/bin/bash

character=$1
charname=$2

mv listblue-PRINT.tex listblue-BACKUP.tex
mv listchar-PRINT.tex listchar-BACKUP.tex
mv listgreen-PRINT.tex listgreen-BACKUP.tex
mv abil-PRINT.tex abil-BACKUP.tex

echo "Working on $character"

cat >listchar-PRINT.tex <<EOL

%% character sheets printed
\documentclass[listchar]{GL2020} %% make sure name of class is correct
\begin{document}

\c$character{}

\end{document}
EOL


cat >listblue-PRINT.tex <<EOL
\documentclass[listblue]{GL2020} %% make sure name of class is correct

\usepackage{array}
\usepackage{xcolor}
\usepackage{hyperref}
\usepackage{multicol}
\usepackage{ltablex}
\usepackage{tabularx}

\usepackage{enumitem}
\setlist{nosep}
\parindent=0pt


\begin{document}

\c$character{}

\end{document}
EOL


cat >listgreen-PRINT.tex <<EOL

\documentclass[listgreen]{GL2020} %% make sure name of class is correct

\usepackage{array}
\usepackage{xcolor}
\usepackage{hyperref}
\usepackage{multicol}
\usepackage{ltablex}
\usepackage{tabularx}

\usepackage{graphicx}
\graphicspath{ {C:/Users/wasse/Documents/GitHub/GL2020/Puzzles/} }

\usepackage{enumitem}
\setlist{nosep}
\parindent=0pt

\usepackage{makecell}

\begin{document}
\c$character{}

\end{document}
EOL


cat >abil-PRINT.tex <<EOL

\documentclass[abils]{GL2020} %% make sure name of class is correct
\begin{document}
\c$character{}

\end{document}
EOL


/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" listblue-PRINT.tex 
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" listchar-PRINT.tex
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" listgreen-PRINT.tex
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" abil-PRINT.tex


mv listblue-PRINT.pdf $charname-blue.pdf
mv listgreen-PRINT.pdf $charname-green.pdf
mv abil-PRINT.pdf $charname-abil.pdf
mv listchar-PRINT.pdf $charname.pdf
echo "Done with $character"

mv listblue-BACKUP.tex listblue-PRINT.tex
mv listgreen-BACKUP.tex listgreen-PRINT.tex
mv listchar-BACKUP.tex listchar-PRINT.tex
mv abil-BACKUP.tex abil-PRINT.tex