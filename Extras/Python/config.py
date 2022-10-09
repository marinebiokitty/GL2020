"""
Configuration options for the name_pdfs module
"""
from shutil import which
from os import path
import os

TEXCMD = str(which("pdflatex"))
GAMEBASE = path.abspath("../..")
INCLUDES = " --include-directory=" + path.join(GAMEBASE, "LaTeX")
JOBFLAG = " --job-name="
RUNFLAGS = " --interaction=nonstopmode --enable-write18"
OUTDIR = " --output-directory=" + path.join(GAMEBASE, "Charsheets")
POSIX = bool(os.name == "posix")
