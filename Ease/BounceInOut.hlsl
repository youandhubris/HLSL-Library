#ifndef HUBRIS_EASE_BOUNCEINOUT
#define HUBRIS_EASE_BOUNCEINOUT
// REQUIRES
#include "BounceOut.hlsl"

namespace Hubris
{
	inline float BounceInOut(float t)
    {
	    return t < 0.5 ? 0.5 * (1.0 - BounceOut(1.0 - t * 2.0)) : 0.5 * BounceOut(t * 2.0 - 1.0) + 0.5;
    }
}

#endif // HUBRIS_EASE_BOUNCEINOUT