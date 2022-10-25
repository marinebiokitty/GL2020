#!/usr/bin/env python

"""
Copyright (C) 2022 Andy Piltser-Cowan <awc34@cornell.edu>.

Released under Creative Commons Attribution-Sharealike License 4.0
Available at https://creativecommons.org/licenses/by-sa/4.0/
Contact the author if a different license is desired.

This should be considered alpha-quality software, the author makes no warranty
as to its quality.  Expect bugs.
"""


import re
import argparse
from pathlib import Path
import subprocess  # nosec
import shlex
from warnings import warn
import os
import tempfile
from config import *  # pylint: disable=wildcard-import, unused-wildcard-import


def read_names_file(filename: str) -> dict:  # pylint: disable=too-many-locals
    """
    Reads in the list .tex file and returns a dict with macronames as keys
    and (full_name, file_name, blues, greens) as values.
    Full_name and file_name are strings.
    Blues and Greens are each Lists of strings.

    TODO (Andy): make the values a NamedTuple
    """
    player_characters: list[str]
    parsed_characters: dict[str, tuple]
    parsed_characters = {}
    re_for_character = re.compile(r"^\\NEW{PC}.*?^}$", re.M | re.S)
    re_for_macroname = re.compile(r"(?:^\\NEW{PC}{\\c)(\w+)(?:})")
    # breakpoint()
    re_for_filename = re.compile(r"(?:\\s\\MYfile\s+{)(\w+\.\w+)")
    re_for_name = re.compile(r"(?:\\s\\MYname\s+{)([ -~\s]+?)(?:}|\\suf)")
    re_for_blues_line = re.compile(r"(?:\\s\\MYblues\s+{\\b)[ -~\s]*?\n")
    re_for_greens_line = re.compile(r"(?:\\s\\MYgreens\s+{\\g)[ -~\s]*?\n")
    re_blues_from_line = re.compile(r"(?:\\b)([\w]+)")
    re_greens_from_line = re.compile(r"(?:\\g)([\w]+)")

    # The comment below disables a pylint warning for not specifying file
    # encoding.  This is safe for a text-mode read in Python 3.10
    # pylint: disable=W1514
    with open(filename, "r") as file:
        player_characters = re.findall(re_for_character, file.read())
    for character in player_characters:
        macroname = str(re.findall(re_for_macroname, character)[0])
        full_name = str(re.findall(re_for_name, character)[0])
        blues = re.findall(re_for_blues_line, character)
        if len(blues) > 0:
            blues = re.findall(re_blues_from_line, blues[0])
        greens = re.findall(re_for_greens_line, character)
        if len(greens) > 0:
            greens = re.findall(re_greens_from_line, greens[0])
        try:
            file_name = str(re.findall(re_for_filename, character)[0])
        except IndexError:
            file_name = None
            warn(f"Warning!  Missing file name for {macroname}")
        parsed_characters[macroname] = full_name, file_name, blues, greens

    return parsed_characters


def build_cmd(charname: str, filename: str, draft=False) -> list[str]:
    """Builds the shell command used in the render_pdf() functions"""
    if not isinstance(charname, str):
        raise TypeError("Buildcmd received a 'charname' that was not a string!")
    if not isinstance(filename, str):
        raise TypeError("Buildcmd received a filename that was not a string!")

    job_flags = JOBFLAG + charname.replace(" ", "_") + "_Charsheet"
    command = TEXCMD + job_flags + OUTDIR + RUNFLAGS
    if draft:
        command += "--draft"
    command = command + INCLUDES + " " + filename
    arrgh = shlex.split(command, posix=POSIX)  # POSIX is a bool defined in config.py
    return arrgh


def render_pdf(charname: str, texfile: str, draft=False) -> int:
    """
    This function calls 'pdflatex' to render a PDF file for the character
    named charname
    """
    # print(f"texsource (filename) = {texfile}")
    absname = os.path.join(GAMEBASE, "Charsheets", texfile)
    # print(f"Fully qualified filename = {absname}")
    exists = Path.exists(Path(absname))
    if exists:
        arrgh = build_cmd(charname, absname, draft)
        return subprocess.run(arrgh, check=True).returncode  # nosec

    raise FileNotFoundError(f"Error! Character sheet file {absname} does not exist!")


def render_pdf_from_list(
    charname: str, macroname: str, compendium=False, production=False
) -> int:
    """
    Same as render_pdf, but instead of looking up a character file name,
    this one invokes listchar-PRINT.tex.

    "Compendium" and "production" are the flags that file defines.
    """
    # pylint: disable=unused-argument
    list_file_path = os.path.join(GAMEBASE, "Production", "listchar-PRINT.tex")
    exists = Path.exists(Path(list_file_path))
    if exists:
        with tempfile.NamedTemporaryFile(mode="wt", suffix=".tex") as temp_file:
            text_to_write = (
                r"\documentclass[listchar]{GL2020}"
                r"\begin{document}"
                f"\\c{macroname}{{}}"
                r"\end{document}"
            )
            temp_file.write(text_to_write)
            temp_file.flush()
            arrgh = build_cmd(charname, temp_file.name)
            retcode = subprocess.run(arrgh, check=True).returncode  # nosec
        return retcode

    raise FileNotFoundError(f"Error! File {list_file_path} not found!")


def main() -> int:
    """
    Parse out command line arguments and call other functions to select and render
    the appropriate .tex file for the macro selected by the user.

    Usage: $ name_pdfs.py MyCharacterMaccro

    Where MyCharacterMacro is one of the names defined in char-LIST.tex
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("name")
    parser.add_argument("--listfile", default=GAMEBASE + "/Lists/char-LIST.tex")
    arguments = parser.parse_args()
    name = arguments.name
    output = read_names_file(arguments.listfile)
    try:
        #  return render_pdf(output[name][0], output[name][1])
        return render_pdf_from_list(output[name][0], name)
    except KeyError:
        print(f"Fatal error: macroname {name} not found!")
        return 1


if __name__ == "__main__":
    main()
