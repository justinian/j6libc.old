/* _PDCLIB_rename( const char *, const char * )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

/* This is an example implementation of _PDCLIB_rename() fit for use with
   POSIX kernels.
 */

#include <stdio.h>

#ifndef REGTEST

#include "poplibc/glue.h"

int _PDCLIB_rename( const char * old, const char * new )
{
	_PDCLIB_errno = _PDCLIB_ERROR;
	return EOF;
}

#endif

#ifdef TEST
#include "_PDCLIB_test.h"

#include <stdlib.h>

int main( void )
{
    return TEST_RESULTS;
}

#endif
