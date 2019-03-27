/* fflush( FILE * )

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

#include <stdio.h>
#include "poplibc/glue.h"

extern struct _PDCLIB_file_t * _PDCLIB_filelist;

int fflush( struct _PDCLIB_file_t * stream )
{
    if ( stream == NULL )
    {
        int rc = 0;
        stream = _PDCLIB_filelist;
        /* TODO: Check what happens when fflush( NULL ) encounters write errors, in other libs */
        while ( stream != NULL )
        {
            if ( stream->status & _PDCLIB_FWRITE )
            {
                if ( _PDCLIB_flushbuffer( stream ) == EOF )
                {
                    rc = EOF;
                }
            }
            stream = stream->next;
        }
        return rc;
    }
    else
    {
        return _PDCLIB_flushbuffer( stream );
    }
}
