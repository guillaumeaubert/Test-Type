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
		'File::Spec'            => '0',
		'Test::Builder::Tester' => '0',
	},
	requires            =>
	{
		'perl'                  => 5.006,
		'Carp'                  => '0',
		'Data::Validate::Type'  => '1.2.0',
		'Exporter'              => '0',
		'Test::More'            => '0.94',
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
			repository  => 'https://github.com/guillaumeaubert/Test-Type',
			homepage    => 'https://metacpan.org/release/Test-Type',
			bugtracker  => 'http://rt.cpan.org/NoAuth/ReportBug.html?Queue=test-type',
		},
	},
);

$builder->create_build_script();
