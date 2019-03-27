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

typedef __PTRDIFF_TYPE__ ptrdiff_t;

#if ! __has_include("__stddef_max_align_t.h")
typedef long double      max_align_t;
#endif

#define offsetof( type, member ) _PDCLIB_offsetof( type, member )
