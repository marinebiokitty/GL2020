#!/bin/bash

mv listchar-PRINT.tex listchar-BACKUP.tex

character=$1
charname=$2

cat >listchar-PRINT.tex <<EOL

%% character sheets printed
\documentclass[listchar]{GL2020} %% make sure name of class is correct
\begin{document}

\c$character{}

\end{document}
EOL
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" listchar-PRINT.tex
mv listchar-PRINT.pdf $charname.pdf

mv listchar-BACKUP.tex listchar-PRINT.tex
