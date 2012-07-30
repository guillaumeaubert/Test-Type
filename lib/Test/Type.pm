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

=cut

our @EXPORT = qw(
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
