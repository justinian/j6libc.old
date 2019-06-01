# j6libc: C standard library for the jsix operating system

This is the C library for [jsix][], forked from [PDCLib][], the public
domain C library by Martin Baute and Erin Shepherd.

[jsix]: https://github.com/justinian/jsix
[PDCLib]: https://github.com/DevSolar/pdclib

## License

In keeping with PDCLib, j6libc is distributed unter the Creative Commons CC0
License. See the file `COPYING.CC0` or the licence at [Creative Commons][CC0].

[CC0]: https://creativecommons.org/publicdomain/zero/1.0/legalcode

## Internals

_From the PDCLib readme:_

As a namespace convention, everything (files, typedefs, functions, macros) not
defined in ISO/IEC 9899 is prefixed with `_PDCLIB`.  The standard defines any
identifiers starting with `_` and a capital letter as reserved for the
implementation, and since the chances of your compiler using an identifier in
the `_PDCLIB` range are slim, any strictly conforming application should work
with this library.

PDCLib consists of several parts:

1. standard headers;
2. implementation files for standard functions;
3. internal header files keeping complex stuff out of the standard headers;
4. the central, platform-specific file `_PDCLIB_config.h`;
5. platform-specific implementation files;
6. platform-specific, optimized "overlay" implementations (optional).

The standard headers (in `./include/`) only contain what they are defined to
contain. Where additional logic or macro magic is necessary, that is deferred
to the internal files. This has been done so that the headers are actually
educational as to what they provide (as opposed to how the library does it).

There is a seperate implementation file (in `./function/{header}/`) for every
function defined by the standard, named `{function}.c`. Not only does this
avoid linking in huge amounts of unused code when you use but a single
function, it also allows the optimization overlay to work (see below).

(The directory `./functions/_PDCLIB/` contains internal and helper functions
that are not part of the standard.)

Then there are internal header files (in `./include/pdclib/`), which contain
all the "black magic" and "code fu" that was kept out of the standard headers.
You should not have to touch them if you want to adapt PDCLib to a new
platform. Note that, if you *do* have to touch them, I would consider it a
serious design flaw, and would be happy to fix it in the next PDCLib release.
Any adaption work should be covered by the steps detailed below.
