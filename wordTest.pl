#!/usr/local/bin/perl 
use strict;

use List::MoreUtils qw(uniq);
use SequenceWord;

###  Ask user for file name.
my $fileName = "none";
do {
	print "Please enter name of Dictionary File: <empty to exit> ";
	$fileName = <STDIN>; # I moved chomp to a new line to make it more readable
	chomp $fileName; # Get rid of newline character at the end
	exit 0 if ($fileName eq ""); # If empty string, exit.
	unless (-e $fileName) {
		print "File does not exist!\n";
	}
} until (-e $fileName) ;

### Open the file and read in the words
my @words;
open DicFile, "<$fileName" or die $!;
while (<DicFile>) {
	my $line = $_;
	#print $line;
	chomp $line;
	my @array = split(/\W+/, $line);
	foreach (@array)  {
		### could restrict to length >= 4
		#print "!$_!\n";
		if ($_ ne "") {
			push (@words, $_);
		}
	}
}

### Get Unique word list
my @unique_words = uniq @words;
#print "@unique_words\n";

### Hash used to store sequences.
my %seqHash; 

## Find the Sequences and write out to a file
open WordFile, ">words" || die $!;
open SequenceFile, ">sequences" || die $!;
foreach(@unique_words) {
	my $word = $_;
	if (length($word) >= 4) {
		for (my $i =0; $i<= length($word)-4; $i++) {
			my $seq = substr($word,$i,4);
			my $sw = $seqHash{$seq};
			if (defined $sw) {
				$sw->incrementCount();
			} else {
				$sw = new SequenceWord($seq,$word);
				$seqHash{$seq} = $sw;
			}
		}
	}
}


for (sort keys  %seqHash)
{
	my $sw = $seqHash{$_};
	my $seq = $sw->sequence();
	my $word = $sw->word();
	if ($sw->getCount() == 1) {
		print SequenceFile "$seq\n";
		print WordFile "$word\n";
    }
	# else {
		# print "duplicate sequence: $seq " . $sw->getCount() . "\n";
	# }
}

close WordFile;
close SequenceFile;

exit 0;
