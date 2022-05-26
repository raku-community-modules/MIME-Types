[![Actions Status](https://github.com/raku-community-modules/MIME-Types/actions/workflows/test.yml/badge.svg)](https://github.com/raku-community-modules/MIME-Types/actions)

NAME
====

MIME::Types - determine mime type by file extension

SYNOPSIS
========

```raku
use MIME::Types;

# Specify the mime file you wisg to use
# Or don't pass anything and get the default from the 'resources' directory
my $mime = MIME::Types.new("/etc/mime.types");

my $type = $mime.type('txt'); ## Returns: 'text/plain';
my @known_extensions = $mime.extensions('application/vnd.ms-excel');
# Returns: [ 'xls', 'xlb', 'xlt' ]
```

DESCRIPTION
===========

A Raku library that reads the `mime.types` file as used by many Linux distributions, and web servers, and returns an object that can be queried by either type or extension.

EXAMPLE
=======

An example mime.types is included in the resources/ directory, and is used by the tests in t/.

AUTHOR
======

Zoffix Znet

COPYRIGHT AND LICENSE
=====================

Copyright 2011 - 2015 Zoffix Znet

Copyright 2016 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

