# t/001_load.t - check module loading

use Test::More tests => 1;

BEGIN { use_ok( 'DateTime::Format::Epoch::NTP' ); }
