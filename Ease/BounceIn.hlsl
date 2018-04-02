#ifndef HUBRIS_EASE_BOUNCEIN
#define HUBRIS_EASE_BOUNCEIN
// REQUIRES
#include "BounceOut.hlsl"

namespace Hubris
{
	inline float BounceIn(float t)
    {
	    return 1.0 - BounceOut(1.0 - t);
    }
}

#endif // HUBRIS_EASE_BOUNCEIN