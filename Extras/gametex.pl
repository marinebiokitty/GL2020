#!/usr/bin/env perl
###############################################################################
# GameTeX Sheet Generator
###############################################################################

if ((!$ARGV[1]) || ($ARGV[3])) {
    print "usage: ./gametex.pl option    command \n";
    print "   or: ./gametex.pl pdfsheets command \n";
    print "   or: ./gametex.pl option    command gameclass\n";
    print "   or: ./gametex.pl pdfsheets command gameclass\n";
    exit;
}

$gameclass = "guildcamp1";

if ($ARGV[2]) {
    $gameclass = $ARGV[2];
} else {
    print "\nusing default gameclass \"$gameclass\"\n";
}

sub latex {
    my($outfile) = shift;
    my($intext) = shift;
    print "\n";
    if (-e "$outfile.tex") {
	print "$outfile.tex already exists\n";
	exit;
    }
    open LTX, ">", "$outfile.tex";
    print LTX $intext;
    close LTX;
    system "latex $outfile.tex";
    unlink("$outfile.tex");
}

sub gametex {
    my($opt) = shift;
    my($command) = shift;
    my($pdfpart) = shift;
    "\\documentclass[$opt]{$gameclass}" .
    "$pdfpart\\begin{document}\\$command\{}\\end{document}";
}

sub dvipdf {
    my($outfile) = shift;
    my($infiles) = shift;
    print "\n";
    system "( for b in $infiles ; do if [ -f \$b ] ; " .
	"then dvips -Ppdf -tletterSize -G0 -f \$b ; fi ; done ) " .
	"| $gs -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite " .
	"-sPAPERSIZE=letter -dPDFSETTINGS=/printer -sOutputFile=$outfile " .
	"-dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100 " .
	"-dCompatibilityLevel=1.3 -dParseDSCCommentsForDocInfo=false " .
	"-dParseDSCComments=false " .
	"-c save pop -";
}

if ($ARGV[0] eq "pdfsheets") {
    if (`gs --version` < 6) {
	print "Creating PDF files needs ghostscript 6.0 or greater\n";
	exit;
    } else {
	$gs = "gs";
    }
    $name = $ARGV[1];
    &latex("$name-listchar",  &gametex("listchar", $name, "\\PDFPart"));
    &latex("$name-listblue",  &gametex("listblue", $name, "\\PDFPart"));
    &latex("$name-listgreen", &gametex("listgreen", $name, "\\PDFPart"));
    &dvipdf("$name-sheets.pdf",
	    "$name-listchar.dvi $name-listblue.dvi $name-listgreen.dvi");
    unlink("$name-listchar.dvi");
    unlink("$name-listblue.dvi");
    unlink("$name-listgreen.dvi");
} else {
    my($opt) = shift;
    my($name) = shift;
    &latex("$name-$opt",  &gametex($opt,  $name, ""));
}

exit;
