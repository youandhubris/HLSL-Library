#ifndef HUBRIS_EASE_BACKIN
#define HUBRIS_EASE_BACKIN
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	inline float BackIn(float t)
    {
	    return pow(t, 3.0) - t * sin(t * HUBRIS_PI);
    }
}

#endif // HUBRIS_EASE_BACKIN