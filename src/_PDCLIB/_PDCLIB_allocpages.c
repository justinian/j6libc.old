/* _PDCLIB_allocpages( int const )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

/* This is an example implementation of _PDCLIB_allocpages() fit for use with
   POSIX kernels.
*/


#ifndef REGTEST

#include "pdclib/_PDCLIB_glue.h"

void * _PDCLIB_allocpages( int const n )
{
	return 0;
}

#endif

#ifdef TEST

#include "_PDCLIB_test.h"

int main( void )
{
    return TEST_RESULTS;
}

#endif
