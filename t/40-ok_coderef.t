#!perl -T

use strict;
use warnings;

use Data::Validate::Type;
use Test::Builder::Tester;
use Test::More tests => 3;
use Test::Type;

{
	test_out( '1..1' )
		if $Test::More::VERSION >= 1.005000005;
	test_out( 'ok 1 - Variable is a coderef.' );
	
	ok_coderef(
		sub
		{
			return 0;
		},
	);
	
	test_test(
		name     => "Test without arguments.",
		skip_err => 1,
	);
}

{
	test_out( '1..1' )
		if $Test::More::VERSION >= 1.005000005;
	test_out( 'not ok 1 - Variable is a coderef.' );
	
	ok_coderef(
		[]
	);
	
	test_test(
		name     => "Test a variable that is not a coderef.",
		skip_err => 1,
	);
}

{
	test_out( '1..1' )
		if $Test::More::VERSION >= 1.005000005;
	test_out( 'ok 1 - Test subroutine is a coderef.' );
	
	ok_coderef(
		sub
		{
			return 0;
		},
		name => 'Test subroutine',
	);
	
	test_test(
		name     => "Test specifying the variable name.",
		skip_err => 1,
	);
}
