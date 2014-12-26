#!/usr/bin/env perl

use strict;
use warnings;

use CGI;

my $q = CGI->new;
my ($keyword) = $q->keywords;

my $map = {
	'6'    => 'Молитви/Шостопсалміє',
};

exit unless exists $map->{$keyword};

my $header = do { local( @ARGV, $/ ) = '../tpl/header'; <> };
my $body   = do { local( @ARGV, $/ ) = "../src/$map->{$keyword}"; <> };
my $footer = do { local( @ARGV, $/ ) = '../tpl/footer'; <> };

print "Content-Type: text/html; charset=utf-8\n\n";
print $header.$body.$footer;
