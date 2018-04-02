#ifndef HUBRIS_EASE_BACKINOUT
#define HUBRIS_EASE_BACKINOUT
// REQUIRES
#include "BackIn.hlsl"

namespace Hubris
{
	inline float BackInOut(float t)
    {
	    float f = t < 0.5 ? 2.0 * t : 1.0 - (2.0 * t - 1.0);
	    float g = BackIn(f);
	    return t < 0.5 ? 0.5 * g : 0.5 * (1.0 - g) + 0.5;
    }
}

#endif // HUBRIS_EASE_BACKINOUT