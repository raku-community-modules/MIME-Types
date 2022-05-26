unit class MIME::Types;
has %.exts  is built(False);
has %.types is built(False);

method !SET-SELF(IO::Path:D $io) {
    my %types;
    my %exts;

    for $io.lines.grep({ .chars and !.starts-with('#') }) -> $line {
        my str @exts  = $line.words;
        my str $ctype = @exts.shift;

        %types{$ctype} := @exts;
        for @exts -> $ext {
            %exts{$ext} := $ctype;
        }
    }

    %!types := %types.Map;
    %!exts  := %exts.Map;

    self
}

my $default;
multi method new() {
    $default
      // ($default := self.CREATE!SET-SELF: %?RESOURCES<mime.types>.IO)
}
multi method new(Str:D $mtfile) {
    self.new: $mtfile.IO
}
multi method new(IO::Path:D $io) {
    $io.f
      ?? self.CREATE!SET-SELF($io)
      !! (die "cannot access '$io.absolute()': No such file or directory")
}

method type(Str:D $ext) {
    %.exts{$ext} // Nil
}

method extensions(Str:D $type) {
    %.types{$type} // Nil
}

=begin pod

=head1 NAME

MIME::Types - determine mime type by file extension

=head1 SYNOPSIS

=begin code :lang<raku>

use MIME::Types;

# Specify the mime file you wisg to use
# Or don't pass anything and get the default from the 'resources' directory
my $mime = MIME::Types.new("/etc/mime.types");

my $type = $mime.type('txt'); ## Returns: 'text/plain';
my @known_extensions = $mime.extensions('application/vnd.ms-excel');
# Returns: [ 'xls', 'xlb', 'xlt' ]

=end code

=head1 DESCRIPTION

A Raku library that reads the C<mime.types> file as used by
many Linux distributions, and web servers, and returns an object
that can be queried by either type or extension.

=head1 EXAMPLE

An example mime.types is included in the resources/ directory, and is used by
the tests in t/.

=head1 AUTHOR

Timothy Totten

=head1 COPYRIGHT AND LICENSE

Copyright 2011 - 2015 Timothy Totten

Copyright 2016 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
