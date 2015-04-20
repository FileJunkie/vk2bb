#!/usr/bin/perl

use LWP::Simple;
use Data::Dumper;
use strict;

if($#ARGV != 1){
	print "Usage: ./vk2bb.pl userid albumid\n";
	exit;
}

my $url = "https://api.vk.com/method/photos.get?owner_id=" . $ARGV[0] . "&album_id=" . $ARGV[1];

my $json = get($url);
die "Could not get $url! $!" unless defined $json;

my @parts = split(',' , $json);

foreach my $part (@parts){
	next if $part !~ /.*src_xxbig.*/;
	$part =~ s/\\//g;
	$part = substr $part, 13, -1;
	print "[img]" . $part. "[/img]\n";
}
