use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'DateTime::Format::Epoch',
    VERSION_FROM => 'lib/DateTime/Format/Epoch.pm',
    AUTHOR       => 'Eugene van der Pijll (pijll@gmx.net)',
    ABSTRACT     => 'Convert dates to seconds since epoch, for arbritrary epochs',
);
