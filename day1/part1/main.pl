#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

my $filename = '.\input';

open(INPUT, '<', $filename) or die $!;

my @arrLeft;
my @arrRight;

while(<INPUT>){
   my @x = split(/   /, "$_");
   push(@arrLeft, $x[0]);
   push(@arrRight, $x[1]);
}

close(INPUT);

@arrLeft = sort @arrLeft;
@arrRight =sort @arrRight;

my $arrSize = @arrLeft;
my $sum = 0;

for my $i (0..$arrSize-1) {
   my $left = $arrLeft[$i];
   my $right = $arrRight[$i];
   
   $sum += $left > $right ? $left - $right : $right - $left; 
}
print $sum;

