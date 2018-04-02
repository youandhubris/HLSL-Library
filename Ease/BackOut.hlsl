#ifndef HUBRIS_EASE_BACKOUT
#define HUBRIS_EASE_BACKOUT
// REQUIRES
#include "BackIn.hlsl"

namespace Hubris
{
	inline float BackOut(float t)
    {
	    return 1.0 - BackIn(1.0 - t);
    }
}

#endif // HUBRIS_EASE_BACKOUT