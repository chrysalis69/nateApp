#!/usr/bin/perl -wT

use strict;
use CGI;
use CGI::Carp qw ( fatalsToBrowser );
use File::Basename;

require './include/config.pl';
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $query = new CGI;
my $filename = $query->param("inputFile");
my $presenter = $query->param("inputPresentor");
my $description = $query->param("inputDescription");

if (!$filename) {exit;}

my ( $name, $path, $extension ) = fileparse ( $filename, '..*' );
$filename = $name . $extension;
$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ ){
  $filename = $1;
}
else {
  die "Filename contains invalid characters";
}

my $upload_filehandle = $query->upload("inputFile");

open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE;
}

close UPLOADFILE;


