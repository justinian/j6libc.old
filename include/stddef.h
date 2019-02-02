#pragma once
/* Common definitions <stddef.h>

   This file is part of the Public Domain C Library (PDCLib).
   Permission is granted to use, modify, and / or redistribute at will.
*/

#include "pdclib/_PDCLIB_int.h"
#include "pdclib/null.h"
#include "pdclib/max_align_t.h"
#include "pdclib/size_t.h"
#include "pdclib/wchar_t.h"

typedef _PDCLIB_ptrdiff_t ptrdiff_t;

#define offsetof( type, member ) _PDCLIB_offsetof( type, member )
