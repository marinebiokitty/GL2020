#!/usr/bin/env python3

"""
Tests for the name_pdfs program
"""

import unittest
import subprocess  # nosec
from pathlib import Path
from config import GAMEBASE
import config
import name_pdfs


class TestPDFRender(unittest.TestCase):
    """Main test bed"""

    bad_filenames = [
        15,
        "This isn't a valid filename",
        "./doesntExist",
        ".",
        "; echo bwahahahahaha",
    ]

    def test_reader(self):
        """
        Tests the reader function with various inputs
        """
        default_list_file = GAMEBASE + "/Lists/char-LIST.tex"
        output = name_pdfs.read_names_file(default_list_file)
        self.assertIsInstance(output, dict)
        self.assertGreater(len(output), 0)
        # Check that the function returns a dict ✓
        # Of greater than length 0 ✓
        fname = ""
        for example in self.bad_filenames:
            with self.subTest(fname=example):
                with self.assertRaises(OSError):
                    name_pdfs.read_names_file(fname)

    def test_build_command(self):
        """
        Tests the build_cmd function with valid and invalid inputs
        """
        output = name_pdfs.build_cmd("ChupStudent", "somefile.tex")
        self.assertIsInstance(output, list)
        self.assertGreater(len(output), 0)
        for chunk in output:
            self.assertIsInstance(chunk, str)
        name = [8675309, "ChupStudent"]
        filename = ["somefile.tex", 8675309]
        for i in range(2):
            with self.subTest():
                with self.assertRaises(TypeError):
                    name_pdfs.build_cmd(name[i], filename[i])

    def test_render_pdf(self):
        """
        Tests the render-pdf function with valid and invalid inputs
        Since the subprocess command carries some inherent security risk,
        explicitly try passing it a shell command instead of a valid file name
        """
        charname = "ChupStudent"
        bad_char_name = "Rumplestiltskin"  # pylint: disable=unused-variable
        config.OUTDIR = "."
        retval = -1
        expected_out_name = GAMEBASE + "/Charsheets/" + charname + "_Charsheet.pdf"
        retval = name_pdfs.render_pdf(charname, "COS_Student_Adopted.tex")
        self.assertEqual(retval, 0)
        self.assertTrue(
            Path.exists(Path(expected_out_name)),
            f"Failed for expected output name {expected_out_name}",
        )
        retval = -1
        for badname in self.bad_filenames:
            with self.subTest(badname=badname):
                try:
                    retval = name_pdfs.render_pdf(charname, badname, draft=True)
                except TypeError:
                    retval = 1
                except FileNotFoundError:
                    retval = 1
                except subprocess.CalledProcessError:
                    retval = 1
                else:
                    self.fail()
                finally:
                    self.assertNotEqual(retval, 0)


if __name__ == "__main__":
    unittest.main()
