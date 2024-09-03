#!/bin/bash

character=$1
charname=$2

mv listgreen-PRINT.tex listgreen-BACKUP.tex

echo "Working on $character"
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
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" listgreen-PRINT.tex
mv listgreen-PRINT.pdf $charname-greens.pdf
echo "Done with $character"

mv listgreen-BACKUP.tex listgreen-PRINT.tex