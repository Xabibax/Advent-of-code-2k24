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

sub is_safe {
    my @arr = @_;
    my $previous = $arr[0];
    my $safe = 1;
    my $all_inc = all_inc(@arr);
    my $all_dec = all_dec(@arr);
    for my $i (1..@arr-1) {
        my $n= $arr[$i];
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
    return $safe;
}

open my $input_fh, '<', $filename or die $!;

my @arrLeft;
my @arrRight;

my $sum = 0;

while(<$input_fh>){
    my @x = split(/\s+/, "$_");

    my @arr = @x;
    my $safe = is_safe(@arr);
    if(!$safe) {
        for my $i (0..@arr-1) {
            my @tmp = @arr;
            splice(@tmp, $i, 1);
            if (is_safe(@tmp)) {
                $safe = 1;
                last;
            }
        }
    } 

    $sum += $safe;
}

close($input_fh);

print $sum;

