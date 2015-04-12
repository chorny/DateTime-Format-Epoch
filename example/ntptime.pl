#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use DateTime::Format::Epoch::NTP;
use Socket;

my $hostname = 'pool.ntp.org';
socket(SOCKET, PF_INET, SOCK_DGRAM, getprotobyname('udp'));
my $ipaddr = inet_aton($hostname);
my $portaddr = sockaddr_in(123, $ipaddr);
my $bstr = "\010" . "\0"x47;
send(SOCKET, $bstr, 0, $portaddr);
$portaddr = recv(SOCKET, $bstr, 1024, 0);
my @words = unpack("N12",$bstr);
my $ntptime = $words[10];

my $dt = DateTime::Format::Epoch::NTP->parse_datetime( $ntptime );

$dt->set_time_zone('Europe/Moscow');

say "NTPTime $ntptime is in Moscow: " . $dt->hms;
say $dt->datetime;
