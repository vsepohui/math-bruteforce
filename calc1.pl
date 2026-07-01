#!/usr/bin/perl

use 5.022;
use warnings;

# 0.33071891388

# sqrt(7)/8=
# my $x = 0.33071891388; 

# (sin(180/7)^4)*16=
#my $x = 0.56703971721;

# ln(2)=
#my $a = 0.69314718056;

my @data;
my %com;

open my $fi, 'input.txt';
while (my $s = <$fi>) {
	chomp $s;
	my ($x, $c) = split /\s+\#/, $s;
	push @data, $x;
	$com{$x} = $c;
}
close $fi;

for my $a (@data) {
	for my $x (@data) {
		if ($a != $x) {
			process ($a, $x);
		}
	}
}

sub process {
	my ($x, $a) = @_;
	if (my $r = pod_rotate($x, $a)) { say "WOW: rotate(\$x, \$a) $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate($x*$x, $a)) { say "WOW: rotate(\$x*\$x, \$a) $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate(sqrt($x), $a)) { say "WOW: rotate(sqrt(\$x), \$a) $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate($x, $a*$a)) { say "WOW: rotate(\$x, \$a*\$a)  $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate($x, sqrt($a))) { say "WOW: rotate(\$x, sqrt(\$a)) $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate(abs ($x-$a), $a)) { say "WOW: rotate(abs(\$x-\$a), \$a) $r = $com{$x}, $com{$a}" };
	if (my $r = pod_rotate($x, abs($x-$a))) { say "WOW: rotate(\$x, abs(\$x-\$a)) $r = $com{$x}, $com{$a}" };
}

sub pod_rotate {
	my ($x, $a) = @_;
	for (1..108) {
		if (my $r = rotate($x / $_, $a)) { say "pod rotate x(1) $_"; return $r;}
		if (my $r = rotate($x, $a / $_)) { say "pod rotate a(2) $_"; return $r;}
	}
}


sub rotate {
	my ($x, $a) = @_;
	my $t = 1;
	for(1..108) {
		$t = abs ($t - $a);
		#say $t;
		if (abs($t - $x) < 0.000001) {
			say "tmp = " . $_ . " $x $a";
			return $_;
		}
	}
	return;
}




1;


