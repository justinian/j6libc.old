/* getchar( void )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

#include <stdio.h>

int getchar( void )
{
    return fgetc( stdin );
}
