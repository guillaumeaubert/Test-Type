package Test::Type;

use strict;
use warnings;

use Carp qw();
use Data::Validate::Type;
use Exporter 'import';
use Test::More qw();


=head1 NAME

Test::Type - Functions to validate data types in test files.


=head1 VERSION

Version 1.0.0

=cut

our $VERSION = '1.0.0';


=head1 SYNOPSIS

	use Test::Type;
	
	# Test strings.
	ok_string( $variable );
	ok_string(
		$variable,
		name => 'My variable',
	);
	
	# Test arrayrefs.
	ok_arrayref( $variable );
	ok_arrayref(
		$variable,
		name => 'My variable',
	);
	
	# Test hashrefs.
	ok_hashref( $variable );
	ok_hashref(
		$variable,
		name => 'Test variable',
	);

=cut

our @EXPORT = qw(
	ok_arrayref
	ok_hashref
	ok_string
);


=head1 FUNCTIONS

=head2 ok_string()

Test if the variable passed is a string.

	ok_string(
		$variable,
	);
	
	ok_string(
		$variable,
		name => 'My variable',
	);
	
	ok_string(
		$variable,
		name        => 'My variable',
		allow_empty => 1,
	);

Parameters:

=over 4

=item * name

Optional, the name of the variable being tested.

=item * allow_empty

Boolean, default 1. Allow the string to be empty or not.

=back

=cut

sub ok_string
{
	my ( $variable, %args ) = @_;
	my $name = delete( $args{'name'} ) // 'Variable';
	my $allow_empty = delete( $args{'allow_empty'} ) // 1;
	Carp::croak( 'Unknown parameter(s): ' . join( ', ', keys %args ) . '.' )
		if scalar( keys %args ) != 0;
	
	my @test_properties = ();
	push( @test_properties, $allow_empty ? 'allow empty' : 'non-empty' );
	my $test_properties = scalar( @test_properties ) == 0
		? ''
		: ' (' . join( ', ', @test_properties ) . ')';
	
	return Test::More::ok(
		Data::Validate::Type::is_string(
			$variable,
			allow_empty => $allow_empty,
		),
		$name . ' is a string' . $test_properties . '.',
	);
}


=head2 ok_arrayref()

Test if the variable passed is an arrayref that can be dereferenced into an
array.

	ok_arrayref( $variable );
	
	ok_arrayref(
		$variable,
		name => 'My variable',
	);
	
	ok_arrayref(
		$variable,
		allow_empty => 1,
		no_blessing => 0,
	);
	
	# Check if the variable is an arrayref of hashrefs.
	ok_arrayref(
		$variable,
		allow_empty           => 1,
		no_blessing           => 0,
		element_validate_type =>
			sub
			{
				return Data::Validate::Type::is_hashref( $_[0] );
			},
	);

Parameters:

=over 4

=item * name

Optional, the name of the variable being tested.

=item * allow_empty

Boolean, default 1. Allow the array to be empty or not.

=item * no_blessing

Boolean, default 0. Require that the variable is not blessed.

=item * element_validate_type

None by default. Set it to a coderef to validate the elements in the array.
The coderef will be passed the element to validate as first parameter, and it
must return a boolean indicating whether the element was valid or not.

=back

=cut

sub ok_arrayref
{
	my ( $variable, %args ) = @_;
	my $name = delete( $args{'name'} ) // 'Variable';
	my $allow_empty = delete( $args{'allow_empty'} ) // 1;
	my $no_blessing = delete( $args{'no_blessing'} ) // 0;
	my $element_validate_type = delete( $args{'element_validate_type'} );
	Carp::croak( 'Unknown parameter(s): ' . join( ', ', keys %args ) . '.' )
		if scalar( keys %args ) != 0;
	
	my @test_properties = ();
	push( @test_properties, $allow_empty ? 'allow empty' : 'non-empty' );
	push( @test_properties, $no_blessing ? 'no blessing' : 'allow blessed' );
	push( @test_properties, 'validate elements' )
		if $element_validate_type;
	my $test_properties = scalar( @test_properties ) == 0
		? ''
		: ' (' . join( ', ', @test_properties ) . ')';
	
	return Test::More::ok(
		Data::Validate::Type::is_arrayref(
			$variable,
			allow_empty           => $allow_empty,
			no_blessing           => $no_blessing,
			element_validate_type => $element_validate_type,
		),
		$name . ' is an arrayref' . $test_properties . '.',
	);
}


=head2 ok_hashref()

Test if the variable passed is a hashref that can be dereferenced into a hash.

	ok_hashref( $variable );
	
	ok_hashref(
		$variable,
		name => 'Test variable',
	);
	
	ok_hashref(
		$variable,
		allow_empty => 1,
		no_blessing => 0,
	);

Parameters:

=over 4

=item * name

Optional, the name of the variable being tested.

=item * allow_empty

Boolean, default 1. Allow the array to be empty or not.

=item * no_blessing

Boolean, default 0. Require that the variable is not blessed.

=back

=cut

sub ok_hashref
{
	my ( $variable, %args ) = @_;
	my $name = delete( $args{'name'} ) // 'Variable';
	my $allow_empty = delete( $args{'allow_empty'} ) // 1;
	my $no_blessing = delete( $args{'no_blessing'} ) // 0;
	Carp::croak( 'Unknown parameter(s): ' . join( ', ', keys %args ) . '.' )
		if scalar( keys %args ) != 0;
	
	my @test_properties = ();
	push( @test_properties, $allow_empty ? 'allow empty' : 'non-empty' );
	push( @test_properties, $no_blessing ? 'no blessing' : 'allow blessed' );
	my $test_properties = scalar( @test_properties ) == 0
		? ''
		: ' (' . join( ', ', @test_properties ) . ')';
	
	return Test::More::ok(
		Data::Validate::Type::is_hashref(
			$variable,
			allow_empty           => $allow_empty,
			no_blessing           => $no_blessing,
		),
		$name . ' is a hashref' . $test_properties . '.',
	);
}


=head1 AUTHOR

Guillaume Aubert, C<< <aubertg at cpan.org> >>.


=head1 BUGS

Please report any bugs or feature requests to C<bug-test-dist-versionsync at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=test-type>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

	perldoc Test::Type


You can also look for information at:

=over

=item *

RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=test-type>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/test-type>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/test-type>

=item *

Search CPAN

L<http://search.cpan.org/dist/test-type/>

=back


=head1 COPYRIGHT & LICENSE

Copyright 2012 Guillaume Aubert.

This program is free software; you can redistribute it and/or modify it
under the terms of the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
