#!/usr/bin/perl


use 5.022;
use warnings;


my @data;

open my $fi, 'pre-output.txt';
while (my $s = <$fi>) {
	chomp $s;
	my $a = <$fi>;
	chomp $a;
	my $b = <$fi>;
	chomp $b;
	
	push @data, [$s, $a, $b];
}
close $fi;

#tmp = 8 0.00885999558140625 0.12610746335
#pod rotate x(1) 64
#WOW: rotate($x, abs($x-$a)) 8 =  (sin(180/7)^4)*16,  ln (2)

for (@data) {
	my @a = @$_;
	say $a[2];
	my ($x, $y, $d, $f1, $f2) = $a[2] =~ /rotate\((.*), (.*)\)\s+(\d+)\s+\=\s*(.*),\s*(.*)/;
	
	my ($u, $s) = $a[1] =~ /rotate \w\((.+)\)\s+(\d+)/;
	
	if ($u == 1) {
		$f1 = '('.$f1.'/'.$s.'.0)';
	}
	if ($u == 2) {
		$f2 = '('.$f1.'/'.$s.'.0)';
	}
	
	my $x2 = $x;
	$x2 =~ s/\$x/$f1/g;
	$x2 =~ s/\$a/$f2/g;


	my $y2 = $y;
	$y2 =~ s/\$x/$f1/g;
	$y2 =~ s/\$a/$f2/g;
	
	my $result = '1';
	
	for(1..$s) {
		$result = 'abs('.$result.'-'.$y2.')';
	}

	say "$x2 = $result";
}


1;
