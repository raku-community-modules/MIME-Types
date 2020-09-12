use v6;

unit class MIME::Types;

has %.exts;
has %.types;

multi method new(Str $mtfile) {
    self.new: $mtfile.IO;
}

multi method new(*@params) {
    self.new: %?RESOURCES<mime.types>.IO;
}

multi method new(IO::Path $mtfile) {
    if $mtfile !~~ :f {
        die "cannot access '{$mtfile.absolute}': No such file or directory";
    }

    my @lines = slurp($mtfile).lines;
    my $types = {};
    my $exts  = {};

    for @lines -> $line {
        next if $line eq '' || $line ~~ /^'#'/;

        my ($ctype, @exts) = $line.split(/\s+/);
        #$*ERR.say: "# Found: $ctype, {@exts.perl}";

        $types{$ctype} = @exts;
        for @exts -> $ext {
          $exts{$ext} = $ctype;
        }
    }
    self.bless(:$exts, :$types);
}

method type ($ext) {
  if %.exts{$ext}:exists {
    return %.exts{$ext};
  }
  return;
}

method extensions ($type) {
  if %.types{$type}:exists {
    #$*ERR.say: "Typedef: "~%.types{$type}.perl;

    return @(%.types{$type});
  }
  return;
}
