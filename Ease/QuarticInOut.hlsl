#ifndef HUBRIS_EASE_QUARTICINOUT
#define HUBRIS_EASE_QUARTICINOUT
// REQUIRES
#include "QuarticIn.hlsl"

namespace Hubris
{
	inline float QuarticInOut(float t)
    {
	    return t < 0.5
		    ? 8.0 * QuarticIn(t)
		    : -8.0 * pow(t - 1.0, 4.0) + 1.0;
    }
}

#endif // HUBRIS_EASE_QUARTICINOUT