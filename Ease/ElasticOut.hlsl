#ifndef HUBRIS_EASE_ELASTICOUT
#define HUBRIS_EASE_ELASTICOUT
// REQUIRES
#include "../Variables.hlsl"

namespace Hubris
{
    inline float ElasticOut(float t)
    {
	    return sin(-13.0 * (t + 1.0) * HUBRIS_HALF_PI) * pow(2.0, -10.0 * t) + 1.0;
    }
}

#endif // HUBRIS_EASE_ELASTICOUT