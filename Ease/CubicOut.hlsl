#ifndef HUBRIS_EASE_CUBICOUT
#define HUBRIS_EASE_CUBICOUT
// REQUIRES
#include "CubicIn.hlsl"

namespace Hubris
{
    inline float CubicOut(float t)
	{
		return CubicIn(t - 1.0) + 1.0;
	}
}

#endif // HUBRIS_EASE_CUBICOUT