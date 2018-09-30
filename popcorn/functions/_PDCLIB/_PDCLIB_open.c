/* _PDCLIB_open( const char * const, int )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

/* This is an example implementation of _PDCLIB_open() fit for use with POSIX
   kernels.
*/

#ifndef REGTEST

#include "pdclib/_PDCLIB_glue.h"

int _PDCLIB_open( const char * const filename, unsigned int mode )
{
	_PDCLIB_errno = _PDCLIB_ERROR;
    return -1;
}

#endif

#ifdef TEST

#include "_PDCLIB_test.h"

#include <stdlib.h>
#include <string.h>

int main( void )
{
    return TEST_RESULTS;
}

#endif
