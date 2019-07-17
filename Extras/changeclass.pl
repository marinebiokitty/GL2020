#!/usr/bin/env perl
use strict;

sub change_file($$$$$) {
    my $file = $_[0];
    my $old = $_[1];
    my $new = $_[2];
    my $leading = $_[3];
    my $trailing = $_[4];
    my $foundit = 0;
    open (FILEIN, $file) || die "Can't open $file";
    open (FILEOUT, ">$file.tmp") || die "Can't open $file.tmp";
    while ($_ = <FILEIN>) {
	if ($foundit == 0 && $_ =~ /($leading)$old($trailing)/) {
	    print FILEOUT "$1$new$2\n";
	    $foundit = 1;
	} else {
	    print FILEOUT $_;
	}
    }
    close FILEOUT;
    close FILEIN;
    system "mv $file.tmp $file" || die "Can't move file";
}

sub change_tex_file($$$) {
    return change_file($_[0], $_[1], $_[2],
		       "^[^%]*\\\\documentclass\\[\\w+\\]\\{","\\}.*");
}

sub change_cls_file($$$) {
    return change_file($_[0], $_[1], $_[2],
		       "^[^%]*\\\\def\\\\gameclassname\\{","\\}.*");
}

sub change_pl_file($$$) {
    return change_file($_[0], $_[1], $_[2],
		       ".*\\\$gameclass = \"","\".*");
}

sub change_file_by_extension($$$) {
    if ($_[0] =~ /\.pl$/) {
	change_pl_file($_[0], $_[1], $_[2]);
    } elsif ($_[0] =~/\.cls$/) {
	change_cls_file($_[0], $_[1], $_[2]);
    } elsif ($_[0] =~/\.tex$/) {
	change_tex_file($_[0], $_[1], $_[2]);
    }
}

if (3 != @ARGV) {
    print "usage: ./changeclass.pl gamepath oldclass newclass\n";
    exit;
}

change_file_by_extension("$ARGV[0]/LaTeX/$ARGV[1].cls", $ARGV[1], $ARGV[2]);
system("mv $ARGV[0]/LaTeX/$ARGV[1].cls $ARGV[0]/LaTeX/$ARGV[2].cls");
change_file_by_extension("$ARGV[0]/Extras/gametex.pl", $ARGV[1], $ARGV[2]);
system("chmod 700 $ARGV[0]/Extras/gametex.pl");
open (FILES, "find \"$ARGV[0]\" -name '*.tex' |");
while (defined( $_ = <FILES>)) {
    chomp $_;
    change_file_by_extension($_,$ARGV[1], $ARGV[2]);
}
