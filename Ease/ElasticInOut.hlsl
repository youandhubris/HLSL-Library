#ifndef HUBRIS_EASE_ELASTICINOUT
#define HUBRIS_EASE_ELASTICINOUT
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	inline float ElasticInOut(float t)
    {
	    return t < 0.5
		    ? 0.5 * sin(+13.0 * HUBRIS_HALF_PI * 2.0 * t) * pow(2.0, 10.0 * (2.0 * t - 1.0))
		    : 0.5 * sin(-13.0 * HUBRIS_HALF_PI * ((2.0 * t - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * t - 1.0)) + 1.0;
    }
}

#endif // HUBRIS_EASE_ELASTICINOUT