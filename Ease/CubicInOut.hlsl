#ifndef HUBRIS_EASE_CUBICINOUT
#define HUBRIS_EASE_CUBICINOUT
// REQUIRES
#include "CubicIn.hlsl"

namespace Hubris
{
	inline float CubicInOut(float t)
    {
	    return t < 0.5 ? 4.0 * CubicIn(t) : 0.5 * pow(2.0 * t - 2.0, 3.0) + 1.0;
    }
}

#endif // HUBRIS_EASE_CUBICINOUT