#ifndef HUBRIS_EASE_ELASTICIN
#define HUBRIS_EASE_ELASTICIN
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
	inline float ElasticIn(float t)
    {
	    return sin(13.0 * t * HUBRIS_HALF_PI) * pow(2.0, 10.0 * (t - 1.0));
    }
}

#endif // HUBRIS_EASE_ELASTICIN