#!/bin/env python3

import re
import sys

def read_names_files(filename: str) -> dict:

    PCs: list[str]
    parsed_characters = {}
    re_for_character = re.compile(r"^\\NEW{PC}.*?^}$", re.M | re.S)
    re_for_macroname = re.compile(r"(?:^\\NEW{PC}{\\c)(\w+)(?:})")
    re_for_name = re.compile(r"(?:\\s\\MYname\s+{)([ -~\s]+?)(?:}|\\suf)")
    with open(filename, "r") as file:
        PCs = re.findall(re_for_character, file.read())
    for character in PCs:
#        breakpoint()
        macroname = str(re.findall(re_for_macroname, character)[0])
        full_name = str(re.findall(re_for_name, character)[0])
        parsed_characters[macroname] = full_name

    return parsed_characters


if __name__ == "__main__":
    output = read_names_files(sys.argv[1])
    print(repr(output))
