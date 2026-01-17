unit class MIME::Types:ver<0.3>:auth<zef:raku-community-modules>;
has %.exts  is built(False);
has %.types is built(False);

method !SET-SELF(IO::Path:D $io) {
    my %types;
    my %exts;

    for $io.lines.grep({ .chars and !.starts-with('#') }) -> $line {
        my str @exts  = $line.words;
        my str $ctype = @exts.shift;

        %types{$ctype} := @exts;  # UNCOVERABLE
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

# vim: expandtab shiftwidth=4
