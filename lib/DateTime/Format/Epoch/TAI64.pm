package DateTime::Format::Epoch::TAI64;

use strict;

use vars qw($VERSION @ISA);

$VERSION = 0.04;

use DateTime;
use DateTime::Format::Epoch;

@ISA = qw/DateTime::Format::Epoch/;

# Epoch is 1970-01-01 00:00:00 TAI, is 1969-12-31T23:59:49 or
# 1969-12-31T23:59:50 (not clear)
my $epoch = DateTime->new( year => 1969, month => 12, day => 31,
                           hour => 23, minute => 59, second => 51 );

my $start = Math::BigInt->new(1) << 62;

sub new {
	my $class = shift;

    return $class->SUPER::new( epoch => $epoch,
                               unit  => 'seconds',
                               type  => 'bigint',
                               skip_leap_seconds => 0,
                               start_at => $start );
}

sub format_datetime_as_string {
    my ($self, $dt) = @_;

    my $str = $self->format_datetime($dt)->as_hex;
    my ($n) = $str =~ /^0x(\w+)$/ or die "Internal error";

    my $retval = pack "H*", $n;
    return "0" x (8 - length$retval) . $retval;
}

1;
__END__

=head1 NAME

DateTime::Format::Epoch::TAI64 - Convert DateTimes to/from TAI64 values

=head1 SYNOPSIS

  use DateTime::Format::Epoch::TAI64;

  my $formatter = DateTime::Format::Epoch::TAI64->new();

  my $dt2 = $formatter->parse_datetime( ???? );
   # 2003-04-28T00:00:00

  $formatter->format_datetime_as_string($dt2);
   # ????

=head1 DESCRIPTION

This module can convert a DateTime object (or any object that can be
converted to a DateTime object) to a TAI64 value. The TAI64 timescale
covers the entire expected lifespan of the universe (at least, if you
expect the universe to be closed).

=head1 METHODS

Most of the methods are the same as those in L<DateTime::Format::Epoch>.
Apart from one new method, the only difference is the constructor.

=over 4

=item * new()

Constructor of the formatter/parser object. It has no parameters.

=item * format_datetime_as_string( $dt )

Returns the TAI64 value as an 8 byte string.

=back

=head1 BUGS

Before the introduction of the leap seconds in 1972, the relation
between TAI and UTC was irregular. In this module, it is assumed that
the difference TAI-UTC was 10 seconds constantly. Any errors introduced
by this assumption come from the irregularity of UTC, and are not
TAI64's fault or mine.

=head1 SUPPORT

Support for this module is provided via the datetime@perl.org email
list. See http://lists.perl.org/ for more details.

=head1 AUTHOR

Eugene van der Pijll <pijll@gmx.net>

=head1 COPYRIGHT

Copyright (c) 2003 Eugene van der Pijll.  All rights reserved.  This
program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 SEE ALSO

L<DateTime>

datetime@perl.org mailing list

http://cr.yp.to/time.html

=cut
