#!/usr/bin/env perl 
#===============================================================================
#         FILE: ex14-3.pl
#       AUTHOR: Phoenix Ikki (liuxueyang.github.io), liuxueyang457@gmail.com
# ORGANIZATION: Hunan University
#      CREATED: 10/08/14 15:42:22
#===============================================================================

use strict;
use warnings;
use utf8;
use 5.014;

chomp(my $big = <STDIN>);
chomp(my $small = <STDIN>);
my $where = index($big, $small);
while (-1 != $where) {
	print "$where ";
	$where = index($big, $small, $where + 1);
}


