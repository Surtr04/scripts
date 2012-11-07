#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Archive::Zip;
use File::Copy;

my $zip;
my $delete;


Getopt::Long::Configure('bundling');
GetOptions('z' => \$zip,'d' => \$delete);

if($zip) {
	my $name = shift;
	my $zipFile = Archive::Zip->new();
	my $file;
	foreach $file (@ARGV) {
		if(-f $file) {
			$zipFile->addFile($file);
		}
		else {
			$zipFile->addTree("./$file","$file");				
		}
	}		

	$zipFile->writeToFileNamed("$name.zip");

	if ($delete) {
		move("$name.zip","/Users/rmb/Dropbox/Public/$name.zip");
	}
	else {
		copy("$name.zip","/Users/rmb/Dropbox/Public/$name.zip");
	}

	print "https://dl.dropbox.com/u/1041433/$name.zip\n";
}

else {
	
	my $file;

	foreach $file (@ARGV) {		
		if ($delete) {
			move("$file","/Users/rmb/Dropbox/Public/$file");
		}
		else {
			copy("$file","/Users/rmb/Dropbox/Public/$file");
		}
		print "https://dl.dropbox.com/u/1041433/$file\n";
	}
}
	

