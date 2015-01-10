use strict;
BEGIN { $^W = 1 }

use Test::More tests => 4;
use DateTime;
use DateTime::Format::Epoch::NTP;

my $f = DateTime::Format::Epoch::NTP->new();

isa_ok($f, 'DateTime::Format::Epoch::NTP' );

my $dt = DateTime->new( year => 2015, month => 1, day => 10,
time_zone => 'Europe/Amsterdam' );
is($f->format_datetime($dt), '3629833200', 'Format DateTime as NTP epoch time');

$dt = DateTime::Format::Epoch::NTP->parse_datetime( 3629848426 );

is($dt->iso8601(), '2015-01-10T03:13:46', 'read NTP time');
is($dt->time_zone_long_name(), 'UTC', 'NPT time timezone is UTC');
