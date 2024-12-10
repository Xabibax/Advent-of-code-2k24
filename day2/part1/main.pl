#!/usr/bin/perl -l
use warnings;
use strict;
use Data::Dumper;
use List::Util qw( min max );

my $filename = '.\input';

sub all_inc {
    my @arr = @_;
    my $previous = $arr[0];
    for my $i (1..@arr-1) {
        my $n = $arr[$i];
        if ($previous >= $n) {
            return 0 ;
        }
        $previous = $n;
    }
    return 1;
}

sub all_dec {
    my @arr = @_;
    my $previous = $arr[0];
    for my $i (1..@arr-1) {
        my $n = $arr[$i];
        if ($previous <= $n) {
            return 0 ;
        }
        $previous = $n;
    }
    return 1;
}

open my $input_fh, '<', $filename or die $!;

my @arrLeft;
my @arrRight;

my $sum = 0;

while(<$input_fh>){
    my @x = split(/\s+/, "$_");
    my $previous = $x[0];
    my $safe = 1;
    my $all_inc = all_inc(@x);
    my $all_dec = all_dec(@x);
    for my $i (1..@x-1) {
        my $n= $x[$i];
        my $diff = 0;
        if ($all_inc) {
            $diff = $n - $previous;
        }
        elsif ($all_dec) {
            $diff = $previous - $n;
        } 
        $safe = $diff ? $diff >= 1 && $diff <= 3 : 0;
        if (!$safe) {
            last;
        }
        $previous = $n;
    }

    $sum ++ if $safe;
}

close($input_fh);

print $sum;

