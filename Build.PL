use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'Test::Type',
	license             => 'artistic',
	dist_author         => q{Guillaume Aubert <aubertg@cpan.org>},
	dist_version_from   => 'lib/Test/Type.pm',
	build_requires      =>
	{
		'Carp'                  => '0',
		'Data::Validate::Type'  => '1.0.5',
		'Exporter'              => '0',
		'File::Spec'            => '0',
		'Test::Builder::Tester' => '0',
		'Test::More'            => '0.94',
	},
	requires            =>
	{
		'perl'         => 5.006,
	},
	add_to_cleanup      =>
	[
		'Test-Type-*',
	],
	create_makefile_pl  => 'traditional',
	configure_requires  =>
	{
		'Module::Build'         => 0,
	},
	meta_merge          =>
	{
		resources               =>
		{
			repository  => 'https://sourceforge.net/p/perl-test-type/code',
			homepage    => 'https://metacpan.org/release/Test-Type',
			bugtracker  => 'http://rt.cpan.org/NoAuth/ReportBug.html?Queue=test-type',
		},
	},
);

$builder->create_build_script();
