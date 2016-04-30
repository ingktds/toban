#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use FindBin;
use lib "$FindBin::Bin/../../../../lib";
use Toban::DB::Mongo;

use_ok 'Toban::DB::Mongo';

my $db = Toban::DB::Mongo->new(collection => 'users');
can_ok $db, 'get_collection';

subtest 'insert test' => sub {
    my $db = Toban::DB::Mongo->new(collection => 'users');
    my $collection = $db->get_collection();
};

done_testing();
