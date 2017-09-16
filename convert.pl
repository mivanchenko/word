#!/usr/bin/env perl

use strict;
use warnings;

use Perl6::Slurp;
use Text::MultiMarkdown 'markdown';

my $head_begin = '<div align="center"><img src="../img/';
my $head_end   = '" /></div>' . "\n\n";

my $pages = {
	'anthem' => {
		head => $head_begin . 'herb_15_90.png' . $head_end,
	},
	'happy' => {},
	'wife' => {
		head => $head_begin . 'christianmarriage-200x138.jpg' . $head_end,
	},
	'6' => {},
	'letter' => {
		head => '<div align="center"><a href="http://molytva.at.ua/index/khresna_doroga/0-65"><img src="../img/sts3-12_15_90.jpg" /></a></div>'
	},
	'nation' => {
		head => $head_begin . '125502_20_90.jpg' . $head_end,
	},
	'thank' => {},
	'serb' => {},
	'ukr-sins' => {},
#	'shukai' => {
#		src => 'Цитати/Шукайте',
#	},
#	'spovid' => {
#		src => 'Цитати/Сповідь',
#		head => q{'<div align="center"><a href="http://www.cerkva.info/uk/publications/articles/5873-pronyzylyva-spovid-divchyny-z-rukhu-qza-yedynu-pomisnu-tserkvuq.html" title='Пронизлива сповідь дівчини з руху "За Єдину Помісну Церкву"' target=_blank><img src="img/upc_50_90.jpg" alt="Церква.info: Офіційний веб-сайт УПЦ Київського Патріархату" border="0" /></a></div>'}
#	},
};

my $head_default = $head_begin . 'sonce.jpg' . $head_end;
my $foot_default = '';

foreach my $keyword ( sort keys %{$pages} ) {
	my $page = $pages->{$keyword};

	my $header = slurp 'tpl/header';
	my $footer = slurp 'tpl/footer';

	my $head = $page->{head} || $head_default;
	my $foot = $page->{foot} || $foot_default;

	my $md   = slurp "src/$keyword";
	my $body = markdown $md;

	my $dest = $keyword;
	open my $dest_fh, '>', $dest
		or die "Can't open $dest for writing: $!";
	print $dest_fh join( "\n", $header, $head, $body, $foot, $footer );
	close $dest_fh;
}

