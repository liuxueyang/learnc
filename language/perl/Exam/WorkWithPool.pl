#!/usr/bin/env perl 
#===============================================================================
#         FILE: MultiThread.pl
#       AUTHOR: Phoenix Ikki (liuxueyang.github.io), liuxueyang457@gmail.com
# ORGANIZATION: Hunan University
#      CREATED: 04/23/2015 10:53:16 AM
#===============================================================================

use strict;
use warnings;
use utf8;
use 5.014;
use threads;
use threads::shared;
use Thread::Pool;

open TXT, $ARGV[0];
my ($first, $second, @record1, @threads);
my @NameList :shared;
my @ResList :shared;
my $pool = Thread::Pool->new(
    {
        workers => 3,
        do => \&myfunc,
    }
);

sub cal { int(rand(2)); }

while (defined($first = <TXT>)) {
    chomp($first);
    $first =~ s/\s+/ /g;
    @record1 = split / /, $first;
    $pool->job(@record1);
}
$pool->shutdown();

sub myfunc {
    print "<$_> " for @_;
    print "\n";
    my $token = @_;
    my ($name, $passwd, $channel) = @_;
    my ($index, $pos, $truth, $len);

    # a block lock NameList
    {
        lock(@NameList);
        $len = @NameList;
        for $index (0..($len - 1)) {
            if ($NameList[$index] eq $name) {
                $pos = $index;
                last;
            }
        }
        # unlocking happens when this block ends.
    }

    if ($pos) {
        lock(@NameList);
        lock(@ResList);
        $truth = $ResList[$pos];
        # delete name 
        delete $NameList[$pos];
        delete $ResList[$pos];
        # add it at the end of array
        @NameList = grep defined, @NameList;
        @ResList = grep defined, @ResList;
        push @NameList, $name;
        push @ResList, $truth;
        if ($truth) {
            print "OK";
        } else {
            print "ERR";
        }
        print " ", $channel if (defined($channel));
        print "\n";
        # unlock at end of block
    } 
    else {
        lock(@NameList);
        lock(@ResList);
        $truth = cal($name, $passwd);
        if ($len == 10) {
            shift(@NameList);
            shift(@ResList);
        } else { push @NameList, $name;;
            push @ResList, $truth;
        }
        if ($truth) {
            print "OK";
        } else {
            print "ERR";
        }
        print " ", $channel if (defined($channel));
        print "\n";
    }


    my $tid = threads->tid();
    print "token = $token. Thread $tid ended. Please wait for 5 seconds...\n";
    print "Current Array contains: ";
    print "<$_> " for @NameList;
    print "\n\n";
    sleep(5);
}


=commet
aries@raymond:~/Hack/language/perl/Exam> perl MultithreadWithPool.pl input.txt
<liuxueyang> <1234> <0> 
ERR 0
token = 3. Thread 2 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> 

<lxy> <321> 
OK
token = 2. Thread 3 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <lxy> 

<phoenix> <12> <2> 
ERR 2
token = 3. Thread 4 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <lxy> <phoenix> 

<mu> <21> 
OK
token = 2. Thread 2 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <lxy> <phoenix> <mu> 

<ray> <9> <98> 
OK 98
token = 3. Thread 3 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <lxy> <phoenix> <mu> <ray> 

<phoenix> <12> <2> 
ERR 2
token = 3. Thread 4 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <lxy> <mu> <ray> <phoenix> 

<lxy> <321> 
OK
token = 2. Thread 2 ended. Please wait for 5 seconds...
Current Array contains: <liuxueyang> <mu> <ray> <phoenix> <lxy> 

=cut

=comment
liuxueyang 1234 0
lxy 321
phoenix 12 2
mu 21
ray 9 98
phoenix 12 2
lxy 321
=cut
