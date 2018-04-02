#ifndef HUBRIS_EASE_QUADRATICINOUT
#define HUBRIS_EASE_QUADRATICINOUT
// REQUIRES
#include "QuadraticIn.hlsl"

namespace Hubris
{
	inline float QuadraticInOut(float t)
    {
	    float p = 2.0 * QuadraticIn(t);
	    return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
    }
}

#endif // HUBRIS_EASE_QUADRATICINOUT