#ifndef HUBRIS_EASE_QUARTICOUT
#define HUBRIS_EASE_QUARTICOUT

namespace Hubris
{
	inline float QuarticOut(float t)
    {
	    return pow(t - 1.0, 3.0) * (1.0 - t) + 1.0;
    }
}

#endif // HUBRIS_EASE_QUARTICOUT