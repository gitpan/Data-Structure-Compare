package Data::Structure::Compare;

use Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(hashes_to_hash hash_compare);

use strict;
use warnings;
use 5.010;
use YAML qw(Dump);

=head1 NAME

Data::Structure::Compare - The great new Data::Structure::Compare!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
# ----------------------------------
# compare hash, hash must is reference
#
sub hash_compare {
    my ($hashes_1, $hashes_2) = @_;
    my $hash_1 = hashes_to_hash($hashes_1);
    say Dump($hash_1);
    my $hash_2 = hashes_to_hash($hashes_2);
    foreach my $key (keys %{$hash_1}) {
        return 0 unless (exists $hash_2->{$key});
    }
    foreach my $key (keys %{$hash_2}) {
        return 0 unless (exists $hash_1->{$key});
    }
    return 1;
}

# ------------------------
# in default would parse depth 100 structure
#
sub hashes_to_hash {
    my ($hash) = @_;
    my $max_depth = 100;
    my $flag = 0;
    foreach (1 .. $max_depth) {
        ($hash, $flag) = _transfer_hash($hash);
        last if ($flag == 0);
    }
    return $hash;
}

sub _transfer_hash {
    my $ref_hashes = shift;
    my $ref_hash    = {};
    my $expand_flag = 0;
    my $split_char = "\x{ff}";
    foreach my $key (keys %{$ref_hashes}) {
        my $value = $ref_hashes->{$key};
        if (ref($value) eq ref({})) {
            foreach my $sub_key (keys %{$value}) {
                my $sub_value = $value->{$sub_key};
                $ref_hash->{"$key$split_char$sub_key"} = $sub_value;
                $expand_flag++ if (ref($sub_value) eq ref({}));
            }
            next;
        }
        $ref_hash->{$key} = $value;
    }
    return ($ref_hash, $expand_flag);
}
=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Data::Structure::Compare;

    my $foo = Data::Structure::Compare->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut
=head1 AUTHOR

Micheal Song, C<< <perlvim at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-data-structure-compare at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data-Structure-Compare>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Structure::Compare


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Data-Structure-Compare>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Data-Structure-Compare>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Data-Structure-Compare>

=item * Search CPAN

L<http://search.cpan.org/dist/Data-Structure-Compare/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Micheal Song.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
1;
