#ifndef HUBRIS_EASE_SINEINOUT
#define HUBRIS_EASE_SINEINOUT
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	inline float SineInOut(float t)
    {
	    return -0.5 * (cos(HUBRIS_PI * t) - 1.0);
    }
}

#endif // HUBRIS_EASE_SINEINOUT