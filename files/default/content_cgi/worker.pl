#!/usr/bin/perl -w
use strict;

use DBI;
my %config = do './config.pl';

my $dbh = DBI->connect("$config{database_name};host=$config{database_host}",
                         "$config{database_username}", "$config{database_password}",
                         {'RaiseError' => 1});
my $guid;
my $command;
my $name;
my $extension;

print <<END;
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
END

my $sth = $dbh->prepare("SELECT presentations.guid, name, presentations.extension, filename, command FROM jobs, presentations, converter WHERE jobs.state = 1 AND jobs.guid = presentations.guid AND LOWER(presentations.extension) = converter.extension LIMIT 1");

$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
  $guid = $ref->{'guid'};
  $command = $ref->{'command'};
  $name = $ref->{'filename'};
  $extension = $ref->{'extension'}; 
  $dbh->do("UPDATE jobs SET state = 2 WHERE guid = ?", undef, $guid);

  my $in_file = "$config{upload_dir}/$guid/$name";
  my $out_file = "$config{upload_dir}/$guid/$guid.pdf";
  $command =~ s/\%\{IN\}\%/$in_file/g;
  $command =~ s/\%\{OUT\}\%/$out_file/g;

  my $result = `$command`;
  my $pdfinfo = `pdfinfo "$out_file"`;
  my @pdfinfo = split "\n", $pdfinfo;
  my %pdf = map {split /:/} @pdfinfo;
  $dbh->do("UPDATE presentations SET pages = ? WHERE guid = ?", undef, $pdf{Pages}, $guid);
  $result = `convert "$config{upload_dir}/$guid/$guid.pdf" "$config{upload_dir}/$guid/page-%02d.png"`;
  $result = `convert -resize 256x256 "$config{upload_dir}/$guid/$guid.pdf"[0] "$config{upload_dir}/$guid/thumb.png"`;
  $result = `convert -resize 128x128 "$config{upload_dir}/$guid/$guid.pdf" "$config{upload_dir}/$guid/thumb-%02d.png"`;
}
$sth->finish();
$dbh->disconnect();

