#!/usr/bin/perl -w

use strict;
use CGI;
use CGI::Carp qw ( fatalsToBrowser );
use File::Basename;
use Data::GUID;
use DBI;

my %config = do './config.pl';
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $query = new CGI;
my $filename = $query->param("inputFile");
my $presenter = $query->param("inputPresentor");
my $description = $query->param("inputDescription");
print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
END

if (!$filename) {exit;}

my ( $name, $path, $extension ) = fileparse ( $filename, '\..*' );
$filename = lc($name . $extension);
$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ ){
  $filename = $1;
}
else {
  die "Filename contains invalid characters";
}

my $upload_filehandle = $query->upload("inputFile");
my $guid = Data::GUID->new;
my $guid_str = $guid->as_string;
mkdir ( "$config{upload_dir}/$guid_str" );
open ( UPLOADFILE, ">$config{upload_dir}/$guid_str/$filename" ) or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE;
}

close UPLOADFILE;

my $dbh = DBI->connect("$config{database_name};host=$config{database_host}",
                         "$config{database_username}", "$config{database_password}",
                         {'RaiseError' => 1});

my $sth = $dbh->prepare("SELECT id FROM presenters where email = \"$presenter\"");
$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
  $presenter = $ref->{'id'};
}
$sth->finish();
$dbh->do("INSERT INTO presentations(guid, name, extension, presenter, description, filename) VALUES (?, ?, ?, ?, ?, ?)", undef, $guid, $name, $extension, $presenter, $description, $filename);
$dbh->do("INSERT INTO jobs(guid) VALUES(?)", undef, $guid);
$dbh->disconnect();
