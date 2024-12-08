#!/usr/bin/perl -l
use warnings;
use strict;
use Data::Dumper;

my $filename = '.\input';

open my $input_fh, '<', $filename or die $!;

my (%hashLeft, %hashRight);

while(<$input_fh>){
   my ($left, $right) = split(/\s+/, "$_");
   $hashLeft{$left}++;
   $hashRight{$right}++;
}

close($input_fh);

my $sum = 0;

while(my($k, $v) = each %hashLeft) {
   $sum += $hashRight{$k} * $v * $k if (exists($hashRight{$k}));
}

print $sum;