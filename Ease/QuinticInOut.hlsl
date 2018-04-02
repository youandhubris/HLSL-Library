#ifndef HUBRIS_EASE_QUINTICINOUT
#define HUBRIS_EASE_QUINTICINOUT
// REQUIRES
#include "QuinticIn.hlsl"

namespace Hubris
{
	inline float QuinticInOut(float t)
    {
	    return t < 0.5 ? 16.0 * QuinticIn(t) : 0.5 * pow(2.0 * t - 2.0, 5.0) + 1.0;
    }
}

#endif // HUBRIS_EASE_QUINTICINOUT