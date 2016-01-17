#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use FindBin qw( $Bin );
use lib "$Bin/../../../../lib";
use Toban::Model::Member;
use Data::Dumper;

my $member = Toban::Model::Member->member_list;
ok $member, 'メンバーが返ること';
warn Dumper $member;

done_testing();
