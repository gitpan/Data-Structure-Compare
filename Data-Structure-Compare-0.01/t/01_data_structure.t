#!perl

use strict;
use warnings;
use 5.010;

use Test::More tests => 1;
use Data::Structure::Compare qw(hash_compare);

my $data1 = {
    key1 => 1,
    key2 => {
        key3 => {
            key4 => 1,
        },
    },
};

my $data2 = {
    key1 => 1,
    key2 => {
        key3 => {
            key4 => 21,
            key5 => 22,
        },
    },
};

ok(hash_compare($data1, $data2), 'data structure is same');
