#!/bin/env python3

'''
Copyright (C) 2022 Andy Piltser-Cowan <awc34@cornell.edu>.

Released under Creative Commons Attribution-Sharealike License 4.0
Available at https://creativecommons.org/licenses/by-sa/4.0/
Contact the author if a different license is desired.

This should be considered alpha-quality software, the author makes no warranty
as to its quality.  Expect bugs.
'''


import re
import sys
import os
import argparse
from pathlib import Path
import subprocess
import shutil
import shlex

TEXCMD = str(shutil.which("pdflatex"))
GAMEBASE = os.path.abspath("../..") + "/"
INCLUDES = " --include-directory=" + GAMEBASE + "LaTeX"
JOBFLAG = " --job-name="
OUTDIR = " --output-directory=" + GAMEBASE + "Charsheets"

def read_names_file(filename: str) -> dict:
    """Reads in the list .tex file and returns a dict with macronames as keys
    and (full_name, file_name) as values, both strings."""
    PCs: list[str]
    parsed_characters: dict[str, tuple]
    parsed_characters = {}
    re_for_character = re.compile(r"^\\NEW{PC}.*?^}$", re.M | re.S)
    re_for_macroname = re.compile(r"(?:^\\NEW{PC}{\\c)(\w+)(?:})")
    # breakpoint()
    re_for_filename = re.compile(r'(?:\\s\\MYfile\s+{)(\w+\.\w+)')
    re_for_name = re.compile(r"(?:\\s\\MYname\s+{)([ -~\s]+?)(?:}|\\suf)")
    with open(filename, "r") as file:
        PCs = re.findall(re_for_character, file.read())
    for character in PCs:
        macroname = str(re.findall(re_for_macroname, character)[0])
        full_name = str(re.findall(re_for_name, character)[0])
        try:
            file_name = str(re.findall(re_for_filename, character)[0])
        except IndexError:
            file_name = None
            print(f"Warning!  Missing file name for {macroname}", sys.stderr)
        parsed_characters[macroname] = full_name, file_name

    return parsed_characters


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("name")
    parser.add_argument("--listfile", default=GAMEBASE+"/Lists/char-LIST.tex")
    arguments = parser.parse_args()
    name = arguments.name
    listfile = arguments.listfile

    output = read_names_file(arguments.listfile)
    # Now render the one the user asked for
    texsource = output[name][1]
    print(f"texsource (filename) = {texsource}")
    absname = GAMEBASE + '/Charsheets/' + texsource
    print(f"Fully qualified filename = {absname}")
    exists = Path.exists(Path(absname))
    if exists:
        JOBFLAG = JOBFLAG + output[name][0].replace(" ", "_") + "_Charsheet"
        command = TEXCMD + JOBFLAG+ OUTDIR
        command = command + INCLUDES + " " + absname
        arrgh = shlex.split(command)
        subprocess.run(arrgh, check=False)
    else:
        print(f"Error! Character sheet file {absname} does not exist!")
    # And rename it based on our dict
    # Maybe have a nice picker GUI
    # That also displays the output?
