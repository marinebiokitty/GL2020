
#!/bin/bash

character=$1
charname=$2

mv abil-PRINT.tex abil-BACKUP.tex

echo "Working on $character"
cat >abil-PRINT.tex <<EOL

\documentclass[abils]{GL2020} %% make sure name of class is correct
\begin{document}
\c$character{}

\end{document}
EOL
/mnt/c/Users/wasse/AppData/local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe -include-directory="C:/Users/wasse/Documents/GitHub/GL2020/LaTeX/" abil-PRINT.tex
mv abil-PRINT.pdf $charname-abil.pdf
echo "Done with $character"

mv abil-BACKUP.tex abil-PRINT.tex