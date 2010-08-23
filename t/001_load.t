# t/001_load.t - check module loading

use Test::More tests => 1;

BEGIN { use_ok( 'DateTime::Format::Epoch' ); }

diag("==> DateTime version = $DateTime::VERSION");
diag("==> Math::BigInt version = $Math::BigInt::VERSION");
diag("==> Math::BigInt lib = ".Math::BigInt->config()->{lib});
