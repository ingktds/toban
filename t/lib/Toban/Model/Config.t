#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use FindBin;
use lib "$FindBin::Bin/../../../../lib";
use Toban::Model::Config;

use_ok 'Toban::Model::Config';

subtest 'call config' => sub {
    my $config = Toban::Model::Config->new();
    can_ok $config, 'config';
};

subtest 'arg file' => sub {
    my $config = Toban::Model::Config->new(
        file => "/var/toban/toban.json"
    );
    can_ok $config, 'load_config';
    can_ok $config, 'config';
    is $config->config->{mojo}{host}{www}, 'www.toban.ingk.xyz', 'コンフィグから値が取れること';
};

done_testing();
